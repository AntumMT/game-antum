-- Rainbow_Ore Test Mod ----------- Copyright Robin Kuhn 2015

rainbow_ore = {}
rainbow_ore.modname = core.get_current_modname()
rainbow_ore.modpath = core.get_modpath(rainbow_ore.modname)

--Check for mods
if core.get_modpath("3d_armor") then
dofile(rainbow_ore.modpath.."/rainbow_armor.lua")
end

if core.get_modpath("shields") then
dofile(rainbow_ore.modpath.."/rainbow_shield.lua")
end


local S = core.get_translator(rainbow_ore.modname)

-- Define Rainbow_Ore_Block node
core.register_node("rainbow_ore:block", {
	description = S("Rainbow Ore"),
	tiles = {"rainbow_ore_block.png"},
	groups = {stone=2, cracky=3},
	drop = "rainbow_ore:block",
	is_ground_content = true,
})


--Define Rainbow_Ore_Ingot node
core.register_craftitem("rainbow_ore:ingot", {
	description = S("Rainbow Ore Ingot"),
	inventory_image = "rainbow_ore_ingot.png",
})

--Define Rainbow_Ore Smelt Recipe
core.register_craft({
	type = "cooking",
	output = "rainbow_ore:ingot",
	recipe = "rainbow_ore:block",
	cooktime = 10,
})


--Register Rainbow Pickaxe
core.register_tool("rainbow_ore:pick", {
	description = S("Rainbow Pickaxe"),
	inventory_image = "rainbow_ore_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=1.0, [2]=0.5, [3]=0.25}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=5},
	},
})


local stick = core.settings:get("rainbow_ore.stick")
if not stick then
	if core.registered_items["default:stick"] then
		stick = "default:stick"
	else
		stick = "rainbow_ore:rainbow_ore_ingot"
	end
end

--Define Rainbow_Ore_Pickaxe crafting recipe
core.register_craft({
	output = "rainbow_ore:pick",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"", stick, ""},
		{"", stick, ""}
	}
})


--Register Rainbow Axe
core.register_tool("rainbow_ore:axe", {
	description = S("Rainbow Axe"),
	inventory_image = "rainbow_ore_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			choppy={times={[1]=1.05, [2]=0.45, [3]=0.25}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	}
})


--Define Rainbow Axe crafting recipe
core.register_craft({
	output = "rainbow_ore:axe",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", ""},
		{"rainbow_ore:ingot", stick, ""},
		{"", stick, ""}
	}
})

core.register_craft({
	output = "rainbow_ore:axe",
	recipe = {
		{"", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"", stick, "rainbow_ore:ingot"},
		{"", stick, ""}
	}
})


--Register Rainbow shovel
core.register_tool("rainbow_ore:shovel", {
	description = S("Rainbow Shovel"),
	inventory_image = "rainbow_ore_shovel.png",
	wield_image = "rainbow_ore_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=0.55, [2]=0.25, [3]=0.15}, uses=15, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})


--Define Rainbow shovel crafting recipe
core.register_craft({
	output = "rainbow_ore:shovel",
	recipe = {
		{"", "rainbow_ore:ingot", ""},
		{"", stick, ""},
		{"", stick, ""}
	}
})


--Register Rainbow sword
core.register_tool("rainbow_ore:sword", {
	description = S("Rainbow Sword"),
	inventory_image = "rainbow_ore_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=3,
		groupcaps={
			snappy={times={[1]=0.95, [2]=0.45, [3]=0.15}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=8},
	}
})


--Define Rainbow sword crafting recipe
core.register_craft({
	output = "rainbow_ore:sword",
	recipe = {
		{"", "rainbow_ore:ingot", ""},
		{"", "rainbow_ore:ingot", ""},
		{"", stick, ""}
	}
})


--Define Nyan Rainbow crafting recipe
core.register_craft({
	output = "default:nyancat_rainbow",
	recipe = {
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"},
		{"rainbow_ore:ingot", "rainbow_ore:ingot", "rainbow_ore:ingot"}
	}
})


--Make Rainbow Ore spawn
local spawn_within = core.settings:get("rainbow_ore.spawn_within") or "default:stone"
core.log("action", "[rainbow_ore] ore set to spawn within " .. spawn_within
	.. ", this can be changed with rainbow_ore.spawn_within setting")

core.register_on_mods_loaded(function()
	if core.registered_nodes[spawn_within] then
		core.register_ore({
			ore_type = "scatter",
			ore = "rainbow_ore:block",
			wherein = spawn_within,
			clust_scarcity = 17*17*17,
			clust_num_ores = 3,
			clust_size = 3,
			y_min = -31000,
			y_max = -200,
		})
	else
		core.log("warning", "[rainbow_ore] " .. spawn_within .. " is not a registered node, rainbow ore will not spawn")
	end
end)


-- backward compatibility

local aliases = {
	"ingot",
	"pickaxe",
	"axe",
	"shovel",
	"sword",
	"block",
	-- xdecor nodes
	"block_cube",
	"block_doublepanel",
	"block_halfstair",
	"block_micropanel",
	"block_microslab",
	"block_nanoslab",
	"block_panel",
	"block_thinstair",
}

for _, al in ipairs(aliases) do
	local tgt = al
	if tgt == "pickaxe" then
		tgt = "pick"
	end

	core.register_alias("rainbow_ore:rainbow_ore_"..al, "rainbow_ore:"..tgt)
end
