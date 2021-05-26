
-- base specs
local zombie = {
	modes = {
		idle = {chance=0.7, duration=3, update_yaw=6},
		walk = {chance=0.3, duration=5.5, moving_speed=1.5},
		attack = {chance=0, moving_speed=2.5},
	},
	mesh = "creatures_zombie.b3d",
	collisionbox = {-0.25, -0.01, -0.25, 0.25, 1.65, 0.25},
	rotation = -90.0,
	animations = {
		idle = {start=0, stop=80, speed=15},
		walk = {start=102, stop=122, speed=15.5},
		attack = {start=102, stop=122, speed=25},
		death = {start=81, stop=101, speed=28, loop=false, duration=2.12},
	},
	sounds = {
		on_damage = {name="creatures_zombie_hit", gain=0.4, distance=10},
		on_death = {name="creatures_zombie_death", gain=0.7, distance=10},
		swim = {name="creatures_splash", gain=1.0, distance=10},
		random = {
			idle = {name="creatures_zombie", gain=0.7, distance=12},
		},
	},
	drops = {
		{"creatures:rotten_flesh", {min=1, max=2}, chance=0.7},
	},
	nodes = {
		spawn_on = {"default:stone", "default:dirt_with_grass", "default:dirt",
			"default:cobblestone", "default:mossycobble", "group:sand"},
	},
}


creatures.register_mob({
	-- general
	name = ":creatures:zombie",
	nametag = creatures.feature_nametags and "Zombie" or nil,
	stats = {
		hp = 20,
		lifetime = cmer_zombie.lifetime,
		can_jump = 1,
		can_swim = true,
		can_burn = true,
		has_falldamage = true,
		has_knockback = true,
		light = {min=0, max=8},
		hostile = true,
	},

	modes = zombie.modes,

	model = {
		mesh = zombie.mesh,
		textures = {"creatures_zombie.png"},
		collisionbox = zombie.collisionbox,
		rotation = zombie.rotation,
		animations = zombie.animations,
	},

	sounds = zombie.sounds,

	combat = {
		attack_damage = 1,
		attack_speed = 0.6,
		attack_radius = 1.1,

		search_enemy = true,
		search_timer = 2,
		search_radius = 12,
		search_type = "player",
	},

	spawning = {
		abm_nodes = zombie.nodes,
		abm_interval = cmer_zombie.spawn_interval,
		abm_chance = cmer_zombie.spawn_chance,
		max_number = 1,
		number = 2,
		light = {min=0, max=8},
		height_limit = {min=-200, max=50},

		spawner = {
			description = "Zombie Spawner",
			range = 8,
			number = 6,
			light = {min=0, max=8},
		}
	},

	drops = zombie.drops,
})

if core.global_exists("asm") then
	asm.addEgg({
		name = "zombie",
		spawn = "creatures:zombie",
		inventory_image = "creatures_egg_zombie.png",
		ingredient = "creatures:rotten_flesh",
	})
end


-- harder zombie
creatures.register_mob({
	name = ":creatures:zombie_manic",
	nametag = creatures.feature_nametags and "Manic Zombie" or nil,

	stats = {
		hp = 75,
		lifetime = cmer_zombie.lifetime,
		can_jump = 1,
		can_swim = true,
		can_burn = true,
		has_falldamage = true,
		has_knockback = true,
		light = {min=0, max=8},
		hostile = true,
	},

	modes = zombie.modes,

	model = {
		mesh = zombie.mesh,
		textures = {"creatures_zombie_manic.png"},
		collisionbox = zombie.collisionbox,
		rotation = zombie.rotation,
		animations = zombie.animations,
	},

	sounds = zombie.sounds,

	combat = {
		attack_damage = 15,
		attack_speed = 0.6,
		attack_radius = 1.1,

		search_enemy = true,
		search_timer = 2,
		search_radius = 20,
		search_type = "player",
	},
	drops = zombie.drops,

	spawning = {
		abm_nodes = zombie.nodes,
		abm_interval = cmer_zombie.spawn_interval + math.floor(cmer_zombie.spawn_interval / 2),
		abm_chance = cmer_zombie.spawn_chance + math.floor(cmer_zombie.spawn_chance / 2),
		max_number = 1,
		number = 1,
		light = {min=0, max=8},
		height_limit = {min=-32000, max=500},
	},
})
