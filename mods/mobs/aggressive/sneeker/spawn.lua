-- Original code by Rui: WTFPL


local time_min = 60
local time_hr = time_min * 60
local time_day = time_hr * 24

local spawn_chance = minetest.setting_get('sneeker_spawn_chance') or 18000
local spawn_interval = minetest.setting_get('sneeker_spawn_interval') or time_min * 40 -- Default interval is 40 minutes

if minetest.setting_getbool('log_mods') then
	sneeker.log('Spawn chance: ' .. tostring(spawn_chance) .. ' (1/' .. tostring(spawn_chance) .. ')')
	sneeker.log('Spawn interval: ' .. tostring(spawn_interval) .. ' (' .. tostring(spawn_interval/60) .. ' minutes)')
end

minetest.register_abm({
	nodenames = {'default:dirt_with_grass','default:stone'},
	neighbors = {'air'},
	interval = spawn_interval,
	chance = spawn_chance,
	action = function(pos, node, _, active_object_count_wider)
		if active_object_count_wider > 5 then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 5 then
			return
		end
		if minetest.get_node_light(pos) < -1 then
			return
		end
		if pos.y > 31000 then
			return
		end
		if minetest.get_node(pos).name ~= 'air' then
			return
		end
		pos.y = pos.y+1
		if minetest.get_node(pos).name ~= 'air' then
			return
		end
		minetest.add_entity(pos,'sneeker:sneeker')
	end
})
