minetest.register_craftitem("xtraarmor:soap", {
	description = "soap (for washing a dye out of a piece of dyed armor)",
	inventory_image = "xtraarmor_soap.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:soap 5",
	recipe = {"default:leaves", "dye:white"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather",
	recipe = {"group:leather_helmet", "xtraarmor:soap"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather",
	recipe = {"group:leather_leggings", "xtraarmor:soap"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather",
	recipe = {"group:leather_chestplate", "xtraarmor:soap"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather",
	recipe = {"group:leather_boots", "xtraarmor:soap"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather",
	recipe = {"group:leather_shield", "xtraarmor:soap"},
})


	minetest.register_tool("xtraarmor:helmet_mese", {
		description = "mese Helmet",
		inventory_image = "xtraarmor_inv_helmet_mese.png",
		groups = {armor_head=13.4, physics_jump=0.10,physics_speed=0.10, armor_heal=9, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:chestplate_mese", {
		description = "mese Chestplate",
		inventory_image = "xtraarmor_inv_chestplate_mese.png",
		groups = {armor_torso=17.4,physics_jump=0.10,physics_speed=0.10, armor_heal=9, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:leggings_mese", {
		description = "mese Leggings",
		inventory_image = "xtraarmor_inv_leggings_mese.png",
		groups = {armor_legs=17.4,physics_jump=0.10,physics_speed=0.10, armor_heal=9, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_mese", {
		description = "mese Boots",
		inventory_image = "xtraarmor_inv_boots_mese.png",
		groups = {armor_feet=13.4,physics_jump=0.10,physics_speed=0.10, armor_heal=9, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_mese", {
		description = "mese shield",
		inventory_image = "xtraarmor_inv_shield_mese.png",
		groups = {armor_shield=13.4,physics_jump=0.10,physics_speed=0.10, armor_heal=9, armor_use=150},
		wear = 0,
	})

minetest.register_craft({
	output = 'xtraarmor:helmet_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', '', 'default:mese_crystal'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'xtraarmor:chestplate_mese',
	recipe = {
		{'default:mese_crystal', '', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:leggings_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', '', 'default:mese_crystal'},
		{'default:mese_crystal', '', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:boots_mese',
	recipe = {
		{'', '', ''},
		{'default:mese_crystal', '', 'default:mese_crystal'},
		{'default:mese_crystal', '', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:shield_mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'', 'default:mese_crystal', ''},
	}
})


	minetest.register_tool("xtraarmor:helmet_chainmail", {
		description = "chainmail Helmet",
		inventory_image = "xtraarmor_inv_helmet_chainmail.png",
		groups = {armor_head=8, armor_heal=0, armor_use=750},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:chestplate_chainmail", {
		description = "chainmail Chestplate",
		inventory_image = "xtraarmor_inv_chestplate_chainmail.png",
		groups = {armor_torso=13, armor_heal=0, armor_use=750},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:leggings_chainmail", {
		description = "chainmail Leggings",
		inventory_image = "xtraarmor_inv_leggings_chainmail.png",
		groups = {armor_legs=13, armor_heal=0, armor_use=750},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:boots_chainmail", {
		description = "chainmail Boots",
		inventory_image = "xtraarmor_inv_boots_chainmail.png",
		groups = {armor_feet=8, armor_heal=0, armor_use=750},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:shield_chainmail", {
		description = "chainmail shield",
		inventory_image = "xtraarmor_inv_shield_chainmail.png",
		groups = {armor_shield=8, armor_heal=0, armor_use=750},
		wear = 0,
	})

minetest.register_craft({
	output = 'xtraarmor:helmet_chainmail',
	recipe = {
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'xtraarmor:chestplate_chainmail',
	recipe = {
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:leggings_chainmail',
	recipe = {
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:boots_chainmail',
	recipe = {
		{'', '', ''},
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', '', 'xpanes:bar_flat'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:shield_chainmail',
	recipe = {
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
		{'xpanes:bar_flat', 'xpanes:bar_flat', 'xpanes:bar_flat'},
		{'', 'xpanes:bar_flat', ''},
	}
})

	minetest.register_tool("xtraarmor:helmet_leather", {
		description = "leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather.png",
		groups = {armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather", {
		description = "leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather.png",
		groups = {armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather", {
		description = "leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather.png",
		groups = {armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather", {
		description = "leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather.png",
		groups = {armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather", {
		description = "leather shield",
		inventory_image = "xtraarmor_inv_shield_leather.png",
		groups = {armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	output = 'xtraarmor:helmet_leather',
	recipe = {
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
		{'mobs:leather', '', 'mobs:leather'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'xtraarmor:chestplate_leather',
	recipe = {
		{'mobs:leather', '', 'mobs:leather'},
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:leggings_leather',
	recipe = {
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
		{'mobs:leather', '', 'mobs:leather'},
		{'mobs:leather', '', 'mobs:leather'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:boots_leather',
	recipe = {
		{'', '', ''},
		{'mobs:leather', '', 'mobs:leather'},
		{'mobs:leather', '', 'mobs:leather'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:shield_leather',
	recipe = {
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
		{'mobs:leather', 'default:wood', 'mobs:leather'},
		{'', 'mobs:leather', ''},
	}
})

	minetest.register_tool("xtraarmor:helmet_copper", {
		description = "copper Helmet",
		inventory_image = "xtraarmor_inv_helmet_copper.png",
		groups = {armor_head=8, armor_heal=0, armor_use=750},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:chestplate_copper", {
		description = "copper Chestplate",
		inventory_image = "xtraarmor_inv_chestplate_copper.png",
		groups = {armor_torso=13, armor_heal=0, armor_use=750},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:leggings_copper", {
		description = "copper Leggings",
		inventory_image = "xtraarmor_inv_leggings_copper.png",
		groups = {armor_legs=13, armor_heal=0, armor_use=750},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:boots_copper", {
		description = "copper Boots",
		inventory_image = "xtraarmor_inv_boots_copper.png",
		groups = {armor_feet=8, armor_heal=0, armor_use=750},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:shield_copper", {
		description = "copper shield",
		inventory_image = "xtraarmor_inv_shield_copper.png",
		groups = {armor_shield=8, armor_heal=0, armor_use=750},
		wear = 0,
	})

minetest.register_craft({
	output = 'xtraarmor:helmet_copper',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', '', 'default:copper_ingot'},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'xtraarmor:chestplate_copper',
	recipe = {
		{'default:copper_ingot', '', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:leggings_copper',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', '', 'default:copper_ingot'},
		{'default:copper_ingot', '', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:boots_copper',
	recipe = {
		{'', '', ''},
		{'default:copper_ingot', '', 'default:copper_ingot'},
		{'default:copper_ingot', '', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraarmor:shield_copper',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'', 'default:copper_ingot', ''},
	}
})

	minetest.register_tool("xtraarmor:helmet_studded", {
		description = "studded Helmet",
		inventory_image = "xtraarmor_inv_helmet_studded.png",
		groups = {armor_head=12.4, armor_heal=2, armor_use=400},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:chestplate_studded", {
		description = "studded Chestplate",
		inventory_image = "xtraarmor_inv_chestplate_studded.png",
		groups = {armor_torso=16.4, armor_heal=2, armor_use=400},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:leggings_studded", {
		description = "studded Leggings",
		inventory_image = "xtraarmor_inv_leggings_studded.png",
		groups = {armor_legs=16.4, armor_heal=2, armor_use=400},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:boots_studded", {
		description = "studded Boots",
		inventory_image = "xtraarmor_inv_boots_studded.png",
		groups = {armor_feet=12.4, armor_heal=2, armor_use=400},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:shield_studded", {
		description = "studded shield",
		inventory_image = "xtraarmor_inv_shield_studded.png",
		groups = {armor_shield=12.4, armor_heal=2, armor_use=400},
		wear = 0,
	})


minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_studded",
	recipe = {"xtraarmor:helmet_chainmail", "xtraarmor:helmet_leather"},
})
minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_studded",
	recipe = {"xtraarmor:chestplate_chainmail", "xtraarmor:chestplate_leather"},
})
minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_studded",
	recipe = {"xtraarmor:leggings_chainmail", "xtraarmor:leggings_leather"},
})
minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_studded",
	recipe = {"xtraarmor:boots_chainmail", "xtraarmor:boots_leather"},
})
minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_studded",
	recipe = {"xtraarmor:shield_chainmail", "xtraarmor:shield_leather"},
})

	minetest.register_tool("xtraarmor:helmet_leather_green", {
		description = "green leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_green.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_green", {
		description = "green leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_green.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_green", {
		description = "green leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_green.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_green", {
		description = "green leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_green.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_green", {
		description = "green leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_green.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_green",
	recipe = {"xtraarmor:shield_leather", "dye:green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_green",
	recipe = {"xtraarmor:helmet_leather", "dye:green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_green",
	recipe = {"xtraarmor:chestplate_leather", "dye:green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_green",
	recipe = {"xtraarmor:leggings_leather", "dye:green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_green",
	recipe = {"xtraarmor:boots_leather", "dye:green"},
})

	minetest.register_tool("xtraarmor:helmet_leather_blue", {
		description = "blue leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_blue.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_blue", {
		description = "blue leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_blue.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_blue", {
		description = "blue leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_blue.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_blue", {
		description = "blue leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_blue.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_blue", {
		description = "blue leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_blue.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_blue",
	recipe = {"xtraarmor:shield_leather", "dye:blue"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_blue",
	recipe = {"xtraarmor:helmet_leather", "dye:blue"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_blue",
	recipe = {"xtraarmor:chestplate_leather", "dye:blue"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_blue",
	recipe = {"xtraarmor:leggings_leather", "dye:blue"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_blue",
	recipe = {"xtraarmor:boots_leather", "dye:blue"},
})

	minetest.register_tool("xtraarmor:helmet_leather_red", {
		description = "red leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_red.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_red", {
		description = "red leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_red.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_red", {
		description = "red leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_red.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_red", {
		description = "red leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_red.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_red", {
		description = "red leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_red.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_red",
	recipe = {"xtraarmor:shield_leather", "dye:red"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_red",
	recipe = {"xtraarmor:helmet_leather", "dye:red"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_red",
	recipe = {"xtraarmor:chestplate_leather", "dye:red"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_red",
	recipe = {"xtraarmor:leggings_leather", "dye:red"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_red",
	recipe = {"xtraarmor:boots_leather", "dye:red"},
})

	minetest.register_tool("xtraarmor:helmet_leather_yellow", {
		description = "yellow leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_yellow.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_yellow", {
		description = "yellow leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_yellow.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_yellow", {
		description = "yellow leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_yellow.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_yellow", {
		description = "yellow leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_yellow.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_yellow", {
		description = "yellow leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_yellow.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_yellow",
	recipe = {"xtraarmor:shield_leather", "dye:yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_yellow",
	recipe = {"xtraarmor:helmet_leather", "dye:yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_yellow",
	recipe = {"xtraarmor:chestplate_leather", "dye:yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_yellow",
	recipe = {"xtraarmor:leggings_leather", "dye:yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_yellow",
	recipe = {"xtraarmor:boots_leather", "dye:yellow"},
})

	minetest.register_tool("xtraarmor:helmet_leather_white", {
		description = "white leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_white.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_white", {
		description = "white leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_white.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_white", {
		description = "white leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_white.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_white", {
		description = "white leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_white.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_white", {
		description = "white leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_white.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_white",
	recipe = {"xtraarmor:shield_leather", "dye:white"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_white",
	recipe = {"xtraarmor:helmet_leather", "dye:white"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_white",
	recipe = {"xtraarmor:chestplate_leather", "dye:white"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_white",
	recipe = {"xtraarmor:leggings_leather", "dye:white"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_white",
	recipe = {"xtraarmor:boots_leather", "dye:white"},
})

	minetest.register_tool("xtraarmor:helmet_leather_black", {
		description = "black leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_black.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_black", {
		description = "black leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_black.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_black", {
		description = "black leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_black.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_black", {
		description = "black leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_black.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_black", {
		description = "black leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_black.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_black",
	recipe = {"xtraarmor:shield_leather", "dye:black"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_black",
	recipe = {"xtraarmor:helmet_leather", "dye:black"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_black",
	recipe = {"xtraarmor:chestplate_leather", "dye:black"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_black",
	recipe = {"xtraarmor:leggings_leather", "dye:black"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_black",
	recipe = {"xtraarmor:boots_leather", "dye:black"},
})

	minetest.register_tool("xtraarmor:helmet_leather_grey", {
		description = "grey leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_grey.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_grey", {
		description = "grey leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_grey.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_grey", {
		description = "grey leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_grey.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_grey", {
		description = "grey leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_grey.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_grey", {
		description = "grey leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_grey.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_grey",
	recipe = {"xtraarmor:shield_leather", "dye:grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_grey",
	recipe = {"xtraarmor:helmet_leather", "dye:grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_grey",
	recipe = {"xtraarmor:chestplate_leather", "dye:grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_grey",
	recipe = {"xtraarmor:leggings_leather", "dye:grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_grey",
	recipe = {"xtraarmor:boots_leather", "dye:grey"},
})

	minetest.register_tool("xtraarmor:helmet_leather_orange", {
		description = "orange leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_orange.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_orange", {
		description = "orange leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_orange.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_orange", {
		description = "orange leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_orange.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_orange", {
		description = "orange leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_orange.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_orange", {
		description = "orange leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_orange.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_orange",
	recipe = {"xtraarmor:shield_leather", "dye:orange"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_orange",
	recipe = {"xtraarmor:helmet_leather", "dye:orange"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_orange",
	recipe = {"xtraarmor:chestplate_leather", "dye:orange"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_orange",
	recipe = {"xtraarmor:leggings_leather", "dye:orange"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_orange",
	recipe = {"xtraarmor:boots_leather", "dye:orange"},
})

	minetest.register_tool("xtraarmor:helmet_leather_dark_grey", {
		description = "dark grey leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_dark_grey.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_dark_grey", {
		description = "dark grey leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_dark_grey.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_dark_grey", {
		description = "dark grey leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_dark_grey.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_dark_grey", {
		description = "dark grey leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_dark_grey.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_dark_grey", {
		description = "dark grey leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_dark_grey.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_dark_grey",
	recipe = {"xtraarmor:shield_leather", "dye:dark_grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_dark_grey",
	recipe = {"xtraarmor:helmet_leather", "dye:dark_grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_dark_grey",
	recipe = {"xtraarmor:chestplate_leather", "dye:dark_grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_dark_grey",
	recipe = {"xtraarmor:leggings_leather", "dye:dark_grey"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_dark_grey",
	recipe = {"xtraarmor:boots_leather", "dye:dark_grey"},
})

	minetest.register_tool("xtraarmor:helmet_leather_dark_green", {
		description = "dark green leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_dark_green.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_dark_green", {
		description = "dark green leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_dark_green.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_dark_green", {
		description = "dark green leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_dark_green.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_dark_green", {
		description = "dark green leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_dark_green.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_dark_green", {
		description = "dark green leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_dark_green.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_dark_green",
	recipe = {"xtraarmor:shield_leather", "dye:dark_green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_dark_green",
	recipe = {"xtraarmor:helmet_leather", "dye:dark_green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_dark_green",
	recipe = {"xtraarmor:chestplate_leather", "dye:dark_green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_dark_green",
	recipe = {"xtraarmor:leggings_leather", "dye:dark_green"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_dark_green",
	recipe = {"xtraarmor:boots_leather", "dye:dark_green"},
})

	minetest.register_tool("xtraarmor:helmet_leather_cyan", {
		description = "cyan leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_cyan.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_cyan", {
		description = "cyan leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_cyan.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_cyan", {
		description = "cyan leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_cyan.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_cyan", {
		description = "cyan leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_cyan.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_cyan", {
		description = "cyan leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_cyan.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_cyan",
	recipe = {"xtraarmor:shield_leather", "dye:cyan"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_cyan",
	recipe = {"xtraarmor:helmet_leather", "dye:cyan"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_cyan",
	recipe = {"xtraarmor:chestplate_leather", "dye:cyan"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_cyan",
	recipe = {"xtraarmor:leggings_leather", "dye:cyan"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_cyan",
	recipe = {"xtraarmor:boots_leather", "dye:cyan"},
})

	minetest.register_tool("xtraarmor:helmet_leather_pink", {
		description = "pink leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_pink.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_pink", {
		description = "pink leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_pink.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_pink", {
		description = "pink leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_pink.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_pink", {
		description = "pink leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_pink.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_pink", {
		description = "pink leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_pink.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_pink",
	recipe = {"xtraarmor:shield_leather", "dye:pink"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_pink",
	recipe = {"xtraarmor:helmet_leather", "dye:pink"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_pink",
	recipe = {"xtraarmor:chestplate_leather", "dye:pink"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_pink",
	recipe = {"xtraarmor:leggings_leather", "dye:pink"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_pink",
	recipe = {"xtraarmor:boots_leather", "dye:pink"},
})

	minetest.register_tool("xtraarmor:helmet_leather_magenta", {
		description = "magenta leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_magenta.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_magenta", {
		description = "magenta leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_magenta.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_magenta", {
		description = "magenta leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_magenta.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_magenta", {
		description = "magenta leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_magenta.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_magenta", {
		description = "magenta leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_magenta.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_magenta",
	recipe = {"xtraarmor:shield_leather", "dye:magenta"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_magenta",
	recipe = {"xtraarmor:helmet_leather", "dye:magenta"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_magenta",
	recipe = {"xtraarmor:chestplate_leather", "dye:magenta"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_magenta",
	recipe = {"xtraarmor:leggings_leather", "dye:magenta"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_magenta",
	recipe = {"xtraarmor:boots_leather", "dye:magenta"},
})

	minetest.register_tool("xtraarmor:helmet_leather_violet", {
		description = "violet leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_violet.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_violet", {
		description = "violet leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_violet.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_violet", {
		description = "violet leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_violet.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_violet", {
		description = "violet leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_violet.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_violet", {
		description = "violet leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_violet.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_violet",
	recipe = {"xtraarmor:shield_leather", "dye:violet"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_violet",
	recipe = {"xtraarmor:helmet_leather", "dye:violet"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_violet",
	recipe = {"xtraarmor:chestplate_leather", "dye:violet"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_violet",
	recipe = {"xtraarmor:leggings_leather", "dye:violet"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_violet",
	recipe = {"xtraarmor:boots_leather", "dye:violet"},
})

	minetest.register_tool("xtraarmor:helmet_leather_brown", {
		description = "brown leather cap",
		inventory_image = "xtraarmor_inv_helmet_leather_brown.png",
		groups = {leather_helmet=1, armor_head=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:chestplate_leather_brown", {
		description = "brown leather tunic",
		inventory_image = "xtraarmor_inv_chestplate_leather_brown.png",
		groups = {leather_chestplate=1, armor_torso=12, armor_heal=2, armor_use=1000},
		wear = 0,
	})

	minetest.register_tool("xtraarmor:leggings_leather_brown", {
		description = "brown leather trousers",
		inventory_image = "xtraarmor_inv_leggings_leather_brown.png",
		groups = {leather_leggings=1, armor_legs=7, armor_heal=2, armor_use=150},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:boots_leather_brown", {
		description = "brown leather Boots",
		inventory_image = "xtraarmor_inv_boots_leather_brown.png",
		groups = {leather_boots=1, armor_feet=7, armor_heal=2,physics_speed=0.15, armor_use=1000},
		wear = 0,
	})
	minetest.register_tool("xtraarmor:shield_leather_brown", {
		description = "brown leather shield",
		inventory_image = "xtraarmor_inv_shield_leather_brown.png",
		groups = {leather_shield=1, armor_shield=7, armor_heal=2, armor_use=1000},
		wear = 0,
	})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:shield_leather_brown",
	recipe = {"xtraarmor:shield_leather", "dye:brown"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:helmet_leather_brown",
	recipe = {"xtraarmor:helmet_leather", "dye:brown"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:chestplate_leather_brown",
	recipe = {"xtraarmor:chestplate_leather", "dye:brown"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:leggings_leather_brown",
	recipe = {"xtraarmor:leggings_leather", "dye:brown"},
})

minetest.register_craft({
	type = "shapeless",
	output = "xtraarmor:boots_leather_brown",
	recipe = {"xtraarmor:boots_leather", "dye:brown"},
})




