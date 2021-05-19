
mobs_cow = {}
mobs_cow.modname = core.get_current_modname()
mobs_cow.modpath = core.get_modpath(mobs_cow.modname)

-- Load support for intllib.
local S = minetest.get_translator and minetest.get_translator("mobs_animal") or
		dofile(mobs_cow.modpath .. "/intllib.lua")

mobs.intllib = S


dofile(mobs_cow.modpath .. "/settings.lua")
dofile(mobs_cow.modpath .. "/cow.lua") -- KrupnoPavel

print (S("[MOD] Mobs Redo cow loaded"))
