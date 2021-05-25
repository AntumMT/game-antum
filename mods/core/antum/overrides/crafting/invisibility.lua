--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local depends_satisfied = true

local depends = {
	"antum",
	"antum_items",
	"bucket",
	"default",
	"vessels",
}

for I in pairs(depends) do
	if not core.get_modpath(depends[I]) then
		depends_satisfied = false
	end
end

if depends_satisfied then
	antum.registerCraft({
		output = "invisibility:potion",
		type = "shapeless",
		recipe = {
			"antum:bottled_water", "default:mese_crystal_fragment",
		},
	})
end
