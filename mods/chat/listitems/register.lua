--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


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


minetest.log('action', '[listitems] Registering chat command "listitems"')

minetest.register_chatcommand('listitems', {
	params = '[string1] [string2] ...',
	description = 'List registered items',
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
				minetest.chat_send_player(player, found_names[I])
			end
		else
			minetest.chat_send_player(player, 'No registered items found!')
		end
		
		return true
	end,
})