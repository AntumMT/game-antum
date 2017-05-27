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


-- Directory where textures are located
local tdir = 'animal_inventory'

minetest.register_craftitem(':kpgmobs:horseh1', {
	description = 'Brown Horse',
	inventory_image = 'horse_brown.png',
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, 'kpgmobs:horseh1')
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_alias('kpgmobs:brown_horse', 'kpgmobs:horseh1')
minetest.register_alias('brown_horse', 'kpgmobs:horseh1')

minetest.register_craftitem(':kpgmobs:horsepegh1', {
	description = 'White Horse',
	inventory_image = 'horse_white.png',
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, 'kpgmobs:horsepegh1')
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_alias('kpgmobs:white_horse', 'kpgmobs:horsepegh1')
minetest.register_alias('white_horse', 'kpgmobs:horsepegh1')

minetest.register_craftitem(':kpgmobs:horsearah1', {
	description = 'Black Horse',
	inventory_image = 'horse_black.png',
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, 'kpgmobs:horsearah1')
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_alias('kpgmobs:black_horse', 'kpgmobs:horsearah1')
minetest.register_alias('black_horse', 'kpgmobs:horsearah1')
