abstract_trees.trees_register_nodes_tree = function(name)


  minetest.register_node("trees:leaves_"..name, {
	  description = name.. " Leaves",
	  drawtype = "allfaces_optional",
	  tiles = {"trees_leaves_"..name..".png"},
	  paramtype = "light",
	  groups = {snappy=3, leafdecay=3, flammable=2},
	  drop = {
		  max_items = 1,
		  items = {
			  {items = {'trees:sapling_'..name},rarity = 20},
		  }
	  },
	  sounds = default.node_sound_leaves_defaults(),
  })
  
  minetest.register_node("trees:tree_"..name, {
	  description = name.. " Tree",
	  
	  tiles = {"trees_tree_top_"..name..".png", "trees_tree_top_"..name..".png", "trees_tree_"..name..".png"},
	  groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	  sounds = default.node_sound_wood_defaults(),
  })
  
  minetest.register_node("trees:wood_"..name, {
	  description = name.. " Wood",
	  paramtype2 = "facedir",
	  tiles = {"trees_wood_"..name..".png"},
	  groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	  sounds = default.node_sound_wood_defaults(),
  })
  
  minetest.register_craft({
	output = 'trees:wood_'..name..' 4',
	recipe = {
		{'trees:tree_'..name},
	}
  })
  
  minetest.register_node("trees:sapling_"..name, {
	  description = name.." sapling",
	  drawtype = "plantlike",
	  visual_scale = 1.0,
	  tile_images = { "trees_sapling_"..name..".png" },
	  paramtype = "light",
	  walkable = false,
	  groups = {
		  snappy = 2,
		  dig_immediate = 3,
		  flammable = 2
	  },
	  sounds = default.node_sound_defaults(),
  })
  
end

abstract_trees.trees_register_nodes_tree("palm")
abstract_trees.trees_register_nodes_tree("mangrove")
abstract_trees.trees_register_nodes_tree("conifer")

