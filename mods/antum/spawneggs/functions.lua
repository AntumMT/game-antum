--[[ LICENSE HEADER
  
  The MIT License (MIT)
  
  Copyright © 2016 Jordan Irwin
  
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


local eggs = {
	{'sheep', 'creatures:sheep', 'wool:white'},
}

-- FIXME: Need better checks
if minetest.get_modpath('sheep') then
	for I in pairs(eggs) do
		local eggname = eggs[I][1]
		local spawn = eggs[I][2]
		local ingredients = {'spawneggs:egg', eggs[I][3]}
		
		minetest.register_craftitem(':spawneggs:' .. eggname, {
			description = 'Sheep Spawn Egg',
			inventory_image = 'spawneggs_sheep.png',
			
			on_place = function(itemstack, placer, target)
				if target.type == 'node' then
					local pos = target.above
					pos.y = pos.y + 1
					minetest.add_entity(pos, spawn)
					if not minetest.setting_getbool('creative_mode') then
						itemstack:take_item()
					end
					
					return itemstack
				end
			end
		})
		
		minetest.register_craft({
			output = 'spawneggs:' .. eggname,
			type = 'shapeless',
			recipe = ingredients,
		})
	end
end
