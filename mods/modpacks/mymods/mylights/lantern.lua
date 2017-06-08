
minetest.register_node("mylights:lantern_30", {
	description = "Lantern 30w",
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png"
	},
	sunlight_propagates = true,
	walkable = true,
	light_source = 5,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1, cracky = 2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.3125, 0.3125}, 
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, 
			{-0.3125, -0.375, -0.3125, -0.1875, 0.375, -0.1875}, 
			{-0.3125, -0.375, 0.1875, -0.1875, 0.375, 0.3125}, 
			{0.1875, -0.375, 0.1875, 0.3125, 0.375, 0.3125}, 
			{0.1875, -0.375, -0.3125, 0.3125, 0.375, -0.1875}, 
			{-0.4375, 0.375, -0.4375, 0.4375, 0.1875, 0.4375}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_30 1",
		recipe = {
			{'','wool:black',''},
			{'wool:black','wool:white','wool:black'},
			{'','mylights:lightbulb30',''}
			}
})
minetest.register_node("mylights:lantern_60", {
	description = "Lantern 60w",
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png"
	},
	sunlight_propagates = true,
	walkable = true,
	light_source = 8,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1, cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.3125, 0.3125}, 
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, 
			{-0.3125, -0.375, -0.3125, -0.1875, 0.375, -0.1875}, 
			{-0.3125, -0.375, 0.1875, -0.1875, 0.375, 0.3125}, 
			{0.1875, -0.375, 0.1875, 0.3125, 0.375, 0.3125}, 
			{0.1875, -0.375, -0.3125, 0.3125, 0.375, -0.1875}, 
			{-0.4375, 0.375, -0.4375, 0.4375, 0.1875, 0.4375}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_60 1",
		recipe = {
			{'','wool:black',''},
			{'wool:black','wool:white','wool:black'},
			{'','mylights:lightbulb60',''}
			}
})

minetest.register_node("mylights:lantern_90", {
	description = "Lantern 90w",
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png"
	},
	sunlight_propagates = true,
	walkable = true,
	light_source = 11,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1, cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.3125, 0.3125}, 
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, 
			{-0.3125, -0.375, -0.3125, -0.1875, 0.375, -0.1875}, 
			{-0.3125, -0.375, 0.1875, -0.1875, 0.375, 0.3125}, 
			{0.1875, -0.375, 0.1875, 0.3125, 0.375, 0.3125}, 
			{0.1875, -0.375, -0.3125, 0.3125, 0.375, -0.1875}, 
			{-0.4375, 0.375, -0.4375, 0.4375, 0.1875, 0.4375}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_90 1",
		recipe = {
			{'','wool:black',''},
			{'wool:black','wool:white','wool:black'},
			{'','mylights:lightbulb90',''}
			}
})

minetest.register_node("mylights:lantern_120", {
	description = "Lantern 120w",
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png"
	},
	sunlight_propagates = true,
	walkable = true,
	light_source = 14,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1, cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.3125, 0.3125}, 
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, 
			{-0.3125, -0.375, -0.3125, -0.1875, 0.375, -0.1875}, 
			{-0.3125, -0.375, 0.1875, -0.1875, 0.375, 0.3125}, 
			{0.1875, -0.375, 0.1875, 0.3125, 0.375, 0.3125}, 
			{0.1875, -0.375, -0.3125, 0.3125, 0.375, -0.1875}, 
			{-0.4375, 0.375, -0.4375, 0.4375, 0.1875, 0.4375}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_120 1",
		recipe = {
			{'','wool:black',''},
			{'wool:black','wool:white','wool:black'},
			{'','mylights:lightbulb120',''}
			}
})
-------------------------------------------------------------------------------------
minetest.register_node("mylights:lantern_sm_30", {
	description = "Lantern Small 30w",
	paramtype = "light",
	groups = {cracky = 1, cracky = 2},
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png", 
		"mylights_streetlight.png",
	},
	drawtype = "nodebox",
	light_source = 5,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.125, 0.125, 0.3125, 0.125}, 
			{-0.1875, -0.25, -0.1875, 0.1875, -0.125, -0.125}, 
			{-0.1875, -0.25, 0.125, 0.1875, -0.125, 0.1875}, 
			{-0.1875, -0.25, -0.1875, -0.125, -0.125, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, -0.125, 0.125}, 
			{-0.1875, 0.125, 0.125, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, 0.1875, 0.25, -0.125}, 
			{0.125, 0.125, -0.1875, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, -0.125, 0.25, 0.1875}, 
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.5, 0.0625}, 
			{0.125, -0.125, 0.125, 0.1875, 0.1875, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, 0.25, -0.125},
			{-0.1875, -0.1875, -0.1875, -0.125, 0.25, -0.125}, 
			{-0.1875, -0.1875, 0.125, -0.125, 0.25, 0.1875}, 
			{-0.25, 0.1875, -0.25, 0.25, 0.25, 0.25}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_sm_30 1",
		recipe = {
			{'','wool:black',''},
			{'','wool:white',''},
			{'','mylights:lightbulb30',''}
			}
})

