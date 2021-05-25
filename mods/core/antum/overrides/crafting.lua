--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local modoverrides = {
	"atm",
	"bags",
	"biofuel",
	"carts",
	"castle_weapons",
	"craftguide",
	"currency",
	"dye",
	"ethereal",
	"farming",
	"helicopter",
	"invisibility",
	"motorbike",
	"mypaths",
	"simple_protection",
}

for index, modname in ipairs(modoverrides) do
	if core.get_modpath(modname) then
		if antum.verbose then
			antum.log("action", "Executing craft overrides for \"" .. modname .. "\" mod")
		end

		antum.loadScript("crafting/" .. modname)
	end
end

antum.loadScript("crafting/homedecor")
