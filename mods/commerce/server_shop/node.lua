
local ss = server_shop


core.register_node(ss.modname .. ":sell", {
	description = "Seller Shop",
	--drawtype = "nodebox",
	drawtype = "normal",
	tiles = {
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_front.png",
		"server_shop_side.png",
	},
	--[[
	drawtype = "mesh",
	mesh = "server_shop.obj",
	tiles = {"server_shop_mesh.png",},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.45, 0.5},
	},
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	]]
	groups = {oddly_breakable_by_hand=1,},
	paramtype2 = "facedir",
	after_place_node = function(pos, placer)
		-- set node owner
		core.get_meta(pos):set_string("owner", placer:get_player_name())
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local pmeta = player:get_meta()

		-- store node pos in player meta for retrieval in callbacks
		pmeta:set_string(ss.modname .. ":pos", core.serialize(pos))
		-- store selected index in player meta for retrieval in callbacks
		pmeta:set_int(ss.modname .. ":selected", 1)

		ss.show_formspec(pos, player)
	end,
	can_dig = function(pos, player)
		return ss.is_shop_owner(pos, player) or ss.is_shop_admin(player)
	end,
})
core.register_alias(ss.modname .. ":shop", ss.modname .. ":sell") -- backward compat


if core.registered_items["currency:minegeld_50"] and core.registered_items["default:gold_ingot"] then
	core.register_node(ss.modname .. ":buy", {
	description = "Buyer Shop",
	drawtype = "normal",
	tiles = {
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_front.png",
		"server_shop_side.png",
	},
	groups = {oddly_breakable_by_hand=1,},
	paramtype2 = "facedir",
	after_place_node = function(pos, placer)
		-- set node owner
		core.get_meta(pos):set_string("owner", placer:get_player_name())
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local pmeta = player:get_meta()

		-- store node pos in player meta for retrieval in callbacks
		pmeta:set_string(ss.modname .. ":pos", core.serialize(pos))
		-- store selected index in player meta for retrieval in callbacks
		-- FIXME: may not be necessary for buyers
		pmeta:set_int(ss.modname .. ":selected", 1)

		ss.show_formspec(pos, player, true)
	end,
	can_dig = function(pos, player)
		return ss.is_shop_owner(pos, player) or ss.is_shop_admin(player)
	end,
	})
end
