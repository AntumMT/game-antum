
core.register_tool(":antum:sword_daemondeath", {
	description = "Daemondeath Sword",
	inventory_image = "antum_sword_daemondeath.png",
	tool_capabilities = {
		full_punch_interval = 0.50,
		max_drop_level = 1,
		groupcaps={
			fleshy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=0, maxlevel=1},
			snappy={times={[2]=0.70, [3]=0.30}, uses=0, maxlevel=1},
			choppy={times={[3]=0.70}, uses=0, maxlevel=0},
			deamon={times={[1]=0.25, [2]=0.10, [3]=0.05}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=28,},
	},
})

local i = {
	gem = "gems_tools:ruby_gem",
	bone = "bonemeal:bone",
	crystal = "basic_materials:energy_crystal_simple",
}

core.register_craft({
	output = "antum:sword_daemondeath",
	recipe = {
		{i.crystal, i.gem, i.crystal},
		{i.crystal, i.gem, i.crystal},
		{i.crystal, i.bone, i.crystal},
	},
})

core.register_alias("animalmaterials:sword_deamondeath", "antum:sword_daemondeath")
