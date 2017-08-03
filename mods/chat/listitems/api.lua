--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- List Items API
-- 
-- @script api.lua


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


--- Valid option switches.
--
-- @table known_switches
-- @local
-- @field -v Display descriptions.
local known_switches = {'-v',}


--- Checks if a parameter is a switch beginning with "-".
--
-- @function isSwitch
-- @local
-- @tparam string param String that is checked for dash prefix.
-- @treturn boolean ***true*** if parameter type is "switch" prefixed with dash.
local function isSwitch(param)
	if param then
		return #param == 2 and string.find(param, '-') == 1
	end
	
	return false
end


--- Checks if value is contained in list.
--
-- @function listContains
-- @local
-- @tparam table tlist List to be iterated.
-- @tparam string v String to search for in list.
-- @treturn boolean ***true*** if string found within list.
local function listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end
	
	return false
end


--- Retrieves a simplified table containing string names of registered items or entities.
--
-- @function getRegistered
-- @local
-- @tparam string r_type Must be either "items" or "entities".
-- @treturn table Either a list of registered item or entity names & descriptions. 
local function getRegistered(r_type)
	if r_type == nil then
		r_type = 'items'
	end
	
	local o_names = {}
	local objects = {}
	local o_temp = {}
	
	if r_type == 'items' then
		o_temp = core.registered_items
	else
		o_temp = core.registered_entities
	end
	
	for name, def in pairs(o_temp) do
		table.insert(objects, {name=name, descr=def.description,})
		table.insert(o_names, name)
	end
	
	-- FIXME: More efficient method to sort output?
	table.sort(o_names)
	local o_sorted = {}
	for i, name in ipairs(o_names) do
		for I, entity in ipairs(objects) do
			if entity.name == name then
				table.insert(o_sorted, entity)
			end
		end
	end
	
	return o_sorted
end


--- Compares a string from a list of substrings.
--
-- @function compareSubstringList
-- @tparam table ss_list
-- @tparam string s_value
-- @treturn boolean
local function compareSubstringList(ss_list, s_value)
	for index, substring in ipairs(ss_list) do
		-- Tests for substring (does not need to match full string)
		if string.find(s_value, substring) then
			return true
		end
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
		
		-- DEBUG:
		if listitems.debug then
			listitems.logDebug('Switches:')
			for i, o in ipairs(switches) do
				listitems.logDebug('  ' .. o)
			end
			
			listitems.logDebug('Parameters:')
			for i, p in ipairs(params) do
				listitems.logDebug('  ' .. p)
			end
		end
	end
	
	return {switches, params}
end


--- Replaces duplicates found in a list.
--
-- @function removeListDuplicates
-- @local
-- @tparam table tlist
-- @treturn table
local function removeListDuplicates(tlist)
	local cleaned = {}
	if tlist ~= nil then
		for index, value in ipairs(tlist) do
			if not listContains(cleaned, value) then
				table.insert(cleaned, value)
			end
		end
	end
	
	return cleaned
end


--- Searches & formats list for matching strings.
--
-- @function formatMatching
-- @local
-- @tparam string player
-- @tparam table nlist
-- @tparam table params
-- @tparam table switches
-- @tparam boolean lower
-- @treturn table
local function formatMatching(player, nlist, params, switches, lower)
	-- Defaults to case-insensitive
	lower = lower == nil or lower == true
	
	local matching = {}
	
	local show_descr = false
	if switches ~= nil then
		show_descr = listContains(switches, '-v')
	end
	
	core.chat_send_player(player, '\n' .. S('Searching in names ...'))
	
	if params == nil then
		params = {}
	end
	
	-- Use entire list if no parameters supplied
	if next(params) == nil then
		for i, item in ipairs(nlist) do
			if show_descr and item.descr ~= nil then
				table.insert(matching, item.name .. ' (' .. item.descr .. ')')
			else
				table.insert(matching, item.name)
			end
		end
	else
		-- Fill matching list
		for i, item in ipairs(nlist) do
			local name = item.name
			-- Case-insensitive matching
			if lower then
				name = string.lower(name)
			end
			
			if compareSubstringList(params, name) then
				if show_descr and item.descr ~= nil then
					table.insert(matching, item.name .. ' (' .. item.descr .. ')')
				else
					table.insert(matching, item.name)
				end
			end
		end
	end
	
	return matching
