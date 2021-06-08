
if core.global_exists("WB") and WB.register_repairable then
	local repairables = {
		"castle_weapons:crossbow",
		"fireflies:bug_net",
		"mobs:lasso",
		"mobs:net",
		"mobs:shears",
		"screwdriver:screwdriver",
		"slingshot:iron",
		"slingshot:wood",
		"technic:treetap",
	}

	for _, tool in ipairs(repairables) do
		WB:register_repairable(tool)
	end
end
