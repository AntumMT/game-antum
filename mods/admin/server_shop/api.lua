
--- API
--
--  @module api.lua


local ss = server_shop

--- Registered shops.
--
--  @local
--  @table shops
local shops = {}

--- Currencies registered for trade.
--
--  @table server_shop.registered_currencies
ss.registered_currencies = {}

-- Suffix displayed after deposited amount.
ss.currency_suffix = nil

--- Registers an item that can be used as currency.
--
--  TODO:
--    - after registering currency, should re-organize table from highest value to lowest
--
--  @function server_shop.register_currency
--  @tparam string item Item name.
--  @tparam int value Value the item should represent.
function ss.register_currency(item, value)
	if not core.registered_items[item] then
		ss.log("warning", "Registering unrecognized item as currency: " .. item)
	end

	value = tonumber(value)
	if not value then
		ss.log("error", "Currency type for " .. item .. " must be a number. Got \"" .. type(value) .. "\"")
		return
	end

	local old_value = ss.registered_currencies[item]
	if old_value then
		ss.log("warning", "Overwriting value for currency " .. item
			.. " from " .. tostring(old_value)
			.. " to " .. tostring(value))
	end

	ss.registered_currencies[item] = value

	ss.log("action", item .. " registered as currency with value of " .. tostring(value))
end

--- Registers a shop list to be accessed via a shop node.
--
--  TODO:
--    - log warning if `def` name or value missing or wrong type or
--      if name is empty string
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
--  @function server_shop.is_shop_admin
--  @param player Player requesting permissions.
--  @return `true` if player has *server* priv.
function ss.is_shop_admin(player)
	if not player then
		return false
	end

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