minetest.register_node("mylights:lantern_sm_60", {
	description = "Lantern Small 60w",
	paramtype = "light",
	groups = {cracky = 1, cracky = 2, not_in_creative_inventory=1},
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png", 
		"mylights_streetlight.png",
	},
	drawtype = "nodebox",
	light_source = 8,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.125, 0.125, 0.3125, 0.125}, 
			{-0.1875, -0.25, -0.1875, 0.1875, -0.125, -0.125}, 
			{-0.1875, -0.25, 0.125, 0.1875, -0.125, 0.1875}, 
			{-0.1875, -0.25, -0.1875, -0.125, -0.125, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, -0.125, 0.125}, 
			{-0.1875, 0.125, 0.125, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, 0.1875, 0.25, -0.125}, 
			{0.125, 0.125, -0.1875, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, -0.125, 0.25, 0.1875}, 
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.5, 0.0625}, 
			{0.125, -0.125, 0.125, 0.1875, 0.1875, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, 0.25, -0.125},
			{-0.1875, -0.1875, -0.1875, -0.125, 0.25, -0.125}, 
			{-0.1875, -0.1875, 0.125, -0.125, 0.25, 0.1875}, 
			{-0.25, 0.1875, -0.25, 0.25, 0.25, 0.25}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_sm_60 1",
		recipe = {
			{'','wool:black',''},
			{'','wool:white',''},
			{'','mylights:lightbulb60',''}
			}
})
minetest.register_node("mylights:lantern_sm_90", {
	description = "Lantern Small 90w",
	paramtype = "light",
	groups = {cracky = 1, cracky = 2, not_in_creative_inventory=1},
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png", 
		"mylights_streetlight.png",
	},
	drawtype = "nodebox",
	light_source = 11,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.125, 0.125, 0.3125, 0.125}, 
			{-0.1875, -0.25, -0.1875, 0.1875, -0.125, -0.125}, 
			{-0.1875, -0.25, 0.125, 0.1875, -0.125, 0.1875}, 
			{-0.1875, -0.25, -0.1875, -0.125, -0.125, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, -0.125, 0.125}, 
			{-0.1875, 0.125, 0.125, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, 0.1875, 0.25, -0.125}, 
			{0.125, 0.125, -0.1875, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, -0.125, 0.25, 0.1875}, 
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.5, 0.0625}, 
			{0.125, -0.125, 0.125, 0.1875, 0.1875, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, 0.25, -0.125},
			{-0.1875, -0.1875, -0.1875, -0.125, 0.25, -0.125}, 
			{-0.1875, -0.1875, 0.125, -0.125, 0.25, 0.1875}, 
			{-0.25, 0.1875, -0.25, 0.25, 0.25, 0.25}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_sm_90 1",
		recipe = {
			{'','wool:black',''},
			{'','wool:white',''},
			{'','mylights:lightbulb90',''}
			}
})
minetest.register_node("mylights:lantern_sm_120", {
	description = "Lantern Small 120w",
	paramtype = "light",
	groups = {cracky = 1, cracky = 2, not_in_creative_inventory=1},
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png",
		"mylights_streetlight.png", 
		"mylights_streetlight.png",
	},
	drawtype = "nodebox",
	light_source = 14,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.3125, -0.125, 0.125, 0.3125, 0.125}, 
			{-0.1875, -0.25, -0.1875, 0.1875, -0.125, -0.125}, 
			{-0.1875, -0.25, 0.125, 0.1875, -0.125, 0.1875}, 
			{-0.1875, -0.25, -0.1875, -0.125, -0.125, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, -0.125, 0.125}, 
			{-0.1875, 0.125, 0.125, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, 0.1875, 0.25, -0.125}, 
			{0.125, 0.125, -0.1875, 0.1875, 0.25, 0.1875}, 
			{-0.1875, 0.125, -0.1875, -0.125, 0.25, 0.1875}, 
			{-0.0625, -0.3125, -0.0625, 0.0625, 0.5, 0.0625}, 
			{0.125, -0.125, 0.125, 0.1875, 0.1875, 0.1875}, 
			{0.125, -0.25, -0.1875, 0.1875, 0.25, -0.125},
			{-0.1875, -0.1875, -0.1875, -0.125, 0.25, -0.125}, 
			{-0.1875, -0.1875, 0.125, -0.125, 0.25, 0.1875}, 
			{-0.25, 0.1875, -0.25, 0.25, 0.25, 0.25}, 
		}
	}
})
--craft
minetest.register_craft({
		output = "mylights:lantern_sm_120 1",
		recipe = {
			{'','wool:black',''},
			{'','wool:white',''},
			{'','mylights:lightbulb120',''}
			}
})
