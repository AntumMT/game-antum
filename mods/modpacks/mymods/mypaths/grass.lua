local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local slope_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -1.5,  0.5, -0.375, 0.5},  --  NodeBox1
		{-0.5, -0.375, -1.25, 0.5, -0.25,  0.5},  --  NodeBox2
		{-0.5, -0.25,  -1,    0.5, -0.125, 0.5},  --  NodeBox3
		{-0.5, -0.125, -0.75, 0.5,  0,     0.5},  --  NodeBox4
		{-0.5,  0,     -0.5,  0.5,  0.125, 0.5},  --  NodeBox5
		{-0.5,  0.125, -0.25, 0.5,  0.25,  0.5},  --  NodeBox6
		{-0.5,  0.25,   0,    0.5,  0.375, 0.5},  --  NodeBox7
		{-0.5,  0.375,  0.25, 0.5,  0.5,   0.5},  --  NodeBox8
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox5
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5}, -- NodeBox6
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5}, -- NodeBox7
		{-0.5, 0, -0.5, 0, 0.25, 0.5}, -- NodeBox8
		{-0.5, 0, 0, 0.5, 0.25, 0.5}, -- NodeBox9
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, -- NodeBox10
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}, -- NodeBox11
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local icorner_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -1.5, -0.25, 0.5, 0.5},
		{-0.5, -0.5, 0.25, 1.5, 0.5, 0.5},
		{-0.5, -0.5, 0, 1.5, 0.375, 0.5},
		{-0.5, -0.5, -1.5, 0, 0.375, 0.5},
		{-0.5, -0.5, -1.5, 0.25, 0.25, 0.5},
		{-0.5, -0.5, -1.5, 0.5, 0.125, 0.5},
		{-0.5, -0.5, -1.5, 0.75, 0, 0.5},
		{-0.5, -0.5, -1.5, 1, -0.125, 0.5},
		{-0.5, -0.5, -1.5, 1.25, -0.25, 0.5},
		{-0.5, -0.5, -1.5, 1.5, -0.375, 0.5},
		{-0.5, -0.5, -0.25, 1.5, 0.25, 0.5},
		{-0.5, -0.5, -0.5, 1.5, 0.125, 0.5}, 
		{-0.5, -0.5, -0.75, 1.5, 0, 0.5},
		{-0.5, -0.5, -1, 1.5, -0.125, 0.5},
		{-0.5, -0.5, -1.25, 1.5, -0.25, 0.5},
	}
}

local ocorner_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.25, -0.25, 0.5, 0.5},
		{-0.5, -0.5, 0, 0, 0.375, 0.5},
		{-0.5, -0.5, -0.25, 0.25, 0.25, 0.5},
		{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, 
		{-0.5, -0.5, -0.75, 0.75, 0, 0.5}, 
		{-0.5, -0.5, -1, 1, -0.125, 0.5}, 
		{-0.5, -0.5, -1.25, 1.25, -0.25, 0.5}, 
		{-0.5, -0.5, -1.5, 1.5, -0.375, 0.5},
	}
}

--Grass Block
minetest.register_node("mypaths:grass", {
	description = "Fake Grass",
	tiles = {"default_grass.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})
--Craft
minetest.register_craft({
	output = "mypaths:grass 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
	}
})

minetest.register_node("mypaths:grass_slope", {
	description = "Grass slope",
	drawtype = "mesh",
	mesh = "twelve-twelve.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_slope 6",
	recipe = {
		{"", "","mypaths:grass"},
		{"", "mypaths:grass","mypaths:grass"},
		{"mypaths:grass", "mypaths:grass","mypaths:grass"},
	}
})
minetest.register_node("mypaths:grass_slope_long", {
	description = "Grass Slope Long",
	drawtype = "mesh",
	mesh = "six-twelve_slope.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_slope_long 1",
	recipe = {
		{"mypaths:grass_slope", "mypaths:grass_slope",""},
		{"", "",""},
		{"", "",""},
	}
})

minetest.register_node("mypaths:grass_ocorner", {
	description = "Grass slope (outer corner)",
	drawtype = "mesh",
	mesh = "twelve-twelve-oc.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox,
	selection_box = ocorner_cbox
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_ocorner 4",
	recipe = {
		{"", "",""},
		{"", "mypaths:grass","mypaths:grass"},
		{"", "mypaths:grass","mypaths:grass"},
	}
})


minetest.register_node("mypaths:grass_icorner", {
	description = "Grass slope (inner corner)",
	drawtype = "mesh",
	mesh = "twelve-twelve-ic.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox,
	selection_box = icorner_cbox
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_icorner 5",
	recipe = {
		{"mypaths:grass", "mypaths:grass","mypaths:grass"},
		{"mypaths:grass", "",""},
		{"mypaths:grass", "",""},
	}
})
minetest.register_node("mypaths:grass_slope_long_oc", {
	description = "Grass Slope Long (Outer Corner)",
	drawtype = "mesh",
	mesh = "six-twelve_slope-oc.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox_long,
	selection_box = ocorner_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_slope_long_oc 3",
	recipe = {
		{"mypaths:grass_slope", "mypaths:grass_slope","mypaths:grass_slope"},
		{"mypaths:grass_slope", "mypaths:grass_slope",""},
		{"mypaths:grass_slope", "",""},
	}
})
minetest.register_node("mypaths:grass_slope_long_ic", {
	description = "Grass Slope Long (Inner Corner)",
	drawtype = "mesh",
	mesh = "six-twelve_slope-ic.obj",
	tiles = {"default_grass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox_long,
	selection_box = icorner_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:grass_slope_long_ic 4",
	recipe = {
		{"mypaths:grass_slope", "mypaths:grass_slope","mypaths:grass_slope"},
		{"mypaths:grass_slope", "mypaths:grass_slope","mypaths:grass_slope"},
		{"mypaths:grass_slope", "mypaths:grass_slope",""},
	}
})
