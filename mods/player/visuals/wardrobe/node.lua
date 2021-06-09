
if core.registered_items["wardrobe:wardrobe"] then
	core.unregister_item("wardrobe:wardrobe")
end

core.register_node(":wardrobe:wardrobe", {
	description = "Wardrobe",
	paramtype2 = "facedir",
	tiles = {
		"wardrobe_wardrobe_topbottom.png",
		"wardrobe_wardrobe_topbottom.png",
		"wardrobe_wardrobe_sides.png",
		"wardrobe_wardrobe_sides.png",
		"wardrobe_wardrobe_sides.png",
		"wardrobe_wardrobe_front.png",
	},
	inventory_image = "wardrobe_wardrobe_front.png",
	sounds = default.node_sound_wood_defaults(),
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	on_rightclick = function(pos, node, player, itemstack, pointedThing)
		wardrobe.show_formspec(player, 1)
	end
})

local recipe = {
	{"group:wood", "group:stick", "group:wood"},
	{"group:wood", "group:wool",  "group:wood"},
	{"group:wood", "group:wool",  "group:wood"},
}

core.clear_craft({recipe=recipe})

core.register_craft({
	output = "wardrobe:wardrobe",
	recipe = recipe,
})
