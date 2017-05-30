local bc_col_box_1 = {
      type = 'fixed',
      fixed = {{-.3, -.5, -.3, .3, .0, .3}}
}
local bc_col_box_2 = {
   type = 'fixed',
   fixed = {{-.3, -.5, -.3, .3, .45, .3}}
}
local bc_col_box_3 = {
   type = 'fixed',
   fixed = {{-.3, -.5, -.3, .3, .8, .3}}
}

local barrel_cacti_table = { --number, desc, col_box
   {1, 'Small Barrel Cacti' ,bc_col_box_1},
   {2, 'Medium Barrel Cacti' ,bc_col_box_2},
   {3, 'Large Barrel Cacti' ,bc_col_box_3}
}

for i in ipairs (barrel_cacti_table) do
   local num = barrel_cacti_table[i][1]
   local desc = barrel_cacti_table[i][2]
   local col = barrel_cacti_table[i][3]

minetest.register_node('desert_life:barrel_cacti_'..num, {
   description = desc,
   drawtype = 'mesh',
   mesh = 'dl_barrel_cacti_'..num..'.obj',
   tiles = {name='dl_barrel_cacti.png'},
   groups = {oddly_breakable_by_hand=3, choppy=1},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = col,
   collision_box = col,
   after_place_node = function(pos, placer, itemstack)
      local under = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
      local node = minetest.get_node(pos)
      if under.name == 'default:sand' or under.name == 'default:desert_sand' then
         minetest.set_node(pos, {name = 'desert_life:barrel_cacti_'..num..'_sp', param2 = node.param2})
      end
   end,
})

minetest.register_node('desert_life:barrel_cacti_'..num..'_sp', {
   description = desc,
   drawtype = 'mesh',
   mesh = 'dl_barrel_cacti_'..num..'.obj',
   tiles = {name='dl_barrel_cacti.png'},
   drop = 'desert_life:barrel_cacti_'..num,
   groups = {oddly_breakable_by_hand=3, choppy=1, dl_bc=1, not_in_creative_inventory=1},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = col,
   collision_box = col,
})
end

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.01,
			spread = {x = 100, y = 100, z = 100},
			seed = 29,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "desert_life:barrel_cacti_1_sp",
})

minetest.register_abm{
	nodenames = {"group:dl_bc"},
	interval = 40,
	chance = 30,
	action = function(pos)
      local node = minetest.get_node(pos)
      if node.name == 'desert_life:barrel_cacti_1_sp' then
		minetest.set_node(pos, {name = "desert_life:barrel_cacti_2_sp", param2 = node.param2})
      end
      if node.name == 'desert_life:barrel_cacti_2_sp' then
		minetest.set_node(pos, {name = "desert_life:barrel_cacti_3_sp", param2 = node.param2})
      end
      if node.name == 'desert_life:barrel_cacti_3_sp' then
         desert_life.spread('desert_life:barrel_cacti_1_sp', pos, 2, 'default:desert_sand', 'air', 48)
   end
end,
}
