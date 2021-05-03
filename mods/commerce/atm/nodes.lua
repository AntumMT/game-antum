
-- ATM node definitions

minetest.register_node("atm:atm", {
	description = "ATM",
	tiles = {
		"atm_top.png", "atm_top.png",
		"atm_side.png", "atm_side.png",
		"atm_side.png", "atm_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 3},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local formspec, formname = atm.getform(placer)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("formname", formname)
	end,

	on_rightclick = function(pos, node, player)
		local formspec, formname = atm.getform(player)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("formname", formname)
		local inv = meta:get_inventory()
		inv:set_size("deposit", 1)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		formname = core.get_meta(pos):get_string("formname")
		atm.on_receive_fields(pos, formname, fields, sender)
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local retval = atm.deposit(player, stack)
		core.get_meta(pos):set_string("formspec", atm.getform(player))
		return retval
	end,
})



-- Wire transfer terminal node

minetest.register_node("atm:wtt", {
	description = "Wire Transfer Terminal",
	tiles = {
		"atm_top.png", "atm_top.png",
		"atm_side.png", "atm_side.png",
		"atm_side.png", "mwt_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2, bank_equipment = 1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local formspec, formname = atm.getform_wt(placer)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("formname", formname)
	end,

	on_rightclick = function(pos, node, player)
		local formspec, formname = atm.getform_wt(player)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("formname", formname)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		formname = core.get_meta(pos):get_string("formname")
		atm.on_receive_fields_wt(pos, formname, fields, sender)
	end,
})
