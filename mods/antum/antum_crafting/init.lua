
-- Create cotton from white wool
minetest.register_craft({
	output = "farming:cotton 4",
	type = "shapeless",
	recipe = {"wool:white"},
})
