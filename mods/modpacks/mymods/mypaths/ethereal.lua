
--Dirt Road Side
minetest.register_craft({
	output = "mypaths:dirt_road_side 9",
	recipe = {
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
	}
})
--Dirt Road Side Angle
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"ethereal:dry_dirt", "default:dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end1 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end2 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "default:dirt","default:dirt"},
		{"default:dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end3 9",
	recipe = {
		{"default:dirt", "default:dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
	}
})
--Dirt Road Side Angle End
minetest.register_craft({
	output = "mypaths:dirt_road_side_angle_end4 9",
	recipe = {
		{"ethereal:dry_dirt", "default:dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
	}
})
--Dirt Road Inside Corner
minetest.register_craft({
	output = "mypaths:dirt_road_icorner 9",
	recipe = {
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
	}
})

--Dirt Road Outside Corner
minetest.register_craft({
	output = "mypaths:dirt_road_ocorner 9",
	recipe = {
		{"default:dirt", "default:dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","default:dirt"},
	}
})

--Dirt Slope
minetest.register_craft({
	output = "mypaths:dirt_dirt_slope 6",
	recipe = {
		{"", "","ethereal:dry_dirt"},
		{"", "ethereal:dry_dirt","ethereal:dry_dirt"},
		{"ethereal:dry_dirt", "ethereal:dry_dirt","ethereal:dry_dirt"},
	}
})
