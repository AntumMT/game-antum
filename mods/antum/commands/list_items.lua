--[[ LICENSE HEADER
  
  MIT License
  
  Copyright © 2017 Jordan Irwin
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:
  
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  
--]]


-- Retrieves a simplified table containing string names of registered items
function antum.getRegisteredItemNames()
	local item_names = {}
	for item, def in pairs(minetest.registered_items) do
		table.insert(item_names, item)
	end
	
	table.sort(item_names)
	
	return item_names
end


-- Compares a string from a list of substrings
-- FIXME: Move to Antum functions
function antum.compareSubstringList(ss_list, s_value)
	for index, substring in ipairs(ss_list) do
		-- Tests for substring (does not need to match full string)
		if string.find(s_value, substring) then
			return true
		end
	end
	
	return false
end


-- Checks if value is contained in list
-- FIXME: Move to Antum functions
function antum.listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end
	
	return false
end


-- Replaces duplicates found in a list
-- FIXME: Move to Antum functions
function antum.removeListDuplicates(tlist)
	local cleaned = {}
	for index, value in ipairs(tlist) do
		if not antum.listContains(cleaned, value) then
			table.insert(cleaned, value)
		end
	end
	
	return cleaned
end


antum.logAction('Registering chat command "listitems"')

minetest.register_chatcommand('listitems', {
	params = '[string1] [string2] ...',
	description = 'List registered items',
	func = function(player, param)
		-- Make all parameters lowercase for case-insensitive matching
		param = antum.removeListDuplicates(string.split(string.lower(param), ' '))
		
		-- Debug
		minetest.log('action', '[list_items] Parameters:')
		for I in pairs(param) do
			minetest.log('action', '  ' .. param[I])
		end
		
		local all_item_names = antum.getRegisteredItemNames()
		local found_names = {}
		
		-- Check if table is empty
		if next(param) == nil then
			found_names = all_item_names
		else
			-- Need to fill item list
			for I in pairs(all_item_names) do
				if antum.compareSubstringList(param, string.lower(all_item_names[I])) then
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
