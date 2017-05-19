-- Various kinds of window shutters

local S = homedecor.gettext

local shutters = {
	{"oak",          S("unpainted oak"), "#bf8a51:200" },
	{"mahogany",     S("mahogany"),      "#822606:200" },
	{"red",          S("red"),           "#d00000:150" },
	{"yellow",       S("yellow"),        "#ffff00:150" },
	{"forest_green", S("forest green"),  "#006000:150" },
	{"light_blue",   S("light blue"),    "#1963c7:150" },
	{"violet",       S("violet"),        "#6000ff:150" },
	{"black",        S("black"),         "#000000:200" },
	{"dark_grey",    S("dark grey"),     "#202020:200" },
	{"grey",         S("grey"),          "#c0c0c0:150" },
	{"white",        S("white"),         "#ffffff:150" },
}

local shutter_cbox = {
	type = "wallmounted",
	wall_top =		{ -0.5,  0.4375, -0.5,  0.5,     0.5,    0.5 },
	wall_bottom =	{ -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
	wall_side =		{ -0.5, -0.5,    -0.5, -0.4375,  0.5,    0.5 }
}

for _, s in ipairs(shutters) do
	local name, desc, hue = unpack(s)

	local tile = "homedecor_window_shutter.png^[colorize:"..hue
	local inv  = "homedecor_window_shutter_inv.png^[colorize:"..hue

	homedecor.register("shutter_"..name, {
		mesh = "homedecor_window_shutter.obj",
		tiles = { tile },
		description = S("Wooden Shutter (@1)", desc),
		inventory_image = inv,
		wield_image = inv,
		paramtype2 = "wallmounted",
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = shutter_cbox,
		node_box = shutter_cbox,
			-- collision_box doesn't accept type="wallmounted", but node_box
			-- does.  Said nodeboxes create a custom collision box but are
			-- invisible themselves because drawtype="mesh".
	})
end

minetest.register_alias("homedecor:shutter_purple", "homedecor:shutter_violet")
