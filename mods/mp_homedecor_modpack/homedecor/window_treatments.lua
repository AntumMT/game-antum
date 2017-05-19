
local S = homedecor.gettext

local function N_(x) return x end

homedecor.register("window_quartered", {
	description = S("Window (quartered)"),
	tiles = {
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_quartered.png",
		"homedecor_window_quartered.png"
	},
	use_texture_alpha = true,
	groups = {snappy=3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.025, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, 0.4375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox2
			{-0.5, -0.5, -0.0625, 0.5, -0.4375, 0.0625}, -- NodeBox3
			{-0.5, -0.0625, -0.025, 0.5, 0.0625, 0.025}, -- NodeBox4
			{0.4375, -0.5, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0.0625}, -- NodeBox6
			{-0.0625, -0.5, -0.025, 0.0625, 0.5, 0.025}, -- NodeBox7
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
	}
})

homedecor.register("window_plain", {
	description = S("Window (plain)"),
	tiles = {
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_sides.png",
		"homedecor_window_frame.png",
		"homedecor_window_frame.png"
	},
	use_texture_alpha = true,
	groups = {snappy=3},
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.025, 0.5, 0.5, 0}, -- NodeBox1
			{-0.5, 0.4375, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox2
			{-0.5, -0.5, -0.0625, 0.5, -0.4375, 0.0625}, -- NodeBox3
			{0.4375, -0.5, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox4
			{-0.5, -0.5, -0.0625, -0.4375, 0.5, 0.0625}, -- NodeBox5
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.0625, 0.5, 0.5, 0.0625}
	}
})

local wb1_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 },
}

homedecor.register("blinds_thick", {
	description = S("Window Blinds (thick)"),
	mesh = "homedecor_windowblind_thick.obj",
	inventory_image = "homedecor_windowblind_thick_inv.png",
	tiles = {
		"homedecor_windowblind_strings.png",
		"homedecor_windowblinds.png"
	},
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = wb1_cbox
})

local wb2_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 6/16, 8/16, 8/16, 8/16 },
}

homedecor.register("blinds_thin", {
	description = S("Window Blinds (thin)"),
	mesh = "homedecor_windowblind_thin.obj",
	inventory_image = "homedecor_windowblind_thin_inv.png",
	tiles = {
		"homedecor_windowblind_strings.png",
		"homedecor_windowblinds.png"
	},
	walkable = false,
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = wb2_cbox
})

local curtaincolors = {
	{ N_("red"),    "#ad2323e0:175" },
	{ N_("green"),  "#27a927e0:175" },
	{ N_("blue"),   "#2626c6e0:175" },
	{ N_("white"),  "#ffffffe0:175" },
	{ N_("pink"),   "#ff8fb7e0:175" },
	{ N_("violet"), "#7f29d7e0:175" },
}

for _, c in ipairs(curtaincolors) do
	local color, hue = unpack(c)

	homedecor.register("curtain_"..color, {
		description = S("Curtains (@1)", S(color)),
		tiles = { "homedecor_curtain.png^[colorize:"..hue },
		inventory_image = "homedecor_curtain.png^[colorize:"..hue,
		wield_image = "homedecor_curtain.png^[colorize:"..hue,
		drawtype = 'signlike',
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = { type = "wallmounted" },
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
			if string.find(topnode.name, "homedecor:curtainrod") then
				-- Open the curtains
				local fdir = node.param2
				minetest.set_node(pos, { name = "homedecor:curtain_open_"..color, param2 = fdir })
			end
			return itemstack
		end
	})

	homedecor.register("curtain_open_"..color, {
		description = S("Curtains (@1)", S(color)),
		tiles = { "homedecor_curtain_open.png^[colorize:"..hue },
		inventory_image = "homedecor_curtain_open.png^[colorize:"..hue,
		wield_image = "homedecor_curtain_open.png^[colorize:"..hue,
		drawtype = 'signlike',
		use_texture_alpha = true,
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_leaves_defaults(),
		paramtype2 = 'wallmounted',
		selection_box = { type = "wallmounted" },
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
			if string.find(topnode.name, "homedecor:curtainrod") then
				-- Close the curtains
				local fdir = node.param2
				minetest.set_node(pos, { name = "homedecor:curtain_"..color, param2 = fdir })
			end
			return itemstack
		end
	})

end

local mats = {
	{ "brass", S("brass"), "homedecor_generic_metal_brass.png" },
	{ "wrought_iron", S("wrought iron"), "homedecor_generic_metal_wrought_iron.png" },
	{ "wood", S("wood"), "default_wood.png" }
}

for _, m in ipairs(mats) do
	local material, mat_name, texture = unpack(m)
	homedecor.register("curtainrod_"..material, {
		tiles = { texture },
		inventory_image  = "homedecor_curtainrod_"..material.."_inv.png",
		description = S("Curtain Rod (@1)", mat_name),
		groups = { snappy = 3 },
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0.375, 0.5, -0.4375, 0.4375},
				{-0.4375, -0.5, 0.4375, -0.375, -0.4375, 0.5},
				{0.375, -0.5, 0.4375, 0.4375, -0.4375, 0.5}
			}
		}
	})
end

homedecor.register("window_flowerbox", {
	description = S("Window flowerbox"),
	tiles = {
		"homedecor_flowerbox_top.png",
		"homedecor_flowerbox_bottom.png",
		"homedecor_flowerbox_sides.png"
	},
	inventory_image = "homedecor_flowerbox_inv.png",
	sounds = default.node_sound_stone_defaults(),
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, 0.25, -0.125, 0.375, 0.5, 0.375}, -- NodeBox1
			{-0.3125, 0.4375, 0.375, -0.25, 0.4875, 0.5}, -- NodeBox2
			{0.25, 0.4375, 0.375, 0.3125, 0.4875, 0.5}, -- NodeBox3
		}
	}
})

homedecor.register("stained_glass", {
	description = S("Stained Glass"),
	tiles = {"homedecor_stained_glass.png"},
	inventory_image = "homedecor_stained_glass.png",
	groups = {snappy=3},
	use_texture_alpha = true,
	light_source = 3,
	sounds = default.node_sound_glass_defaults(),
	node_box = {
		type = "fixed",
		fixed = { {-0.5, -0.5, 0.46875, 0.5, 0.5, 0.5} }
	}
})
