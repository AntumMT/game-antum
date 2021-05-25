--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local modoverrides = {
	"walking_light",
}

for _, mo in ipairs(modoverrides) do
	if core.get_modpath(mo) then
		antum.loadScript("misc/" .. mo)
	end
end
