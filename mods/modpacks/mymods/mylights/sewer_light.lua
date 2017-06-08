minetest.register_node("mylights:sewer_light_30", {
	description = "Sewer Light 30w",
	tiles = {"mylights_sewer_light.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=2, cracky = 2},
	sunlight_propagates = true,
	light_source = 5,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.1875, 0.1875, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox2
			{-0.0625, 0.1875, -0.1875, 0.0625, 0.5, 0.1875}, -- NodeBox3
		}
	},

})
--craft
minetest.register_craft({
		output = "mylights:sewer_light_30 5",
		recipe = {
			{'','wool:black',''},
			{'','wool:yellow',''},
			{'','mylights:lightbulb30',''}
			}
})
minetest.register_node("mylights:sewer_light_60", {
	description = "Sewer Light 60w",
	tiles = {"mylights_sewer_light.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=2, cracky = 2, not_in_creative_inventory=1},
	sunlight_propagates = true,
	light_source = 8,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.1875, 0.1875, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox2
			{-0.0625, 0.1875, -0.1875, 0.0625, 0.5, 0.1875}, -- NodeBox3
		}
	},

})
--craft
minetest.register_craft({
		output = "mylights:sewer_light_60 5",
		recipe = {
			{'','wool:black',''},
			{'','wool:yellow',''},
			{'','mylights:lightbulb60',''}
			}
})
minetest.register_node("mylights:sewer_light_90", {
	description = "Sewer Light 90w",
	tiles = {"mylights_sewer_light.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=2, cracky = 2, not_in_creative_inventory=1},
	sunlight_propagates = true,
	light_source = 11,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.1875, 0.1875, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox2
			{-0.0625, 0.1875, -0.1875, 0.0625, 0.5, 0.1875}, -- NodeBox3
		}
	},

})
--craft
minetest.register_craft({
		output = "mylights:sewer_light_90 5",
		recipe = {
			{'','wool:black',''},
			{'','wool:yellow',''},
			{'','mylights:lightbulb90',''}
			}
})
minetest.register_node("mylights:sewer_light_120", {
	description = "Sewer Light 120w",
	tiles = {"mylights_sewer_light.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=2, cracky = 2, not_in_creative_inventory=1},
	sunlight_propagates = true,
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, 0.125, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.1875, 0.1875, -0.0625, 0.1875, 0.5, 0.0625}, -- NodeBox2
			{-0.0625, 0.1875, -0.1875, 0.0625, 0.5, 0.1875}, -- NodeBox3
		}
	},

})
--craft
minetest.register_craft({
		output = "mylights:sewer_light_120 5",
		recipe = {
			{'','wool:black',''},
			{'','wool:yellow',''},
			{'','mylights:lightbulb120',''}
			}
})
