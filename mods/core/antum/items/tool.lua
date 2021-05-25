
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


core.register_tool(":walking_light:helmet_gold", {
	description = "Gold Helmet with light",
	inventory_image = "walking_light_inv_helmet_gold.png",
	wield_image = "3d_armor_inv_helmet_gold.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250},
	wear = 0,
})

walking_light.addLightItem("walking_light", {
	"helmet_gold",
	}
)


antum.registerCraft({
	output = "walking_light:helmet_gold",
	recipe = {
		{"default:torch"},
		{"3d_armor:helmet_gold"},
	}
})


local glowlight = {
	cube = "homedecor:glowlight_small_cube_14",
	quarter = "homedecor:glowlight_quarter_14",
	half = "homedecor:glowlight_half_14",
	glass = "moreblocks:super_glow_glass",
}

if core.registered_items[glowlight.glass] then
	if core.registered_items[glowlight.cube] then
		core.register_craft({
			type = "shapeless",
			output = glowlight.cube .. " 4",
			recipe = {glowlight.glass},
		})
	end

	if core.registered_items[glowlight.quarter] then
		core.register_craft({
			output = glowlight.quarter,
			recipe = {
				{glowlight.glass, glowlight.glass},
			},
		})
	end

	if core.registered_items[glowlight.half] then
		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.glass, glowlight.glass},
				{glowlight.glass, glowlight.glass},
			},
		})

		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.quarter},
				{glowlight.quarter},
			},
		})
	end
end
