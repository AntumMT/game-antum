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


-- Sheep spawnegg
if core.get_modpath("sheep") and core.get_modpath("wool") then
	asm.addEgg("sheep", "creatures:sheep", "group:wool")
end

-- Chicken spawnegg
if core.get_modpath("chicken") then
	asm.addEgg("chicken", "creatures:chicken", "antum:feather")
end

-- cow
if core.get_modpath("mobs_animal") and core.registered_items["mobs:bucket_milk"] then
	asm.addEgg("cow", "mobs_animal:cow", "mobs:bucket_milk")
end

-- Oerrki spawnegg
if core.get_modpath("oerkki") and core.registered_items["default:obsidian"] then
	asm.addEgg("oerkki", "creatures:oerkki", "default:obsidian")
end


local mobs_monster = core.get_modpath("mobs_monster") ~= nil

-- mobs_redo monsters
if mobs_monster and core.global_exists("default") then
	-- dirt monster
	asm.addEgg("dirt_monster", "mobs_monster:dirt_monster", "default:dirt")

	-- mese monster
	asm.addEgg("mese_monster", "mobs_monster:mese_monster", "default:mese")

	-- sand monster
	asm.addEgg("sand_monster", "mobs_monster:sand_monster", "default:sand")

	-- tree monster
	asm.addEgg("tree_monster", "mobs_monster:tree_monster", "default:sapling")

	-- dungeon master (needs ingredient)
	asm.addEgg("dungeon_master", "mobs_monster:dungeon_master")

	-- spider (needs ingredient & texture, disabled)
	--asm.addEgg("spider", "mobs_monster:spider")

	-- stone monster (disabled: too graphic)
	--asm.addEgg("stone_monster", "mobs_monster:stone_monster", "default:stone")
end
