local node_picketb = {
	description = "Picket Fence",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.25, -0.4375, 0.1875, 0.4375},
			{0.4375, -0.5, 0.25, 0.5, 0.1875, 0.4375},
			{-0.2187, -0.5, 0.4375, -0.0313, 0.375, 0.5},
			{0.0312, -0.5, 0.4375, 0.2187, 0.375, 0.5},
			{0.2812, -0.5, 0.4375, 0.4687, 0.375, 0.5},
			{-0.4687, -0.5, 0.4375, -0.2812, 0.375, 0.5},
			{-0.5, 0.125, 0.25, 0.5, 0.1875, 0.4375},
			{-0.5, -0.375, 0.25, 0.5, -0.3125, 0.4375},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,0.25,0.5,0.5,0.5},
		}
	},
	groups = {choppy = 2, flammable = 1},
	sounds = default.node_sound_stone_defaults(),
}
minetest.register_node("myfences:picketb", node_picketb)

local node_picket = {
	description = "Picket Fence",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.25, -0.4375, 0.1875, 0.4375},
			{0.4375, -0.5, 0.25, 0.5, 0.1875, 0.4375},
			{-0.2187, -0.5, 0.4375, -0.0313, 0.375, 0.5},
			{0.0312, -0.5, 0.4375, 0.2187, 0.375, 0.5},
			{0.2812, -0.5, 0.4375, 0.4687, 0.375, 0.5},
			{-0.4687, -0.5, 0.4375, -0.2812, 0.375, 0.5},
			{-0.5, 0.125, 0.25, 0.5, 0.1875, 0.4375},
			{-0.5, -0.375, 0.25, 0.5, -0.3125, 0.4375},
			{-0.4375, 0.375, 0.4375, -0.3125, 0.4375, 0.5},
			{-0.1875, 0.375, 0.4375, -0.0625, 0.4375, 0.5},
			{0.0625, 0.375, 0.4375, 0.1875, 0.4375, 0.5},
			{0.3125, 0.375, 0.4375, 0.4375, 0.4375, 0.5},
			{-0.4087, 0.4375, 0.4375, -0.3437, 0.5, 0.5},
			{-0.1562, 0.4375, 0.4375, -0.0937, 0.5, 0.5},
			{0.0948, 0.4375, 0.4375, 0.1563, 0.5, 0.5},
			{0.3448, 0.4375, 0.4375, 0.4063, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,0.25,0.5,0.5,0.5},
		}
	},
	groups = {choppy = 2, flammable = 1},
	sounds = default.node_sound_stone_defaults(),
}

minetest.register_node("myfences:picket", node_picket)

local node_picket_corner = {
	description = "Picket Fence Corner",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.25, -0.4375, 0.1875, 0.4375},
			{0.4375, -0.5, 0.25, 0.5, 0.1875, 0.4375},
			{-0.2187, -0.5, 0.4375, -0.0313, 0.375, 0.5},
			{0.0312, -0.5, 0.4375, 0.2187, 0.375, 0.5},
			{0.2812, -0.5, 0.4375, 0.4687, 0.375, 0.5},
			{-0.4687, -0.5, 0.4375, -0.2812, 0.375, 0.5},
			{-0.5, 0.125, 0.25, 0.5, 0.1875, 0.4375},
			{-0.5, -0.375, 0.25, 0.5, -0.3125, 0.4375},
			{-0.4375, 0.375, 0.4375, -0.3125, 0.4375, 0.5},
			{-0.1875, 0.375, 0.4375, -0.0625, 0.4375, 0.5},
			{0.0625, 0.375, 0.4375, 0.1875, 0.4375, 0.5},
			{0.3125, 0.375, 0.4375, 0.4375, 0.4375, 0.5},
			{-0.4087, 0.4375, 0.4375, -0.3437, 0.5, 0.5},
			{-0.1562, 0.4375, 0.4375, -0.0937, 0.5, 0.5},
			{0.0948, 0.4375, 0.4375, 0.1563, 0.5, 0.5},
			{0.3448, 0.4375, 0.4375, 0.4063, 0.5, 0.5},
			
			{0.25, -0.5, 0.4375, 0.4375, 0.1875, 0.5},
			{0.25, -0.5, -0.5, 0.4375, 0.1875, -0.4375},
			{0.4375, -0.5, 0.0313, 0.5, 0.375, 0.2187},
			{0.4375, -0.5, -0.2187, 0.5, 0.375, -0.0312},
			{0.4375, -0.5, -0.4687, 0.5, 0.375, -0.2812},
			{0.4375, -0.5, 0.2812, 0.5, 0.375, 0.4687},
			{0.25, 0.125, -0.5, 0.4375, 0.1875, 0.5},
			{0.25, -0.375, -0.5, 0.4375, -0.3125, 0.5},
			{0.4375, 0.375, 0.3125, 0.5, 0.4375, 0.4375},
			{0.4375, 0.375, 0.0625, 0.5, 0.4375, 0.1875},
			{0.4375, 0.375, -0.1875, 0.5, 0.4375, -0.0625},
			{0.4375, 0.375, -0.4375, 0.5, 0.4375, -0.3125},
			{0.4375, 0.4375, 0.3437, 0.5, 0.5, 0.4087},
			{0.4375, 0.4375, 0.0937, 0.5, 0.5, 0.1562},
			{0.4375, 0.4375, -0.1563, 0.5, 0.5, -0.0948},
			{0.4375, 0.4375, -0.4063, 0.5, 0.5, -0.3448},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,0.25,0.5,0.5,0.5},
			{0.25,-0.5,-0.5,0.5,0.5,0.5},
		}
	},
	groups = {choppy = 2, flammable = 1},
	sounds = default.node_sound_stone_defaults(),
}
minetest.register_node("myfences:picket_corner", node_picket_corner)

