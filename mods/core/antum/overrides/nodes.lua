--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local modoverrides = {
	"technic_worldgen",
}

for _, mo in ipairs(modoverrides) do
	antum.loadScript("nodes/" .. mo)
end
