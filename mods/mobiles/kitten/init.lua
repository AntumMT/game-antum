
mobs_kitten = {}
mobs_kitten.modname = core.get_current_modname()
mobs_kitten.modpath = core.get_modpath(mobs_kitten.modname)

-- Load support for intllib.
local S = minetest.get_translator and minetest.get_translator("mobs_animal") or
		dofile(mobs_kitten.modpath .. "/intllib.lua")

mobs.intllib = S


dofile(mobs_kitten.modpath .. "/settings.lua")
dofile(mobs_kitten.modpath .. "/kitten.lua") -- Jordach/BFD

print (S("[MOD] Mobs Redo kitten loaded"))
