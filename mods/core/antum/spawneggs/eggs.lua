--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


if core.get_modpath("spawneggs") then
	-- Clear all old spawneggs
	local spawneggs_default = {
		"dirt_monster", "dungeon_master", "oerkki", "rat",
		"sand_monster", "sheep", "stone_monster", "tree_monster"
	}

	for I in pairs(spawneggs_default) do
		core.clear_craft({
			output = "spawneggs:" .. spawneggs_default[I],
		})
	end
end

-- cow
if core.registered_entities["mobs_animal:cow"] and core.registered_items["mobs:bucket_milk"] then
	asm.addEgg({
		name = "cow",
		spawn = "mobs_animal:cow",
		ingredients = "mobs:bucket_milk",
	})
end


local mobs_monster = {
	{"dirt_monster", "mobs:dirt_monster", "default:dirt"},
	{"mese_monster", "mobs:mese_monster", "default:mese"},
	{"sand_monster", "mobs:sand_monster", "default:sand"},
	{"stone_monster", "mobs_monster:stone_monster", "default:stone"},
	{"tree_monster", "mobs:tree_monster", "default:sapling"},
	{"dungeon_master", "mobs:dungeon_master"},
}

for _, mob in ipairs(mobs_monster) do
	local monster = mob[1]
	local spawn = mob[2]
	local ingredients = mob[3]

	if not ingredients then
		if core.registered_entities[spawn] then
			asm.addEgg({name=monster, spawn=spawn})
		end
	else
		if core.registered_entities[spawn] and core.registered_items[ingredients] then
			asm.addEgg({name=monster, spawn=spawn, ingredients=ingredients})
		end
	end
end
