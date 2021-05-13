
server_shop = {}
local ss = server_shop

ss.modname = core.get_current_modname()
ss.modpath = core.get_modpath(ss.modname)

function ss.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	if not lvl then
		core.log("[" .. ss.modname .. "] " .. msg)
	else
		core.log(lvl, "[" .. ss.modname .. "] " .. msg)
	end
end

local scripts = {
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
	for _, shop in ipairs(json) do
		if shop.type == "currency" then
			if type(shop.value) ~= "number" or shop.value <= 0 then
				shop_file_error("invalid or undeclared currency \"value\"; must be a number greater than 0")
			end

			ss.register_currency(shop.name, shop.value)
		elseif shop.type == "suffix" then
			if type(shop.value) ~= "string" or shop.value:trim() == "" then
				shop_file_error("invalid or undeclared suffix \"value\"; must be non-empty string")
			else
				ss.currency_suffix = shop.value
			end
		elseif shop.type == "sell" then
			if type(shop.id) ~= "string" or shop.id:trim() == "" then
				shop_file_error("invalid or undeclared \"id\"; must be non-empty string")
			elseif type(shop.name) ~= "string" or shop.name:trim() == "" then
				shop_file_error("invalid or undeclared \"name\"; must be non-empty string")
			elseif type(shop.products) ~= "table" then
				shop_file_error("invalid or undeclared \"products\" list; must be non-empty table")
			else
				shop.id = shop.id:trim()
				shop.name = shop.name:trim()
				local products = {}

				for k, v in pairs(shop.products) do
					if type(k) ~= "string" or k == "" then
						shop_file_error("shop " .. shop.id .. ": invalid or undeclared product name, must be string")
					elseif type(v) ~= "number" or v <= 0 then
						shop_file_error("shop " .. shop.id .. ": invalid or undeclared product value ("
							.. k .. "), must be number greater than 0")
					else
						table.insert(products, {k, v})
					end
				end

				if #products == 0 then
					ss.log("warning", shop_file .. ": empty shop list for shop id \"" .. shop.id .. "\"")
				end

				server_shop.register_shop(shop.id, shop.name, products)
			end
		elseif not shop.type then
			error(shops_file .. ": mandatory \"type\" parameter not set")
		else
			error(shops_file .. ": Unrecognized type: " .. shop.type)
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
