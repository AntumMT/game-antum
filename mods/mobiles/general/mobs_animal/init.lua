
-- Load support for intllib.
local path = minetest.get_modpath(minetest.get_current_modname()) .. "/"

local S = minetest.get_translator and minetest.get_translator("mobs_animal") or
		dofile(path .. "intllib.lua")

mobs.intllib = S


-- Check for custom mob spawn file
local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_animal = true
	input:close()
	input = nil
end


-- Animals
dofile(path .. "chicken.lua") -- JKmurray
dofile(path .. "cow.lua") -- KrupnoPavel
dofile(path .. "rat.lua") -- PilzAdam
--dofile(path .. "sheep.lua") -- PilzAdam
dofile(path .. "warthog.lua") -- KrupnoPavel
dofile(path .. "bee.lua") -- KrupnoPavel
dofile(path .. "bunny.lua") -- ExeterDad
dofile(path .. "kitten.lua") -- Jordach/BFD
dofile(path .. "penguin.lua") -- D00Med
dofile(path .. "panda.lua") -- AspireMint


-- Load custom spawning
if mobs.custom_spawn_animal then
	dofile(path .. "spawn.lua")
end


-- Lucky Blocks
dofile(path .. "lucky_block.lua")


print (S("[MOD] Mobs Redo Animals loaded"))
