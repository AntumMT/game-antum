
core.register_node("walking_light:light_debug", {
	drawtype = "glasslike",
	tiles = {"walking_light_debug.png"},
	inventory_image = core.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	light_source = 13,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
})

core.register_node("walking_light:light", {
	drawtype = "glasslike",
	tiles = {"walking_light.png"},
	inventory_image = core.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	sunlight_propagates = true,
	light_source = 13,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
})

core.register_node("walking_light:megatorch", {
	description = "Megatorch",
	drawtype = "torchlike",
	tiles = {
		{
			name = "default_torch_on_floor_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_torch_on_ceiling_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_torch_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	inventory_image = "default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = 13,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1},
	legacy_wallmounted = true,
})

core.register_craft({
	output = "walking_light:megatorch",
	recipe = {
		{"default:torch", "default:torch", "default:torch"},
		{"default:torch", "default:torch", "default:torch"},
		{"default:torch", "default:torch", "default:torch"},
	}
})
