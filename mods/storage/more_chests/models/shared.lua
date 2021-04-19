local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local actions = dofile(minetest.get_modpath("more_chests") .. "/utils/actions.lua")
local S = minetest.get_translator("more_chests")

local function get_formspec(string)
	return "size[8,10]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[current_name;main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6;8,3;8]" ..
		"field[.25,9.5;8,1;shared;" ..
		S("Shared with (separate names with spaces)") ..
		":;" .. string .. "]" ..
		"button[6,9.2;2,1;submit;" ..
		S("submit") .. "]" ..
		"listring[current_name;main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,4.85)
end

local function check_privs(meta, player)
	local name = player:get_player_name()
	local shared = " " .. meta:get_string("shared") .. " "
	if name == meta:get_string("owner") then
		return true
	elseif shared:find(" " .. name .. " ") then
		return true
	else
		return false
	end
end

local shared = gen_def({
	description = S("Shared Chest"),
	type = "shared chest",
	size = "small",
	tiles = {
		top = "shared_top.png",
		side = "shared_side.png",
		front = "shared_front.png"
	},
	formspec = get_formspec(""),
	pipeworks_enabled = true,
	sounds = default.node_sound_wood_defaults(),
	allow_metadata_inventory_move = actions.get_allow_metadata_inventory_move{"shared chest", check_privs=check_privs},
	allow_metadata_inventory_put = actions.get_allow_metadata_inventory_put{"shared chest", check_privs=check_privs},
	allow_metadata_inventory_take = actions.get_allow_metadata_inventory_take{"shared chest", check_privs=check_privs},
})

shared.on_receive_fields = function(pos, formspec, fields, sender)
	local meta = minetest.get_meta(pos);
	if fields.shared then
		if meta:get_string("owner") == sender:get_player_name() then
			meta:set_string("shared", fields.shared)
			meta:set_string("formspec", get_formspec(fields.shared))
		end
	end
end


minetest.register_node("more_chests:shared", shared)
minetest.register_craft({
	output = "more_chests:shared",
	recipe = {
		{"group:wood", "default:leaves", "group:wood"},
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
