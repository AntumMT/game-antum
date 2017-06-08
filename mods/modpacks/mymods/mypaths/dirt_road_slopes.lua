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

--Dirt Road Side Slope
minetest.register_node("mypaths:dirt_road_slope", {
	description = "Dirt Road Edge Slope",
	drawtype = "mesh",
	mesh = "slope.obj",
	tiles = {"mypaths_path_mesh.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})


--Craft
minetest.register_craft({
	output = "mypaths:dirt_road_slope 6",
	recipe = {
		{"", "","mypaths:dirt_road_side"},
		{"", "mypaths:dirt_road_side","mypaths:dirt_road_side"},
		{"mypaths:dirt_road_side", "mypaths:dirt_road_side","mypaths:dirt_road_side"},
	}
})

--Dirt Road Side Slope 2
minetest.register_node("mypaths:dirt_road_slope2", {
	description = "Dirt Road Edge Slope 2",
	drawtype = "mesh",
	mesh = "slope.obj",
	tiles = {"mypaths_path_mesh2.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})
--Craft
minetest.register_craft({
	output = "mypaths:dirt_road_slope2 6",
	recipe = {
		{"mypaths:dirt_road_side", "",""},
		{"mypaths:dirt_road_side", "mypaths:dirt_road_side",""},
		{"mypaths:dirt_road_side", "mypaths:dirt_road_side","mypaths:dirt_road_side"},
	}
})

--Dirt Road Slope
minetest.register_node("mypaths:dirt_dirt_slope", {
	description = "Dirt Road Slope",
	drawtype = "mesh",
	mesh = "twelve-twelve.obj",
	tiles = {"mypaths_dirt_road.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})

--Dirt Road Slope Long
minetest.register_node("mypaths:dirt_slope_long", {
	description = "Dirt Long slope",
	drawtype = "mesh",
	mesh = "six-twelve_slope.obj",
	tiles = {"mypaths_dirt_road.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:dirt_slope_long 1",
	recipe = {
		{"mypaths:dirt_dirt_slope", "mypaths:dirt_dirt_slope",""},
		{"", "",""},
		{"", "",""},
	}
})

--Dirt Road Side Slope Long
minetest.register_node("mypaths:dirt_side_slope_long", {
	description = "Dirt Side Long slope",
	drawtype = "mesh",
	mesh = "slope_long.obj",
	tiles = {"mypaths_dirt_side_long_mesh.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:dirt_side_slope_long 1",
	recipe = {
		{"mypaths:dirt_road_slope", "mypaths:dirt_road_slope",""},
		{"", "",""},
		{"", "",""},
	}
})

--Dirt Road Side Slope Long2
minetest.register_node("mypaths:dirt_side_slope_long2", {
	description = "Dirt Side Long slope 2",
	drawtype = "mesh",
	mesh = "slope_long.obj",
	tiles = {"mypaths_dirt_side_long_mesh2.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})
--Craft
minetest.register_craft({
	output = "mypaths:dirt_side_slope_long2 1",
	recipe = {
		{"mypaths:dirt_road_slope2", "mypaths:dirt_road_slope2",""},
		{"", "",""},
		{"", "",""},
	}
})
