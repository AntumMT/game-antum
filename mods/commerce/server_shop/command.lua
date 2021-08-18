
--- Server Shops Chat Commands
--
--  @topic commands


local ss = server_shop
local S = core.get_translator(ss.modname)


local command_list = {"reload", "register", "unregister"}
local commands = {
	reload = "",
	register = "<"..S("ID")..">".." <sell/buy> ".."<"..S("name")..">"
		.." ["..S("product1=value,product2=value,...").."]",
	unregister = "<"..S("ID")..">",
}

local format_usage = function(cmd)
	local usage = S("Usage:").."\n  /"..ss.modname.." "..cmd
	local params = commands[cmd]
	if params and params ~= "" then
		usage = usage.." "..params
	end

	return usage
end


--- Manages shops & config.
--
--  @chatcmd server_shop
--  @param command Command to execute.
--  @param[opt] params Parameters associated with command.
--  @usage
--  /server_shop <command> [<params>]
--
--  Commands:
--  - reload
--    - Reloads shops configuration.
--  - register
--    - Registers new shop & updates configuration.
--    - parameters: <id> <sell/buy> <name> [product1=value,product2=value,...]
--  - unregister
--    - Unregisters shop & updates configuration.
--    - parameters: <id>
core.register_chatcommand(ss.modname, {
	description = S("Manage shops configuration."),
	privs = {server=true},
	params = "<"..S("command").."> ["..S("params").."]",
	func = function(name, param)
		local params = param:split(" ")
		local cmd = params[1]
		table.remove(params, 1)

		if not cmd then
			return false, S("Must provide a command: @1", table.concat(command_list, ", "))
		end

		if cmd == "reload" then
			if #params > 0 then
				return false, S('"@1" command takes no parameters.', cmd).."\n\n"..format_usage(cmd)
			end

			ss.file_load()
			ss.prune_shops()
			return true, S("Shops configuration loaded.")
		elseif cmd == "register" then
			if #params > 4 then
				return false, S("Too many parameters.").."\n\n"..format_usage(cmd)
			end

			local shop_id = params[1]
			local shop_type = params[2]
			local shop_name = params[3]
			local shop_products = params[4]

			if not shop_id then
				return false, S("Must provide ID.").."\n\n"..format_usage(cmd)
			elseif not shop_type then
				return false, S("Must provide type.").."\n\n"..format_usage(cmd)
			elseif not shop_name then
				return false, S("Must provide name.").."\n\n"..format_usage(cmd)
			end

			if shop_type ~= "sell" and shop_type ~= "buy" then
				return false, S('Shop type must be "@1" or "@2".', "sell", "buy").."\n\n"..format_usage(cmd)
			end

			shop_name = shop_name:gsub("_", " ")

			local products = {}
			if shop_products then
				shop_products = shop_products:split(",")
				for _, p in ipairs(shop_products) do
					local item = p:split("=")
					local item_name = item[1]
					local item_value = tonumber(item[2])

					if not core.registered_items[item_name] then
						return false, S('"@1" is not a recognized item.', item_name).."\n\n"..format_usage(cmd)
					elseif not item_value then
						return false, S("Item value must be a number.").."\n\n"..format_usage(cmd)
					end

					table.insert(products, {item_name, item_value})
				end
			end

			ss.file_register(shop_id, {
				type = shop_type,
				name = shop_name,
				products = products,
			})
			ss.file_load()
			ss.prune_shops()

			return true, S("Registered shop with ID: @1", shop_id)
		elseif cmd == "unregister" then
			if #params > 1 then
				return false, S("Too many parameters.").."\n\n"..format_usage(cmd)
			end

			local shop_id = params[1]
			if not shop_id then
				return false, S("Must provide ID.").."\n\n"..format_usage(cmd)
			end

			if not ss.file_unregister(shop_id) then
				return false, S("Cannot unregister shop with ID: @1", shop_id)
			end

			return true, S("Unregistered shop with ID: @1", shop_id)
		end

		return false, S("Unknown command: @1", cmd)
	end,
})
