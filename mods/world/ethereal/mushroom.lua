
local S = ethereal.intllib

-- mushroom soup (Heals 1 heart)
minetest.register_craftitem("ethereal:mushroom_soup", {
	description = S("Mushroom Soup"),
	inventory_image = "ethereal_mushroom_soup.png",
	groups = {drink = 1},
	on_use = minetest.item_eat(5, "ethereal:bowl")
})

minetest.register_craft({
	output = "ethereal:mushroom_soup",
	recipe = {
		{"group:food_mushroom"},
		{"group:food_mushroom"},
		{"group:food_bowl"}
	}
})

-- 4x red mushrooms make mushroom block
minetest.register_craft({
	output = "ethereal:mushroom",
	recipe = {
		{"flowers:mushroom_red", "flowers:mushroom_red"},
		{"flowers:mushroom_red", "flowers:mushroom_red"}
	}
})
