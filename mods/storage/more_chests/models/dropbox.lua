local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local actions = dofile(minetest.get_modpath("more_chests") .. "/utils/actions.lua")
local S = minetest.get_translator("more_chests")

local dropbox = gen_def({
	description = S("Dropbox"),
	type = "dropbox",
	size = "small",
	tiles = {
		top = "dropbox_top.png",
		side = "dropbox_side.png",
		front = "dropbox_front.png"
	},
	pipeworks_enabled = true,
	allow_metadata_inventory_move = false,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if actions.has_locked_chest_privilege(meta, player) then
			return stack:get_count()
		end
		local target = meta:get_inventory():get_list(listname)[index]
		local target_name = target:get_name()
		local stack_count = stack:get_count()
		if target_name == stack:get_name()
		and target:get_count() < stack_count then
			return stack_count
		end
		if target_name ~= "" then
			return 0
		end
		return stack_count
	end,
	allow_metadata_inventory_take = actions.get_allow_metadata_inventory_take({
		"dropbox", check_privs = actions.has_locked_chest_privilege
	}),
})


minetest.register_node("more_chests:dropbox", dropbox)
minetest.register_craft({
	output = "more_chests:dropbox",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
