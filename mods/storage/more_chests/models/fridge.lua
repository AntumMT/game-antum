local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local S = minetest.get_translator("more_chests")

-- TODO model open

-- normal fridge
local fridge = gen_def({
	description = S("Fridge"),
	type = "fridge",
	size = "small",
	tiles = {
		side = "fridge_side.png",
		front = "fridge_front.png",
	},
})

minetest.register_node("more_chests:fridge", fridge)
minetest.register_craft({
	output = "more_chests:fridge",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:ice", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

-- big fridge
local big_fridge = gen_def({
	description = S("Big Fridge"),
	type = "fridge",
	size = "big",
	node_box = {
		{-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	tiles = {
		side = "fridge_side.png",
		front = "fridge_front.png",
	},
})

minetest.register_node("more_chests:big_fridge", big_fridge)
minetest.register_craft({
	output = "more_chests:big_fridge",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:ice", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})
