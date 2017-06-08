local node_post = {
	description = "Fence Post",
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
			{0.1875, -0.5, 0.1875, 0.5, 0.5, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{0.1875, -0.5, 0.1875, 0.5, 0.5, 0.5},
		}
	},
	groups = {choppy = 2, flammable = 1},
	sounds = default.node_sound_stone_defaults(),
}
minetest.register_node("myfences:corner_post", node_post)

for _, entry in ipairs(myfences.colors) do
	local color = entry[1]
	local desc = entry[2]
	local stain = "^(myfences_color.png^[colorize:#"..entry[3]..":255)"

	local node = table.copy(node_post)
	node.description = desc.." Fence Post"
	node.tiles = {
		"myfences_wood.png"..stain,
		"myfences_wood.png"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
		"myfences_wood.png^[transformR90"..stain,
	}
	node.drop = "myfences:corner_post"
	node.groups.not_in_creative_inventory = 1
	minetest.register_node("myfences:corner_post_"..color, node)
end

minetest.register_craft({
	output = "myfences:corner_post",
	recipe = {
		{"myfences:board"},
		{"myfences:board"},
		{"myfences:board"},
	}
})

