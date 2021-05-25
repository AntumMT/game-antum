--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local function registerDyeRecipes(def)
	for I, T in pairs(def) do
		local dye = "dye:" .. T[1]
		local ingredients = T[2]
		-- DEBUG
		core.log("action", "[antum_overrides] Registering new recipe for dye:" .. T[1] .. " with the following ingredients:")
		for i in pairs(ingredients) do
			core.log("action", "[antum_overrides]\t" .. ingredients[i])
		end
		
		core.register_craft({
			output = dye,
			type = "shapeless",
			recipe = ingredients,
		})
	end
end

local dye_defs = {}

if core.get_modpath("flowers") then
	table.insert(dye_defs, -1, {"brown 4", {"flowers:mushroom_brown"}})
end

registerDyeRecipes(dye_defs)
