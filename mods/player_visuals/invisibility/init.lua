
invisibility = {}

local effect_time = 300 -- 5 minutes

-- invisibility function

local toggle_invisible = function(player, toggle)

	if not player then return false end

	local name = player:get_player_name()

	invisibility[name] = toggle

	local prop

	if toggle == true then

		-- hide player and name tag
		prop = {
			visual_size = {x = 0, y = 0},
			collisionbox = {0, 0, 0, 0, 0, 0}
		}

		player:set_nametag_attributes({
			color = {a = 0, r = 255, g = 255, b = 255}
		})
	else
		-- show player and tag
		prop = {
			visual_size = {x = 1, y = 1},
			collisionbox = {-0.35, -1, -0.35, 0.35, 1, 0.35}
		}

		player:set_nametag_attributes({
			color = {a = 255, r = 255, g = 255, b = 255}
		})
	end

	player:set_properties(prop)

end

-- vanish command (admin only)

minetest.register_chatcommand("vanish", {
	params = "<name>",
	description = "Make player invisible",
	privs = {server = true},

	func = function(name, param)

		-- player online
		if param ~= ""
		and minetest.get_player_by_name(param) then

			name = param

		-- player not online
		elseif param ~= "" then

			return false, "Player " .. param .. " is not online!"
		end

		local player = minetest.get_player_by_name(name)

		-- hide / show player
		if invisibility[name] then

			toggle_invisible(player, nil)
		else
			toggle_invisible(player, true)
		end

	end
})

-- reset player invisibility if they go offline

minetest.register_on_leaveplayer(function(player)

	local name = player:get_player_name()

	if invisibility[name] then
		invisibility[name] = nil
	end
end)

-- invisibility potion

minetest.register_node("invisibility:potion", {
	description = "Invisibility Potion",
	drawtype = "plantlike",
	tiles = {"invisibility_potion.png"},
	inventory_image = "invisibility_potion.png",
	wield_image = "invisibility_potion.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),

	on_use = function(itemstack, user)

		local pos = user:getpos()
		local name = user:get_player_name()

		-- are we already invisible?
		if invisibility[name] then

			minetest.chat_send_player(name,
				">>> You are already invisible!")

				return itemstack
		end


		-- make player invisible
		toggle_invisible(user, true)

		-- play sound
		minetest.sound_play("pop", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5
		})

		-- display 10 second warning
		minetest.after(effect_time - 10, function()

			if invisibility[name]
			and user:getpos() then

				minetest.chat_send_player(name,
					">>> You have 10 seconds before invisibility wears off!")
			end
		end)

		-- make player visible 5 minutes later
		minetest.after(effect_time, function()

			if invisibility[name]
			and user:getpos() then

				-- show aready hidden player
				toggle_invisible(user, nil)

				-- play sound
				minetest.sound_play("pop", {
					pos = pos,
					gain = 1.0,
					max_hear_distance = 5
				})
			end
		end)

		-- take potion, return empty bottle (and rest of potion stack)
		if not minetest.setting_getbool("creative_mode") then

			local item_count = user:get_wielded_item():get_count()
			local inv = user:get_inventory()
			local giving_back = "vessels:glass_bottle"

			if inv and item_count > 1 then

				if inv:room_for_item("main", {name = "vessels:glass_bottle"}) then

					inv:add_item("main", {name = "vessels:glass_bottle"})
				else
					pos.y = pos.y + 1

					minetest.add_item(pos, {name = "vessels:glass_bottle"})
				end

				giving_back = "invisibility:potion " .. tostring(item_count - 1)

			end

			return ItemStack(giving_back)
		end

	end,
})

-- craft recipe

minetest.register_craft( {
	output = "invisibility:potion",
	type = "shapeless",
	recipe = {"default:nyancat_rainbow", "vessels:glass_bottle"},
})
