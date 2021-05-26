--= Ghost for Creatures MOB-Engine (cme) =--
-- Copyright (c) 2015-2016 BlockMen <blockmen2015@gmail.com>
--
-- init.lua
--
-- This software is provided 'as-is', without any express or implied warranty. In no
-- event will the authors be held liable for any damages arising from the use of
-- this software.
--
-- Permission is granted to anyone to use this software for any purpose, including
-- commercial applications, and to alter it and redistribute it freely, subject to the
-- following restrictions:
--
-- 1. The origin of this software must not be misrepresented; you must not
-- claim that you wrote the original software. If you use this software in a
-- product, an acknowledgment in the product documentation is required.
-- 2. Altered source versions must be plainly marked as such, and must not
-- be misrepresented as being the original software.
-- 3. This notice may not be removed or altered from any source distribution.
--

cmer_ghost = {}
cmer_ghost.modname = core.get_current_modname()
cmer_ghost.modpath = core.get_modpath(cmer_ghost.modname)

dofile(cmer_ghost.modpath .. "/settings.lua")


local def = {
	-- general
	name = ":creatures:ghost",
	nametag = creatures.feature_nametags and "Ghost" or nil,
	stats = {
		hp = 12,
		lifetime = cmer_ghost.lifetime,
		can_burn = true,
		can_fly = true,
		has_falldamage = false,
		has_knockback = true,
		light = {min = 0, max = 8},
		hostile = true,
	},

	modes = {
		idle = {chance = 0.65, duration = 3, update_yaw = 6},
		fly = {chance = 0.25, duration = 2.5, moving_speed = 2, max_height = 25, target_offset = 2.1},
		fly_2 = {chance = 0.1, duration = 4, moving_speed = 1.6, update_yaw = 3, max_height = 25, target_offset = 2.5},
		-- special modes
		attack = {chance = 0, moving_speed = 2.6},
	},

	model = {
		mesh = "creatures_ghost.b3d",
		textures = {"creatures_ghost.png"},
		collisionbox = {-0.22, 0, -0.22, 0.22, 1.2, 0.22},
		rotation = -90.0,
		animations = {
			idle = {start = 0, stop = 80, speed = 15},
			fly = {start = 102, stop = 122, speed = 12},
			fly_2 = {start = 102, stop = 122, speed = 10},
			attack = {start = 102, stop = 122, speed = 25},
			death = {start = 81, stop = 101, speed = 28, loop = false, duration = 1.32},
		},
	},

	sounds = {
			on_damage = {name = "creatures_ghost_hit", gain = 0.4, distance = 10},
			on_death = {name = "creatures_ghost_death", gain = 0.7, distance = 10},
			random = {
				idle = {name = "creatures_ghost", gain = 0.5, distance = 10, time_min = 23},
			},
	},

	combat = {
		attack_damage = 2,
		attack_speed = 1.1,
		attack_radius = 0.9,

		search_enemy = true,
		search_timer = 2,
		search_radius = 12,
		search_type = "player",
	},

	spawning = {
		abm_nodes = {
			spawn_on = {"default:gravel", "default:dirt_with_grass", "default:dirt",
				"group:leaves", "group:sand"},
		},
		abm_interval = cmer_ghost.spawn_interval,
		abm_chance = cmer_ghost.spawn_chance,
		max_number = 1,
		number = 1,
		time_range = {min = 18500, max = 4000},
		light = {min = 0, max = 8},
		height_limit = {min = 0, max = 80},

		spawner = {
			description = "Ghost Spawner",
			range = 8,
			number = 6,
			light = {min = 0, max = 8},
		}
	},

	--drops = {
	--  {"creatures:rotten_flesh", {min = 1, max = 2}, chance = 0.7},
	--},

}

creatures.register_mob(def)

if core.global_exists("asm") then
	asm.addEgg({
		name = "ghost",
		inventory_image = "creatures_ghost_inv.png",
		spawn = "creatures:ghost",
	})
end
