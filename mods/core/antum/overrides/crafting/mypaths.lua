
-- one of the default stair recipes overrides the slope

-- FIXME: appears to be multiples registered. e.g. "mypaths:grass_slope" & "mypaths:slope_grass"

local recipe_slope = {
	{"mypaths:grass", "", ""},
	{"mypaths:grass", "mypaths:grass", ""},
	{"mypaths:grass", "mypaths:grass", "mypaths:grass"},
}

local recipe_slope_long = {
	{"mypaths:grass_slope", "", ""},
	{"mypaths:grass_slope", "mypaths:grass_slope", ""},
	{"mypaths:grass_slope", "mypaths:grass_slope", "mypaths:grass_slope"},
}

for _, out in ipairs({"mypaths:grass_slope", "mypaths:grass_slope_long",
		"mypaths:slope_grass", "mypaths:slope_grass_long"}) do
	antum.clearCraftOutput(out)
end

antum.registerCraft({
	output = "mypaths:grass_slope 6",
	recipe = recipe_slope,
})

-- FIXME: hack (couldn't use original recipe)
antum.registerCraft({
	output = "mypaths:grass_slope_long 3",
	recipe = recipe_slope_long,
})
