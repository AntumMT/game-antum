local pp_col_box_1 = {
   type = 'fixed',
   fixed = {{-.2, -.5, -.2, .2, .0, .2}}
}

local pp_col_box_2 = {
   type = 'fixed',
   fixed = {{-.6, -.5, -.2, .2, .2, .2}}
}

local pp_col_box_3 = {
   type = 'fixed',
   fixed = {{-.6, -.5, -.2, .6, .2, .2}}
}

local pp_col_box_4 = {
   type = 'fixed',
   fixed = {{-.6, -.5, -.2, .6, .45, .2}}
}

local pp_col_box_5 = {
   type = 'fixed',
   fixed = {{-.7, -.5, -.2, .7, .7, .2}}
}

local pp_col_box_6 = {
   type = 'fixed',
   fixed = {{-.7, -.5, -.2, .7, .7, .2}}
}

local pp_col_box_7 = {
   type = 'fixed',
   fixed = {{-.6, -.5, -.2, .6, .9, .2}}
}

local prickly_pear_table = { --number, after_dig, col_box
   {1, 'air', pp_col_box_1},
   {2, 'desert_life:prickly_pear_1', pp_col_box_2},
   {3, 'desert_life:prickly_pear_2', pp_col_box_3},
   {4, 'desert_life:prickly_pear_3', pp_col_box_4},
   {5, 'desert_life:prickly_pear_4', pp_col_box_5},
   {6, 'desert_life:prickly_pear_5', pp_col_box_6},
   {7, 'desert_life:prickly_pear_6', pp_col_box_7},
}

for i in ipairs (prickly_pear_table) do
   local num = prickly_pear_table[i][1]
   local AD = prickly_pear_table[i][2]
   local col = prickly_pear_table[i][3]

  minetest.register_node('desert_life:prickly_pear_'..num, {
     description = 'Prickly Pear',
     drawtype = 'mesh',
     mesh = 'dl_pp_'..num..'.obj',
     tiles = {name='dl_prickly_pear.png'},
     groups = {not_in_creative_inventory=1, dl_pp=1},
     paramtype = 'light',
     paramtype2 = 'facedir',
     selection_box = col,
	 collision_box = col,
     on_punch = function(pos, node, player, pointed_thing)
        minetest.set_node(pos, {name = AD, param2 = node.param2})
        player:get_inventory():add_item('main', 'desert_life:prickly_pear') --If inventory is full it should be dropped.
--        local stack = ItemStack('desert_life:prickly_pear')
--        local leftover = minetest.add_item('main', stack)
--        if leftover:get_count() > 0 then
--           minetest.add_item (pos, 'desert_life:prickly_pear '..leftover:get_count())
--        end
        local damage_chance = math.random(1,15)
        if damage_chance == 1 then
           local hp = player:get_hp()
           player:set_hp(hp - 1)
        end
     end
     })

     if desert_life.bloom == true then
        minetest.register_node('desert_life:prickly_pear_'..num..'_bloom', {
           description = 'Blooming Prickly Pear',
           drawtype = 'mesh',
           mesh = 'dl_pp_'..num..'.obj',
           tiles = {name='dl_prickly_pear_bloom.png'},
           groups = {not_in_creative_inventory=1, dl_pp=1},
           paramtype = 'light',
           paramtype2 = 'facedir',
           selection_box = col,
           collision_box = col,
           on_punch = function(pos, node, player, pointed_thing)
             minetest.set_node(pos, {name = AD..'_bloom', param2 = node.param2})
             player:get_inventory():add_item('main', 'desert_life:prickly_pear') --If inventory is full it should be dropped.
   --        local stack = ItemStack('desert_life:prickly_pear')
   --        local leftover = minetest.add_item('main', stack)
   --        if leftover:get_count() > 0 then
   --           minetest.add_item (pos, 'desert_life:prickly_pear '..leftover:get_count())
   --        end
            local damage_chance = math.random(1,15)
            if damage_chance == 1 then
               local hp = player:get_hp()
               player:set_hp(hp - 1)
            end
         end
         })
     end

end


minetest.register_node('desert_life:prickly_pear', {
   description = 'Prickly Pear Pad',
   drawtype = 'mesh',
   mesh = 'dl_pp_1.obj',
   tiles = {name='dl_prickly_pear.png'},
   groups = {dig_immediate = 3},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = {
      type = 'fixed',
      fixed = {{-.2, -.5, -.2, .2, .0, .2}}
   },
   collision_box = {
      type = 'fixed',
      fixed = {{-.2, -.5, -.2, .2, .0, .2}} -- left bottom front right top back
   },
   drop = 'desert_life:prickly_pear',
   after_place_node = function(pos, placer, itemstack)
      local under = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
      local node = minetest.get_node(pos)
      if under.name == 'default:sand' or under.name == 'default:desert_sand' then
         minetest.set_node(pos, {name = 'desert_life:prickly_pear_1', param2 = node.param2})
      end
   end,
})

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 100, y = 100, z = 100},
			seed = 219,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "desert_life:prickly_pear_1",
})

minetest.register_abm{
	nodenames = {"group:dl_pp"},
	interval = 40,
	chance = 30,
	action = function(pos)
      local node = minetest.get_node(pos)
      if node.name == 'desert_life:prickly_pear_1' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_2", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_2' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_3", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_3' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_4", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_4' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_5", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_5' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_6", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_6' then
		minetest.set_node(pos, {name = "desert_life:prickly_pear_7", param2 = node.param2})
      end
      if node.name == 'desert_life:prickly_pear_7' then
         desert_life.spread('desert_life:prickly_pear_1', pos, 1, 'default:desert_sand', 'air', 22)
      end
   end,
}

if desert_life.bloom == true then
   print 'mymonths is enabled.'
   minetest.register_abm{
      nodenames = {"group:dl_pp"},
      interval = 1,
      chance = 2,
      action = function(pos)
         if mymonths.month_counter == 4
         or mymonths.month_counter == 5
         or mymonths.month_counter == 6 then
            local node = minetest.get_node(pos)
            if node.name == 'desert_life:prickly_pear_1' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_1_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_2' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_2_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_3' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_3_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_4' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_4_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_5' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_5_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_6' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_6_bloom", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_7' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_7_bloom", param2 = node.param2})
            end
         else
            local node = minetest.get_node(pos)
            if node.name == 'desert_life:prickly_pear_1_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_1", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_2_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_2", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_3_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_3", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_4_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_4", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_5_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_5", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_6_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_6", param2 = node.param2})
            end
            if node.name == 'desert_life:prickly_pear_7_bloom' then
      		minetest.set_node(pos, {name = "desert_life:prickly_pear_7", param2 = node.param2})
            end
         end
      end,
}
end
