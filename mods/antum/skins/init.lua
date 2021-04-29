
local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)
local texture_dir = modpath .. "/textures"

local function logit(lvl, msg)
	core.log(lvl, "[" .. modname .. "] " .. msg)
end

local function texture_exists(fname)
	local texture = texture_dir .. "/" .. fname
	local f = io.open(texture, "r")
	if f ~= nil then
		io.close(f)
		return true
	end

	return false
end

local skins = {
	{"Ashley.png", "Ashley",},
	{"BlueZ_Sam_II.png", "BlueZ Sam II ",},
	{"CaligoPL.png", "CaligoPL",},
	{"Charlotte.png", "Charlotte",},
	{"Chloe_01.png", "Chloé (by nelly) ",},
	{"Chloe_02.png", "Chloé (by Sporax)",},
	{"Coralie.png", "Coralie",},
	{"Devil.png", "Devil",},
	{"Emma.png", "Emma",},
	{"Female_angel.png", "Angel (female)",},
	{"Fiona.png", "Fiona",},
	{"Gregoire.png", "Grégoire",},
	{"Hobo.png", "Hobo",},
	{"Infantry_man.png", "Infantry Man",},
	{"Iris.png", "Iris",},
	{"Julia.png", "Julia",},
	{"Ladyvioletkitty.png", "LadyVioletKitty",},
	{"lisa.png", "Lisa",},
	{"Male_angel.png", "Angel (male)",},
	{"Morgane.png", "Morgane",},
	{"Older_Man_Sam.png", "Sam (older man)",},
	{"philipbenr.png", "PhilipBenR",},
	{"Skeleton.png", "Skeleton",},
	{"skeleton_disguise.png", "Skeleton Disguise",},
	{"skin_minecraft_repris.png", "Minecraft Repris",},
	{"Space_Sam.png", "Sam (space)",},
	{"Super_Nerd.png", "Super Nerd",},
	{"SuperSam.png", "Sam (super)",},
	{"wheat_farmer.png", "Wheat Farmer",},
	{"villiantest_III.png", "VillianTest",},
	{"Witch.png", "Witch",},
	{"Zenohelds.png", "Zenohelds",},
}

for _, skin in ipairs(skins) do
	local key = skin[1]
	local value = skin[2]

	if not texture_exists(key) then
		logit("warning", "texture " .. key .. " not found in " .. texture_dir)
	end

	wardrobe.registerSkin(skin[1], skin[2])
end

-- put skins in alphabetical order
wardrobe.sortNames()
