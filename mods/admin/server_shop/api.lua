--- API
--

local ss = server_shop


local shops = {}

--- Registers a shop list to be accessed via a shop node.
--
--  @function server_shop.register_shop
--  @param id String ID associated with shop list.
--  @param name Human readable name to be displayed.
--  @param def Shop definition (e.g. items & prices)
function ss.register_shop(id, name, def)
	if shops[id] then
		ss.log("warning", "Overwriting shop with id: " .. id)
	end

	local new_shop = {name=name, def=def,}
	shops[id] = new_shop

	ss.log("action", "Registered shop: " .. id)
end

--- Retrieves shop by ID.
--
--  @function server_shop.get_shop
--  @param id String identifier of shop.
--  @return Table of shop contents.
function ss.get_shop(id)
	return shops[id]
end

--- Checks if a player has admin rights to for managing shop.
--
--  @function server_shoip.is_shop_admin
--  @param pos Position of shop.
--  @param player Player requesting permissions.
--  @return `true` if player has *server* priv.
function ss.is_shop_admin(pos, player)
	if not player then
		return false
	end

	local meta = core.get_meta(pos)
	return core.check_player_privs(player, "server")
end

--- Checks if a player is the owner of node.
--
--  @function server_shop.is_shop_owner
--  @param pos Position of shop node.
--  @param player Player to be checked.
--  @return `true` if player is owner.
function ss.is_shop_owner(pos, player)
	if not player then
		return false
	end

	local meta = core.get_meta(pos)
	return player:get_player_name() == meta:get_string("owner")
end
