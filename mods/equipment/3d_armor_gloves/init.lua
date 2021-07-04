-- support for i18n
local S = minetest.get_translator(minetest.get_current_modname())


if minetest.global_exists("armor") and armor.elements then
	table.insert(armor.elements, "hands")
end

-- Regisiter Gloves/Gauntlets

if armor.materials.wood then
		armor:register_armor("3d_armor_gloves:gloves_wood", {
		description = S("Wood Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_wood.png",
		groups = {armor_hands=1, armor_heal=0, armor_use=2000, flammable=1},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=2, choppy=3, crumbly=2, level=1},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "3d_armor_gloves:gloves_wood",
		burntime = 4,
	})
end

if armor.materials.cactus then
		armor:register_armor("3d_armor_gloves:gloves_cactus", {
		description = S("Cactus Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_cactus.png",
		groups = {armor_hands=1, armor_heal=0, armor_use=1000},
		armor_groups = {fleshy=5},
		damage_groups = {cracky=3, snappy=3, choppy=2, crumbly=2, level=1},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "3d_armor_gloves:gloves_cactus",
		burntime = 8,
	})
end

if armor.materials.steel then
		armor:register_armor("3d_armor_gloves:gloves_steel", {
		description = S("Steel Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_steel.png",
		groups = {armor_hands=1, armor_heal=0, armor_use=800,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
	})
end

if armor.materials.bronze then
		armor:register_armor("3d_armor_gloves:gloves_bronze", {
		description = S("Bronze Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_bronze.png",
		groups = {armor_hands=1, armor_heal=6, armor_use=400,
			physics_speed=-0.01, physics_gravity=0.01},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=3, snappy=2, choppy=2, crumbly=1, level=2},
	})
end

if armor.materials.diamond then
		armor:register_armor("3d_armor_gloves:gloves_diamond", {
		description = S("Diamond Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_diamond.png",
		groups = {armor_hands=1, armor_heal=12, armor_use=200},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, choppy=1, level=3},
	})
end

if armor.materials.gold then
		armor:register_armor("3d_armor_gloves:gloves_gold", {
		description = S("Gold Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_gold.png",
		groups = {armor_hands=1, armor_heal=6, armor_use=300,
			physics_speed=-0.02, physics_gravity=0.02},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=1, snappy=2, choppy=2, crumbly=3, level=2},
	})
end

if armor.materials.mithril then
		armor:register_armor("3d_armor_gloves:gloves_mithril", {
		description = S("Mithril Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_mithril.png",
		groups = {armor_hands=1, armor_heal=12, armor_use=100},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
end

if armor.materials.crystal then
		armor:register_armor("3d_armor_gloves:gloves_crystal", {
		description = S("Crystal Gauntlets"),
		inventory_image = "3d_armor_gloves_inv_gloves_crystal.png",
		groups = {armor_hands=1, armor_heal=12, armor_use=100, physics_speed=1,
				physics_jump=0.5, armor_fire=1},
		armor_groups = {fleshy=15},
		damage_groups = {cracky=2, snappy=1, level=3},
	})
end

for k, v in pairs(armor.materials) do
	minetest.register_craft({
		output = "3d_armor_gloves:gloves_"..k,
		recipe = {
			{v, "", v},
			{"farming:string", "", "farming:string"},
		},
	})
end
