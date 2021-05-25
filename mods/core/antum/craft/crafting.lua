--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


-- Nyan cat blocks
antum.registerCraft({
	output = "default:nyancat_rainbow",
	recipe = {
		{"", "dye:red", "",},
		{"dye:violet", "group:wood", "dye:yellow",},
		{"", "dye:blue", "",},
	}
})


-- Walking light items
antum.registerCraft({
	output = "walking_light:helmet_gold",
	recipe = {
		{"default:torch"},
		{"3d_armor:helmet_gold"},
	}
})


local glowlight = {
	cube = "homedecor:glowlight_small_cube_14",
	quarter = "homedecor:glowlight_quarter_14",
	half = "homedecor:glowlight_half_14",
	glass = "moreblocks:super_glow_glass",
}

if core.registered_items[glowlight.glass] then
	if core.registered_items[glowlight.cube] then
		core.register_craft({
			type = "shapeless",
			output = glowlight.cube .. " 4",
			recipe = {glowlight.glass},
		})
	end

	if core.registered_items[glowlight.quarter] then
		core.register_craft({
			output = glowlight.quarter,
			recipe = {
				{glowlight.glass, glowlight.glass},
			},
		})
	end

	if core.registered_items[glowlight.half] then
		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.glass, glowlight.glass},
				{glowlight.glass, glowlight.glass},
			},
		})

		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.quarter},
				{glowlight.quarter},
			},
		})
	end
end
