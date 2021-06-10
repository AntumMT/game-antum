
core.register_node(":antum:rainbow_block", {
	description = "Rainbow Block",
	tiles = {"rainbow_block.png"},
	groups = {cracky=4},
	is_ground_content = false,
})

if core.registered_items["rainbow_ore:rainbow_ore_ingot"] then
	core.register_craft({
		output = "antum:rainbow_block",
		recipe = {
			{"rainbow_ore:rainbow_ore_ingot", "rainbow_ore:rainbow_ore_ingot"},
			{"rainbow_ore:rainbow_ore_ingot", "rainbow_ore:rainbow_ore_ingot"},
		},
	})
end
