--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]

--- List Items API
--
-- @topic api


local S = core.get_translator(listitems.modname)


local aux = dofile(listitems.modpath .. "/helpers.lua")

local known_switches = {}
for k in pairs(aux.options) do
	table.insert(known_switches, k)
end

if core.global_exists("mobs") then
	table.insert(aux.known_types, "mobs")
end


--- Retrieves a simplified table containing string names of registered items or entities.
--
-- @function getRegistered
-- @local
-- @tparam string r_type Must be either "items" or "entities".
-- @treturn table Either a list of registered item or entity names & descriptions.
-- @note Ore names are located in the "ore" field of the registered tables
local function getRegistered(r_type)
	-- Default is "items"
	r_type = r_type or "items"

	local o_names = {}
	local objects = {}
	local o_temp = {}

	if r_type == "entities" then
		o_temp = core.registered_entities
	elseif r_type == "nodes" then
		o_temp = core.registered_nodes
	elseif r_type == "ores" then
		o_temp = core.registered_ores
	elseif r_type == "tools" then
		o_temp = core.registered_tools
	elseif r_type == "mobs" then
		o_temp = mobs.spawning_mobs
	else
		o_temp = core.registered_items
	end

	for name, def in pairs(o_temp) do
		-- Ore names are located in the "ore" field of the table
		if r_type == "ores" then
			def.description = S("ID: @1", name)
			name = def.ore
		elseif r_type == "mobs" then
			def = {}
		end

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
-- @local
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


--- Searches & formats list for matching strings.
--
-- @function formatMatching
-- @local
-- @tparam string player
-- @tparam table nlist
-- @tparam table params
-- @tparam table switches
-- @tparam boolean nocase
-- @treturn table
local function formatMatching(player, nlist, params, switches, nocase)
	-- Defaults to case-insensitive
	nocase = nocase == nil or nocase == true

	local matching = {}

	local show_descr = false
	local deep_search = true
	if switches ~= nil then
		show_descr = aux.listContains(switches, "-v")
		deep_search = not aux.listContains(switches, "-s")
	end

	if params == nil then
		params = {}
	end

	-- Use entire list if no parameters supplied
	if next(params) == nil then
		for i, item in ipairs(nlist) do
			if show_descr and item.descr ~= nil then
				table.insert(matching, item.name .. " (" .. item.descr .. ")")
			else
				table.insert(matching, item.name)
			end
		end
	else
		-- Fill matching list
		for i, item in ipairs(nlist) do
			local name = item.name
			local descr = item.descr
			-- Case-insensitive matching
			if nocase then
				name = string.lower(name)
				if descr ~= nil then
					descr = string.lower(descr)
				end
			end

			local matches = compareSubstringList(params, name)
			if deep_search and not matches and descr ~= nil then
				matches = compareSubstringList(params, descr)
			end

			if matches then
				if show_descr and item.descr ~= nil then
					table.insert(matching, item.name .. " (" .. item.descr .. ")")
				else
					table.insert(matching, item.name)
				end
			end
		end
	end

	return matching
end


local bullet = ""
if listitems.bullet_list then
	bullet = S("•") .. " "
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
	core.chat_send_player(player, S("Objects listed:") .. " " .. tostring(#dlist))
end


--- *listitems* base function.
--
-- Lists registered items or entities.
--
-- @function listitems.list
-- @tparam string player Name of player to receive message output.
-- @tparam string l_type Objects to list (e.g. "items", "entities", "ores", etc.).
-- @tparam string switches String list of switch options for manipulating output.
-- @tparam string params String list of parameters.
-- @tparam boolean nocase Case-insensitive matching if ***true***.
-- @treturn boolean
function listitems.list(player, l_type, switches, params, nocase)
	-- Default list type is "items"
	l_type = l_type or "items"
	nocase = nocase == nil or nocase == true

	if not aux.listContains(aux.known_types, l_type) then
		listitems.logWarn("listitems.list called with unknown list type: " .. tostring(l_type))
		return false
	end

	if type(params) == "string" then
		if nocase then
			-- Make parameters case-insensitive
			-- FIXME: Switches should not be case-insensitive
			params = string.lower(params)
		end

		-- Split parameters into list & remove duplicates
		params = aux.removeListDuplicates(string.split(params, " "))
	elseif nocase then
		for i in pairs(params) do
			params[i] = string.lower(params[i])
		end
	end

	if type(switches) == "string" then
		switches = string.split(switches, " ")
	end

	for i, s in ipairs(switches) do
		if not aux.listContains(known_switches, s) then
			core.chat_send_player(player, S("Error: Unknown option:") .. " " .. s)
			return false
		end
	end

	local all_objects = getRegistered(l_type)
	local matched_items = formatMatching(player, all_objects, params, switches, nocase)

	if l_type == "ores" then
		matched_items = aux.removeListDuplicates(matched_items)
	end

	displayList(player, matched_items)
	return true
end
