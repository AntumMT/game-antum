

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


-- wand
local wand = {
	head = nil,
	handle = nil,
}

if core.registered_items["gems_encrustable:aquamarine"] then
	wand.head = "gems_encrustable:aquamarine"
elseif core.registered_items["gems:aquamarine"] then
	wand.head = "gems:aquamarine"
end

if core.registered_items["gems_encrustable:opal"] then
	wand.handle = "gems_encrustable:opal"
elseif core.registered_items["gems:opal"] then
	wand.handle = "gems:opal"
end

if wand.head and wand.handle then
	core.register_craft({
		output = alternode.modname .. ":wand",
		recipe = {
			{"", "", wand.head},
			{"", wand.handle, ""},
			{wand.handle, "", ""},
		},
	})
end
