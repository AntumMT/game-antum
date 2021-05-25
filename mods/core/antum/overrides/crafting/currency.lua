--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


if antum.dependsSatisfied({"default", "currency"}) then
	core.register_craft({
		output = "default:paper",
		recipe = {
			{"currency:minegeld", "currency:minegeld"},
			{"currency:minegeld", "currency:minegeld"},
		},
	})

	core.register_craft({
		output = "default:paper",
		recipe = {
			{"currency:minegeld_5", "currency:minegeld_5"},
			{"currency:minegeld_5", "currency:minegeld_5"},
		},
	})

	core.register_craft({
		output = "default:paper",
		recipe = {
			{"currency:minegeld_10", "currency:minegeld_10"},
			{"currency:minegeld_10", "currency:minegeld_10"},
		},
	})

	core.register_craft({
		output = "default:paper 10",
		type = "shapeless",
		recipe = {"currency:minegeld_bundle"},
	})
end
