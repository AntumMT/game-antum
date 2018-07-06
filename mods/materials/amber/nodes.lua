-- Nodes --
-- "Ores" First --

-- Sediments --
-- Dirt --

minetest.register_node("amber:dirt", {
	description = "Dirt With Amber",
	tiles = {"default_dirt.png^amber_sediment.png"},
	groups = {crumbly = 3, soil = 1},
	drop = "amber:amber",
	sounds = default.node_sound_glass_defaults(),
})
if minetest.get_modpath("darkage") then
minetest.register_node("amber:mud", {
	description = "Mud With Amber",
	tiles = {"darkage_mud_top.png", "darkage_mud.png^amber_sediment.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = "amber:amber",
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})
end

-- Crafted Nodes --

minetest.register_node("amber:lamp", {
    description = "Amber Lamp",
    drawtype = "plantlike",
		tiles = {"amber_lamp.png"},
		paramtype = "light",
		walkable = false,
		inventory_image = "amber_lamp.png",
		wield_image = "amber_lamp.png",
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 4 / 16, 5 / 16},
		},
		sunlight_propagates = true,
		light_source = 12,
    on_blast = function() end,
		on_construct = function(pos)
		       minetest.get_node_timer(pos):start(0.4) -- start timer
		    end,
		    on_timer = function(pos, elapsed)
		        light_it_up(pos)
		        minetest.get_node_timer(pos):start(0.1) -- set timer to every 1 second
		    end,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = default.node_sound_glass_defaults(),
})

light_it_up = function(pos)
	local size = 0.2
	local step = 45

	for i = 0, 360, step do
			local angle = (i * math.pi / 180)
			local x = size * math.cos(angle)
			local z = size * math.sin(angle)
			local newpos = {x = pos.x + x, y = pos.y+0.3, z = pos.z + z}
minetest.add_particle({
		pos = newpos,
		velocity = {x = -1*x/2, y = 1, z = -1*z/2},
		acceleration = {x = 0, y = 0, z = 0},
		expirationtime = 1.9,
		collisiondetection = true,
		texture = "amber_fire_animated.png",
		animation = {
				type = "vertical_frames",
				aspect_w = 1,
				aspect_h = 1,
				length = 2,
},
		size = 1,
		glow = 15,
})
end
end

