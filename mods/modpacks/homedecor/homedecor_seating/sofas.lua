local S = minetest.get_translator("homedecor_seating")

local sofa_cbox = {
	type = "wallmounted",
	wall_side = {-0.5, -0.5, -0.5, 0.5, 0.5, 1.5}
}

minetest.register_node(":lrfurn:sofa", {
	description = S("Sofa"),
	drawtype = "mesh",
	mesh = "lrfurn_sofa_short.obj",
	tiles = {
		"lrfurn_upholstery.png",
		{ name = "lrfurn_sofa_bottom.png", color = 0xffffffff }
	},
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	inventory_image = "lrfurn_sofa_inv.png",
	wield_scale = { x = 0.6, y = 0.6, z = 0.6 },
	groups = {snappy=3, ud_param2_colorable = 1, dig_tree=2, axey=5},
	is_ground_content = false,
	_mcl_hardness=1.6,
	_sound_def = {
		key = "node_sound_wood_defaults",
	},
	selection_box = sofa_cbox,
	node_box = sofa_cbox,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		lrfurn.fix_sofa_rotation_nsew(pos, placer, itemstack, pointed_thing)
		local playername = placer:get_player_name()
		if minetest.is_protected(pos, placer:get_player_name()) then return true end

		local fdir = minetest.dir_to_facedir(placer:get_look_dir(), false)

		if lrfurn.check_right(pos, fdir, false, placer) then
			if not minetest.is_creative_enabled(playername) then
				itemstack:take_item()
			end
		else
			minetest.chat_send_player(placer:get_player_name(), S("No room to place the sofa!"))
			minetest.set_node(pos, { name = "air" })
		end
		return itemstack
	end,
	on_dig = unifieddyes.on_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return lrfurn.sit(pos, node, clicker, itemstack, pointed_thing, 2)
	end,
	on_destruct = lrfurn.on_seat_destruct,
	on_movenode = lrfurn.on_seat_movenode,
})

minetest.register_craft({
	output = "lrfurn:sofa",
	recipe = {
		{homedecor.materials.wool_white, homedecor.materials.wool_white, "", },
		{homedecor.materials.slab_wood, homedecor.materials.slab_wood, "", },
		{"group:stick", "group:stick", "", }
	}
})

minetest.register_craft({
	output = "lrfurn:sofa",
	recipe = {
		{homedecor.materials.wool_white, homedecor.materials.wool_white, "", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "", },
		{"group:stick", "group:stick", "", }
	}
})

unifieddyes.register_color_craft({
	output = "lrfurn:sofa",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "lrfurn:sofa",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

-- convert old static nodes to param2 color

lrfurn.old_static_sofas = {}

for _, color in ipairs(lrfurn.colors) do
	table.insert(lrfurn.old_static_sofas, "lrfurn:sofa_"..color)
end

minetest.register_lbm({
	name = ":lrfurn:convert_sofas",
	label = "Convert lrfurn short sofas to use param2 color",
	run_at_every_load = false,
	nodenames = lrfurn.old_static_sofas,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_")+1)

		if color == "red" then
			color = "medium_red"
		elseif color == "dark_green" then
			color = "medium_green"
		elseif color == "magenta" then
			color = "medium_magenta"
		elseif color == "cyan" then
			color = "medium_cyan"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		local param2 = paletteidx + new_fdir

		minetest.set_node(pos, { name = "lrfurn:sofa", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)

	end
})

if minetest.settings:get("log_mods") then
	minetest.log("action", "[lrfurn/sofas] Loaded!")
end
