--Eaves Trough
minetest.register_node("mysheetmetal:eavestrough", {
	description = "Eavestrough",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1}, 
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.3125, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
		}
	},

})

--Ocorner
minetest.register_node("mysheetmetal:eavestrough_ocorner", {
	description = "Eavestrough Outside Corner",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{0.1875, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{0.4375, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{0.25, 0.25, 0.25, 0.5, 0.3125, 0.5}, 
			{0.1875, 0.25, 0.25, 0.25, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{0.1875, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
		}
	},
})

--Icorner
minetest.register_node("mysheetmetal:eavestrough_icorner", {
	description = "Eavestrough Inside Corner",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, -0.5, -0.4375, 0.5, 0.5}, 
			{-0.4375, 0.25, 0.25, 0.5, 0.3125, 0.4375}, 
			{-0.4375, 0.25, -0.5, -0.25, 0.3125, 0.25}, 
			{-0.25, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{-0.25, 0.25, -0.5, -0.1875, 0.5, 0.1875}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, -0.5, -0.1875, 0.5, 0.5}, 
		}
	},
})

--Downspout
minetest.register_node("mysheetmetal:downspout", {
	description = "Downspout",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.475, 0.125, 0.5, 0.5}, 
			{-0.125, -0.5, 0.3125, 0.125, 0.5, 0.3375}, 
			{-0.125, -0.5, 0.3125, -0.0925, 0.5, 0.5}, 
			{0.0925, -0.5, 0.3125, 0.125, 0.5, 0.5}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.3125, 0.125, 0.5, 0.5}, 
		}
	},
	after_place_node = function(pos, placer)
		local thing = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		 if thing ~= "air" then
		    minetest.set_node(pos,{name = "mysheetmetal:downspout_bottom", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
		 if thing == "mysheetmetal:downspout" then
		    minetest.set_node(pos,{name = "mysheetmetal:downspout", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
		 if thing == "mysheetmetal:downspout_bottom" then
		    minetest.set_node(pos,{name = "mysheetmetal:downspout", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		end
	end,

})

--Evaes Trough with Downspout
minetest.register_node("mysheetmetal:eavestrough_downspout", {
	description = "Eavestrough with Downspout",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{-0.5, 0.25, 0.1875, -0.125, 0.3125, 0.5}, 
			{0.125, 0.25, 0.1875, 0.5, 0.3125, 0.5}, 

			{-0.125, 0, 0.395, 0.125, 0.3125, 0.4375}, 
			{-0.125, 0, 0.25, 0.125, 0.3125, 0.29}, 
			{-0.125, 0, 0.25, -0.0925, 0.3125, 0.4375}, 
			{0.0925, 0, 0.25, 0.125, 0.3125, 0.4375}, 
			{-0.125, -0.0625, 0.25, 0.125, 0.0625, 0.5}, 

			{-0.125, -0.125, 0.3125, 0.125, -0.0625, 0.5}, 
			{-0.125, -0.1875, 0.375, 0.125, -0.125, 0.5}, 


			{-0.125, -0.1875,   0.5, 0.125, 0,             1.375}, 
			{-0.125, -0.5,      1.3125, 0.125, -0.125,     1.335}, 
			{-0.125, -0.5,      1.475, 0.125, -0.125,     1.5}, 
			{-0.125, -0.5,      1.3125, -0.0925, -0.125,   1.5}, 
			{0.0925, -0.5,      1.3125, 0.125, -0.125,     1.5}, 
			{-0.125, -0.25,     1.25, 0.125, -0.0625,      1.4375}, 
			{-0.125, -0.25,      1.25, 0.125, -0.125,     1.5}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
			{-0.125, 0.25, 0.25, 0.125, -0.125, 0.4375},
			{-0.125, -0.1875,   0.5, 0.125, 0, 1.375},
			{-0.125, -0.125, 1.3125, 0.125, -0.5, 1.5},
		}
	},


})
--Bottom
minetest.register_node("mysheetmetal:downspout_bottom", {
	description = "Downspout Bottom",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "eavestrough:downspout",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.1875, 0.3125, 0.125, 0.5, 0.3375}, 
			{-0.125, -0.1875, 0.475, 0.125, 0.5, 0.5}, 
			{-0.125, -0.1875, 0.3125, -0.0925, 0.5, 0.5}, 
			{0.0925, -0.1875, 0.3125, 0.125, 0.5, 0.5}, 

			{-0.125, -0.25, 0.25, 0.125, -0.1875, 0.5}, 
			{-0.125, -0.3125, 0.1875, 0.125, -0.25, 0.5}, 
			{-0.125, -0.475, 0.25, 0.125, -0.3125, 0.375}, 
			{-0.125, -0.3125, 0.25, 0.125, -0.435, 0.4375}, 

			{-0.125, -0.335, -0.125, 0.125, -0.3125, 0.475}, 
			{-0.125, -0.5, -0.125, 0.125, -0.475, 0.3125}, 
			{-0.125, -0.5, -0.125, -0.0925, -0.3125, 0.3125}, 
			{0.0925, -0.5, -0.125, 0.125, -0.3125, 0.3125}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.3125, 0.125, 0.5, 0.5},
			{-0.125, -0.5, -0.125, 0.125, -0.3125, 0.5},  
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:downspout_bottomw", param2=node.param2})
	end

})

