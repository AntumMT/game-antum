
cmer.register_mob({
	name = "cmer:skeleton",
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
		mesh = "creatures_zombie.b3d",
		textures = {"cmer_skeleton_mesh.png"},
		collisionbox = {-0.25, -0.01, -0.25, 0.25, 1.65, 0.25},
		rotation = -90.0,
    animations = {
      idle = {start=0, stop=80, speed=15},
      walk = {start=102, stop=122, speed=15.5},
      attack = {start=102, stop=122, speed=25},
      death = {start=81, stop=101, speed=28, loop=false, duration= 2.12},
    },
	},
	sounds = {
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
		title = "Skeleton",
		inventory_image = "cmer_skeleton_inv.png",
		spawn = "cmer:skeleton",
		ingredients = "cmer:bone",
	})
end


core.register_craftitem(":cmer:bone", {
	description = "Bone",
	inventory_image = "cmer_skeleton_bone.png",
	stack_max = default_stack_max,
})
