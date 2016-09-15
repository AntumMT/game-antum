local slope_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5,   -1.5,  0.5, -0.375, 0.5},
		{-0.5, -0.375, -1.25, 0.5, -0.25,  0.5},
		{-0.5, -0.25,  -1,    0.5, -0.125, 0.5},
		{-0.5, -0.125, -0.75, 0.5,  0,     0.5},
		{-0.5,  0,     -0.5,  0.5,  0.125, 0.5},
		{-0.5,  0.125, -0.25, 0.5,  0.25,  0.5},
		{-0.5,  0.25,   0,    0.5,  0.375, 0.5},
		{-0.5,  0.375,  0.25, 0.5,  0.5,   0.5},
	}
}

local icorner_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -1.5, -0.25, 0.5, 0.5},
		{-0.5, -0.5, 0.25, 1.5, 0.5, 0.5},
		{-0.5, -0.5, 0, 1.5, 0.375, 0.5},
		{-0.5, -0.5, -1.5, 0, 0.375, 0.5},
		{-0.5, -0.5, -1.5, 0.25, 0.25, 0.5},
		{-0.5, -0.5, -1.5, 0.5, 0.125, 0.5},
		{-0.5, -0.5, -1.5, 0.75, 0, 0.5},
		{-0.5, -0.5, -1.5, 1, -0.125, 0.5},
		{-0.5, -0.5, -1.5, 1.25, -0.25, 0.5},
		{-0.5, -0.5, -1.5, 1.5, -0.375, 0.5},
		{-0.5, -0.5, -0.25, 1.5, 0.25, 0.5},
		{-0.5, -0.5, -0.5, 1.5, 0.125, 0.5}, 
		{-0.5, -0.5, -0.75, 1.5, 0, 0.5},
		{-0.5, -0.5, -1, 1.5, -0.125, 0.5},
		{-0.5, -0.5, -1.25, 1.5, -0.25, 0.5},
	}
}

local ocorner_cbox_long = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, 0.25, -0.25, 0.5, 0.5},
		{-0.5, -0.5, 0, 0, 0.375, 0.5},
		{-0.5, -0.5, -0.25, 0.25, 0.25, 0.5},
		{-0.5, -0.5, -0.5, 0.5, 0.125, 0.5}, 
		{-0.5, -0.5, -0.75, 0.75, 0, 0.5}, 
		{-0.5, -0.5, -1, 1, -0.125, 0.5}, 
		{-0.5, -0.5, -1.25, 1.25, -0.25, 0.5}, 
		{-0.5, -0.5, -1.5, 1.5, -0.375, 0.5},
	}
}

local wood_long_slopes = {   --Material , Description , Image , Item
	{ "wood" , "Wood" , "default:wood"},
	{ "pine_wood" , "Pinewood" , "default:pine_wood"},	
	{ "junglewood" , "Junglewood" , "default:junglewood"},
	{ "acacia_wood" , "Acacia wood" , "default:acacia_wood"},
	{ "aspen_wood" , "Aspen wood" , "default:aspen_wood"},
}

for i in ipairs(wood_long_slopes) do
	local mat = wood_long_slopes[i][1]
	local desc = wood_long_slopes[i][2]
	local item = wood_long_slopes[i][3]

--long slope
minetest.register_node("mywoodslopes:"..mat.."_slope_long", {
	description = desc.." Slope Long",
	drawtype = "mesh",
	mesh = "six-twelve_slope.obj",
	tiles = {"default_"..mat..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})

--Inside Corner Long
minetest.register_node("mywoodslopes:"..mat.."_long_icorner", {
	description = desc.." Long Slope Inside Corner",
	drawtype = "mesh",
	mesh = "six-twelve_slope-ic.obj",
	tiles = {"default_"..mat..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox_long,
	selection_box = icorner_cbox_long
})

--Outside Corner Long
minetest.register_node("mywoodslopes:"..mat.."_long_ocorner", {
	description = desc.." Long Slope Outside Corner",
	drawtype = "mesh",
	mesh = "six-twelve_slope-oc.obj",
	tiles = {"default_"..mat..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox_long,
	selection_box = ocorner_cbox_long
})

--rotated---------------------------------------------------------------

--long slope
minetest.register_node("mywoodslopes:"..mat.."_slope_long_r", {
	description = desc.." Slope Long Rotated",
	drawtype = "mesh",
	mesh = "six-twelve_slope.obj",
	tiles = {"default_"..mat..".png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox_long,
	selection_box = slope_cbox_long
})

--Inside Corner Long
minetest.register_node("mywoodslopes:"..mat.."_long_icorner_r", {
	description = desc.." Long Slope Inside Corner",
	drawtype = "mesh",
	mesh = "six-twelve_slope-ic.obj",
	tiles = {"default_"..mat..".png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox_long,
	selection_box = icorner_cbox_long
})

--Outside Corner Long
minetest.register_node("mywoodslopes:"..mat.."_long_ocorner_r", {
	description = desc.." Long Slope Outside Corner",
	drawtype = "mesh",
	mesh = "six-twelve_slope-oc.obj",
	tiles = {"default_"..mat..".png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox_long,
	selection_box = ocorner_cbox_long
})

--Crafts--------------------------------------------------------

--slope long
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_slope_long 3",
	recipe = {
		{"", "",""},
		{item, "",""},
		{item, item,item},
	}
})
--slope icorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_long_icorner 3",
	recipe = {
		{"", item,""},
		{item, item,item},
		{item,"", item},
	}
})
--slope ocorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_long_ocorner 3",
	recipe = {
		{item, "",item},
		{item, item,item},
		{"", item,""},
	}
})

--rotated-----------------------------------------------

--slope long
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_slope_long_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_slope_long",""},
		{"", "",""},
	}
})
--slope icorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_long_icorner_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_long_icorner",""},
		{"", "",""},
	}
})
--slope ocorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_long_ocorner_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_long_ocorner",""},
		{"", "",""},
	}
})
end