local node_picketb_corner = {
	description = "Picket Fence Corner",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.25, -0.4375, 0.1875, 0.4375},
			{0.4375, -0.5, 0.25, 0.5, 0.1875, 0.4375},
			{-0.2187, -0.5, 0.4375, -0.0313, 0.375, 0.5},
			{0.0312, -0.5, 0.4375, 0.2187, 0.375, 0.5},
			{0.2812, -0.5, 0.4375, 0.4687, 0.375, 0.5},
			{-0.4687, -0.5, 0.4375, -0.2812, 0.375, 0.5},
			{-0.5, 0.125, 0.25, 0.5, 0.1875, 0.4375},
			{-0.5, -0.375, 0.25, 0.5, -0.3125, 0.4375},
			
			{0.25, -0.5, 0.4375, 0.4375, 0.1875, 0.5},
			{0.25, -0.5, -0.5, 0.4375, 0.1875, -0.4375},
			{0.4375, -0.5, 0.0313, 0.5, 0.375, 0.2187},
			{0.4375, -0.5, -0.2187, 0.5, 0.375, -0.0312},
			{0.4375, -0.5, -0.4687, 0.5, 0.375, -0.2812},
			{0.4375, -0.5, 0.2812, 0.5, 0.375, 0.4687},
			{0.25, 0.125, -0.5, 0.4375, 0.1875, 0.5},
			{0.25, -0.375, -0.5, 0.4375, -0.3125, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,0.25,0.5,0.5,0.5},
			{0.25,-0.5,-0.5,0.5,0.5,0.5},
		}
	},
	groups = {choppy = 2, flammable = 1},
	sounds = default.node_sound_stone_defaults(),
}
minetest.register_node("myfences:picketb_corner", node_picketb_corner)

for _, entry in ipairs(myfences.colors) do
	local color = entry[1]
	local desc = entry[2]
	local stain = "^(myfences_color.png^[colorize:#"..entry[3]..":255)"

	local tiles = {
		"myfences_wood.png"..stain,
		"myfences_wood.png"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
	}

	local node = table.copy(node_picketb)
	node.description = desc.." Picket Fence"
	node.tiles = tiles
	node.drop = "myfences:picketb"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:picketb_"..color, node)

	node = table.copy(node_picketb)
	node.description = desc.." Picket Fence"
	node.tiles = tiles
	node.drop = "myfences:picket"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:picket_"..color, node)

	node = table.copy(node_picket_corner)
	node.description = desc.." Picket Fence Corner"
	node.tiles = tiles
	node.drop = "myfences:picket_corner"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:picket_corner_"..color, node)

	node = table.copy(node_picketb_corner)
	node.description = desc.." Picket Fence Corner"
	node.tiles = tiles
	node.drop = "myfences:picketb_corner"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:picketb_corner_"..color, node)
end

minetest.register_craft({
	output = "myfences:picket",
	recipe = {
		{"","myfences:board",""},
		{"myfences:board","myfences:board","myfences:board"},
		{"myfences:board","myfences:board","myfences:board"},
	}
})
minetest.register_craft({
	output = "myfences:picketb",
	recipe = {
		{"","",""},
		{"myfences:board","myfences:board","myfences:board"},
		{"myfences:board","myfences:board","myfences:board"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "myfences:picket_corner",
	recipe = {"myfences:picket","myfences:picket"},
})
minetest.register_craft({
	type = "shapeless",
	output = "myfences:picketb_corner",
	recipe = {"myfences:picketb","myfences:picketb"},
})

