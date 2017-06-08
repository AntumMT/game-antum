
local fascia_L_U = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}, 
	}
}

--Fascia 1
minetest.register_node("mysheetmetal:fascia", {
	description = "Fascia",
	drawtype = "mesh",
	mesh = "twelve-twelve_L_Upper.obj",
	tiles = {"mysheetmetal_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = fascia_L_U,
	groups = {choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:fascia_L_L", param2=minetest.dir_to_facedir(puncher:get_look_dir())})
	end
})

--Fascia 2
minetest.register_node("mysheetmetal:fascia_L_L", {
	description = "Fascia Left Lower",
	drawtype = "mesh",
	mesh = "twelve-twelve_L_Under.obj",
	tiles = {"mysheetmetal_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "mysheetmetal:fascia",
	selection_box = fascia_L_U,
	groups = {choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:fascia_R_U", param2=minetest.dir_to_facedir(puncher:get_look_dir())})
	end
})
--Fascia 3
minetest.register_node("mysheetmetal:fascia_R_U", {
	description = "Fascia Right Upper",
	drawtype = "mesh",
	mesh = "twelve-twelve_R_Upper.obj",
	tiles = {"mysheetmetal_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "mysheetmetal:fascia",
	selection_box = fascia_L_U,
	groups = {choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:fascia_R_L", param2=minetest.dir_to_facedir(puncher:get_look_dir())})
	end
})
--Fascia 4
minetest.register_node("mysheetmetal:fascia_R_L", {
	description = "Fascia Right Lower",
	drawtype = "mesh",
	mesh = "twelve-twelve_R_Under.obj",
	tiles = {"mysheetmetal_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "mysheetmetal:fascia",
	selection_box = fascia_L_U,
	groups = {choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing) 
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:fascia_full", param2=minetest.dir_to_facedir(puncher:get_look_dir())})
	end
})
--]]
--Fascia 5
minetest.register_node("mysheetmetal:fascia_full", {
	description = "Fascia Full",
	drawtype = "nodebox",
	tiles = {"mysheetmetal_white.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "mysheetmetal:fascia",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4375}, 
			}
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4375}, 
			}
		},
	groups = {choppy=2, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing) 
		minetest.set_node({x = pos.x, y = pos.y, z = pos.z},{name = "mysheetmetal:fascia", param2=minetest.dir_to_facedir(puncher:get_look_dir())})
	end
})
