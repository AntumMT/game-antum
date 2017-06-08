local node_privacy = {
	description = "Privacy Fence",
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
			{-0.5, -0.5, 0.1875, -0.375, 0.5, 0.4375},
			{0.375, -0.5, 0.1875, 0.5, 0.5, 0.4375},
			{-0.375, -0.375, 0.3125, 0.375, -0.1875, 0.4375},
			{-0.375, 0.1875, 0.3125, 0.375, 0.375, 0.4375},
			{-0.4896, -0.5, 0.4375, -0.1772, 0.5, 0.5},
			{-0.1458, -0.5, 0.4375, 0.1458, 0.5, 0.5},
			{0.1772, -0.5, 0.4375, 0.4896, 0.5, 0.5},
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
minetest.register_node("myfences:privacy", node_privacy)

local node_privacy_corner = {
	description = "Privacy Fence Corner",
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
			{-0.5, -0.5, 0.1875, -0.375, 0.5, 0.4375},
			{0.1875, -0.5, 0.1875, 0.4375, 0.5, 0.4375},
			{-0.375, -0.375, 0.3125, 0.375, -0.1875, 0.4375},
			{-0.375, 0.1875, 0.3125, 0.375, 0.375, 0.4375},
			{-0.4896, -0.5, 0.4375, -0.1772, 0.5, 0.5},
			{-0.1458, -0.5, 0.4375, 0.1458, 0.5, 0.5},
			{0.1772, -0.5, 0.4375, 0.4896, 0.5, 0.5},
			
			{0.1875, -0.5, -0.5, 0.4375, 0.5, -0.375},
			{0.3125, -0.375, -0.375, 0.4375, -0.1875, 0.375},
			{0.3125, 0.1875, -0.375, 0.4375, 0.375, 0.375},
			{0.4375, -0.5, 0.1772, 0.5, 0.5, 0.4896},
			{0.4375, -0.5, -0.1458, 0.5, 0.5, 0.1458},
			{0.4375, -0.5, -0.4896, 0.5, 0.5, -0.1772},
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
minetest.register_node("myfences:privacy_corner", node_privacy_corner)

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

	local node = table.copy(node_privacy)
	node.description = desc.." Privacy Fence"
	node.tiles = tiles
	node.drop = "myfences:privacy"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:privacy_"..color, node)

	node = table.copy(node_privacy_corner)
	node.description = desc.." Privacy Fence Corner"
	node.tiles = tiles
	node.drop = "myfences:privacy_corner"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:privacy_corner_"..color, node)
end

minetest.register_craft({
	output = "myfences:privacy",
	recipe = {
		{"","",""},
		{"default:wood","myfences:board","myfences:board"},
		{"default:wood","myfences:board","myfences:board"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "myfences:privacy_corner",
	recipe = {"myfences:privacy","myfences:privacy"},
})

