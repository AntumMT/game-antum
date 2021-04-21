
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
	{"Ashley_by_loupicate.png", "Ashley",},
	{"BlueZ_Sam_II_by_philipbenr.png", "BlueZ Sam II ",},
	{"CaligoPL_by_CaligoPL.png", "CaligoPL",},
	{"Charizard_by_Ferdi_Napoli.png", "Charizard",},
	{"Charlotte_by_Sporax.png", "Charlotte",},
	{"Chloé_by_nelly.png", "Chloé (by nelly) ",},
	{"Chloé_by_Sporax.png", "Chloé (by Sporax)",},
	{"Chop_by_Ferdi_Napoli.png", "Chop",},
	{"Coralie_by_loupicate.png", "Coralie",},
	{"Devil_by_viv100.png", "Devil",},
	{"Emma_by_Cidney7760.png", "Emma",},
	{"Female_angel_by_loupicate.png", "Angel (female)",},
	{"Finn_The_Adventured_by_Ferdi_Napoli.png", "Finn",},
	{"Fiona_by_loupicate.png", "Fiona",},
	{"Fire_Mario_by_Ferdi_Napoli.png", "Fire Mario",},
	{"Grégoire_by_Sporax.png", "Grégoire",},
	{"Hobo_by_Minetestian.png", "Hobo",},
	{"Infantry_man_by_philipbenr.png", "Infantry Man",},
	{"Iris_by_loupicate.png", "Iris",},
	{"Iron_Man_MK._7_by_Jordach.png", "Iron Man",},
	{"Jake_by_Ferdi_Napoli.png", "Jake",},
	{"Joker_by_Ferdi_Napoli.png", "Joker",},
	{"Julia_by_nelly.png", "Julia",},
	{"Ladyvioletkitty_by_lordphoenixmh.png", "LadyVioletKitty",},
	{"Link_by_tux_peng.png", "Link",},
	{"lisa_by_hansuke123.png", "Lisa",},
	{"Male_angel_by_loupicate.png", "Angel (male)",},
	{"Morgane_by_loupicate.png", "Morgane",},
	{"Naruto_by_LuxAtheris.png", "Naruto",},
	{"NERD_by_DJOZZY.png", "NERD",},
	{"Older_Man_Sam_by_philipbenr.png", "Sam (older man)",},
	{"philipbenr_by_philipbenr.png", "PhilipBenR",},
	{"skin_minecraft_repris_by_Sporax.png", "Minecraft Repris",},
	{"Space_Sam_by_philipbenr.png", "Sam (space)",},
	{"Summer_by_lizzie.png", "Summer",},
	{"SuperSam_by_AMMOnym.png", "Sam (super)",},
	{"villiantest_III_by_marshrover.png", "VillianTest",},
	{"War_Machine_by_Ferdi_Napoli.png", "War Machine",},
	{"Witch_by_loupicate.png", "Witch",},
	{"Zenohelds_by_sdzen.png", "Zenohelds",},
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
