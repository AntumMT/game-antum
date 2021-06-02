--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local modoverrides = {}

for _, mo in ipairs(modoverrides) do
	if core.get_modpath(mo) then
		antum.loadScript("nodes/" .. mo)
	end
end
