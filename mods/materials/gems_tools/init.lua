
--     --
--Tools--
--     --

--
--Tools>Picks
--

minetest.register_tool("gems_tools:pick_ruby", {
	description = "ruby pickaxe",
	inventory_image = "ruby_ruby_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.5, [2]=.50, [3]=0.25}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("gems_tools:stone_pick_ruby", {
	description = "ruby stone pickaxe",
	inventory_image = "gems_stone_ruby_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.5, [2]=1.5, [3]=1.0}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("gems_tools:pick_emerald", {
	description = "emerald pickaxe",
	inventory_image = "gems_emerald_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.50, [2]=1.10, [3]=0.30}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("gems_tools:stone_pick_emerald", {
	description = "emerald stone pickaxe",
	inventory_image = "gems_stone_emerald_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.25, [2]=1.80, [3]=1.0}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("gems_tools:pick_sapphire", {
	description = "sapphire pickaxe",
	inventory_image = "gems_sapphire_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.30}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("gems_tools:stone_pick_sapphire", {
	description = "sapphire stone pickaxe",
	inventory_image = "gems_stone_sapphire_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.8, [2]=1.4, [3]=0.90}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("gems_tools:pick_amethyst", {
	description = "amethyst pickaxe",
	inventory_image = "gems_amethyst_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=3.50, [2]=1.10, [3]=0.30}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:stone_pick_amethyst", {
	description = "amethyst stone pickaxe",
	inventory_image = "gems_stone_amethyst_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.25, [2]=1.80, [3]=1.0}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

--
--Tools>Swords
--

minetest.register_tool("gems_tools:sword_ruby", {
    description = "ruby sword",
	inventory_image = "ruby_ruby_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.25, [2]=0.40, [3]=0.20}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("gems_tools:stone_sword_ruby", {
    description = "ruby stone sword",
	inventory_image = "gems_stone_ruby_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=1.30, [3]=0.70}, uses=45, maxlevel=3},
		},
		damage_groups = {fleshy=9},
	},
})

minetest.register_tool("gems_tools:sword_emerald", {
    description = "emerald sword",
	inventory_image = "gems_emerald_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=0.80, [3]=0.20}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=5.5},
	},
})

minetest.register_tool("gems_tools:stone_sword_emerald", {
    description = "emerald stone sword",
	inventory_image = "gems_stone_emerald_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.0, [2]=1.70, [3]=0.85}, uses=37, maxlevel=2},
		},
		damage_groups = {fleshy=7.5},
	},
})

minetest.register_tool("gems_tools:sword_sapphire", {
    description = "sapphire sword",
	inventory_image = "gems_sapphire_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.5, [2]=0.60, [3]=0.30}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("gems_tools:stone_sword_sapphire", {
    description = "sapphire stone sword",
	inventory_image = "gems_stone_sapphire_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.30, [3]=0.60}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	},
})

