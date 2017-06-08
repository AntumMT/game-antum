local light_list = {
	{ "White Light Box", "white"},
	{ "Green Light Box", "green"},	
	{ "Red Light Box", "red"},
	{ "Blue Light Box", "blue"},
	{ "Orange Light Box", "orange"},
	{ "Yellow Light Box", "yellow"},
}


for i in ipairs(light_list) do
	local lightdesc = light_list[i][1]
	local colour = light_list[i][2]


minetest.register_node("mylights:lightbox30_"..colour, {
	description = "30 Watt "..lightdesc,
	tiles = {
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox3_"..colour..".png",
		"mylights_lightbox3_"..colour..".png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 5,
	groups = {cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375}, 
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, 
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, -0.375}, 
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.375, 0.5, 0.5}, 
			{-0.5, -0.5, -0.5, -0.375, -0.375, 0.5}, 
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, -0.375, 0.5}, 
			{0.375, 0.375, -0.5, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, 
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
})


minetest.register_node("mylights:lightbox60_"..colour, {
	description = "60 Watt "..lightdesc,
	tiles = {
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox3_"..colour..".png",
		"mylights_lightbox3_"..colour..".png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 8,
	groups = {cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375}, 
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, 
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, -0.375}, 
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.375, 0.5, 0.5}, 
			{-0.5, -0.5, -0.5, -0.375, -0.375, 0.5}, 
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, -0.375, 0.5}, 
			{0.375, 0.375, -0.5, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, 
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
})


minetest.register_node("mylights:lightbox90_"..colour, {
	description = "90 Watt "..lightdesc,
	tiles = {
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox3_"..colour..".png",
		"mylights_lightbox3_"..colour..".png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 11,
	groups = {cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375}, 
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, 
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, -0.375}, 
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.375, 0.5, 0.5}, 
			{-0.5, -0.5, -0.5, -0.375, -0.375, 0.5}, 
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, -0.375, 0.5}, 
			{0.375, 0.375, -0.5, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, 
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
})

--Craft


minetest.register_node("mylights:lightbox120_"..colour, {
	description = "120 Watt "..lightdesc,
	tiles = {
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox1_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox2_"..colour..".png",
		"mylights_lightbox3_"..colour..".png",
		"mylights_lightbox3_"..colour..".png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 14,
	groups = {cracky = 2, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375}, 
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, 
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, -0.375}, 
			{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, -0.375, 0.5, 0.5}, 
			{-0.5, -0.5, -0.5, -0.375, -0.375, 0.5}, 
			{-0.5, -0.5, 0.375, 0.5, -0.375, 0.5}, 
			{0.375, -0.5, -0.5, 0.5, -0.375, 0.5}, 
			{0.375, 0.375, -0.5, 0.5, 0.5, 0.5}, 
			{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, 
			{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
})

end


