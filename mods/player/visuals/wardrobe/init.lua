
local world_path = core.get_worldpath()

wardrobe = {}
wardrobe.modname = core.get_current_modname()
wardrobe.modpath = core.get_modpath(wardrobe.modname)

wardrobe.player_skin_db = world_path .. "/playerSkins.txt"
wardrobe.skin_files = {wardrobe.modpath .. "/skins.txt", world_path .. "/skins.txt"}
wardrobe.playerSkins = {}

wardrobe.use_3d_armor = core.get_modpath("3d_armor") ~= nil and core.global_exists("armor")

function wardrobe.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. wardrobe.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"api",
	"formspec",
	"node",
}

for _, script in ipairs(scripts) do
	dofile(wardrobe.modpath .. "/" .. script .. ".lua")
end

-- workaround for not using mod name "wardrobe" which is registered with 3d_armor
if wardrobe.use_3d_armor and armor.set_skin_mod then
	armor.set_skin_mod("wardrobe")
end

wardrobe.loadSkins()
wardrobe.loadPlayerSkins()
