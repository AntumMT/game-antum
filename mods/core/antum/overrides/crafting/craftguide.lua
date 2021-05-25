--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


-- Override craftguide:sign
antum.overrideCraftOutput({
	type = "shapeless",
	output = "craftguide:sign",
	recipe = {"default:sign_wall_wood", "default:paper"},
})

-- Alternate recipes for craftguide:sign
antum.registerCraft({
	type = "shapeless",
	output = "craftguide:sign",
	recipe = {"default:sign_wall_wood", "craftguide:book"},
})

antum.registerCraft({
	output = "craftguide:sign",
	recipe = {
		{"default:sign_wall_wood", "default:sign_wall_wood", ""},
		{"default:sign_wall_wood", "default:sign_wall_wood", ""},
	},
})

-- Override craftguide:book
antum.overrideCraftOutput({
	type = "shapeless",
	output = "craftguide:book",
	recipe = {"default:book", "default:paper"},
})

-- Alternate recipes for craftguide:book
antum.registerCraft({
	type = "shapeless",
	output = "craftguide:book",
	recipe = {"default:book", "craftguide:sign"},
})

antum.registerCraft({
	type = "shapeless",
	output = "craftguide:book",
	recipe = {"default:book_written", "default:paper"},
})

antum.registerCraft({
	type = "shapeless",
	output = "craftguide:book",
	recipe = {"default:book_written", "craftguide:sign"},
})
