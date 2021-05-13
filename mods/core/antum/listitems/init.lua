--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin (AntumDeluge)

  See: LICENSE.txt
--]]

--- @script init.lua


listitems = {}
listitems.modname = core.get_current_modname()
listitems.modpath = core.get_modpath(listitems.modname)

local scripts = {
	"settings",
	"logging",
	"api",
}

for index, script in ipairs(scripts) do
	dofile(listitems.modpath .. "/" .. script .. ".lua")
end

-- DEBUG:
listitems.logDebug("Loaded")
