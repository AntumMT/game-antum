--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local function itemsAreRegistered(items)
	for _, iname in pairs(items) do
		if not core.registered_items[iname] then
			return false, iname
		end
	end

	return true
end

local i = {
	topaz = "gems_encrustable:topaz",
	emerald = "gems_tools:emerald_gem",
}

if itemsAreRegistered(i) then
	antum.overrideCraftOutput({
		output = "simple_protection:claim",
		recipe = {
			{"", "", i.topaz},
			{"", i.emerald, ""},
			{i.emerald, "", ""},
		},
	})
end
