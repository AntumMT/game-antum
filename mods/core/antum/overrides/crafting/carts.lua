--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]

local depends_satisfied = true

local depends = {
	"default",
}

for I in pairs(depends) do
	if not core.get_modpath(depends[I]) then
		depends_satisfied = false
	end
end

if depends_satisfied then
	antum.registerCraft({
		output = "carts:powerrail",
		type = "shapeless",
		recipe = {
			"default:rail", "default:mese_crystal_fragment",
		}
	})
end
