
armor_light = {}
armor_light.modname = core.get_current_modname()
armor_light.path = core.get_modpath(armor_light.modname)


dofile(armor_light.path .. "/api.lua")


wielded_light.register_player_lightstep(function(player)
	local armor_inv = minetest.get_inventory({
		type = "detached",
		name = player:get_player_name() .. "_armor",
	})

	local lighted = {}
	if armor_inv then
		for idx, stack in ipairs(armor_inv:get_list("armor")) do
			local item_name = stack:get_name()
			if item_name:trim() == "" then
				item_name = nil
			end

			wielded_light.track_user_entity(player, "armor" .. idx, item_name)
		end
	end
end)
