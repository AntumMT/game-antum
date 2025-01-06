
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