minetest.register_tool("gems_tools:sword_amethyst", {
    description = "amethyst sword",
	inventory_image = "gems_amethyst_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.0, [2]=0.80, [3]=0.20}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_tool("gems_tools:stone_sword_amethyst", {
    description = "amethyst stone sword",
	inventory_image = "gems_stone_amethyst_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.0, [2]=1.70, [3]=0.85}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

--
--Tools>Axes
--

minetest.register_tool("gems_tools:axe_emerald", {
	description = "emerald axe",
	inventory_image = "gems_emerald_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=1.20, [3]=0.60}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:stone_axe_emerald", {
	description = "emerald stone axe",
	inventory_image = "gems_stone_emerald_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.0, [2]=1.70, [3]=1.30}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:axe_ruby", {
	description = "ruby axe",
	inventory_image = "ruby_ruby_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.40, [2]=0.30, [3]=0.20}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=2},
	},
})

minetest.register_tool("gems_tools:stone_axe_ruby", {
	description = "ruby stone axe",
	inventory_image = "gems_stone_ruby_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.30, [2]=1.0, [3]=0.60}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_tool("gems_tools:axe_sapphire", {
	description = "sapphire axe",
	inventory_image = "gems_sapphire_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.60, [2]=0.50, [3]=0.30}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("gems_tools:stone_axe_sapphire", {
	description = "sapphire stone axe",
	inventory_image = "gems_stone_sapphire_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.60, [2]=1.40, [3]=1.10}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=6},
	},
})

minetest.register_tool("gems_tools:axe_amethyst", {
	description = "amethyst axe",
	inventory_image = "gems_amethyst_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=1.20, [3]=0.60}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:stone_axe_amethyst", {
	description = "amethyst stone axe",
	inventory_image = "gems_stone_amethyst_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.0, [2]=1.70, [3]=1.30}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

--
--Tools>Shovels
--

minetest.register_tool("gems_tools:shovel_ruby", {
	description = "ruby shovel",
	inventory_image = "ruby_ruby_shovel.png",
	wield_image = "ruby_ruby_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.50}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:stone_shovel_ruby", {
	description = "ruby stone shovel",
	inventory_image = "gems_stone_ruby_shovel.png",
	wield_image = "gems_stone_ruby_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=0.90, [2]=0.30, [3]=0.10}, uses=35, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:shovel_emerald", {
	description = "emerald shovel",
	inventory_image = "gems_emerald_shovel.png",
	wield_image = "gems_emerald_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.20}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("gems_tools:stone_shovel_emerald", {
	description = "emerald stone shovel",
	inventory_image = "gems_stone_emerald_shovel.png",
	wield_image = "gems_stone_emerald_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.70, [2]=1.10, [3]=0.60}, uses=40, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})


minetest.register_tool("gems_tools:shovel_sapphire", {
	description = "sapphire shovel",
	inventory_image = "gems_sapphire_shovel.png",
	wield_image = "gems_sapphire_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.0, [2]=0.40, [3]=0.10}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:stone_shovel_sapphire", {
	description = "sapphire stone shovel",
	inventory_image = "gems_stone_sapphire_shovel.png",
	wield_image = "gems_stone_sapphire_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.40, [2]=0.80, [3]=0.50}, uses=25, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})

minetest.register_tool("gems_tools:shovel_amethyst", {
	description = "amethyst shovel",
	inventory_image = "gems_amethyst_shovel.png",
	wield_image = "gems_amethyst_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.30, [2]=0.70, [3]=0.20}, uses=25, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_tool("gems_tools:stone_shovel_amethyst", {
	description = "amethyst stone shovel",
	inventory_image = "gems_stone_amethyst_shovel.png",
	wield_image = "gems_stone_amethyst_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.70, [2]=1.10, [3]=0.60}, uses=35, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

--             --
--Item registry--
--             --

--
--Ores
--

minetest.register_node("gems_tools:ruby_ore", {
	  description = "ruby ore",
	  tiles = {"default_stone.png^ruby_ruby_ore.png"},
	  is_ground_content = true,
	  groups = {cracky=1},
	  sounds = default.node_sound_defaults(),
	  drop = 'craft "gems_tools:raw_ruby" 1',
})

minetest.register_node("gems_tools:emerald_ore", {
	  description = "emerald ore",
	  tiles = {"default_stone.png^gems_emerald_ore.png"},
	  is_ground_content = true,
	  groups = {cracky=1},
	  sounds = default.node_sound_defaults(),
	  drop = 'craft "gems_tools:raw_emerald" 1',
})

minetest.register_node("gems_tools:sapphire_ore", {
	  description = "sapphire ore",
	  tiles = {"default_stone.png^gems_sapphire_ore.png"},
	  is_ground_content = true,
	  groups = {cracky=1},
	  sounds = default.node_sound_defaults(),
	  drop = 'craft "gems_tools:raw_sapphire" 1',
})

minetest.register_node("gems_tools:amethyst_ore", {
	  description = "amethyst ore",
	  tiles = {"default_stone.png^gems_amethyst_ore.png"},
	  is_ground_content = true,
	  groups = {cracky=1},
	  sounds = default.node_sound_defaults(),
	  drop = 'craft "gems_tools:raw_amethyst" 1',
})

--
--Blocks
--

minetest.register_node( "gems_tools:ruby_block", {
	description = "ruby block",
	tile_images = { "ruby_ruby_block.png" },
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "gems_tools:emerald_block", {
	description = "emerald block",
	tile_images = { "gems_emerald_block.png" },
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "gems_tools:sapphire_block", {
	description = "sapphire block",
	tile_images = { "gems_sapphire_block.png" },
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "gems_tools:amethyst_block", {
	description = "amethyst block",
	tile_images = { "gems_amethyst_block.png" },
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

--
--Gems
--
  
minetest.register_craftitem( "gems_tools:ruby_gem", {
	description = "ruby gem",
	tile_images = { "ruby:ruby_gem" },
	inventory_image = "ruby_ruby_gem.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:emerald_gem", {
	description = "emerald gem",
	tile_images = { "gems_tools:emerald_gem" },
	inventory_image = "gems_emerald_gem.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:sapphire_gem", {
	description = "sapphire gem",
	tile_images = { "gems_tools:sapphire_gem" },
	inventory_image = "gems_sapphire_gem.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:amethyst_gem", {
	description = "amethyst gem",
	tile_images = { "gems_tools:amethyst_gem" },
	inventory_image = "gems_amethyst_gem.png",
	on_place_on_ground = minetest.craftitem_place_item,
	
})

--
--crafting items
--

minetest.register_craftitem( "gems_tools:stone_rod", {
	description = "stone rod",
	tile_images = { "gems_tools:stone_rod" },
	inventory_image = "gems_stone_rod.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--
--Ruby heads
--

minetest.register_craftitem( "gems_tools:ruby_pick_head", {
	description = "ruby pick head",
	tile_images = { "gems_tools:ruby_pick_head" },
	inventory_image = "gems_ruby_pick_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:ruby_axe_head", {
	description = "ruby axe head",
	tile_images = { "gems_tools:ruby_axe_head" },
	inventory_image = "gems_ruby_axe_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:ruby_shovel_head", {
	description = "ruby shovel head",
	tile_images = { "gems_tools:ruby_shovel_head" },
	inventory_image = "gems_ruby_shovel_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:ruby_sword_blade", {
	description = "ruby blade",
	tile_images = { "gems_tools:ruby_sword_blade" },
	inventory_image = "gems_ruby_sword_blade.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--
--amethyst heads
--

minetest.register_craftitem( "gems_tools:amethyst_pick_head", {
	description = "amethyst pick head",
	tile_images = { "gems_tools:amethyst_pick_head" },
	inventory_image = "gems_amethyst_pick_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:amethyst_axe_head", {
	description = "amethyst axe head",
	tile_images = { "gems_tools:amethyst_axe_head" },
	inventory_image = "gems_amethyst_axe_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:amethyst_shovel_head", {
	description = "amethyst shovel head",
	tile_images = { "gems_tools:amethyst_shovel_head" },
	inventory_image = "gems_amethyst_shovel_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:amethyst_sword_blade", {
	description = "amethyst blade",
	tile_images = { "gems_tools:amethyst_sword_blade" },
	inventory_image = "gems_amethyst_sword_blade.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--
--emerald heads
--

minetest.register_craftitem( "gems_tools:emerald_pick_head", {
	description = "emerald pick head",
	tile_images = { "gems_tools:emerald_pick_head" },
	inventory_image = "gems_emerald_pick_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:emerald_axe_head", {
	description = "emerald axe head",
	tile_images = { "gems_tools:emerald_axe_head" },
	inventory_image = "gems_emerald_axe_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:emerald_shovel_head", {
	description = "emerald shovel head",
	tile_images = { "gems_tools:emerald_shovel_head" },
	inventory_image = "gems_emerald_shovel_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:emerald_sword_blade", {
	description = "emerald blade",
	tile_images = { "gems_tools:emerald_sword_blade" },
	inventory_image = "gems_emerald_sword_blade.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--
--sapphire heads
--

minetest.register_craftitem( "gems_tools:sapphire_pick_head", {
	description = "sapphire pick head",
	tile_images = { "gems_tools:sapphire_pick_head" },
	inventory_image = "gems_sapphire_pick_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:sapphire_axe_head", {
	description = "sapphire axe head",
	tile_images = { "gems_tools:sapphire_axe_head" },
	inventory_image = "gems_sapphire_axe_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:sapphire_shovel_head", {
	description = "sapphire shovel head",
	tile_images = { "gems_tools:sapphire_shovel_head" },
	inventory_image = "gems_sapphire_shovel_head.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:sapphire_sword_blade", {
	description = "sapphire blade",
	tile_images = { "gems_tools:sapphire_sword_blade" },
	inventory_image = "gems_sapphire_sword_blade.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--        --
--Crafting--
--        --

--
--Crafting>tool heads
--

minetest.register_craft({
        output = 'gems_tools:ruby_pick_head',
        recipe = {
            {'gems_tools:ruby_gem', 'gems_tools:ruby_gem', 'gems_tools:ruby_gem'},
		    
        }
})

---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:ruby_axe_head',
        recipe = {
            {'gems_tools:ruby_gem', 'gems_tools:ruby_gem', ''},
		    {'gems_tools:ruby_gem', '', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:ruby_axe_head',
        recipe = {
            {'', 'gems_tools:ruby_gem', 'gems_tools:ruby_gem'},
		    {'', '', 'gems_tools:ruby_gem'},
		    {'', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:ruby_axe_head',
        recipe = {
            {'', '', ''},
		    {'gems_tools:ruby_gem', 'gems_tools:ruby_gem', ''},
		    {'gems_tools:ruby_gem', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:ruby_axe_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:ruby_gem', 'gems_tools:ruby_gem'},
		    {'', '', 'gems_tools:ruby_gem'},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:ruby_shovel_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:ruby_gem', ''},
		    {'', '', ''},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:ruby_sword_blade',
        recipe = {
            {'gems_tools:ruby_gem'},
		    {'gems_tools:ruby_gem'},

        }
})
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:amethyst_pick_head',
        recipe = {
            {'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem'},
		    
        }
})

---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:amethyst_axe_head',
        recipe = {
            {'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem', ''},
		    {'gems_tools:amethyst_gem', '', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:amethyst_axe_head',
        recipe = {
            {'', 'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem'},
		    {'', '', 'gems_tools:amethyst_gem'},
		    {'', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:amethyst_axe_head',
        recipe = {
            {'', '', ''},
		    {'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem', ''},
		    {'gems_tools:amethyst_gem', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:amethyst_axe_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:amethyst_gem', 'gems_tools:amethyst_gem'},
		    {'', '', 'gems_tools:amethyst_gem'},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:amethyst_shovel_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:amethyst_gem', ''},
		    {'', '', ''},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:amethyst_sword_blade',
        recipe = {
            {'gems_tools:amethyst_gem'},
		    {'gems_tools:amethyst_gem'},

        }
})
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:emerald_pick_head',
        recipe = {
            {'gems_tools:emerald_gem', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
		    
        }
})

---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:emerald_axe_head',
        recipe = {
            {'gems_tools:emerald_gem', 'gems_tools:emerald', ''},
		    {'gems_tools:emerald_gem', '', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:emerald_axe_head',
        recipe = {
            {'', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
		    {'', '', 'gems_tools:emerald_gem'},
		    {'', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:emerald_axe_head',
        recipe = {
            {'', '', ''},
		    {'gems_tools:emerald_gem', 'gems_tools:emerald_gem', ''},
		    {'gems_tools:emerald_gem', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:emerald_axe_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
		    {'', '', 'gems_tools:emerald_gem'},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:emerald_shovel_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:emerald_gem', ''},
		    {'', '', ''},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:emerald_sword_blade',
        recipe = {
            {'gems_tools:emerald_gem'},
		    {'gems_tools:emerald_gem'},

        }
})
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:sapphire_pick_head',
        recipe = {
            {'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
		    
        }
})

---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:sapphire_axe_head',
        recipe = {
            {'gems_tools:sapphire_gem', 'gems_tools:sapphire', ''},
		    {'gems_tools:sapphire_gem', '', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:sapphire_axe_head',
        recipe = {
            {'', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
		    {'', '', 'gems_tools:sapphire_gem'},
		    {'', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:sapphire_axe_head',
        recipe = {
            {'', '', ''},
		    {'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem', ''},
		    {'gems_tools:sapphire_gem', '', ''},
                
        }
})
minetest.register_craft({
        output = 'gems_tools:sapphire_axe_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
		    {'', '', 'gems_tools:sapphire_gem'},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:sapphire_shovel_head',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:sapphire_gem', ''},
		    {'', '', ''},
                
        }
})
---------------------------------------------------------------------
minetest.register_craft({
        output = 'gems_tools:sapphire_sword_blade',
        recipe = {
            {'gems_tools:sapphire_gem'},
		    {'gems_tools:sapphire_gem'},

        }
})
--
--Crafting>Picks
--

minetest.register_craft({
        output = 'gems_tools:pick_emerald',
        recipe = {
            {'', 'gems_tools:emerald_pick_head', ''},
		    {'', 'default:stick', ''},
		    {'', 'default:stick', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_pick_emerald',
        recipe = {
            {'', 'gems_tools:emerald_pick_head', ''},
		    {'', 'gems_tools:stone_rod', ''},
		    {'', 'gems_tools:stone_rod', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:pick_ruby',
        recipe = {
            {'', 'gems_tools:ruby_pick_head', ''},
		    {'', 'default:stick', ''},
		    {'', 'default:stick', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_pick_ruby',
        recipe = {
            {'', 'gems_tools:ruby_pick_head', ''},
		    {'', 'gems_tools:stone_rod', ''},
		    {'', 'gems_tools:stone_rod', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:pick_sapphire',
        recipe = {
            {'', 'gems_tools:sapphire_pick_head', ''},
		    {'', 'default:stick', ''},
		    {'', 'default:stick', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_pick_sapphire',
        recipe = {
            {'', 'gems_tools:sapphire_pick_head', ''},
		    {'', 'gems_tools:stone_rod', ''},
		    {'', 'gems_tools:stone_rod', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:pick_amethyst',
        recipe = {
            {'', 'gems_tools:amethyst_pick_head', ''},
		    {'', 'default:stick', ''},
		    {'', 'default:stick', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_pick_amethyst',
        recipe = {
            {'', 'gems_tools:amethyst_pick_head', ''},
		    {'', 'gems_tools:stone_rod', ''},
		    {'', 'gems_tools:stone_rod', ''},
                
        }
})

--
--Crafting>Blocks
--

minetest.register_craft({
	output = 'gems_tools:ruby_block',
	recipe = {
		{'gems_tools:ruby_gem','gems_tools:ruby_gem','gems_tools:ruby_gem',},
		{'gems_tools:ruby_gem','gems_tools:ruby_gem','gems_tools:ruby_gem',},
		{'gems_tools:ruby_gem','gems_tools:ruby_gem','gems_tools:ruby_gem',},
	}
})

minetest.register_craft({
	output = 'gems_tools:amethyst_block',
	recipe = {
		{'gems_tools:amethyst_gem','gems_tools:amethyst_gem','gems_tools:amethyst_gem',},
		{'gems_tools:amethyst_gem','gems_tools:amethyst_gem','gems_tools:amethyst_gem',},
		{'gems_tools:amethyst_gem','gems_tools:amethyst_gem','gems_tools:amethyst_gem',},
	}
})

minetest.register_craft({
	output = 'gems_tools:emerald_block',
	recipe = {
		{'gems_tools:emerald_gem', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
		{'gems_tools:emerald_gem', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
		{'gems_tools:emerald_gem', 'gems_tools:emerald_gem', 'gems_tools:emerald_gem'},
	}
})

minetest.register_craft({
	output = 'gems_tools:sapphire_block',
	recipe = {
		{'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
		{'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
		{'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem', 'gems_tools:sapphire_gem'},
	}
})

--
--Crafting>Shovels
--

minetest.register_craft({
        output = 'gems_tools:shovel_ruby',
        recipe = {
            {'gems_tools:ruby_shovel_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_shovel_ruby',
        recipe = {
            {'gems_tools:ruby_shovel_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:shovel_emerald',
        recipe = {
            {'gems_tools:emerald_shovel_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_shovel_emerald',
        recipe = {
            {'gems_tools:emerald_shovel_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:shovel_sapphire',
        recipe = {
            {'gems_tools:sapphire_shovel_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_shovel_sapphire',
        recipe = {
            {'gems_tools:sapphire_shovel_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:shovel_amethyst',
        recipe = {
            {'gems_tools:amethyst_shovel_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_shovel_amethyst',
        recipe = {
            {'gems_tools:amethyst_shovel_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

--
--Crafting>Swords
--

minetest.register_craft({
        output = 'gems_tools:sword_ruby',
        recipe = {    
		    {'gems_tools:ruby_sword_blade'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_sword_ruby',
        recipe = {    
		    {'gems_tools:ruby_sword_blade'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:sword_amethyst',
        recipe = {
		    {'gems_tools:amethyst_sword_blade'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_sword_amethyst',
        recipe = {
		    {'gems_tools:amethyst_sword_blade'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:sword_emerald',
        recipe = {
		    {'gems_tools:emerald_sword_blade'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_sword_emerald',
        recipe = {
		    {'gems_tools:emerald_sword_blade'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:sword_sapphire',
        recipe = {
		    {'gems_tools:sapphire_sword_blade'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_sword_sapphire',
        recipe = {
		    {'gems_tools:sapphire_sword_blade'},
		    {'gems_tools:stone_rod'},
                
        }
})

--
--Crafting>Axes <left side and right side craftings for axes>
--

minetest.register_craft({
        output = 'gems_tools:axe_ruby',
        recipe = {
            {'gems_tools:ruby_axe_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_axe_ruby',
        recipe = {
            {'gems_tools:ruby_axe_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:axe_emerald',
        recipe = {
            {'gems_tools:emerald_axe_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_axe_emerald',
        recipe = {
            {'gems_tools:emerald_axe_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:axe_sapphire',
        recipe = {
            {'gems_tools:sapphire_axe_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_axe_sapphire',
        recipe = {
            {'gems_tools:sapphire_axe_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:axe_amethyst',
        recipe = {
            {'gems_tools:amethyst_axe_head'},
		    {'default:stick'},
		    {'default:stick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:stone_axe_amethyst',
        recipe = {
            {'gems_tools:amethyst_axe_head'},
		    {'gems_tools:stone_rod'},
		    {'gems_tools:stone_rod'},
                
        }
})

--
--Crafting>Gems
--

minetest.register_craft({
        output = 'gems_tools:amethyst_gem 9',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:amethyst_block', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:ruby_gem 9',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:ruby_block', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:emerald_gem 9',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:emerald_block', ''},
		    {'', '', ''},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:sapphire_gem 9',
        recipe = {
            {'', '', ''},
		    {'', 'gems_tools:sapphire_block', ''},
		    {'', '', ''},
                
        }
})

--
--Crafting>Stone Rod 
--
minetest.register_craft({
        output = 'gems_tools:stone_rod 4',
        recipe = {
            {'', '', ''},
		    {'', 'default:cobble', ''},
		    {'', '', ''},
                
        }
})

--Generation

local mg_params = minetest.get_mapgen_params()
if mg_params.mgname == "v6" then
	default.register_ores()
	default.register_mgv6_decorations()
	--minetest.register_on_generated(default.generate_nyancats)
elseif mg_params.mgname ~= "singlenode" then
	default.register_biomes()
	default.register_ores()
	default.register_decorations()
	--minetest.register_on_generated(default.generate_nyancats)
end

--ruby

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:ruby_ore",
		wherein        = "default:stone",
		clust_scarcity = 17 * 17 * 17,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -255,
		y_max          = -128,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:ruby_ore",
		wherein        = "default:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
	})

--emerald

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:emerald_ore",
		wherein        = "default:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:emerald_ore",
		wherein        = "default:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
	})

--sapphire

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:sapphire_ore",
		wherein        = "default:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:sapphire_ore",
		wherein        = "default:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
	})

--amethyst

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:amethyst_ore",
		wherein        = "default:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -63,
		y_max          = -16,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "gems_tools:amethyst_ore",
		wherein        = "default:stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -64,
	})
	
--              --
--gem fabricator--
--              --


--
-- Formspecs
--

local function active_formspec(fuel_percent, item_percent)
	local formspec = 
		"size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[current_name;src;2.75,0.5;1,1;]"..
		"list[current_name;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;gems_progress_bg.png^[lowpart:"..
		(100-fuel_percent)..":gems_progress_fg.png]"..
		"list[current_name;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25)
	return formspec
end

local inactive_formspec =
	"size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;src;2.75,0.5;1,1;]"..
	"list[current_name;fuel;2.75,2.5;1,1;]"..
	"image[2.75,1.5;1,1;gems_progress_bg.png]"..
	"list[current_name;dst;4.75,0.96;2,2;]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0, 4.25)

--
-- Node callback functions that are the same for active and inactive furnace
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", "Fabricator is empty")
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function furnace_node_timer(pos, elapsed)
	--
	-- Inizialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist = inv:get_list("src")
	local fuellist = inv:get_list("fuel")
	local dstlist = inv:get_list("dst")

	--
	-- Cooking
	--

	-- Check if we have cookable content
	local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
	local cookable = true

	if cooked.time == 0 then
		cookable = false
	end

	-- Check if we have enough fuel to burn
	if fuel_time < fuel_totaltime then
		-- The furnace is currently active and has enough fuel
		fuel_time = fuel_time + 1

		-- If there is a cookable item then check if it is ready yet
		if cookable then
			src_time = src_time + 1
			if src_time >= cooked.time then
				-- Place result in dst list if possible
				if inv:room_for_item("dst", cooked.item) then
					inv:add_item("dst", cooked.item)
					inv:set_stack("src", 1, aftercooked.items[1])
					src_time = 0
				end
			end
		end
	else
		-- Furnace ran out of fuel
		if cookable then
			-- We need to get new fuel
			local fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

			if fuel.time == 0 then
				-- No valid fuel in fuel list
				fuel_totaltime = 0
				fuel_time = 0
				src_time = 0
			else
				-- Take fuel from fuel list
				inv:set_stack("fuel", 0, afterfuel.items[1])

				fuel_totaltime = fuel.time
				fuel_time = 0
			end
		else
			-- We don't need to get new fuel since there is no cookable item
			fuel_totaltime = 0
			fuel_time = 0
			src_time = 0
		end
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec = inactive_formspec
	local item_state = ""
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		item_state = item_percent .. "%"
	else
		if srclist[1]:is_empty() then
			item_state = "Empty"
		else
			item_state = "can not be fabricated"
		end
	end

	local fuel_state = "Empty"
	local active = "inactive "
	local result = false

	if fuel_time <= fuel_totaltime and fuel_totaltime ~= 0 then
		active = "active "
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = fuel_percent .. "%"
		formspec = active_formspec(fuel_percent, item_percent)
		swap_node(pos, "gems_tools:gem_fabricator_active")
		-- make sure timer restarts automatically
		result = true
	else
		if not fuellist[1]:is_empty() then
			fuel_state = "0%"
		end
		swap_node(pos, "gems_tools:gem_fabricator")
		-- stop timer on the inactive furnace
		local timer = minetest.get_node_timer(pos)
		timer:stop()
	end

	local infotext = "Fabricator " .. active .. "(Raw material: " .. item_state .. "; Grinder Wheel: " .. fuel_state .. ")"

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

--
-- Node definitions
--

minetest.register_node("gems_tools:gem_fabricator", {
	description = "gem fabricator",
	tiles = {
		"gem_fabricator_top.png", "gem_fabricator_bottom.png",
		"gem_fabricator_side.png", "gem_fabricator_side.png",
		"gem_fabricator_side.png", "gem_fabricator_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_timer = furnace_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", inactive_formspec)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('fuel', 1)
		inv:set_size('dst', 4)
	end,

	on_metadata_inventory_move = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether furnace can burn or not.
		local timer = minetest.get_node_timer(pos)
		timer:start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "src", drops)
		default.get_inventory_drops(pos, "fuel", drops)
		default.get_inventory_drops(pos, "dst", drops)
		drops[#drops+1] = "gems_tools:gem_fabricator"
		minetest.remove_node(pos)
		return drops
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_node("gems_tools:gem_fabricator_active", {
	description = "gem fabricator",
	tiles = {
		"gem_fabricator_top.png", "gem_fabricator_bottom.png",
		"gem_fabricator_side.png", "gem_fabricator_side.png",
		"gem_fabricator_side.png",
		{
			image = "gem_fabricator_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "gems_tools:gem_fabricator",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_timer = furnace_node_timer,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

--cutting wheels burntime

minetest.register_craft({
	type = "fuel",
	recipe = "gems_tools:diamond_cutting_wheel",
	burntime = 3,
})

--cutting wheel registry

minetest.register_craftitem( "gems_tools:diamond_cutting_wheel", {
	description = "diamond cutting wheel",
	tile_images = { "gems_tools:diamond_cutting_wheel" },
	inventory_image = "diamond_cutting_wheel.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--raw ore registry

minetest.register_craftitem( "gems_tools:raw_amethyst", {
	description = "raw amethyst",
	tile_images = { "gems_tools:raw_amethyst" },
	inventory_image = "gems_raw_amethyst.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:raw_ruby", {
	description = "raw ruby",
	tile_images = { "gems_tools:raw_ruby" },
	inventory_image = "gems_raw_ruby.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:raw_emerald", {
	description = "raw emerald",
	tile_images = { "gems_tools:raw_emerald" },
	inventory_image = "gems_raw_emerald.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "gems_tools:raw_sapphire", {
	description = "raw sapphire",
	tile_images = { "gems_tools:raw_sapphire" },
	inventory_image = "gems_raw_sapphire.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--register gems for fabrication

minetest.register_craft({
	type = "cooking",
	output = "gems_tools:ruby_gem",
	recipe = "gems_tools:raw_ruby",
})

minetest.register_craft({
	type = "cooking",
	output = "gems_tools:sapphire_gem",
	recipe = "gems_tools:raw_sapphire",
})

minetest.register_craft({
	type = "cooking",
	output = "gems_tools:emerald_gem",
	recipe = "gems_tools:raw_emerald",
})

minetest.register_craft({
	type = "cooking",
	output = "gems_tools:amethyst_gem",
	recipe = "gems_tools:raw_amethyst",
})

--gems_tools:gem_fabricator recipes

minetest.register_craft({
        output = 'gems_tools:gem_fabricator',
        recipe = {
            {'default:desert_stonebrick', 'default:desert_stonebrick', 'default:desert_stonebrick'},
		    {'default:desert_stonebrick', 'default:diamond', 'default:desert_stonebrick'},
		    {'default:desert_stonebrick', 'default:desert_stonebrick', 'default:desert_stonebrick'},
                
        }
})

minetest.register_craft({
        output = 'gems_tools:diamond_cutting_wheel',
        recipe = {
            {'', 'default:diamond', ''},
		    {'default:diamond', '', 'default:diamond'},
		    {'', 'default:diamond', ''},
                
        }
})
