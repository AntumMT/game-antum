-- Removing fall damage is done by overwriting the group
-- fall_damage_add_percent of all nodes. ]]
function remove_fall_damage()
	for itemstring, def in pairs(minetest.registered_nodes) do
		local groups = def.groups and table.copy(def.groups)
		if groups then
			groups.fall_damage_add_percent = -100
			-- Let's hack the node!
			minetest.override_item(itemstring, { groups = groups })
		end
	end
end

minetest.register_on_mods_loaded(remove_fall_damage)