--Bottom with Water
minetest.register_node("mysheetmetal:downspout_bottomw", {
	description = "Downspout Bottom with Water",
	tiles = {
		"mysheetmetal_water_top.png",
		"mysheetmetal_white.png",
		"mysheetmetal_water_top.png^[transformR270",
		"mysheetmetal_water_top.png^[transformR90",
		"mysheetmetal_water_back.png",
		"mysheetmetal_water_front.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	drop = "eavestrough:downspout",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.1875, 0.3125, 0.125, 0.5, 0.3375}, 
			{-0.125, -0.1875, 0.475, 0.125, 0.5, 0.5}, 
			{-0.125, -0.1875, 0.3125, -0.0925, 0.5, 0.5}, 
			{0.0925, -0.1875, 0.3125, 0.125, 0.5, 0.5}, 

			{-0.125, -0.25, 0.25, 0.125, -0.1875, 0.5}, 
			{-0.125, -0.3125, 0.1875, 0.125, -0.25, 0.5}, 
			{-0.125, -0.475, 0.25, 0.125, -0.3125, 0.375}, 
			{-0.125, -0.3125, 0.25, 0.125, -0.435, 0.4375}, 

			{-0.125, -0.335, -0.125, 0.125, -0.3125, 0.475}, 
			{-0.125, -0.5, -0.125, 0.125, -0.475, 0.3125}, 
			{-0.125, -0.5, -0.125, -0.0925, -0.3125, 0.3125}, 
			{0.0925, -0.5, -0.125, 0.125, -0.3125, 0.3125}, 

			{-0.0625, -0.5, -0.4375, 0.0625, -0.375, 0.125}, 
			{-0.1875, -0.5, -0.5, 0.1875, -0.4375, -0.1875}, 
			{-0.25, -0.5, -0.4375, 0.25, -0.4375, -0.1255}, 
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, 0.3125, 0.125, 0.5, 0.5},
			{-0.125, -0.5, -0.125, 0.125, -0.3125, 0.5}, 
		}
	},

	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos,{name = "mysheetmetal:downspout_bottom", param2=node.param2})
	end

})



--Eavestrough with right cap
minetest.register_node("mysheetmetal:eavestrough_rc", {
	description = "Eavestrough rc",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.3125, 0.5},
			{0.4375, 0.25, 0.1875, 0.5, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
		}
	},

})
--Eavestrough with left cap
minetest.register_node("mysheetmetal:eavestrough_lc", {
	description = "Eavestrough lc",
	tiles = {"mysheetmetal_white.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1}, 
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.4375, 0.5, 0.5, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.25}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.3125, 0.5},
			{-0.4375, 0.25, 0.1875, -0.5, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.5}, 
		}
	},
})
