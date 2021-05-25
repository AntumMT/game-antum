--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local function replace_item(old, new)
	if core.registered_items[old] and core.registered_items[new] then
		core.log("action", "Replacing " .. old .. " with " .. new)
		core.unregister_item(old)
		core.register_alias(old, new)

		return true
	end

	return false
end

replace_item("creatures:flesh", "mobs:meat_raw")
replace_item("creatures:meat", "mobs:meat")
replace_item("creatures:chicken_flesh", "mobs:chicken_raw")
replace_item("creatures:chicken_meat", "mobs:chicken_cooked")
replace_item("creatures:egg", "mobs:egg")
replace_item("creatures:fried_egg", "mobs:chicken_egg_fried")
replace_item("creatures:shears", "mobs:shears")

if not replace_item("mobs:kitten_set", "spawneggs:kitten") then
	core.register_alias("mobs:kitten_set", "spawneggs:kitten")
end
