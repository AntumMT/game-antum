-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- Converted to 'creatures' mob engine API by Jordan Irwin (AntumDeluge)
--
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice.
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief shark implementation
--! @copyright Sapier
--! @author Sapier
--! @date 2014-05-30
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local S = core.get_translator("shark")


shark = {
	modname = core.get_current_modname()
}
shark.modpath = core.get_modpath(shark.modname)

local version = "1.0"
local variant = "me" -- Creatures MOB-Engine
local version_full = tostring(version) .. "-" .. variant


local function mlog(lvl, msg)
	if lvl and msg == nil then
		msg = lvl
		lvl = nil
	end

	if lvl == nil then
		core.log("[" .. shark.modname .. "] " .. msg)
	else
		core.log(lvl, "[" .. shark.modname .. "] " .. msg)
	end
end


mlog("action", "v" .. version_full .. " loading ...")


local mobname = "creatures:shark"
local scripts = {
	"settings",
	"items",
}

for _, script in ipairs(scripts) do
	dofile(shark.modpath .. "/" .. script .. ".lua")
end


local spawn_nodes = {"default:sand", "default:desert_sand", "default:clay"}
if core.global_exists("ethereal") then
	table.insert(spawn_nodes, "ethereal:seaweed")
end

local shark_def = {
	name = ":creatures:shark",
	nametag = creatures.feature_nametags and S("Shark") or nil,
	stats = {
		hp = 15, -- TODO: add setting to change
		--hp_min = 10,
		--hp_max = 15,
		hostile = true,
		lifetime = 600, -- 10 minutes
		can_jump = 0,
		can_swim = true,
	},
	-- FIXME:
	-- - shark moves on land after being attacked
	-- - shark doesn't attack until attacked
	-- - shark floats into air when attacked
	modes = {
		idle = {
			chance = 0.1,
			duration = 30,
			moving_speed = 0,
		},
		follow = {
			chance = 0.1,
			duration = 120,
			moving_speed = 2,
		},
		attack = {
			chance = 0.8,
			moving_speed = 3,
		},
	},
	model = {
		mesh = "shark.b3d",
		textures = {"shark_mesh.png"},
		collisionbox = {-0.38, -0.25, -0.38, 0.38, 0.25, 0.38},
		--rotation = 0.0,
		animations = {
			idle = {
				start = 1,
				stop = 80,
				speed = 24,
			},
			follow = {
				start = 80,
				stop = 160,
				speed = 24,
			},
			attack = {
				start = 80,
				stop = 160,
				speed = 24,
			},
		},
	},
	drops = {
		{"shark:meat_raw", 3, 1.0},
		{"shark:tooth", {min=1, max=3}, 0.4},
		{"shark:skin", 1, 0.4},
	},
	combat = {
		attack_damage = 6,
		--attack_speed = 1.0,
		attack_radius = 2.0,
		--search_enemy = ,
		--search_timer = ,
		search_radius = 10.0,
		--search_type = ,
	},
	spawning = {
		abm_nodes = {
			spawn_on = spawn_nodes,
			neighbors = {"default:water_source", "default:water_flowing",},
		},
		abm_interval = shark.interval,
		abm_chance = shark.chance,
		--max_number = 1,
		number = 1,
		time_range = {min=shark.min_time, max=shark.max_time},
		light = {min=shark.min_light, max=shark.max_light},
		height_limit = {min=shark.min_height, max=shark.max_height},
	},
}

creatures.register_mob(shark_def)

if core.global_exists("asm") then
	asm.addEgg({
		name = "shark",
		inventory_image = "shark_inv.png",
		spawn = mobname,
		ingredients = "shark:tooth",
	})
end


mlog("action", "v" .. version_full .. " loaded")
