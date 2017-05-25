-- Nodes registration for trampoline mod


-- Regular trampoline
minetest.register_node("trampoline:regular", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampoline.box,
	selection_box = trampoline.box,
	paramtype = "light",
	tiles = {
		"top.png",
		"bottom.png",
		"sides.png^sides_overlay.png"
	},
	groups = {dig_immediate=2, bouncy=20+20, fall_damage_add_percent=-70},
})


-- Brown trampoline
minetest.register_node("trampoline:brown", {
	description = "Brown Trampoline",
	drawtype = "nodebox",
	node_box = trampoline.box,
	selection_box = trampoline.box,
	paramtype = "light",
	tiles = {
		"top.png",
		"bottom.png",
		"sides.png^sides_overlay_brown.png"
	},
	groups = {dig_immediate=2, bouncy=20+20, fall_damage_add_percent=-70},
})
