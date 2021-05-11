
server_shop = {}
server_shop.modname = core.get_current_modname()
server_shop.modpath = core.get_modpath(server_shop.modname)

function server_shop.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	if not lvl then
		core.log("[" .. server_shop.modname .. "] " .. msg)
	else
		core.log(lvl, "[" .. server_shop.modname .. "] " .. msg)
	end
end

local scripts = {
	"api",
	"formspec",
	"node",
}

for _, script in ipairs(scripts) do
	dofile(server_shop.modpath .. "/" .. script .. ".lua")
end


-- load configured shops from world directory
local shops_file = core.get_worldpath() .. "/server_shops.json"
local fopen = io.open(shops_file, "r")
if fopen ~= nil then
	local content = fopen:read("*a")
	io.close(fopen)

	local json = core.parse_json(content)
	for _, shop in ipairs(json) do
		local sells = {}
		for k, v in pairs(shop.sells) do
			table.insert(sells, {k, v})
		end

		-- FIXME: need safety checks
		server_shop.register_shop(shop.id, shop.name, sells)
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
