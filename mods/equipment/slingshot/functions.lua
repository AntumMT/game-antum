-- Functions for slingshot mod


slingshot.tmp_throw = {}
slingshot.tmp_throw_timer = 0
slingshot.tmp_time = tonumber(minetest.setting_get('item_entity_ttl')) or 890


minetest.register_globalstep(function(dtime)
	slingshot.tmp_throw_timer = slingshot.tmp_throw_timer + dtime
	if slingshot.tmp_throw_timer < 0.2 then return end
	slingshot.tmp_throw_timer = 0
	for i, t in pairs(slingshot.tmp_throw) do
		t.timer = t.timer-0.25
		if t.timer <= 0 or t.ob == nil or t.ob:getpos() == nil then table.remove(slingshot.tmp_throw, i) return end
		for ii, ob in pairs(minetest.get_objects_inside_radius(t.ob:getpos(), 1.5)) do
			if (not ob:get_luaentity()) or (ob:get_luaentity() and (ob:get_luaentity().name ~= '__builtin:item')) then
				if (not ob:is_player()) or (ob:is_player() and ob:get_player_name(ob) ~= t.user and minetest.setting_getbool('enable_pvp') == true) then
					ob:set_hp(ob:get_hp()-5)
					ob:punch(ob, {full_punch_interval=1.0, damage_groups={fleshy=4}}, 'default:bronze_pick', nil)
					t.ob:setvelocity({x=0, y=0, z=0})
					if ob:get_hp() <= 0 and ob:is_player() == false then ob:remove() end
					t.ob:setacceleration({x=0, y=-10,z=0})
					t.ob:setvelocity({x=0, y=-10, z=0})
					table.remove(slingshot.tmp_throw, i)
					minetest.sound_play('slingshot_hard_punch', {pos=ob:getpos(), gain = 1.0, max_hear_distance = 5,})
					break
				end
			end
		end
	end
end)


function slingshot.on_use(itemstack, user)
	local veloc = 15
	local pos = user:getpos()
	local upos = {x=pos.x, y=pos.y+2, z=pos.z}
	local dir = user:get_look_dir()
	local item = itemstack:to_table()
	local mode = minetest.deserialize(item['metadata'])
	if mode == nil then mode = 1 else mode = mode.mode end

	local item = user:get_inventory():get_stack('main', user:get_wield_index()+mode):get_name()
	if item == '' then return itemstack end
	local e = minetest.add_item({x=pos.x, y=pos.y+2, z=pos.z}, item)
	e:setvelocity({x=dir.x*veloc, y=dir.y*veloc, z=dir.z*veloc})
	e:setacceleration({x=dir.x*-3, y=-5, z=dir.z*-3})
	e:get_luaentity().age = slingshot.tmp_time
	table.insert(slingshot.tmp_throw, {ob=e, timer=2, user=user:get_player_name()})

	if item == 'slingshot:slingshot' then
	itemstack:set_wear(9999999)
	end

	user:get_inventory():remove_item('main', item)
	minetest.sound_play('slingshot_throw', {pos=pos, gain = 1.0, max_hear_distance = 5,})
	return itemstack
end
