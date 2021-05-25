--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


antum.craft = {}

antum.craft.modname = core.get_current_modname()
antum.craft.modpath = core.get_modpath(antum.craft.modname)


-- Load sub-scripts
local scripts = {
	"items",
	"crafting",
}

for _, script in ipairs(scripts) do
	antum.loadScript(script)
end
