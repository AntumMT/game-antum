-- Registrations for slinghot mod


minetest.register_tool('slingshot:slingshot', {
	description = 'Slingshot',
	range = 4,
	inventory_image = 'slingshot.png',
	
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.ref and pointed_thing.ref:is_player() == false and pointed_thing.ref:get_luaentity().name == '__builtin:item' then
			pointed_thing.ref:punch(user, {full_punch_interval=1.0, damage_groups={fleshy=4}}, 'default:bronze_pick', nil)
			return itemstack
		end
		slingshot.on_use(itemstack, user)
		return itemstack
	end,
	
	on_place = function(itemstack, user, pointed_thing)
		local item = itemstack:to_table()
		local meta = minetest.deserialize(item['metadata'])
		local mode = 0
		if meta == nil then meta = {} mode = 1 end
		if meta.mode == nil then meta.mode = 1 end
		mode = (meta.mode)
		if mode == 1 then
			mode = -1
			minetest.chat_send_player(user:get_player_name(), 'Use stack to left')
		else
			mode = 1
			minetest.chat_send_player(user:get_player_name(), 'Use stack to right ')
		end
		meta.mode = mode
		item.metadata = minetest.serialize(meta)
		item.meta = minetest.serialize(meta)
		itemstack:replace(item)
		return itemstack
	end
})


minetest.register_alias('slingshot', 'slingshot:slingshot')
