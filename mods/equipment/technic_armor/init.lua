
-- Use 3d_armor translator to take advantage of existing translations for armor parts
local S = minetest.get_translator("3d_armor")

local materials = {}

if minetest.get_modpath("technic_worldgen") then
	materials.lead = {
		name = S("Lead"),
		craft_item = "technic:lead_ingot",
		armor = 1.6,
		heal = 0,
		use = 500,
		radiation = 88
	}
	materials.brass = {
		name = S("Brass"),
		craft_item = "technic:brass_ingot",
		armor = 1.8,
		heal = 0,
		use = 650,
		radiation = 43
	}
	materials.cast = {
		name = S("Cast Iron"),
		craft_item = "technic:cast_iron_ingot",
		armor = 2.5,
		heal = 8,
		use = 200,
		radiation = 40
	}
	materials.carbon = {
		name = S("Carbon Steel"),
		craft_item = "technic:carbon_steel_ingot",
		armor = 2.7,
		heal = 10,
		use = 100,
		radiation = 40
	}
	materials.stainless = {
		name = S("Stainless Steel"),
		craft_item = "technic:stainless_steel_ingot",
		armor = 2.7,
		heal = 10,
		use = 75,
		radiation = 40
	}
end

if minetest.get_modpath("moreores") then
	materials.silver = {
		name = S("Silver"),
		craft_item = "moreores:silver_ingot",
		armor = 1.8,
		heal = 6,
		use = 650,
		radiation = 53
	}
end

if minetest.get_modpath("default") then
	materials.tin = {
		name = S("Tin"),
		craft_item = "default:tin_ingot",
		armor = 1.6,
		heal = 0,
		use = 750,
		radiation = 37
	}
end

local parts = {
	helmet = {
		name = S("Helmet"),
		place = "head",
		level = 5,
		radlevel = 0.10,
		craft = {{1, 1, 1}, {1, 0, 1}}
	},
	chestplate = {
		name = S("Chestplate"),
		place = "torso",
		level = 8,
		radlevel = 0.35,
		craft = {{1, 0, 1}, {1, 1, 1}, {1, 1, 1}}
	},
	leggings = {
		name = S("Leggings"),
		place = "legs",
		level = 7,
		radlevel = 0.15,
		craft = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}}
	},
	boots = {
		name = S("Boots"),
		place = "feet",
		level = 4,
		radlevel = 0.10,
		craft = {{1, 0, 1}, {1, 0, 1}}
	}
}

if minetest.get_modpath("shields") then
	parts.shield = {
		name = S("Shield"),
		place = "shield",
		level = 5,
		radlevel = 0.00,
		craft = {{1, 1, 1}, {1, 1, 1}, {0, 1, 0}}
	}
end

local function make_recipe(template, material)
	local recipe = {}
	for i, row in ipairs(template) do
		recipe[i] = {}
		for j, item in ipairs(row) do
			recipe[i][j] = item == 0 and "" or material
		end
	end
	return recipe
end

for material, m in pairs(materials) do
	for part, p in pairs(parts) do
		local name = "technic_armor:"..part.."_"..material
		armor:register_armor(name, {
			description = S("@1 @2", m.name, p.name),
			inventory_image = "technic_armor_inv_"..part.."_"..material..".png",
			groups = {
				["armor_"..p.place] = math.floor(p.level * m.armor),
				armor_heal = m.heal,
				armor_use = m.use,
				armor_radiation = math.floor(p.radlevel * m.radiation)
			}
		})
		minetest.register_craft({
			output = name,
			recipe = make_recipe(p.craft, m.craft_item),
		})
	end
end
