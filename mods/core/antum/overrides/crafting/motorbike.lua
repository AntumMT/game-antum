
if core.registered_items["motorbike:wheel"] and core.registered_items["technic:rubber"] then
	-- use rubber instead of obsidian shard
	antum.clearCraftOutput("motorbike:wheel")
	antum.registerCraft({
		output = "motorbike:wheel",
		recipe = {
			{"", "technic:rubber", ""},
			{"technic:rubber", "default:steel_ingot", "technic:rubber"},
			{"", "technic:rubber", ""},
		},
	})

	if core.registered_items["basic_materials:motor"] and core.registered_items["basic_materials:steel_bar"] then
		local bike_colors = {
			"black", "blue", "brown", "cyan", "dark_green", "dark_grey", "green",
			"grey", "magenta", "orange", "pink", "red", "violet", "white", "yellow",
		}

		for _, color in ipairs(bike_colors) do
			if not core.registered_items["motorbike:" .. color] then
				antum.log("warning", "Motorbike not registered: motorbike:" .. color)
			end

			-- use steel bar & motor instead of stick & mese crystal
			antum.clearCraftOutput("motorbike:" .. color)
			antum.registerCraft({
				output = "motorbike:" .. color,
				recipe = {
					{"", "", "basic_materials:steel_bar"},
					{"default:steel_ingot", "basic_materials:motor", "default:steel_ingot"},
					{"motorbike:wheel", "wool:" .. color, "motorbike:wheel"},
				},
			})
		end
	end
end