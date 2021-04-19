local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local S = minetest.get_translator("more_chests")

local cobble = gen_def({
	description = S("Cobble Chest"),
	type = "chest",
	size = "small",
	tiles = {
		top = "default_cobble.png",
		side = "default_cobble.png",
		front = "cobblechest_front.png"
	},
	pipeworks_enabled = true
})


minetest.register_node("more_chests:cobble", cobble)
minetest.register_craft({
	output = "more_chests:cobble",
	recipe = {
		{"group:wood", "default:cobble", "group:wood"},
		{"default:cobble", "default:steel_ingot", "default:cobble"},
		{"group:wood", "default:cobble", "group:wood"}
	}
})
