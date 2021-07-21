local timer_check = 5 -- seconds per check
local flight_secs = 5 * 60 -- seconds of flight
local S = ethereal.intllib


-- disable flight
local function set_flight(user, set)

	local name = user:get_player_name()
	local privs = minetest.get_player_privs(name)

	privs.fly = set

	minetest.set_player_privs(name, privs)

	-- when 'fly' removed set timer to temp value for checks
	if not set then

		local meta = user:get_meta() ; if not meta then return end

		meta:set_string("ethereal:fly_timer", "-99")
	end
end


-- after function
local function ethereal_set_flight(user)

	local meta = user:get_meta() ; if not meta then return end
	local timer = tonumber(meta:get_string("ethereal:fly_timer"))

	if not timer then return end -- nil check

	-- if timer ran out then remove 'fly' privelage
	if timer <= 0 and timer ~= -99 then

		set_flight(user, nil)

		return
	end

	local name = user:get_player_name()
	local privs = minetest.get_player_privs(name)

	-- have we already applied 'fly' privelage?
	if not privs.fly then
		set_flight(user, true)
	end

	-- handle timer
	timer = timer - timer_check

	-- show expiration message and play sound
	if timer < 10 then

		minetest.chat_send_player(name,
				minetest.get_color_escape_sequence("#ff5500")
				.. S("Flight timer about to expire!"))

		minetest.sound_play("default_dig_dig_immediate",
				{to_player = name, gain = 1.0}, true)
	end

	-- store new timer setting
	meta:set_string("ethereal:fly_timer", timer)

	minetest.after(timer_check, function()
		ethereal_set_flight(user)
	end)
end


-- on join / leave
minetest.register_on_joinplayer(function(player)

	local meta = player:get_meta() ; if not meta then return end
	local timer = tonumber(meta:get_string("ethereal:fly_timer"))

	if timer and timer == -99 then
		return
	end

	local privs = minetest.get_player_privs(player:get_player_name())

	if privs.fly and timer then

		minetest.after(timer_check, function()
			ethereal_set_flight(player)
		end)
	end
end)


-- potion item
minetest.register_node("ethereal:flight_potion", {
	description = S("Flight Potion"),
	drawtype = "plantlike",
	tiles = {"ethereal_flight_potion.png"},
	inventory_image = "ethereal_flight_potion.png",
	wield_image = "ethereal_flight_potion.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.37, -0.2, 0.2, 0.31, 0.2}
	},
	groups = {dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),

	on_use = function(itemstack, user, pointed_thing)

		-- get privs
		local name = user:get_player_name()
		local privs = minetest.get_player_privs(name)
		local meta = user:get_meta()
		local timer = meta:get_string("ethereal:fly_timer")

		if privs.fly then

			local msg = timer

			if timer == "" or timer == "-99" then
				msg = S("unlimited")
			end

			minetest.chat_send_player(name,
				minetest.get_color_escape_sequence("#ffff00")
				.. S("Flight already granted, @1 seconds left!", msg))

			return
		end

		if not meta then return end

		meta:set_string("ethereal:fly_timer", flight_secs)

		minetest.chat_send_player(name,
				minetest.get_color_escape_sequence("#1eff00")
				.. S("Flight granted, you have @1 seconds!", flight_secs))

		ethereal_set_flight(user)

		-- take item
		itemstack:take_item()

		-- return empty bottle
		local inv = user:get_inventory()

		if inv:room_for_item("main", {name = "vessels:glass_bottle"}) then
			user:get_inventory():add_item("main", "vessels:glass_bottle")
		else
			minetest.add_item(user:get_pos(), {name = "vessels:glass_bottle"})
		end

		return itemstack
	end
})


-- recipe
minetest.register_craft({
	output = "ethereal:flight_potion",
	recipe = {
		{"ethereal:etherium_dust", "ethereal:etherium_dust", "ethereal:etherium_dust"},
		{"ethereal:etherium_dust", "ethereal:fire_dust", "ethereal:etherium_dust"},
		{"ethereal:etherium_dust", "vessels:glass_bottle", "ethereal:etherium_dust"}
	}
})
