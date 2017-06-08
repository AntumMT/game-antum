

--Dirt Road Side
minetest.register_node("mypaths:dirt_road_side", {
	description = "Dirt Road Side",
	tiles = {"mypaths_dirt_road_side.png",
			"mypaths_dirt_road_side.png",
			"default_grass.png",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road_side2.png",
			"mypaths_dirt_road_side.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Side Angle
minetest.register_node("mypaths:dirt_road_side_angle", {
	description = "Dirt Road Side Angle",
	tiles = {"mypaths_dirt_road_side_angle.png",
			"default_grass.png",
			"default_grass.png",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road.png",
			"default_grass.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Side Angle End
minetest.register_node("mypaths:dirt_road_side_angle_end1", {
	description = "Dirt Road Angle End 1",
	tiles = {"mypaths_dirt_road_side_angle_end1.png",
			"mypaths_dirt_road_side_angle_end2.png^[transformR180",
			"default_grass.png",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road_side.png^[transformR180",
			"default_grass.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Side Angle End
minetest.register_node("mypaths:dirt_road_side_angle_end2", {
	description = "Dirt Road Angle End 2",
	tiles = {"mypaths_dirt_road_side_angle_end2.png",
			"mypaths_dirt_road_side_angle_end2.png^[transformFY",
			"mypaths_dirt_road.png",
			"default_grass.png",
			"mypaths_dirt_road_side.png",
			"default_grass.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Side Angle End
minetest.register_node("mypaths:dirt_road_side_angle_end3", {
	description = "Dirt Road Angle End 3",
	tiles = {"mypaths_dirt_road_side_angle_end3.png",
			"mypaths_dirt_road_side_angle_end4.png^[transformR180",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road_side.png",
			"mypaths_dirt_road.png",
			"default_grass.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Side Angle End
minetest.register_node("mypaths:dirt_road_side_angle_end4", {
	description = "Dirt Road Angle End 4",
	tiles = {"mypaths_dirt_road_side_angle_end4.png",
			"mypaths_dirt_road_side_angle_end3.png^[transformR180",
			"mypaths_dirt_road_side.png^[transformR180",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road.png",
			"default_grass.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Dirt Road Inside Corner
minetest.register_node("mypaths:dirt_road_icorner", {
	description = "Dirt Road Inside Corner",
	tiles = {"mypaths_dirt_road_icorner.png",
			"mypaths_dirt_road_icorner.png^[transformR90",
			"mypaths_dirt_road_side2.png",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road.png",
			"mypaths_dirt_road_side.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})

--Dirt Road Outside Corner
minetest.register_node("mypaths:dirt_road_ocorner", {
	description = "Dirt Road Outside Corner",
	tiles = {"mypaths_dirt_road_ocorner.png",
			"mypaths_dirt_road_ocorner.png^[transformR270",
			"default_grass.png",
			"mypaths_dirt_road_side2.png",
			"default_grass.png",
			"mypaths_dirt_road_side.png",
			},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})

