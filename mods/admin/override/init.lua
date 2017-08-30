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


-- Read overrides file from world path
local o_list = nil
local o_path = core.get_worldpath() .. '/overrides.txt'
local o_file = io.open(o_path, 'r')
if o_file then
	o_list = o_file:read()
	o_file:close()
else
	-- Create empty overrides file
	o_file = io.open(o_path, 'w')
	if o_file then
		o_file:close()
	end
end

if o_list then
	o_list = string.split(o_list, '\n')
	local overrides = {}
	
	for i, o in ipairs(o_list) do
		local aliases = string.split(o, ';')
		local target = aliases[2]
		aliases = string.split(aliases[1], ',')
		
		if aliases and target then
			table.insert(overrides, {aliases, target})
		end
	end
	
	for i, o in ipairs(overrides) do
		override.replaceItems(o[1], o[2])
	end
end