-- Tree Trunks --
minetest.register_node("amber:ambertree", {
	description = "Tree With Amber",
	tiles = {"(default_tree_top.png^[colorize:#80800099)^amber_ore_top.png", "(default_tree_top.png^[colorize:#80800099)^amber_ore_top.png",
		"(default_tree.png^[colorize:#80800099)^amber_ore.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump 2',
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("amber:ambertree_small", {
	description = "Tree With Amber",
	tiles = {"default_tree_top.png^[colorize:#80800050", "default_tree_top.png^[colorize:#80800050",
   "(default_tree.png^[colorize:#80800050)^amber_ore_small.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump',
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("amber:ambertree_pine", {
	description = "Pine Tree With Amber",
	tiles = {"(default_pine_tree_top.png^[colorize:#80800099)^amber_ore_top.png", "(default_pine_tree_top.png^[colorize:#80800099)^amber_ore_top.png",
		"(default_pine_tree.png^[colorize:#80800099)^amber_ore.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump 2',
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("amber:ambertree_pine_small", {
	description = "Tree With Amber",
	tiles = {"default_pine_tree_top.png^[colorize:#80800050", "default_pine_tree_top.png^[colorize:#80800050",
   "(default_pine_tree.png^[colorize:#80800050)^amber_ore_small.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump',
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, oddly_breakable_by_hand = 1, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

-- Root Amber Trees --

minetest.register_node("amber:ambertree_root", {
	description = "Tree With Amber",
	tiles = {"((default_tree.png^[colorize:#80800099)^amber_ore.png)^amber_root.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump 2',
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("amber:ambertree_root_small", {
	description = "Tree With Amber",
	tiles = {"((default_tree.png^[colorize:#80800050)^amber_ore_small.png)^amber_root.png"},
	paramtype2 = "facedir",
  drop = 'amber:amber_lump',
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("amber:ambertree_green", {
	description = "Tree With Green Sediments",
	tiles = {"((default_tree.png^[colorize:#00800025)^amber_green_sediment.png)^amber_root.png"},
	paramtype2 = "facedir",
  drop = 'amber:green_crystals',
	light_source = 8,
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_glass_defaults(),

	on_place = minetest.rotate_node
})

-- Decorations --

minetest.register_node("amber:bricks", {
	description = "Amber Bricks",
	tiles = {"amber_bricks.png"},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:bricks_scarab", {
	description = "Decorated Amber Bricks",
	tiles = {"amber_bricks.png^amber_brick_scarab_overlay.png"},
	is_ground_content = false,
	light_source = 6,
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:block", {
	description = "Amber Block",
	tiles = {"amber_block.png"},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:block_eye", {
	description = "Decorated Amber Block",
	tiles = {"amber_block.png^amber_block_eye_overlay.png"},
	is_ground_content = false,
	light_source = 6,
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:block_frame", {
	description = "Decorated Amber Block",
	tiles = {"amber_block.png^amber_frame_overlay.png"},
	is_ground_content = false,
	light_source = 4,
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:block_sun_edge", {
	description = "Decorated Amber Block",
	tiles = {"amber_block.png^amber_sun_edge_overlay.png"},
	is_ground_content = false,
	light_source = 6,
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:block_sun", {
	description = "Decorated Amber Block",
	tiles = {"amber_block.png^amber_sun_overlay.png"},
	is_ground_content = false,
	light_source = 12,
	paramtype2 = "facedir",
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

if minetest.get_modpath("moreblocks") then
stairsplus:register_all("amber", "bricks", "amber:bricks", {
	description = "Amber Brick",
	tiles = {"amber_bricks.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

stairsplus:register_all("amber", "block", "amber:block", {
	description = "Amber Block",
	tiles = {"amber_block.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})
end

minetest.register_node("amber:glass", {
	description = "Amber Glass",
	tiles = {"amber_glass.png"},
	drawtype = "allfaces",
	use_texture_alpha = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:glass_medieval", {
	description = "Amber Medieval Glass",
	tiles = {"amber_glass_medieval.png"},
	drawtype = "allfaces",
	use_texture_alpha = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

-- Root System Nodes --


minetest.register_node("amber:root_wall", {
	description = "Root System Wall",
	tiles = {"amber_root_wall.png^amber_root.png"},
	is_ground_content = true,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("amber:root_wall_light", {
	description = "Root System Wall Light",
	tiles = {"((amber_root_wall.png^[colorize:#00800025)^amber_green_sediment.png)^amber_root.png"},
	is_ground_content = true,
	sunlight_propagates = true,
	light_source = 8,
	drop = 'amber:green_crystals 3',
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("amber:tree_all", {
	description = "Tree",
	tiles = {"default_tree.png^(amber_root.png^[transformR90)"},
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

-- Root System Vegetation --

minetest.register_node("amber:root", {
	description = "Root Branch",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{0.55, -1, -1, 0.55, 1, 1},
			{-1, -1, -0.55, 1, 1, -0.55},
			{-0.55, -1, -1, -0.55, 1, 1},
			{-1, -1, 0.55, 1, 1, 0.55},
			{-1, -0.55, -1, 1, -0.55, 1},
			{-1, 0.55, -1, 1, 0.55, 1},
		}
	},
	tiles = {"amber_root_offset.png"},
	inventory_image = "amber_root.png",
	wield_image = "amber_root.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	pointable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1, -1, -1, 1, 1, 1},
}
})


-- Particles --

do_circle = function(pos)

    local size = 1
    local step = 90

    for i = 0, 360, step do

        local angle = (i * math.pi / 180)
        local x = size * math.cos(angle)
        local z = size * math.sin(angle)
				local y = size * math.sin(angle)
        local newpos = {x = pos.x + x, y = pos.y + y, z = pos.z + z}

        minetest.add_particle({
            pos = newpos,
            velocity = {x = math.random(0, angle)/100, y = math.random(0, angle)/100, z = math.random(0, angle)/100},
            acceleration = {x = -0.01, y = -0.01, z = -0.01},
            expirationtime = 8,
            collisiondetection = true,
            texture = "amber_particle_animated.png",
						animation = {
                type = "vertical_frames",
                aspect_w = 7,
                aspect_h = 7,
                length = 1,
},
            size = 1,
            glow = 15,
        })
	end
end

minetest.register_node("amber:particle_spawner", {
    description = "Particles!",
    drawtype = "airlike",
		paramtype = "light",
		walkable = false,
		pointable = false,
		sunlight_propagates = true,
		buildable_to = true,
    light_source = 12,
    on_blast = function() end,
		groups = {not_in_creative_inventory = 1},
})

-- Misc --
if minetest.get_modpath("3d_armor") then
n=9
else
n=4
end
types = {
		"Pickaxe",
		"Axe",
		"Shovel",
		"Sword",
		"Helmet",
		"Chest",
		"Leggings",
		"Boots",
		"Shield"
}
for i=1,n do
minetest.register_node("amber:matrix_" .. types[i]:lower(), {
	description = "Amber " .. types[i] .. " Matrix",
	tiles = {
		"amber_matrix_top.png^amber_symbol_" .. types[i]:lower() .. ".png",
		"amber_matrix_top.png",
		"amber_matrix_side.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.1875, 0.4375}, -- NodeBox1
			{-0.375, -0.1875, -0.375, 0.375, -0.125, 0.375}, -- NodeBox2
		}
	},
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults()
})
end
