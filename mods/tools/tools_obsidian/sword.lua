
local t_uses = {}
local tool_wear_enabled = minetest.settings:get_bool("enable_tool_wear")
if tool_wear_enabled == nil then
	-- Default is enabled
	tool_wear_enabled = true
end

if tool_wear_enabled then
	t_uses.forty = 40
else
	t_uses.forty = 0
end


minetest.register_tool("tools_obsidian:sword_obsidian", {
	description = "Obsidian Sword",
	inventory_image = "tools_obsidian_sword.png",
	wield_scale = {x=1.2,y=1,z=.4},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
        stack_max = 1,
        range = 4.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=t_uses.forty, maxlevel=3},
		},
		damage_groups = {fleshy=14},
	}
})

minetest.register_craft({
		output = "tools_obsidian:sword_obsidian",
		recipe = {
			{"default:obsidian_glass", "default:obsidian_shard", "default:obsidian"},
			{"default:mese_crystal", "default:obsidian", "default:diamond"},
			{"bucket:bucket_lava", "default:mese_crystal", "default:obsidian_glass"}
		},
		replacements = {
			{"bucket:bucket_lava", "bucket:bucket_empty"},
		}
	}
)

--longsword
minetest.register_tool("tools_obsidian:longsword_obsidian", {
	description = "Obsidian Longword",
	inventory_image = "tools_obsidian_sword_long.png",
	wield_image = "tools_obsidian_sword_long.png",
	wield_scale = {x=2,y=1.3,z=.4},
	tool_capabilities = {
		full_punch_interval = 4.2,
		max_drop_level=2,
        stack_max = 1,
        range = 4.0,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=t_uses.forty, maxlevel=3},
		},
		damage_groups = {fleshy=26},
	}
})

minetest.register_craft({
		output = "tools_obsidian:longsword_obsidian",
		recipe = {
			{"default:obsidian_glass", "default:obsidian_shard", "default:obsidian"},
			{"default:mese_crystal", "tools_obsidian:sword_obsidian", "default:diamond"},
			{"bucket:bucket_lava", "default:mese_crystal", "default:obsidian_glass"}
		},
		replacements = {
			{"bucket:bucket_lava", "bucket:bucket_empty"},
		}
	}
)

--dagger
minetest.register_tool("tools_obsidian:dagger_obsidian", {
	description = "Obsidian Dagger",
	inventory_image = "tools_obsidian_dagger.png",
	wield_image = "tools_obsidian_dagger_wield.png",
	wield_scale = {x=1.2,y=1,z=.4},
	tool_capabilities = {
		full_punch_interval = .5,
		max_drop_level=1,
        stack_max = 1,
        range = 3.0,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=t_uses.forty, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	}
})

minetest.register_craft({
		output = "tools_obsidian:dagger_obsidian",
		recipe = {
			{"default:obsidian_glass", "default:obsidian", "default:obsidian_shard"},
			{"default:mese_crystal_fragment", "default:obsidian_shard", "default:diamond"},
			{"bucket:bucket_lava", "default:mese_crystal_fragment", "default:obsidian_glass"}
		},
		replacements = {
			{"bucket:bucket_lava", "bucket:bucket_empty"},
		}
	}
)
