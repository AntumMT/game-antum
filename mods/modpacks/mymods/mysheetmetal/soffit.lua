minetest.register_node("mysheetmetal:soffit", {
	description = "Soffit",
	tiles = {
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, -0.4375, 0.5},
			{-0.4375, -0.4375, -0.5, -0.25, -0.375, 0.5},
			{-0.3125, -0.5, -0.5, -0.0625, -0.4375, 0.5}, 
			{-0.125, -0.4375, -0.5, 0.125, -0.375, 0.5},
			{0.0625, -0.5, -0.5, 0.3125, -0.4375, 0.5}, 
			{0.25, -0.4375, -0.5, 0.4375, -0.375, 0.5},
			{0.375, -0.5, -0.5, 0.5, -0.4375, 0.5}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, 
		}
	},
	on_place = minetest.rotate_node,
})

minetest.register_node("mysheetmetal:soffit_corner", {
	description = "Soffit Corner",
	tiles = {
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		"mysheetmetal_white.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.4375, -0.5, -0.25, -0.375, -0.25},
			{-0.125, -0.4375, -0.5, 0.125, -0.375, 0.125}, 
			{0.25, -0.4375, -0.5, 0.4375, -0.375, 0.375}, 
			{-0.5, -0.4375, 0.25, 0.4375, -0.375, 0.4375}, 
			{-0.5, -0.4375, -0.125, -0.125, -0.375, 0.125}, 
			{-0.5, -0.4375, -0.4375, -0.4375, -0.375, -0.25}, 
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, 
		}
	},
	on_place = minetest.rotate_node,
})


minetest.register_node("mysheetmetal:soffit_cap", {
	description = "Soffit Cap Narrow",
	tiles = {
		"mysheetmetal_white.png^[transformR90",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5},
		}
	},
})

minetest.register_node("mysheetmetal:soffit_cap_icorner", {
	description = "Soffit Cap Narrow Inside Corner",
	tiles = {
		"mysheetmetal_white.png^[transformR90",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.4375, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.4375, 0.5, 0.5},
		}
	},
})

minetest.register_node("mysheetmetal:soffit_cap_ocorner", {
	description = "Soffit Cap Narrow Outside Corner",
	inventory_image = "mysheetmetal_mach12.png",
	tiles = {
		"mysheetmetal_white.png^[transformR90",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, 0.4375, -0.4375, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, 0.375, 0.4375, -0.4375, 0.5, 0.5},
		}
	},
})
