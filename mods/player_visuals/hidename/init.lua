--[[ LICENSE HEADER
  
  The MIT License (MIT)
  
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


-- TODO: Argument to check visible state
-- FIXME: Use "text" attribute instead of "color" alpha???

-- Default alpha level (FIXME: Should be player attribute)
local stored_alpha = 255

-- The "hidename" chat command
minetest.register_chatcommand('hidename', {
	description = 'Hide or show nametag',
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local nametag_color = player:get_nametag_attributes().color
		local alpha = nametag_color.a
		
		if alpha == 0 then
			minetest.chat_send_player(name, 'Setting nametag shown')
			
			nametag_color.a = stored_alpha
		else
			minetest.chat_send_player(name, 'Setting nametag hidden')
			
			nametag_color.a = 0
		end
		
		player:set_nametag_attributes({
			color = nametag_color,
		})
		
		-- FIXME: Needs return value
	end
})
