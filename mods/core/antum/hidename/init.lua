--[[ MIT LICENSE HEADER
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
--]]


hidename = {}
hidename.modname = core.get_current_modname()
hidename.modpath = core.get_modpath(hidename.modname)


local scripts = {
	'settings',
	'api',
	'command',
}

for i, s in ipairs(scripts) do
	dofile(hidename.modpath .. '/' .. s .. '.lua')
end
