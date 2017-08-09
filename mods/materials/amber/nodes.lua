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
-- Decorations --

minetest.register_node("amber:bricks", {
	description = "Amber Bricks",
	tiles = {"amber_bricks.png"},
	is_ground_content = false,
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
