
--- API
--
--  @module api.lua


local ss = server_shop

local sellers = {}
local buyers = {}
local shops = sellers -- backward compat

function ss.get_shops(buyer)
	if buyer then
		return buyers
	end

	return sellers
end

--- Currencies registered for trade.
--
--  @table server_shop.registered_currencies
ss.registered_currencies = {}

-- Suffix displayed after deposited amount.
ss.currency_suffix = nil

--- Registers an item that can be used as currency.
--
--  TODO:
--
--  - after registering currency, should re-organize table from highest value to lowest
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

if ss.use_currency_defaults then
	local mg_notes = {
		{"currency:minegeld", 1},
		{"currency:minegeld_5", 5},
		{"currency:minegeld_10", 10},
		{"currency:minegeld_50", 50},
		{"currency:minegeld_100", 100},
	}

	for _, c in ipairs(mg_notes) do
		ss.register_currency(c[1], c[2])
	end

	ss.currency_suffix = "MG"
end

--- Checks ID string for invalid characters.
--
--  @function server_shop.format_id
--  @tparam string id Shop identifier string.
--  @treturn string Formatted string.
function ss.format_id(id)
	return id:trim():gsub("%s", "_")
end

--- Registers a seller shop.
--
--  @function server_shop.register_seller
--  @tparam string id Shop string identifier.
--  @tparam string name Human readable name.
--  @tparam table[string,int] def List of products & prices in format `{item_name, price}`.
function ss.register_seller(id, name, def)
	if type(id) ~= "string" then
		ss.log("error", ss.modname .. ".register_seller: invalid \"id\" parameter")
		return
	elseif type(name) ~= "string" then
		ss.log("error", ss.modname .. ".register_seller: invalid \"name\" parameter")
		return
	elseif type(def) ~= "table" then
		ss.log("error", ss.modname .. ".register_seller: invalid \"def\" parameter")
		return
	end

	id = ss.format_id(id)

	if sellers[id] then
		ss.log("warning", "Overwriting shop with id: " .. id)
	end

	sellers[id] = {name=name:trim(), def=def,}

	ss.log("action", "Registered seller shop: " .. id)
end

--- Registers a buyer shop.
--
--  @function server_shop.register_buyer
--  @tparam string id Shop string identifier.
--  @tparam string name Human readable name.
--  @tparam table[string,int] def List of products & prices in format `{item_name, price}`.
function ss.register_buyer(id, name, def)
	if type(id) ~= "string" then
		ss.log("error", ss.modname .. ".register_buyer: invalid \"id\" parameter")
		return
	elseif type(name) ~= "string" then
		ss.log("error", ss.modname .. ".register_buyer: invalid \"name\" parameter")
		return
	elseif type(def) ~= "table" then
		ss.log("error", ss.modname .. ".register_buyer: invalid \"def\" parameter")
		return
	end

	id = ss.format_id(id)

	if buyers[id] then
		ss.log("warning", "Overwriting buyer shop with id: " .. id)
	end

	buyers[id] = {name=name:trim(), def=def,}

	ss.log("action", "Registered buyer shop: " .. id)
end

--- Registers a shop.
--
--  Added for backwards compatibility.
--
--  @function server_shop.register_shop
--  @tparam string id Shop string identifier.
--  @tparam string name Human readable name.
--  @tparam table[string,int] def List of products & prices in format `{item_name, price}`.
--  @tparam bool buyer Denotes whether to register seller or buyer shop (default: `false` (seller)).
function ss.register_shop(id, name, def, buyer)
	if buyer then
		ss.register_buyer(id, name, def)
	else
		ss.register_seller(id, name, def)
	end
end

--- Retrieves shop product list.
--
--  @function server_shop.get_shop
--  @tparam string id String identifier of shop.
--  @tparam bool buyer Denotes whether seller or buyer shops will be parsed (default: false).
--  @treturn table Table of shop contents.
function ss.get_shop(id, buyer)
	if buyer then
		return buyers[id]
	end

	return sellers[id]
end

--- Checks if a shop is registered.
--
--  @function server_shop.is_registered
--  @tparam string id Shop string identifier.
--  @tparam bool buyer Denotes whether to check seller or buyer shops (default: false).
--  @tparam bool `true` if the shop ID is found.
function ss.is_registered(id, buyer)
	return ss.get_shop(id, buyer) ~= nil
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
