
local register_repairable

if core.global_exists("workbench") and workbench.register_repairable then
	register_repairable = workbench.register_repairable
elseif core.global_exists("xdecor") and xdecor.register_repairable then
	register_repairable = xdecor.register_repairable
end

if register_repairable then
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
		register_repairable(nil, tool)
	end
end
