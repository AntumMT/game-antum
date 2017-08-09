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
	output = 'amber:helmet_amber',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'amber:chestplate_amber',
	recipe = {
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', 'amber:amber', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:leggings_amber',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:boots_amber',
	recipe = {
		{'', '', ''},
		{'amber:amber', '', 'amber:amber'},
		{'amber:amber', '', 'amber:amber'},
	}
})

minetest.register_craft({
	output = 'amber:shield_amber',
	recipe = {
		{'amber:amber', 'amber:amber', 'amber:amber'},
		{'', 'amber:amber', ''},
		{'amber:amber', '', 'amber:amber'},
	}
})
end
