--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2021 Jordan Irwin (AntumDeluge)

  See: LICENSE.txt
--]]

--- Chat Commands
--
--  @topic chat


local S = core.get_translator(listitems.modname)


local aux = dofile(listitems.modpath .. "/helpers.lua")


--- Checks if a parameter is a switch beginning with "-".
--
-- @function isSwitch
-- @local
-- @tparam string param String that is checked for dash prefix.
-- @treturn boolean ***true*** if parameter type is "switch" prefixed with dash.
local function isSwitch(param)
	if param then
		return #param == 2 and string.find(param, "-") == 1
	end

	return false
end


--- Extracts switches prefixed with "-" from parameter list.
--
-- @function extractSwitches
-- @local
-- @tparam table plist
-- @treturn table
local function extractSwitches(plist)
	local switches = {}
	local params = {}
	if plist ~= nil then
		for i, p in ipairs(plist) do
			-- Check if string starts with "-"
			if isSwitch(p) then
				table.insert(switches, p)
			else
				table.insert(params, p)
			end
		end
	end

	return switches, params
end


--- Helper function called from within chat commands.
--
-- @function list
-- @local
-- @param player
-- @param params
local function list(player, l_type, params)
		local switches = string.split(params, " ")

		local type_ok = true
		if not l_type then
			core.chat_send_player(player, S("Error: Must specify list type"))
			type_ok = false
		elseif not aux.listContains(aux.known_types, l_type) then
			core.chat_send_player(player, S("Error: Unknown list type:") .. " " .. l_type)
			type_ok = false
		end

		if not type_ok then
			return false
		end

		switches, params = extractSwitches(switches)
		params = aux.removeListDuplicates(params)

		-- DEBUG:
		if listitems.debug then
			listitems.log("action", "List type: " .. l_type)
			listitems.log("action", "Switches:")
			for i, s in ipairs(switches) do
				listitems.log("action", "  " .. s)
			end
			listitems.log("action", "Parameters:")
			for i, p in ipairs(params) do
				listitems.log("action", "  " .. p)
			end
		end

		local deep_search = true
		for _, sw in ipairs(switches) do
			if sw == "-s" then
				deep_search = false
				break
			end
		end

		if deep_search then
			core.chat_send_player(player, "\n" .. S("Searching in names and descriptions ..."))
		else
			core.chat_send_player(player, "\n" .. S("Searching in names ..."))
		end

		-- let "searching" messages display before executing search
		core.after(0, function()
			return listitems.list(player, l_type, switches, params)
		end)

		return true
end


--- Custom registration function for chat commands.
--
-- @function registerChatCommand
-- @local
-- @tparam string cmd_name
-- @tparam table def
local function registerChatCommand(cmd_name, def)
	listitems.logInfo("Registering chat command \"" .. cmd_name .. "\"")
	core.register_chatcommand(cmd_name, def)
end


local help_string = S("List registered items or entities") .. "\n\n\t" .. S("Options:")
local options_string = ""
for k, v in pairs(aux.options) do
	options_string = options_string .. "\n\t\t" .. k .. ": " .. v.description
end
local types_string = ""
if aux.known_types ~= nil and #aux.known_types > 0 then
	types_string = types_string .. "\n\n\t" .. S("Registered types:") .. " " .. table.concat(aux.known_types, ", ")
end


--- General *list* chat command.
--
-- Options:
--
-- - -v (verbose) Display descriptions.
-- - -s (shallow) Don't search descriptions.
--
-- @chatcmd   list
-- @chatparam type
-- @chatparam [options]
-- @chatparam [string1] [string2] ...
-- @treturn   boolean
registerChatCommand("list", {
	params = S("type") .. " [options] [" .. S("string1") .. "] [" .. S("string2") .. "] ...",
	description = help_string .. options_string .. types_string,
	func = function(player, params)
		local params = string.split(params, " ")
		local l_type = table.remove(params, 1)
		params = table.concat(params, " ")

		return list(player, l_type, params)
	end,
})


if listitems.enable_singleword then
	for _, kt in ipairs(aux.known_types) do
		registerChatCommand("list" .. kt, {
			params = "[options] [" .. S("string1") .. "] [" .. S("string2") .. "] ...",
			description = S("List registered @1", kt) .. "\n\n\t" .. S("Options:") .. options_string,
		func = function(player, params)
			local params = string.split(params, " ")
			params = table.concat(params, " ")

			return list(player, kt, params)
		end,
		})
	end
end
