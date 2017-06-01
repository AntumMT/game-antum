-- Craft recipes for slingshot mod


minetest.register_craft({
	output = 'slingshot:slingshot',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steelblock', ''},
		{'', 'default:steel_ingot', ''},
	}
})
