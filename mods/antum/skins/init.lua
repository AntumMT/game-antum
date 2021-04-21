
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
	{"Charizard.png", "Charizard",},
	{"Charlotte.png", "Charlotte",},
	{"Chloé_01.png", "Chloé (by nelly) ",},
	{"Chloé_02.png", "Chloé (by Sporax)",},
	{"Chop.png", "Chop",},
	{"Coralie.png", "Coralie",},
	{"Devil.png", "Devil",},
	{"Emma.png", "Emma",},
	{"Female_angel.png", "Angel (female)",},
	{"Finn_The_Adventured.png", "Finn",},
	{"Fiona.png", "Fiona",},
	{"Fire_Mario.png", "Fire Mario",},
	{"Grégoire.png", "Grégoire",},
	{"Hobo.png", "Hobo",},
	{"Infantry_man.png", "Infantry Man",},
	{"Iris.png", "Iris",},
	{"Iron_Man_MK._7.png", "Iron Man",},
	{"Jake.png", "Jake",},
	{"Joker.png", "Joker",},
	{"Julia.png", "Julia",},
	{"Ladyvioletkitty.png", "LadyVioletKitty",},
	{"Link.png", "Link",},
	{"lisa.png", "Lisa",},
	{"Male_angel.png", "Angel (male)",},
	{"Morgane.png", "Morgane",},
	{"Naruto.png", "Naruto",},
	{"NERD.png", "NERD",},
	{"Older_Man_Sam.png", "Sam (older man)",},
	{"philipbenr.png", "PhilipBenR",},
	{"skin_minecraft_repris.png", "Minecraft Repris",},
	{"Space_Sam.png", "Sam (space)",},
	{"Summer.png", "Summer",},
	{"SuperSam.png", "Sam (super)",},
	{"villiantest_III.png", "VillianTest",},
	{"War_Machine.png", "War Machine",},
	{"Witch.png", "Witch",},
	{"Zenohelds.png", "Zenohelds",},
	{"tessas_skin.png", "Tessa",},
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
