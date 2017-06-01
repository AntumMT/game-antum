
local path = minetest.get_modpath("mobs_animal")

-- Intllib
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end
mobs.intllib = S

local function log(message)
	if minetest.setting_getbool("log_mods") then
		minetest.log("action", "[mobs_animal] " .. message)
	end
end

-- Animals

local animals = {
	"chicken", -- JKmurray
	"cow", -- KrupnoPavel
	"rat", -- PilzAdam
	"sheep", -- PilzAdam
	"warthog", -- KrupnoPavel
	"bee", -- KrupnoPavel
	"bunny", -- ExeterDad
	"kitten", -- Jordach/BFD
	"penguin", -- D00Med
}

for index, animal in ipairs(animals) do
	local enable_animal = minetest.setting_getbool("mobs.enable_" .. animal)
	-- Default enabled
	if enable_animal == nil then
		enable_animal = true
	end
	if enable_animal then
		log(animal .. " enabled")
		dofile(path .. "/" .. animal .. ".lua")
	else
		log(animal .. " disabled")
	end
end

dofile(path .. "/lucky_block.lua")

print (S("[MOD] Mobs Redo 'Animals' loaded"))
