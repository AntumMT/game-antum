
-- don't load if xdecor:workbench found
if core.global_exists("xdecor") and core.registered_nodes["xdecor:workbench"] then
	core.register_alias("workbench:workbench", "xdecor:workbench")
	core.register_alias("workbench:hammer", "xdecor:hammer")
	return
end


workbench = {}
workbench.modname = core.get_current_modname()
local modpath = minetest.get_modpath(workbench.modname)

dofile(modpath .. "/handlers/helpers.lua")
dofile(modpath .. "/handlers/nodeboxes.lua")
dofile(modpath .. "/handlers/registration.lua")
dofile(modpath .. "/src/workbench.lua")
