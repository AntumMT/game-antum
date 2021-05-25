--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local cotton_aliases = {"thread", "string"}


if core.global_exists("farming") and core.get_modpath("wool") then
	-- Craft cotton from wool
	antum.registerCraft({
		output = "farming:cotton 4",
		type = "shapeless",
		recipe = {"group:wool"},
	})

	-- Add aliases for cotton
	for alias in pairs(cotton_aliases) do
		core.register_alias("farming:" .. alias, "farming:cotton")
	end
end
