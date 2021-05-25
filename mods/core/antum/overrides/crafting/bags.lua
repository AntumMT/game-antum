--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


if core.registered_items["farming:string"] and core.registered_items["mobs:leather"] then
	core.clear_craft({
		recipe = {
			{"", "default:stick", ""},
			{"default:wood", "default:wood", "default:wood"},
			{"default:wood", "default:wood", "default:wood"},
		},
	})
	core.clear_craft({
		recipe = {
			{"bags:small", "bags:small"},
			{"bags:small", "bags:small"},
		},
	})
	core.clear_craft({
		recipe = {
			{"bags:medium", "bags:medium"},
			{"bags:medium", "bags:medium"},
		},
	})

	core.register_craft({
		output = "bags:small",
		recipe = {
			{"mobs:leather", "mobs:leather", "farming:string"},
			{"mobs:leather", "mobs:leather", ""},
		},
	})

	core.register_craft({
		type = "shapeless",
		output = "bags:medium",
		recipe = {"bags:small", "bags:small"},
	})

	core.register_craft({
		type = "shapeless",
		output = "bags:large",
		recipe = {"bags:medium", "bags:medium"},
	})

	core.register_craft({
		type = "shapeless",
		output = "bags:large",
		recipe = {"bags:small", "bags:small", "bags:small", "bags:small"},
	})
end
