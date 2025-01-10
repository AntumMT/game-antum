
local S = core.get_translator(rainbow_ore.modname)


--Define Rainbow Armor
core.register_tool("rainbow_ore:helmet", {
	description = S("Rainbow Helmet"),
	inventory_image = "rainbow_ore_helmet_inv.png",
	groups = {armor_head=20, armor_heal=17, armor_use=40},
	wear = 0,
})
core.register_tool("rainbow_ore:chestplate", {
	description = S("Rainbow Chestplate"),
	inventory_image = "rainbow_ore_chestplate_inv.png",
	groups = {armor_torso=25, armor_heal=17, armor_use=40},
	wear = 0,
})
core.register_tool("rainbow_ore:leggings", {
	description = S("Rainbow Leggings"),
	inventory_image = "rainbow_ore_leggings_inv.png",
	groups = {armor_legs=25, armor_heal=17, armor_use=40},
	wear = 0,
})
core.register_tool("rainbow_ore:boots", {
	description = S("Rainbow Boots"),
	inventory_image = "rainbow_ore_boots_inv.png",
	groups = {armor_feet=20, armor_heal=17, armor_use=40},
	wear = 0,
})


--Define Rainbow Armor crafting recipe
core.register_craft({
	output = "rainbow_ore:helmet",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
		{"", "", ""},
	},
})
core.register_craft({
	output = "rainbow_ore:chestplate",
	recipe = {
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
	},
})
core.register_craft({
	output = "rainbow_ore:leggings",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
	},
})
core.register_craft({
	output = "rainbow_ore:boots",
	recipe = {
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "", "rainbow_ore:ingot"},
	},
})


-- backward compatibility

local aliases = {
	"helmet",
	"chestplate",
	"leggings",
	"boots",
}

for _, al in ipairs(aliases) do
	core.register_alias("rainbow_ore:rainbow_ore_"..al, "rainbow_ore:"..al)
end
