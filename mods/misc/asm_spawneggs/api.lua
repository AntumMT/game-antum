--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2021 Jordan Irwin

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

--- API
--
--  @module api.lua


local S = core.get_translator(asm.modname)

local registered_eggs = {}

--- Retrieves egg that spawns specified entity.
--
--  @function asm.getEgg
--  @tparam string entity Entity name spawned by egg.
--  @treturn string Egg name or `nil`.
function asm.getEgg(entity)
	return registered_eggs[entity]
end


--- Adds a craft recipe for an egg.
--
--  Alias: *asm.addEggRecipe*
--
--  @function asm.registerEggRecipe
--  @param name Name of spawnegg that will be created from recipe.
--  @param ingredients Items used for recipe in addition to `spawneggs:egg`. Can be string or list.
asm.registerEggRecipe = function(name, ingredients)
	if type(ingredients) == "string" then
		ingredients = {ingredients,}
	end

	table.insert(ingredients, 1, "spawneggs:egg")
	core.register_craft({
		output = "spawneggs:" .. name,
		type = "shapeless",
		recipe = ingredients,
	})
end

-- Alias for `asm.registerEggRecipe`.
asm.addEggRecipe = asm.registerEggRecipe


local function formatTitle(s)
	s = s:gsub("_", " ")

	local t = {}

	for m in (s .. " "):gmatch("(.-) ") do
		local v = m:gsub("^%l", string.upper)
		table.insert(t, v)
	end

	return S("@1 Spawn Egg", table.concat(t, " "))
end

--- Registers new egg in game.
--
--  Alias: *asm.addEgg*
--
--  @function asm.registerEgg
--  @param def `EggDef` table.
asm.registerEgg = function(def)
	local img = "spawneggs_" .. def.name .. ".png"
	if def.inventory_image then
		img = def.inventory_image
	end

	local title = def.title
	if not title then
		title = formatTitle(def.name)
	end

	local egg_name = "spawneggs:" .. def.name:lower()

	core.register_craftitem(":" .. egg_name, {
		description = title,
		inventory_image = img,

		on_place = function(itemstack, placer, target)
			if target.type == "node" then
				local pos = target.above
				pos.y = pos.y + 1
				local ref = core.add_entity(pos, def.spawn)
				if ref and placer:is_player() then
					local entity = ref:get_luaentity()
					-- set owner
					if entity.ownable then entity.owner = placer:get_player_name() end
				end
				if not core.settings:get_bool("creative_mode") then
					itemstack:take_item()
				end

				return itemstack
			end
		end
	})

	-- store registration
	registered_eggs[def.spawn] = egg_name

	if def.ingredients then
		asm.registerEggRecipe(def.name:lower(), def.ingredients)
	end

	-- DEBUG
	asm.log("action", "Registered spawnegg for " .. def.spawn)
end

-- Alias for `asm.registerEgg`.
asm.addEgg = asm.registerEgg


--- Egg definition table.
--
--  @table EggDef
--  @tfield string name Name of the egg. Will be appended to "spawneggs:".
--  @tfield[opt] string title Description displayed for item.
--  @tfield string inventory_image Image displayed in inventory.
--  @tfield string spawn Entity that will be spawned from egg.
--  @tfield[opt] table ingredients Ingredients to use, in addition to `spawneggs:egg`, to register craft recipe. Can be a `table` or `string`.
