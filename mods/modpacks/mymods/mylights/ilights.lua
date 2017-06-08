local ilights_types = {
	{"white",		"White",		"#ffffff" },
	{"grey",		"Grey",			"#a0a0a0" },
	{"black",		"Black",		"#000000" },
	{"red",			"Red",			"#ff0000" },
	{"yellow",		"Yellow",		"#ffff00" },
	{"green",		"Green",		"#00ff00" },
	{"cyan",		"Cyan",			"#00ffff" },
	{"blue",		"Blue",			"#0000ff" },
	{"magenta",		"Magenta",		"#ff00ff" },
	{"orange",		"Orange",		"#ff8000" },
	{"violet",		"Violet",		"#8000ff" },
	{"dark_grey",		"Dark Grey",		"#404040" },
	{"dark_green",		"Dark Green",		"#008000" },
	{"pink",		"Pink",			"#ffb0ff" },
	{"brown",		"Brown",		"#604000" },
}

local lamp_cbox = {
	type = "fixed",
	fixed = { -11/32, -8/16, -11/32, 11/32, 4/16, 11/32 }
}

for _, row in ipairs(ilights_types) do
	local name =     row[1]
	local desc =     row[2]
	local colordef = row[3]


minetest.override_item("ilights:light_"..name, {
    light_source = "0",
})

	-- Node Definition

	minetest.register_node("mylights:ilight_30w"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			"ilights_lamp_base.png",
			"ilights_lamp_cage.png",
			"ilights_lamp_bulb.png^[colorize:"..colordef..":200",
			"ilights_lamp_bulb_base.png",
			"ilights_lamp_lens.png^[colorize:"..colordef.."20:75"
		},
		use_texture_alpha = true,
		groups = {cracky=3, not_in_creative_inventory=1},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = "5",
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})
minetest.register_craft({
		output = "mylights:ilight_30w"..name.." 1",
		recipe = {
			{'ilights:light_'..name,'mylights:lightbulb30',''},
			{'','',''},
			{'','',''}
			}
})
	minetest.register_node("mylights:ilight_60w"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			"ilights_lamp_base.png",
			"ilights_lamp_cage.png",
			"ilights_lamp_bulb.png^[colorize:"..colordef..":200",
			"ilights_lamp_bulb_base.png",
			"ilights_lamp_lens.png^[colorize:"..colordef.."20:75"
		},
		use_texture_alpha = true,
		groups = {cracky=3, not_in_creative_inventory=1},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = "8",
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})
	minetest.register_craft({
		output = "mylights:ilight_60w"..name.." 1",
		recipe = {
			{'ilights:light_'..name,'mylights:lightbulb60',''},
			{'','',''},
			{'','',''}
			}
})
	minetest.register_node("mylights:ilight_90w"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			"ilights_lamp_base.png",
			"ilights_lamp_cage.png",
			"ilights_lamp_bulb.png^[colorize:"..colordef..":200",
			"ilights_lamp_bulb_base.png",
			"ilights_lamp_lens.png^[colorize:"..colordef.."20:75"
		},
		use_texture_alpha = true,
		groups = {cracky=3, not_in_creative_inventory=1},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = "11",
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})
	minetest.register_craft({
		output = "mylights:ilight_90w"..name.." 1",
		recipe = {
			{'ilights:light_'..name,'mylights:lightbulb90',''},
			{'','',''},
			{'','',''}
			}
})
	minetest.register_node("mylights:ilight_120w"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			"ilights_lamp_base.png",
			"ilights_lamp_cage.png",
			"ilights_lamp_bulb.png^[colorize:"..colordef..":200",
			"ilights_lamp_bulb_base.png",
			"ilights_lamp_lens.png^[colorize:"..colordef.."20:75"
		},
		use_texture_alpha = true,
		groups = {cracky=3, not_in_creative_inventory=1},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = "14",
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})
	minetest.register_craft({
		output = "mylights:ilight_120w"..name.." 1",
		recipe = {
			{'ilights:light_'..name,'mylights:lightbulb120',''},
			{'','',''},
			{'','',''}
			}
})
end
