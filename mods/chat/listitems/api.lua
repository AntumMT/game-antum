--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


-- Invoking command string
local list_command = S('listitems')


-- Retrieves a simplified table containing string names of registered items
local function getRegisteredItemNames()
	local item_names = {}
	for item, def in pairs(minetest.registered_items) do
		table.insert(item_names, item)
	end
	
	table.sort(item_names)
	
	return item_names
end


-- Compares a string from a list of substrings
local function compareSubstringList(ss_list, s_value)
	for index, substring in ipairs(ss_list) do
		-- Tests for substring (does not need to match full string)
		if string.find(s_value, substring) then
			return true
		end
	end
	
	return false
end


-- Checks if value is contained in list
local function listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end
	
	return false
end


-- Replaces duplicates found in a list
local function removeListDuplicates(tlist)
	local cleaned = {}
	for index, value in ipairs(tlist) do
		if not listContains(cleaned, value) then
			table.insert(cleaned, value)
		end
	end
	
	return cleaned
end


minetest.log('action', '[listitems] Registering chat command "' .. list_command .. '"')

minetest.register_chatcommand(list_command, {
	params = '[' .. S('string1') .. '] [' .. S('string2') .. '] ...',
	description = S('List registered items'),
	func = function(player, param)
		-- Make all parameters lowercase for case-insensitive matching
		param = removeListDuplicates(string.split(string.lower(param), ' '))
		
		local all_item_names = getRegisteredItemNames()
		local found_names = {}
		
		-- Check if table is empty
		if next(param) == nil then
			found_names = all_item_names
		else
			-- Need to fill item list
			for I in pairs(all_item_names) do
				if compareSubstringList(param, string.lower(all_item_names[I])) then
					table.insert(found_names, all_item_names[I])
				end
			end
		end
		
		if found_names ~= nil then
			for I in pairs(found_names) do
				minetest.chat_send_player(player, S('•') .. ' ' .. found_names[I])
			end
		end
		-- Show player number of items listed
		minetest.chat_send_player(player, S('Items listed:') .. ' ' .. tostring(#found_names))
		
		return true
	end,
})