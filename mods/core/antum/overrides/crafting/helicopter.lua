--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


antum.clearCraftOutput("helicopter:cabin")

antum.registerCraft({
	output = "helicopter:cabin",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", ""},
		{"default:steel_ingot", "homedecor:motor","default:glass"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})
