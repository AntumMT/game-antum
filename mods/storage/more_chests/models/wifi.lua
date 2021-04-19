local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local S = minetest.get_translator("more_chests")
local pipeworks_enabled = minetest.global_exists("pipeworks")

local wifi = gen_def({
	description = S("Wifi Chest"),
	type = "wifi chest",
	size = "small",
	tiles = {
		top = "wifi_top.png",
		side = "wifi_side.png",
		front = {name="wifi_front_animated.png", animation={type="vertical_frames",
			aspect_w=16, aspect_h=16, length=2.0}}
	},
	inventory_name = "more_chests:wifi",
	pipeworks_enabled = pipeworks_enabled, -- this adds groups
})

-- wifi chests can always be removed because content is detached
wifi.can_dig = function(pos, player) return true end

-- pipeworks support (we need to override what is created by gen_def because too generic)
wifi.tube = pipeworks_enabled and {
	insert_object = function(pos, node, stack, direction, owner)
		local wifi_chest_owner
		if not owner then
			local wifi_chest = minetest.get_meta(pos)
			if not wifi_chest then
				return stack
			end
			wifi_chest_owner = wifi_chest:get_string("owner")
			if not wifi_chest_owner then
				return stack
			end
		end
		local player = minetest.get_player_by_name(owner or wifi_chest_owner)
		if not player then
			return stack
		end
		local inv = player:get_inventory()
		return inv:add_item("more_chests:wifi", stack)
	end,
	can_insert = function(pos, node, stack, direction, owner)
		local wifi_chest_owner
		if not owner then
			local wifi_chest = minetest.get_meta(pos)
			if not wifi_chest then
				return stack
			end
			wifi_chest_owner = wifi_chest:get_string("owner")
			if not wifi_chest_owner then
				return false
			end
		end
		local player = minetest.get_player_by_name(owner or wifi_chest_owner)
		if not player then
			return false
		end
		local inv = player:get_inventory()
		return inv:room_for_item("more_chests:wifi", stack)
	end,
	input_inventory = "more_chests:wifi",
	return_input_invref = function(pos, node, direction, player_name)
		if not player_name then
			return false
		end
		local player = minetest.get_player_by_name(player_name)
		if not player then
			return false
		end
		return player:get_inventory()
	end,
	connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
} or nil

minetest.register_node("more_chests:wifi", wifi)
minetest.register_craft({
	output = "more_chests:wifi",
	recipe = {
		{"group:wood", "default:mese", "group:wood"},
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("more_chests:wifi", 8*4)
end)
