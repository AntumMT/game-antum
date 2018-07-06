-- Crafts --
-- Tools --

minetest.register_craft({
	output = 'amber:pickaxe',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'amber:shovel',
	recipe = {
		{'', 'amber:amber', ''},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'amber:axe',
	recipe = {
		{'amber:amber', 'amber:amber', ''},
		{'amber:amber', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'amber:sword',
	recipe = {
		{'', 'amber:amber', ''},
		{'', 'amber:amber', ''},
		{'', 'group:stick', ''},
	}
})

-- Nodes --

minetest.register_craft({
	output = 'amber:bricks 6',
	recipe = {
		{'amber:amber', 'amber:brick', 'amber:amber'},
		{'amber:brick', 'amber:amber', 'amber:brick'},
		{'amber:amber', 'amber:brick', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:block 4',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', 'amber:brick', 'amber:amber'},
		{'amber:amber', 'amber:amber', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:glass 6',
	recipe = {
		{'amber:glass_tile', 'amber:glass_tile', 'amber:glass_tile'},
		{'amber:glass_tile', '', 'amber:glass_tile'},
		{'amber:glass_tile', 'amber:glass_tile', 'amber:glass_tile'},
	}
})

minetest.register_craft({
	output = 'amber:glass_medieval 4',
	recipe = {
		{'default:steel_ingot', 'amber:glass_tile', 'default:steel_ingot'},
		{'amber:glass_tile', '', 'amber:glass_tile'},
		{'default:steel_ingot', 'amber:glass_tile', 'default:steel_ingot'},
	}
})

-- Decorative Hieroglyphs --

minetest.register_craft({
	output = 'amber:bricks_scarab',
	recipe = {
		{'amber:green_crystals', '', 'amber:green_crystals'},
		{'', 'amber:bricks', ''},
		{'', 'amber:green_crystals', ''},
	}
})

minetest.register_craft({
	output = 'amber:block_eye',
	recipe = {
		{'', 'amber:green_crystals', ''},
		{'amber:green_crystals', 'amber:block', 'amber:green_crystals'},
		{'', 'amber:green_crystals', ''},
	}
})

minetest.register_craft({
	output = 'amber:block_frame 5',
	recipe = {
		{'amber:green_crystals', 'amber:block', 'amber:green_crystals'},
		{'amber:block', 'amber:block', 'amber:block'},
		{'amber:green_crystals', 'amber:block', 'amber:green_crystals'},
	}
})

minetest.register_craft({
	output = 'amber:block_sun',
	recipe = {
		{'amber:green_crystals', 'amber:green_crystals', 'amber:green_crystals'},
		{'amber:green_crystals', 'amber:block', 'amber:green_crystals'},
		{'amber:green_crystals', 'amber:green_crystals', 'amber:green_crystals'},
	}
})

minetest.register_craft({
	output = 'amber:block_sun_edge 4',
	recipe = {
		{'amber:green_crystals', '', 'amber:green_crystals'},
		{'amber:green_crystals', 'amber:block', 'amber:green_crystals'},
		{'amber:block', 'amber:block', 'amber:block'},
	}
})

-- Root System --

minetest.register_craft({
	output = 'default:wood 2',
	recipe = {
		{'amber:tree_all'},
	}
})

minetest.register_craft({
	output = 'amber:ambertree_green',
	recipe = {
		{'amber:tree_all', 'amber:green_crystals'},
	}
})

-- Craftitems --

minetest.register_craft({
	output = 'amber:glass_tile 2',
	recipe = {
		{'amber:amber'},
	}
})

minetest.register_craft({
	output = 'default:stick',
	recipe = {
		{'amber:root'},
	}
})

-- Cooking --

minetest.register_craft({
	type = "cooking",
	output = "amber:amber",
	recipe = "amber:amber_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "amber:brick",
	recipe = "amber:amber",
})

-- Armor --

if minetest.get_modpath("3d_armor") then

minetest.register_craft({
	output = 'amber:helmet',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'amber:chestplate',
	recipe = {
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', 'amber:amber', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:leggings',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:boots',
	recipe = {
		{'', '', ''},
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:shield',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'', 'amber:amber', ''},
		{'amber:amber', '', 'amber:amber'},
	}
})
end

-- Upgrades --
-- This is gonna take some lines --

-- Tools --
minetest.register_craft({
	output = 'amber:pickaxe_ancient',
	recipe = {
		{'amber:pickaxe'},
		{'amber:matrix_pickaxe'},
	}
})

minetest.register_craft({
	output = 'amber:axe_ancient',
	recipe = {
		{'amber:axe'},
		{'amber:matrix_axe'},
	}
})

minetest.register_craft({
	output = 'amber:shovel_ancient',
	recipe = {
		{'amber:shovel'},
		{'amber:matrix_shovel'},
	}
})

minetest.register_craft({
	output = 'amber:sword_ancient',
	recipe = {
		{'amber:sword'},
		{'amber:matrix_sword'},
	}
})

-- Armor --

if minetest.get_modpath("3d_armor") then
minetest.register_craft({
	output = 'amber:helmet_ancient',
	recipe = {
		{'amber:helmet'},
		{'amber:matrix_helmet'},
	}
})

minetest.register_craft({
	output = 'amber:chest_ancient',
	recipe = {
		{'amber:chest'},
		{'amber:matrix_chest'},
	}
})

minetest.register_craft({
	output = 'amber:leggings_ancient',
	recipe = {
		{'amber:leggings'},
		{'amber:matrix_leggings'},
	}
})

minetest.register_craft({
	output = 'amber:boots_ancient',
	recipe = {
		{'amber:boots'},
		{'amber:matrix_boots'},
	}
})

minetest.register_craft({
	output = 'amber:shield_ancient',
	recipe = {
		{'amber:shield'},
		{'amber:matrix_shield'},
	}
})

end



minetest.register_craft({
	type = "fuel",
	recipe = "amber:root_wall",
	burntime = 8,
})
