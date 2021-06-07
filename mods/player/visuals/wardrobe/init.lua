
local world_path = core.get_worldpath();

wardrobe = {};
wardrobe.name = core.get_current_modname();
wardrobe.path = core.get_modpath(wardrobe.name)
wardrobe.player_skin_db = world_path.."/playerSkins.txt"
wardrobe.skin_files = {wardrobe.path.."/skins.txt", world_path.."/skins.txt"};
wardrobe.playerSkins = {}

function wardrobe.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. wardrobe.name .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


dofile(wardrobe.path.."/settings.lua")
dofile(wardrobe.path.."/formspec.lua")
local initSkin, changeSkin, updateSkin = dofile(wardrobe.path.."/skinMethods.lua");
dofile(wardrobe.path.."/storage.lua");
dofile(wardrobe.path.."/wardrobe.lua");


-- API

--- Updates the visual appearance of a player's skin according to whatever skin
 -- has been set for the player.
 --
 -- @param player
 --    The Player object for the player.
 --
wardrobe.updatePlayerSkin = updateSkin;

--- Compatibility method.
 --
 -- Identical to wardrobe.updatePlayerSkin(player).
 --
wardrobe.setPlayerSkin = updateSkin;

--- Changes the skin set for a named player.
 --
 -- Player need not be logged in.  Automatically updates the player's visual
 -- appearance accordingly if they ARE logged in.
 --
 -- @param playerName
 --    Name of the player.
 -- @param skin
 --    Name of the skin.
 --
function wardrobe.changePlayerSkin(playerName, skin)
	changeSkin(playerName, skin);

	local player = core.get_player_by_name(playerName);
	if player then updateSkin(player); end;
end


wardrobe.loadSkins();
wardrobe.loadPlayerSkins();

if initSkin then
	core.register_on_joinplayer(
		function(player)
			core.after(1, initSkin, player)
		end);
end;

if not changeSkin then
	error("No wardrobe skin change method registered.  Check skinMethods.lua.");
end;
if not updateSkin then
	error("No wardrobe skin update method registered.  Check skinMethods.lua.");
end;

