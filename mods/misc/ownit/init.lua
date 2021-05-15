
ownit = {}
ownit.modname = core.get_current_modname()
ownit.modpath = core.get_modpath(ownit.modname)

dofile(ownit.modpath .. "/wand.lua")
