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


local depends_satisfied = true

local depends = {
	'bucket',
	'vessels',
}

for I in pairs(depends) do
	if not minetest.get_modpath(depends[I]) then
		depends_satisfied = false
	end
end

if depends_satisfied then
	-- Override vessels:glass_bottle
	--[[
	minetest.override_item('vessesl:glass_bottle', {
		description = 'Glass Bottle (empty)',
		drawtype = 'plantlike',
		tiles = {'vessels_glass_bottle.png'},
		inventory_image = 'vessels_glass_bottle_inv.png',
		wield_image = 'vessels_glass_bottle.png',
		paramtype = 'light',
		is_ground_content = false,
		walkable = false,
		selection_box = {
			type = 'fixed',
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
		},
		groups = {vessel=1,dig_immediate=3,attached_node=1},
		sounds = default.node_sound_glass_defaults(),
		on_use = function(itemstack, user, pointed_thing)
			-- Must be pointing to node
			if pointed_thing.type ~= 'node' then
				return
			end
			-- Check if pointing to a liquid source
			local node = minetest.get_node(pointed_thing.under)
			local liquiddef = bucket.liquids[node.name]
			local item_count = user:get_wielded_item():get_count()
	
			if liquiddef ~= nil
			and liquiddef.itemname ~= nil
			and node.name == liquiddef.source then
				if check_protection(pointed_thing.under,
						user:get_player_name(),
						'take '.. node.name) then
					return
				end
	
				-- default set to return filled bottle
				local giving_back = liquiddef.itemname
	
				-- check if holding more than 1 empty bucket
				if item_count > 1 then
	
					-- if space in inventory add filled bucked, otherwise drop as item
					local inv = user:get_inventory()
					if inv:room_for_item('main', {name=liquiddef.itemname}) then
						inv:add_item('main', liquiddef.itemname)
					else
						local pos = user:getpos()
						pos.y = math.floor(pos.y + 0.5)
						core.add_item(pos, liquiddef.itemname)
					end
	
					-- set to return empty buckets minus 1
					giving_back = 'vessels:glass_bottle '..tostring(item_count-1)
	
				end
	
				minetest.add_node(pointed_thing.under, {name='air'})
	
				return ItemStack(giving_back)
			end
		end,
	})--]]
		
	
	minetest.register_craftitem(':antum:bottled_water', {
		description = 'A bottle of water',
		inventory_image = 'bottled_water.png',
	})
	
	minetest.register_craft({
		output = 'antum:bottled_water',
		type = 'shapeless',
		recipe = {
			'bucket:bucket_water', 'vessels:glass_bottle',
		},
		replacements = {
			{"bucket:bucket_water", "bucket:bucket_empty"},
		},
	})
	
	minetest.register_craft({
		output = 'invisibility:potion',
		type = 'shapeless',
		recipe = {
			'antum:bottled_water', 'default:mese_crystal_fragment',
		},
	})
end