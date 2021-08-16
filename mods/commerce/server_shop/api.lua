
--- Server Shops API
--
--  @topic api.lua


local ss = server_shop


local shops = {}

ss.get_shops = function()
	return table.copy(shops)
end

local registered_currencies = {}

-- Suffix displayed after deposited amount.
ss.currency_suffix = nil

--- Checks if there are registered currencies in order to give refunds.
--
--  @function server_shop.currency_is_registered
--  @treturn bool `true` if at least one currency item is registered.
ss.currency_is_registered = function()
	for k, v in pairs(registered_currencies) do
		return true
	end

	return false
end

--- Retrieves registered currencies & values.
--
--  @function server_shop.get_currencies
--  @treturn table Registered currencies.
ss.get_currencies = function()
	return table.copy(registered_currencies)
end

--- Registers an item that can be used as currency.
--
--  @function server_shop.register_currency
--  @tparam string item Item name.
--  @tparam int value Value the item should represent.
ss.register_currency = function(item, value)
	if not core.registered_items[item] then
		ss.log("warning", "Registering unrecognized item as currency: " .. item)
	end

	value = tonumber(value)
	if not value then
		ss.log("error", "Currency type for " .. item .. " must be a number. Got \"" .. type(value) .. "\"")
		return
	end

	local old_value = registered_currencies[item]
	if old_value then
		ss.log("warning", "Overwriting value for currency " .. item
			.. " from " .. tostring(old_value)
			.. " to " .. tostring(value))
	end

	registered_currencies[item] = value

	ss.log("action", item .. " registered as currency with value of " .. tostring(value))
end

if ss.use_currency_defaults then
	if not core.get_modpath("currency") then
		ss.log("warning", "currency mod not found, not registering default currencies")
	else
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
end

--- Checks ID string for invalid characters.
--
--  @function server_shop.format_id
--  @tparam string id Shop identifier string.
--  @treturn string Formatted string.
ss.format_id = function(id)
	return id:trim():gsub("%s", "_")
end

--- Registers a shop.
--
--  **Aliases:**
--
--  - server\_shop.register\_shop
--
--  @function server_shop.register
--  @tparam string id Shop string identifier.
--  @param name Can be a human readable `string` name or a `table` with fiels "name", "products", & "buyer".
--  @tparam table[string,int] products List of products & prices in format `{item_name, price}`.
--  @tparam[opt] bool buyer Denotes whether to register seller or buyer shop (default: `false` (seller)).
ss.register = function(id, name, products, buyer)
	if type(name) == "table" then
		products = name.products
		buyer = name.buyer
		name = name.name
	end

	if type(id) ~= "string" then
		ss.log("error", ss.modname .. ".register: invalid \"id\" parameter")
		return
	elseif type(name) ~= "string" then
		ss.log("error", ss.modname .. ".register: invalid \"name\" parameter")
		return
	elseif type(products) ~= "table" then
		ss.log("error", ss.modname .. ".register: invalid \"products\" parameter")
		return
	end

	id = ss.format_id(id)

	if shops[id] ~= nil then
		ss.log("warning", "Overwriting shop with id: "..id)
	end

	shops[id] = {name=name:trim(), products=products, buyer=buyer}

	ss.log("action", "Registered "..ss.shop_type(id).." shop with id: "..id)
end

-- backward compatibility
ss.register_shop = ss.register

--- Unregisters a shop.
--
--  @function server_shop.unregister
--  @tparam string Shop ID.
--  @treturn bool `true` if shop was unregistered.
ss.unregister = function(id)
	local unregistered = false
	if shops[id] ~= nil then
		local stype = ss.shop_type(id)
		shops[id] = nil
		ss.log("action", "Unregistered "..stype.." shop with id: "..id)
		return true
	end

	ss.log("action", "Cannot unregister non-registered shop with id: "..id)
	return false
end

--- Registers a seller shop.
--
--  @function server_shop.register_seller
--  @tparam string id Shop string identifier.
--  @tparam string name Human readable name.
--  @tparam table[string,int] products List of products & prices in format `{item_name, price}`.
ss.register_seller = function(id, name, products)
	return ss.register(id, name, products)
end

--- Registers a buyer shop.
--
--  @function server_shop.register_buyer
--  @tparam string id Shop string identifier.
--  @tparam string name Human readable name.
--  @tparam table[string,int] products List of products & prices in format `{item_name, price}`.
ss.register_buyer = function(id, name, products)
	return ss.register(id, name, products, true)
end

--- Retrieves shop product list.
--
--  @function server_shop.get_shop
--  @tparam string id String identifier of shop.
--  @tparam bool buyer Denotes whether seller or buyer shops will be parsed (default: false) (deprecated).
--  @treturn table Table of shop contents.
ss.get_shop = function(id, buyer)
	if buyer ~= nil then
		ss.log("warning", "get_shop: \"buyer\" parameter is deprecated")
	end

	local s = shops[id]
	if s then
		s = table.copy(s)
	end

	return s
end

--- Checks if a shop is registered.
--
--  @function server_shop.is_registered
--  @tparam string id Shop string identifier.
--  @tparam bool buyer Denotes whether to check seller or buyer shops (default: false) (deprecated).
--  @treturn bool `true` if the shop ID is found.
ss.is_registered = function(id, buyer)
	if buyer ~= nil then
		ss.log("warning", "is_registered: \"buyer\" parameter is deprecated")
	end

	return ss.get_shop(id) ~= nil
end

---
--
--  @function server_shop.shop_type
--  @tparam string id
ss.shop_type = function(id)
	local shop = ss.get_shop(id)
	if shop == nil then
		return "unregistered"
	end

	if shop.buyer then
		return "buyer"
	end

	return "seller"
end

--- Checks if a player has admin rights to for managing shop.
--
--  @function server_shop.is_shop_admin
--  @tparam ObjectRef player Player requesting permissions.
--  @return `true` if player has *server* priv.
ss.is_shop_admin = function(player)
	if not player then
		return false
	end

	return core.check_player_privs(player, "server")
end

--- Checks if a player is the owner of node.
--
--  @function server_shop.is_shop_owner
--  @tparam vector pos Position of shop node.
--  @tparam ObjectRef player Player to be checked.
--  @treturn bool `true` if player is owner.
ss.is_shop_owner = function(pos, player)
	if not player then
		return false
	end

	local meta = core.get_meta(pos)
	return player:get_player_name() == meta:get_string("owner")
end
