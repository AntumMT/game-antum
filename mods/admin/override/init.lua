--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- @script init.lua


override = {}
override.modname = core.get_current_modname()
override.modpath = core.get_modpath(override.modname)

override.debug = core.settings:get_bool('enable_debug_mods') or false


local scripts = {
	'logging',
	'api',
}

for i, s in ipairs(scripts) do
	dofile(override.modpath .. '/' .. s .. '.lua')
end
