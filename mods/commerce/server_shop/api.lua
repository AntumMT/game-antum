
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

		if name.type then
			buyer = name.type == "buy"
		end
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

local shops_file = core.get_worldpath() .. "/server_shops.json"

local function shop_file_error(msg)
	ss.log("error", shops_file .. ": " .. msg)
end

--- Loads configuration from world path.
--
--  Configuration file is <world\_path>/server\_shops.json
--
--  @function server_shop.file_load
ss.file_load = function()
	local shops_data = wdata.read("server_shops") or {}

	for _, shop in ipairs(shops_data) do
		if shop.type == "currency" then
			ss.log("warning", "using \"currency\" key in server_shops.json is deprecated, please use \"currencies\"")

			if type(shop.value) ~= "number" or shop.value <= 0 then
				shop_file_error("invalid or undeclared currency \"value\"; must be a number greater than 0")
			end

			ss.register_currency(shop.name, shop.value)
		elseif shop.type == "currencies" then
			if not shop.currencies then shop.currencies = shop.value end -- allow "value" to be used instead of "currencies"
			for k, v in pairs(shop.currencies) do
				ss.register_currency(k, v)
			end
		elseif shop.type == "suffix" then
			if type(shop.value) ~= "string" or shop.value:trim() == "" then
				shop_file_error("invalid or undeclared suffix \"value\"; must be non-empty string")
			else
				ss.currency_suffix = shop.value
			end
		elseif shop.type == "sell" or shop.type == "buy" then
			if type(shop.id) ~= "string" or shop.id:trim() == "" then
				shop_file_error("invalid or undeclared \"id\"; must be non-empty string")
			elseif type(shop.name) ~= "string" or shop.name:trim() == "" then
				shop_file_error("invalid or undeclared \"name\"; must be non-empty string")
			elseif type(shop.products) ~= "table" then
				shop_file_error("invalid or undeclared \"products\" list; must be non-empty table")
			else
				if not shop.products then shop.products = {} end
				if #shop.products == 0 then
					ss.log("warning", shops_file .. ": empty shop list for shop id \"" .. shop.id .. "\"")
				end

				if shop.type == "sell" then
					server_shop.register_seller(shop.id, shop.name, shop.products)
				else
					server_shop.register_buyer(shop.id, shop.name, shop.products)
				end
			end
		elseif not shop.type then
			ss.log("error", shops_file .. ": mandatory \"type\" parameter not set")
		else
			ss.log("error", shops_file .. ": Unrecognized type: " .. shop.type)
		end
	end
end

--- Permanently registers a shop.
--
--  @function server_shop.file_register
--  @tparam string id Shop identifier.
--  @tparam ShopDef def Shop definition.
ss.file_register = function(id, def)
	local shops_data = wdata.read("server_shops") or {}

	local existing = {}
	for idx=1, #shops_data do
		local entry = shops_data[idx]
		if (entry.type == "sell" or entry.type == "buy") and id == entry.id then
			table.insert(existing, 1, idx)
		end
	end

	for _, idx in ipairs(existing) do
		table.remove(shops_data, idx)
	end

	def.id = id
	table.insert(shops_data, def)

	wdata.write("server_shops", shops_data)
end

--- Permanently adds a product to a shop.
--
--  @function server_shop.file_add_product
--  @tparam string id Shop identifier.
--  @tparam string name Item technical name.
--  @tparam int value Item value.
--  @tparam[opt] int idx Shop index for item placement.
ss.file_add_product = function(id, name, value, idx)
	local shops_data = wdata.read("server_shops") or {}

	local target_shop
	for idx=1, #shops_data do
		local entry = shops_data[idx]
		if entry.type == "sell" or entry.type == "buy" then
			if id == entry.id then
				target_shop = entry
				break
			end
		end
	end

	if not target_shop then
		ss.log("error", "cannot add item to non-registered shop ID: " .. id)
		return false
	end

	-- FIXME: check for duplicates

	if not idx or idx > #target_shop.products then
		table.insert(target_shop.products, {name, value})
	else
		table.insert(target_shop.products, idx, {name, value})
	end

	ss.register(id, target_shop)
	wdata.write("server_shops", shops_data)
end

--- Unregisters a shop & updates configuration.
--
--  @function server_shop.file_unregister
--  @tparam string id Shop identifier.
--  @treturn bool
ss.file_unregister = function(id)
	local shops_data = wdata.read("server_shops") or {}

	local unregister_idx
	for idx=1, #shops_data do
		local entry = shops_data[idx]
		if entry.type == "sell" or entry.type == "buy" then
			if id == entry.id then
				unregister_idx = idx
				break
			end
		end
	end

	if not unregister_idx then
		ss.log("warning", "cannot unregister unknown shop ID: " .. id)
		return false
	end

	table.remove(shops_data, unregister_idx)
	ss.unregister(id)
	wdata.write("server_shops", shops_data)
	return true
end

--- Prunes unknown items & updates aliases in shops.
--
--  @function server_shop.prune_shops
ss.prune_shops = function()
	-- show warning if no currencies are registered
	if not ss.currency_is_registered() then
		ss.log("warning", "no currencies registered")
	else
		local have_ones = false
		for k, v in pairs(ss.get_currencies()) do
			have_ones = v == 1
			if have_ones then break end
		end

		if not have_ones then
			ss.log("warning", "no currency registered with value 1, players may not be refunded all of their money")
		end
	end

	-- prune unregistered items
	for id, def in pairs(ss.get_shops()) do
		local pruned = false
		for idx = #def.products, 1, -1 do
			local pname = def.products[idx][1]
			local value = def.products[idx][2]
			if not core.registered_items[pname] then
				ss.log("warning", "removing unregistered item \"" .. pname
					.. "\" from seller shop id \"" .. id .. "\"")
				table.remove(def.products, idx)
				pruned = true
			elseif not value then
				ss.log("warning", "removing item \"" .. pname
					.. "\" without value from seller shop id \"" .. id .. "\"")
				table.remove(def.products, idx)
				pruned = true
			end

			-- check aliases
			local alias_of = core.registered_aliases[pname]
			if alias_of then
				ss.log("action", "replacing alias \"" .. pname .. "\" with \"" .. alias_of
					.. "\" in seller shop id \"" .. id .. "\"")
				table.remove(def.products, idx)
				table.insert(def.products, idx, {alias_of, value})
				pruned = true
			end
		end

		if pruned then
			ss.unregister(id)
			ss.register(id, def)
		end
	end
end
