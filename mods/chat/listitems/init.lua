--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- @script init.lua


listitems = {}
listitems.modname = core.get_current_modname()
listitems.modpath = core.get_modpath(listitems.modname)

listitems.debug = core.settings:get_bool('enable_debug_mods') or false

local scripts = {
	'logging',
	'api',
}

for index, script in ipairs(scripts) do
	dofile(listitems.modpath .. '/' .. script .. '.lua')
end

-- DEBUG:
listitems.logDebug('Loaded')
