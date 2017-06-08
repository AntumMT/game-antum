
--Dirt Road
minetest.register_node("mypaths:dirt_road", {
	description = "Dirt Road",
	tiles = {"mypaths_dirt_road.png"},
	drawtype = "normal",
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
	})
--Craft
minetest.register_craft({
	type = "cooking",
	output = "mypaths:dirt_road 1",
	recipe = "default:dirt",
})
--Dirt Road Side
minetest.register_craft({
	output = "mypaths:dirt_road_side 9",
	recipe = {
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
	}
})
--Dirt Road Side Angle
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"mypaths:dirt_road", "default:dirt","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end1 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end2 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "mypaths:dirt_road","mypaths:dirt_road"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end3 9",
	recipe = {
		{"default:dirt", "default:dirt","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end4 9",
	recipe = {
		{"mypaths:dirt_road", "default:dirt","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
	}
})
--Dirt Road Inside Corner
minetest.register_craft({
	output = "mypaths:dirt_road_icorner 9",
	recipe = {
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
	}
})

--Dirt Road Outside Corner
minetest.register_craft({
	output = "mypaths:dirt_road_ocorner 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
		{"mypaths:dirt_road", "mypaths:dirt_road","default:dirt"},
	}
})

--Craft
minetest.register_craft({
	output = "mypaths:dirt_dirt_slope 6",
	recipe = {
		{"", "","mypaths:dirt_road"},
		{"", "mypaths:dirt_road","mypaths:dirt_road"},
		{"mypaths:dirt_road", "mypaths:dirt_road","mypaths:dirt_road"},
	}
})
