
mobs_bee = {}
mobs_bee.modname = core.get_current_modname()
mobs_bee.modpath = core.get_modpath(mobs_bee.modname)

-- Load support for intllib.
local S = minetest.get_translator and minetest.get_translator("mobs_animal") or
		dofile(mobs_bee.modpath .. "/intllib.lua")

mobs.intllib = S


dofile(mobs_bee.modpath .. "/bee.lua") -- KrupnoPavel

print (S("[MOD] Mobs Redo bee loaded"))
