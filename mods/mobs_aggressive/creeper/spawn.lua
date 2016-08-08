minetest.register_abm({
	nodenames = {"default:dirt_with_grass","default:stone"},
	neighbors = {"air"},
	interval = 60,
	chance = 2250,
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
		if minetest.get_node(pos).name ~= "air" then
			return
		end
		pos.y = pos.y+1
		if minetest.get_node(pos).name ~= "air" then
			return
		end
		minetest.add_entity(pos,"creeper:creeper")
	end
})
