--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


-- ** castle_weapons **

-- Recipe for "throwing:arrow" conflicts with "castle_weapons:crossbow_bolt"
if antum.dependsSatisfied({"throwing", "antum"}) then
	-- TODO: Possible alternate solutions:
	--   * Allow "throwing:arrow" to be used as ammo for "castle_weapons:crossbow"

	-- FIXME: Cannot use "antum.overrideCraftOutput" because "core.clear_craft" does not allow
	--        clearing craft by output with quantity. E.g., "castle_weapons:crossbow_bolt 6".
	--  - Solution 1: Parse whitespace in "output"
	antum.clearCraftOutput("castle_weapons:crossbow_bolt")

	-- New recipe
	antum.registerCraft({
		output = "castle_weapons:crossbow_bolt 6",
		recipe = {
			{"antum:feather", "default:stick", "default:steel_ingot"},
		},
	})

	-- Same recipe but reversed
	antum.registerCraft({
		output = "castle_weapons:crossbow_bolt 6",
		recipe = {
			{"default:steel_ingot", "default:stick", "antum:feather"},
		},
	})
end
