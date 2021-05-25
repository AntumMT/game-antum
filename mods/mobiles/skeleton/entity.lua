
local S = core.get_translator(cmer_skeleton.modname)


local zombie_model = nil
local zombie_sounds = {}
local anim_walk = {start=102, stop=122, speed=15.5}
local anim_attack = {start=102, stop=122, speed=25}

if core.get_modpath("cmer_zombie") or core.get_modpath("zombie") then
	zombie_model = "creatures_zombie.b3d"
	zombie_sounds.on_death = {name="creatures_zombie_death", gain=0.7, distance=10}
end

-- use player model if zombie not installed
if not zombie_model then
	if not core.get_modpath("player_api") then
		error("Compatible model not found (requires one of the following mods: \"cmer_zombie\", \"zombie\", \"player_api\")")
	end

	zombie_model = "character.b3d"
	-- I don't know what the correct animations for default player model are
	--anim_walk = {start=102, stop=122, speed=15.5}
	--anim_attack = {start=102, stop=122, speed=25}

	cmer_skeleton.log("warning", "using \"" .. zombie_model .. "\" model, may not look right")
end


local mob_name = "creatures:skeleton"

creatures.register_mob({
	name = ":" .. mob_name,
	nametag = creatures.feature_nametags and S("Skeleton") or nil,
	stats = {
		hp = 55,
		hostile = true,
		lifetime = cmer_skeleton.lifetime,
		can_jump = 1,
		can_swim = true,
		has_kockback = true,
	},
	modes = {
		idle = {chance=0.3,},
		walk = {chance=0.7, moving_speed=1,},
		attack = {chance=0, moving_speed=3,},
	},
	model = {
		mesh = zombie_model,
		textures = {"cmer_skeleton_mesh.png"},
		collisionbox = {-0.25, -0.01, -0.25, 0.25, 1.65, 0.25},
		rotation = -90.0,
    animations = {
      idle = {start=0, stop=80, speed=15},
      walk = anim_walk,
      attack = anim_attack,
      death = {start=81, stop=101, speed=28, loop=false, duration= 2.12},
    },
	},
	sounds = {
		on_death = zombie_sounds.on_death,
		random = {
			idle = {name="cmer_skeleton_bones", gain=1.0,},
			walk = {name="cmer_skeleton_bones", gain=1.0,},
			attack = {name="cmer_skeleton_bones", gain=1.0,},
		},
	},
	drops = {
		{"cmer:bone", 1, chance=1},
	},
	combat = {
		attack_damage = 13,
		attack_radius = 2.0,
		search_enemy = true,
		search_type = "player",
		search_radius = 20,
	},
	spawning = {
		abm_nodes = {
			spawn_on = {
				"default:sand",
				"default:desert_sand",
				"default:stone",
				"default:desert_stone",
			},
		},
		abm_interval = cmer_skeleton.spawn_interval,
		abm_chance = cmer_skeleton.spawn_chance,
		max_number = 1,
		number = {min=1, max=2},
		time_range = {min=0, max=23999},
		light = {min=0, max=8},
		height_limit = {min=-31000, max=31000},
	},
})


if core.global_exists("asm") then
	asm.addEgg({
		name = "skeleton",
		title = S("Skeleton"),
		inventory_image = "cmer_skeleton_inv.png",
		spawn = mob_name,
		ingredients = "cmer:bone",
	})
end
if not core.registered_items["creatures:skeleton"] then
	core.register_alias("creatures:skeleton", "spawneggs:skeleton")
end


core.register_craftitem(":cmer:bone", {
	description = S("Bone"),
	inventory_image = "cmer_skeleton_bone.png",
	stack_max = 99,
})
if not core.registered_items["creatures:bone"] then
	core.register_alias("creatures:bone", "cmer:bone")
end
