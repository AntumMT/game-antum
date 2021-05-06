--[[ LICENSE HEADER

  MIT License

  Copyright © 2017 Jordan Irwin

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

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


-- Chicken spawnegg
if core.registered_entities["creatures:chicken"] then
	asm.addEgg({
		name = "chicken",
		spawn = "creatures:chicken",
		ingredients = "antum:feather",
	})
end

-- cow
if core.registered_entities["mobs_animal:cow"] and core.registered_items["mobs:bucket_milk"] then
	asm.addEgg({
		name = "cow",
		spawn = "mobs_animal:cow",
		ingredients = "mobs:bucket_milk",
	})
end

-- spider (needs ingredient)
if core.registered_entities["mobs:spider"] then
	asm.addEgg({
		name = "spider",
		spawn = "mobs:spider",
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
