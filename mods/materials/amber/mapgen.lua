-- Oregen --
-- Sediments --

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:dirt",
		wherein        = "default:dirt",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 9,
		clust_size     = 3,
		y_min          = -1024,
		y_max          = 31000,
})

if minetest.get_modpath("darkage") then
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:mud",
		wherein        = "darkage:mud",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 9,
		clust_size     = 3,
		y_min          = -1024,
		y_max          = 31000,
})
end

-- Matrices --
for i=1,n do
minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:matrix_" .. types[i]:lower(),
		wherein        = "default:stone",
		clust_scarcity = 75 * 75 * 75,
		clust_num_ores = 1,
		clust_size     = 25,
		y_min          = -31000,
		y_max          = -2048,
})
end
-- Schematics --

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 8,
    fill_ratio = 0.0001,
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("amber") .. "/schematics/amber_trunk1.mts",
		flags = "place_center_x, place_center_z, place_center_y = false",
		rotation = "random",
	})

  minetest.register_decoration({
  		deco_type = "schematic",
  		place_on = {"default:dirt_with_grass"},
  		sidelen = 8,
      fill_ratio = 0.00005,
  		biomes = {"deciduous_forest"},
  		y_min = 1,
  		y_max = 31000,
  		schematic = minetest.get_modpath("amber") .. "/schematics/amber_trunk2.mts",
  		flags = "place_center_x, place_center_z, place_center_y = false",
  		rotation = "random",
  	})

    minetest.register_decoration({
    		deco_type = "schematic",
    		place_on = {"default:dirt_with_grass"},
    		sidelen = 8,
        fill_ratio = 0.00005,
    		biomes = {"deciduous_forest"},
    		y_min = 1,
    		y_max = 31000,
    		schematic = minetest.get_modpath("amber") .. "/schematics/amber_trunk3.mts",
    		flags = "place_center_x, place_center_z, place_center_y = false",
    		rotation = "random",
    	})

      minetest.register_decoration({
      		deco_type = "schematic",
      		place_on = {"default:dirt_with_grass"},
      		sidelen = 8,
          fill_ratio = 0.00001,
      		biomes = {"deciduous_forest"},
      		y_min = 1,
      		y_max = 31000,
      		schematic = minetest.get_modpath("amber") .. "/schematics/amber_trunk4.mts",
      		flags = "place_center_x, place_center_z, place_center_y = false",
      		rotation = "random",
      	})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 8,
    fill_ratio = 0.0001,
		biomes = {"taiga", "coniferous_forest", "floatland_coniferous_forest"},
		y_min = 2,
		y_max = 31000,
		schematic = minetest.get_modpath("amber") .. "/schematics/amber_pine_trunk1.mts",
		flags = "place_center_x, place_center_z, place_center_y = false",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 8,
    fill_ratio = 0.00005,
		biomes = {"taiga", "coniferous_forest", "floatland_coniferous_forest"},
		y_min = 2,
		y_max = 31000,
		schematic = minetest.get_modpath("amber") .. "/schematics/amber_pine_trunk2.mts",
		flags = "place_center_x, place_center_z, place_center_y = false",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 8,
    fill_ratio = 0.00005,
		biomes = {"taiga", "coniferous_forest", "floatland_coniferous_forest"},
		y_min = 2,
		y_max = 31000,
		schematic = minetest.get_modpath("amber") .. "/schematics/amber_pine_trunk3.mts",
		flags = "place_center_x, place_center_z, place_center_y = false",
})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 8,
    fill_ratio = 0.00001,
		biomes = {"taiga", "coniferous_forest", "floatland_coniferous_forest"},
		y_min = 2,
		y_max = 31000,
		schematic = minetest.get_modpath("amber") .. "/schematics/amber_pine_trunk4.mts",
		flags = "place_center_x, place_center_z, place_center_y = false",
})

-- Root System --

