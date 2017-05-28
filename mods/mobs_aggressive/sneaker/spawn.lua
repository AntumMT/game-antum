-- Original code by Rui: WTFPL


local time_sec = 1
local time_min = time_sec * 60
local time_hr = time_min * 60
local time_day = time_hr * 24

minetest.register_abm({
	nodenames = {'default:dirt_with_grass','default:stone'},
	neighbors = {'air'},
	interval = time_min * 20, -- Run spawn function every 20 minutes
	chance = 9000,
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
		minetest.add_entity(pos,'sneaker:sneaker')
	end
})
