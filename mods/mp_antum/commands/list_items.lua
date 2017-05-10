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


antum.logAction('Registering chat command "listitems"')

minetest.register_chatcommand('listitems', {
	params = '',
	description = 'List registered items',
	func = function(player, param)
		local item_names = antum.getRegisteredItemNames()
		if item_names ~= nil then
			for INDEX in pairs(item_names) do
				minetest.chat_send_player(player, item_names[INDEX])
			end
		else
			minetest.chat_send_player(player, 'No registered items found!')
		end
		
		return true
	end,
})