minetest.register_ore({
		ore_type        = "blob",
		ore             = "air",
		wherein         = {"default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 15,
		y_min           = -64,
		y_max           = -32,
	})

minetest.register_ore({
		ore_type        = "blob",
		ore             = "amber:root_wall",
		wherein         = {"default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
		clust_scarcity  = 8 * 6 * 8,
		clust_size      = 25,
		y_min           = -64,
		y_max           = -32,
	})

	minetest.register_ore({
			ore_type        = "blob",
			ore             = "amber:root_wall",
			wherein         = {"default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
			clust_scarcity  = 3 * 2 * 3,
			clust_size      = 10,
			y_min           = -64,
			y_max           = -32,
		})

	minetest.register_ore({
			ore_type       = "scatter",
			ore            = "air",
			wherein        = {"amber:root_wall", "default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
			clust_scarcity = 3 * 4 * 3,
			clust_num_ores = 32,
			clust_size     = 18,
			y_min          = -64,
			y_max          = -32,
	})


-- Root system Decorations --
-- Roots --
minetest.register_ore({
		ore_type        = "blob",
		ore             = "amber:tree_all",
		wherein         = {"default:water_source", "air", "amber:root_wall", "default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
		clust_scarcity  = 10 * 2 * 10,
		clust_size      = 16,
		y_min           = -72,
		y_max           = -16,
		noise_params    = {
			offset = 0.0,
			scale = 0.5,
			spread = {x = 50, y = 100, z = 50},
			seed = 5476,
			octaves = 2,
			persist = 0.0
		},
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:root_wall",
		wherein        = {"amber:root_wall", "default:stone"},
		clust_scarcity = 3 * 3 * 3,
		clust_num_ores = 12,
		clust_size     = 6,
		y_min          = -64,
		y_max          = -16,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:root_wall_light",
		wherein        = "amber:root_wall",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 8,
		clust_size     = 12,
		y_min          = -64,
		y_max          = -32,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:root",
		wherein        = "air",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 16,
		clust_size     = 12,
		y_min          = -64,
		y_max          = -16,
})

minetest.register_ore({
		ore_type        = "blob",
		ore             = "amber:tree_all",
		wherein         = {"default:water_source", "air", "amber:root_wall", "default:stone", "default:stone_with_coal", "default:stone_with_iron", "default:stone_with_copper", "default:stone_with_tin", "default:gravel", "default:sand", "default:silver_sand"},
		clust_scarcity  = 10 * 4 * 10,
		clust_size      = 16,
		y_min           = -72,
		y_max           = -16,
		noise_params    = {
			offset = 0.0,
			scale = 0.5,
			spread = {x = 75, y = 75, z = 75},
			seed = 3489,
			octaves = 1,
			persist = 0.0
		},
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:ambertree_green",
		wherein        = {"amber:tree_all"},
		clust_scarcity = 6 * 6 * 6,
		clust_num_ores = 8,
		clust_size     = 8,
		y_min          = -64,
		y_max          = -16,
})

-- Dirt --

minetest.register_ore({
		ore_type        = "blob",
		ore             = "default:dirt",
		wherein         = {"amber:root_wall", "air"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 10,
		y_min           = -68,
		y_max           = -32,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 4536,
			octaves = 1,
			persist = 0.0
		},
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "amber:root_wall",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 16,
		clust_size     = 10,
		y_min          = -68,
		y_max          = -32,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "amber:root_wall",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 12,
		clust_size     = 8,
		y_min          = -68,
		y_max          = -32,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "amber:root_wall",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 12,
		clust_size     = 8,
		y_min          = -68,
		y_max          = -32,
})

-- Walls in Dirt --

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:root_wall",
		wherein        = "default:dirt",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 16,
		clust_size     = 10,
		y_min          = -68,
		y_max          = -32,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:root_wall",
		wherein        = "default:dirt",
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 12,
		clust_size     = 8,
		y_min          = -68,
		y_max          = -32,
})

-- Amber ores --

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:ambertree_root",
		wherein        = "amber:tree_all",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 16,
		clust_size     = 10,
		y_min          = -64,
		y_max          = -32,
})

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:ambertree_root_small",
		wherein        = "amber:tree_all",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 16,
		clust_size     = 8,
		y_min          = -64,
		y_max          = -32,
})
-- Light --

minetest.register_ore({
		ore_type       = "scatter",
		ore            = "amber:particle_spawner",
		wherein        = "air",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 16,
		clust_size     = 8,
		y_min          = -64,
		y_max          = -32,
})

minetest.register_abm{
  label = "lightup",
	nodenames = {"amber:particle_spawner"},
	interval = 8,
	chance = 2,
	catchup = false,
	action = function(pos)
		do_circle(pos)
	end
}
