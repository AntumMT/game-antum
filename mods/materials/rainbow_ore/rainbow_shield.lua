
local S = core.get_translator(rainbow_ore.modname)


--Define Rainbow shield
core.register_tool("rainbow_ore:shield", {
	description = S("Rainbow Shield"),
	inventory_image = "rainbow_ore_shield_inv.png",
	groups = {armor_shield=20, armor_heal=17, armor_use=40, armor_fire=1},
	wear = 0,
})


--Define Rainbow shield crafting recipe
core.register_craft({
	output = "rainbow_ore:shield",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"", "rainbow_ore:ingot", ""},
	},
})


-- backward compatibility

core.register_alias("rainbow_ore:rainbow_ore_shield", "rainbow_ore:shield")
