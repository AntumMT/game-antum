local node_garden = {
	description = "Garden Fence",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png",
		"myfences_wood.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, -0.375, 0.5, 0.4375},
			{0.375, -0.5, 0.1875, 0.5, 0.5, 0.4375},
			{-0.5, -0.4375, 0.4375, 0.5, -0.25, 0.5},
			{-0.5, -0.1875, 0.4375, 0.5, 0, 0.5},
			{-0.5, 0.0625, 0.4375, 0.5, 0.25, 0.5},
			{-0.5, 0.3125, 0.4375, 0.5, 0.5, 0.5},
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
minetest.register_node("myfences:garden", node_garden)
	
local node_garden_corner = {
	description = "Garden Fence Corner",
	drawtype = "nodebox",
	tiles = {
		"myfences_wood.png",
		"myfences_wood.png",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png^[transformR90",
		"myfences_wood.png",
		"myfences_wood.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propogates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.1875, -0.375, 0.5, 0.4375},
			{0.1875, -0.4375, 0.1875, 0.4375, 0.5, 0.4375},
			{-0.5, -0.4375, 0.4375, 0.5, -0.25, 0.5},
			{-0.5, -0.1875, 0.4375, 0.5, 0, 0.5},
			{-0.5, 0.0625, 0.4375, 0.5, 0.25, 0.5},
			{-0.5, 0.3125, 0.4375, 0.5, 0.5, 0.5},
			
			{0.1875, -0.5, -0.5, 0.4375, 0.5, -0.375},
			{0.4375, -0.4375, -0.5, 0.5, -0.25, 0.5},
			{0.4375, -0.1875, -0.5, 0.5, 0, 0.5},
			{0.4375, 0.0625, -0.5, 0.5, 0.25, 0.5},
			{0.4375, 0.3125, -0.5, 0.5, 0.5, 0.5},
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
minetest.register_node("myfences:garden_corner", node_garden_corner)

for _, entry in ipairs(myfences.colors) do
	local color = entry[1]
	local desc = entry[2]
	local stain = "^(myfences_color.png^[colorize:#"..entry[3]..":255)"

	local tiles = {
		"myfences_wood.png"..stain,
		"myfences_wood.png"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png"..stain,
		"myfences_wood.png"..stain,
	}

	local node = table.copy(node_garden)
	node.description = desc.." Garden Fence"
	node.tiles = tiles
	node.drop = "myfences:garden"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:garden_"..color, node)

	node = table.copy(node_garden_corner)
	node.description = desc.." Garden Fence Corner"
	node.tiles = tiles
	node.drop = "myfences:garden_corner"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:garden_corner_"..color, node)
end

minetest.register_craft({
	output = "myfences:garden",
	recipe = {
		{"","",""},
		{"myfences:board","myfences:board","myfences:board"},
		{"default:wood","myfences:board","default:wood"},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = "myfences:fence_garden_corner",
	recipe = {"myfences:garden","myfences:garden"},
})

