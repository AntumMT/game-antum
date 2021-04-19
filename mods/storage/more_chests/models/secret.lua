local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local actions = dofile(minetest.get_modpath("more_chests") .. "/utils/actions.lua")
local S = minetest.get_translator("more_chests")

local open = "size[8,10]"..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[current_name;main;0,0.3;8,4;]" ..
	"list[current_player;main;0,4.85;8,1;]" ..
	"list[current_player;main;0,6.08;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"button[3,9;2,1;open;close]" ..
	default.get_hotbar_bg(0,4.85)

local closed = "size[2,1]" ..
	"button[0,0;2,1;open;open]"

local secret = gen_def({
	description = S("Secret Chest"),
	type = "secret chest",
	size = "small",
	tiles = {
		top = "secret_top.png",
		side = "secret_side.png",
		front = "secret_front.png"
	},
	formspec = open,
	pipeworks_enabled = true,
})

secret.on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	if actions.has_locked_chest_privilege(meta, sender) then
		if fields.open == "open" then
			meta:set_string("formspec", open)
		else
			meta:set_string("formspec", closed)
		end
	end
end


minetest.register_node("more_chests:secret", secret)
minetest.register_craft({
	output = "more_chests:secret",
	recipe = {
		{"group:wood", "default:cobble", "group:wood"},
		{"group:wood", "default:steel_ingot", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})
