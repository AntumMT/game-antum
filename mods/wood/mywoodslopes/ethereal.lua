local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox5
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5}, -- NodeBox6
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5}, -- NodeBox7
		{-0.5, 0, -0.5, 0, 0.25, 0.5}, -- NodeBox8
		{-0.5, 0, 0, 0.5, 0.25, 0.5}, -- NodeBox9
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, -- NodeBox10
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}, -- NodeBox11
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}
local moretrees_slopes = {   --Material , Description , Item, Image
	{"willow" ,  "Willow Wood" ,         "ethereal:willow_wood",      "willow"},
	{"redwood",  "RedWood Wood",         "ethereal:redwood_wood",     "redwood"},
	{"frost",	 "Frost Wood",           "ethereal:frost_wood",       "frost"},
	{"yellow",	 "Healing Tree Wood",    "ethereal:yellow_wood",      "yellow"},
	{"palm",	 "Palm Wood",    		 "ethereal:palm_wood",        "moretrees_palm"},
	{"banana",	 "Banana Wood",    		 "ethereal:banana_wood",      "banana"},
	{"birch",	 "Birch Wood",    		 "ethereal:birch_wood",       "moretrees_birch"},
}

for i in ipairs(moretrees_slopes) do
	local mat = moretrees_slopes[i][1]
	local desc = moretrees_slopes[i][2]
	local item = moretrees_slopes[i][3]
	local img = moretrees_slopes[i][4]

--slope
minetest.register_node("mywoodslopes:"..mat.."_slope", {
	description = desc.." Slope",
	drawtype = "mesh",
	mesh = "twelve-twelve.obj",
	tiles = {img.."_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})
--icorner
minetest.register_node("mywoodslopes:"..mat.."_icorner", {
	description = desc.." Slope Inside Corner",
	drawtype = "mesh",
	mesh = "twelve-twelve-ic.obj",
	tiles = {img.."_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox,
	selection_box = icorner_cbox
})
--ocorner
minetest.register_node("mywoodslopes:"..mat.."_ocorner", {
	description = desc.." Slope Outside Corner",
	drawtype = "mesh",
	mesh = "twelve-twelve-oc.obj",
	tiles = {img.."_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox,
	selection_box = ocorner_cbox
})

--rotated---------------------------------------------------------------
--slope
minetest.register_node("mywoodslopes:"..mat.."_slope_r", {
	description = desc.." Slope Rotated",
	drawtype = "mesh",
	mesh = "twelve-twelve.obj",
	tiles = {img.."_wood.png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})
--icorner
minetest.register_node("mywoodslopes:"..mat.."_icorner_r", {
	description = desc.." Slope Inside Corner Rotate",
	drawtype = "mesh",
	mesh = "twelve-twelve-ic.obj",
	tiles = {img.."_wood.png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox,
	selection_box = icorner_cbox
})
--ocorner
minetest.register_node("mywoodslopes:"..mat.."_ocorner_r", {
	description = desc.." Slope Outside Corner Rotated",
	drawtype = "mesh",
	mesh = "twelve-twelve-oc.obj",
	tiles = {img.."_wood.png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox,
	selection_box = ocorner_cbox
})


--Crafts--------------------------------------------------------

--slope
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_slope 3",
	recipe = {
		{"", "",""},
		{item, "",""},
		{item, item,""},
	}
})
--slope icorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_icorner 3",
	recipe = {
		{"", "",""},
		{"", item,""},
		{item,"", item},
	}
})
--slope ocorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_ocorner 3",
	recipe = {
		{"", "",""},
		{item, "",item},
		{"", item,""},
	}
})

--rotated-----------------------------------------------
--slope
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_slope_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_slope",""},
		{"", "",""},
	}
})
--slope icorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_icorner_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_icorner",""},
		{"", "",""},
	}
})
--slope ocorner
minetest.register_craft({
	output = "mywoodslopes:"..mat.."_ocorner_r 1",
	recipe = {
		{"", "",""},
		{"", "mywoodslopes:"..mat.."_ocorner",""},
		{"", "",""},
	}
})
--]]
end