end


--- Setting to display a bulleted list.
--
-- @setting listitems.bullet_list
-- @settype boolean
local bullet_list = core.settings:get_bool('listitems.bullet_list')
if bullet_list == nil then
	-- Default is true
	bullet_list = true
end

local bullet = ''
if bullet_list then
	bullet = S('•') .. ' '
end


--- Displays list to player.
--
-- @function displayList
-- @local
-- @tparam string player
-- @tparam table dlist
local function displayList(player, dlist)
	if dlist ~= nil then
		for i, n in ipairs(dlist) do
			core.chat_send_player(player, bullet .. n)
		end
	end
	-- Show player number of items listed
	core.chat_send_player(player, S('Objects listed:') .. ' ' .. tostring(#dlist))
end


--- Custom registration function for chat commands.
--
-- @function registerChatCommand
-- @local
-- @tparam string cmd_name
-- @tparam table def
local function registerChatCommand(cmd_name, def)
	listitems.logInfo('Registering chat command "' .. cmd_name .. '"')
	core.register_chatcommand(cmd_name, def)
end


--- *listitems* base function.
--
-- Lists registered items or entities.
--
-- @function listitems.list
-- @tparam string player Name of player to receive message output.
-- @tparam string params String list of parameters.
-- @tparam string switches String list of switch options for manipulating output.
-- @tparam string l_type Objects to list (either "items" or "entities").
-- @tparam boolean lower Case-insensitive matching if ***true***.
-- @treturn boolean
function listitems.list(player, params, switches, l_type, lower)
	-- Default list type is "items"
	l_type = l_type or 'items'
	lower = lower == nil or lower == true
	
	local types = {'items', 'entities',}
	if not listContains(types, l_type) then
		listitems.logWarn('listitems.listitems called with unknown list type: ' .. tostring(l_type))
		return false
	end
	
	if type(params) == 'string' then
		if lower then
			-- Make parameters case-insensitive
			-- FIXME: Switches should not be case-insensitive
			params = string.lower(params)
		end
		
		-- Split parameters into list & remove duplicates
		params = removeListDuplicates(string.split(params, ' '))
	elseif lower then
		for i in pairs(params) do
			params[i] = string.lower(params[i])
		end
	end
	
	if type(switches) == 'string' then
		switches = string.split(switches, ' ')
	end
	
	for i, s in ipairs(switches) do
		if not listContains(known_switches, s) then
			core.chat_send_player(player, S('Unknown option:') .. ' ' .. s)
			return false
		end
	end
	
	all_objects = getRegistered(l_type)
	local matched_items = formatMatching(player, all_objects, params, switches, lower)
	
	displayList(player, matched_items)
	
	return true
end


--- Lists registered items.
--
-- @chatcmd listitems
-- @chatparam [-v]
-- @chatparam [string1]
-- @chatparam [string2]
-- @chatparam ...
-- @treturn boolean
registerChatCommand('listitems', {
	params = '[-v] [' .. S('string1') .. '] [' .. S('string2') .. '] ...',
	description = S('List registered items'),
	func = function(player, params)
		local switches = extractSwitches(string.split(params, ' '))
		params = removeListDuplicates(switches[2])
		switches = switches[1]
		
		return listitems.list(player, params, switches, 'items')
	end,
})


--- Lists registered entities.
--
-- @chatcmd listentities
-- @chatparam [-v]
-- @chatparam [string1]
-- @chatparam [string2]
-- @chatparam ...
-- @treturn boolean
registerChatCommand('listentities', {
	params = '[' .. S('options') .. '] [' .. S('string1') .. '] [' .. S('string2') .. '] ...',
	description = S('List registered entities'),
	func = function(player, params)
		local switches = extractSwitches(string.split(params, ' '))
		params = removeListDuplicates(switches[2])
		switches = switches[1]
		
		return listitems.list(player, params, switches, 'entities')
	end,
})
