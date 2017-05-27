--[[

Hill Nodebox for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-hill_nodebox
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-hill_nodebox/master/LICENSE

]]--


-- how many square steps to make the hill
local steps = 16

-- build the nodebox
local nodebox, step = {}, 0
for k=1,steps do
	step = k/steps - 0.5
	table.insert(nodebox,{-0.5,-0.5,step, 0.5,step,0.5})
end

-- register the node
minetest.register_node("hill_nodebox:hill", {
	description = "Hill",
	drawtype = "nodebox",
	node_box = {type = "fixed", fixed = nodebox},
	tiles = {
		"default_grass.png", 
		"default_dirt.png", 
		"default_dirt.png^default_grass_side.png", 
		"default_dirt.png^default_grass_side.png", 
		"default_dirt.png^default_grass_side.png", 
		"default_grass.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

-- register the craft
minetest.register_craft({
	output = "hill_nodebox:hill",
	recipe = {
		{"", "", "default:dirt"},
		{"", "default:dirt", "default:dirt"},
		{"default:dirt", "default:dirt", ""},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
