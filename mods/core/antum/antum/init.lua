--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


antum = {}
antum.modname = core.get_current_modname()
antum.modpath = core.get_modpath(antum.modname)

antum.verbose = false
if core.settings:get_bool("log_mods") then
	antum.verbose = true
end


-- Load API functions
dofile(antum.modpath .. "/api.lua")
