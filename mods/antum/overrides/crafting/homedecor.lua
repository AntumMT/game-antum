
print("\nHOMEDECOR!!!\n")

local i = {
	pole = "homedecor:pole_wrought_iron",
	glass = "vessels:drinking_glass",
}

local craft_it = true
for _, iname in pairs(i) do
	if not core.registered_items[iname] then
		core.log("warning", "[antum_overrides] not creating craft for home_workshop_misc:soda_machine, item not registered: " .. iname)
		craft_it = false
		break
	end
end

if craft_it then
	antum.registerCraft({
		output = "home_workshop_misc:soda_machine",
		recipe = {
			{i.pole, i.glass, i.pole},
			{i.pole, i.glass, i.pole},
			{i.pole, i.glass, i.pole},
		},
	})
end