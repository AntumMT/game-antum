
server_shop = {}
local ss = server_shop

ss.modname = core.get_current_modname()
ss.modpath = core.get_modpath(ss.modname)

function ss.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. ss.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end

local scripts = {
	"settings",
	"api",
	"deposit",
	"formspec",
	"node",
}

for _, script in ipairs(scripts) do
	dofile(ss.modpath .. "/" .. script .. ".lua")
end

-- load configured shops from world directory
local shops_file = core.get_worldpath() .. "/server_shops.json"

local function shop_file_error(msg)
	error(shops_file .. ": " .. msg)
end

local fopen = io.open(shops_file, "r")
if fopen ~= nil then
	local content = fopen:read("*a")
	io.close(fopen)

	local json = core.parse_json(content)
	if json then
		for _, shop in ipairs(json) do
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
				error(shops_file .. ": mandatory \"type\" parameter not set")
			else
				error(shops_file .. ": Unrecognized type: " .. shop.type)
			end
		end
	end
else
	-- create file if doesn't exist
	fopen = io.open(shops_file, "w")
	if fopen == nil then
		server_shop.log("error", "Could not create " .. shops_file .. ", directory exists")
	else
		io.close(fopen)
	end
end


core.register_on_mods_loaded(function()
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
				-- FIXME: this should be done in registration method
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
end)
