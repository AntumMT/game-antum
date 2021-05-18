

-- pencil
local pencil = {
	lead = "technic:lead_lump",
	stick = "group:stick",
	rubber = "technic:rubber",
}

-- FIXME: how to check if items are registered under "group:stick"
if core.global_exists("default") and
		core.registered_items[pencil.lead] and core.registered_items[pencil.rubber] then
	core.register_craft({
		output = alternode.modname .. ":pencil",
		recipe = {
			{"", "", pencil.lead},
			{"", pencil.stick, ""},
			{pencil.rubber, "", ""},
		},
	})
end


-- key
local key = {
	main = "basic_materials:brass_ingot",
}

if core.registered_items[key.main] then
	core.register_craft({
		output = alternode.modname .. ":key",
		recipe = {
			{"", key.main},
			{key.main, ""},
		},
	})
end
