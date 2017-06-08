local ceiling_lights = {   --color , Description 
	{ "white" , "White"},
	{ "yellow" , "Yellow"},	
	{ "blue" , "Blue"},
}

for i in ipairs(ceiling_lights) do
	local color = ceiling_lights[i][1]
	local desc = ceiling_lights[i][2]
	local item = ceiling_lights[i][3]

minetest.register_node("mylights:ceiling_light_30_"..color, {
	description = desc.."Ceiling Light 30w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 5,
	groups = {snappy = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_30_"..color.." 1",
		recipe = {
			{'','mylights:lightbulb30',''},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_60_"..color, {
	description = desc.."Ceiling Light 60w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_60_"..color.." 1",
		recipe = {
			{'','mylights:lightbulb60',''},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_90_"..color, {
	description = desc.."Ceiling Light 90w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 11,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_90_"..color.." 1",
		recipe = {
			{'','mylights:lightbulb90',''},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_120_"..color, {
	description = desc.."Ceiling Light 120w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 14,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_120_"..color.." 1",
		recipe = {
			{'','mylights:lightbulb120',''},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})

-----------------------------------------------------------------------------------
minetest.register_node("mylights:ceiling_light_lg_30_"..color, {
	description = desc.."Larger Ceiling Light 30w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 5,
	groups = {snappy = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
			{-0.375, -0.25, -0.3125, 0.375, -0.5, 0.3125}, 
			{-0.3125, -0.25, -0.375, 0.3125, -0.5, 0.375}, 
			{-0.3125, -0.125, -0.25, 0.3125, -0.5, 0.25}, 
			{-0.25, -0.125, -0.3125, 0.25, -0.5, 0.3125}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_lg_30_"..color.." 1",
		recipe = {
			{'xpanes:pane','mylights:lightbulb30','xpanes:pane'},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_lg_60_"..color, {
	description = desc.."Larger Ceiling Light 60w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
			{-0.375, -0.25, -0.3125, 0.375, -0.5, 0.3125}, 
			{-0.3125, -0.25, -0.375, 0.3125, -0.5, 0.375}, 
			{-0.3125, -0.125, -0.25, 0.3125, -0.5, 0.25}, 
			{-0.25, -0.125, -0.3125, 0.25, -0.5, 0.3125}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_lg_60_"..color.." 1",
		recipe = {
			{'xpanes:pane','mylights:lightbulb60','xpanes:pane'},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_lg_90_"..color, {
	description = desc.."Larger Ceiling Light 90w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 11,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
			{-0.375, -0.25, -0.3125, 0.375, -0.5, 0.3125}, 
			{-0.3125, -0.25, -0.375, 0.3125, -0.5, 0.375}, 
			{-0.3125, -0.125, -0.25, 0.3125, -0.5, 0.25}, 
			{-0.25, -0.125, -0.3125, 0.25, -0.5, 0.3125}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_lg_90_"..color.." 1",
		recipe = {
			{'xpanes:pane','mylights:lightbulb90','xpanes:pane'},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
minetest.register_node("mylights:ceiling_light_lg_120_"..color, {
	description = desc.."Larger Ceiling Light 120w",
	tiles = {"mylights_ceiling_"..color..".png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 14,
	groups = {snappy = 1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.375, -0.375, 0.4375, -0.5, 0.375}, 
			{-0.375, -0.375, -0.4375, 0.375, -0.5, 0.4375}, 
			{-0.375, -0.25, -0.3125, 0.375, -0.5, 0.3125}, 
			{-0.3125, -0.25, -0.375, 0.3125, -0.5, 0.375}, 
			{-0.3125, -0.125, -0.25, 0.3125, -0.5, 0.25}, 
			{-0.25, -0.125, -0.3125, 0.25, -0.5, 0.3125}, 
		}
	},
	on_place = minetest.rotate_node,
})
minetest.register_craft({
		output = "mylights:ceiling_light_lg_120_"..color.." 1",
		recipe = {
			{'xpanes:pane','mylights:lightbulb120','xpanes:pane'},
			{'','xpanes:pane',''},
			{'','dye:'..color,''}
			}
})
end
