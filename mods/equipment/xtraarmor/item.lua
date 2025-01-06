
minetest.register_craftitem("xtraarmor:soap", {
	description = "soap (for washing a dye out of a piece of dyed armor)",
	inventory_image = "xtraarmor_soap.png",
	groups = {flammable = 2},
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
