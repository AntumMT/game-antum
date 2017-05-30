
local S = mobs.intllib

mobs:register_mob("desert_life:ostrich", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 2,
	damage = 2,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.4, -0.5, -0.4, 0.4, 0.75, 0.4},
	visual = "mesh",
	mesh = "dl_ostrich.b3d",
	textures = {
		{'dl_ostrich.png'},
	},
    visual_size = {x=9, y=9},
	makes_footstep_sound = true,
--	sounds = {
--		random = "mobs_chicken",
--	},
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "mobs:chicken_raw", chance = 1, min = 2, max = 6},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -8,
	fear_height = 5,
	animation = {
		speed_normal = 15,
		speed_run = 30,
		stand_start = 0,
		stand_end = 60,
		walk_start = 180,
		walk_end = 229,
		run_start = 180,
		run_end = 229,
		punch_start = 65,
		punch_end = 90,
		punch2_start = 95,
		punch2_end = 125,
	},
	follow = {"farming:seed_wheat", "farming:seed_cotton"},
	view_range = 5,
   replace_what = {'group:flora', 'group:plant'},
   replace_with = 'air',
   replace_rate = 1,
})

mobs:register_spawn("desert_life:ostrich",
	{"default:desert_sand", "default:desert_stone"}, 20, 10, 1500, 1, 31000, true)

mobs:register_egg("desert_life:ostrich", S("Ostrich"), "dl_ostrich_inv.png", 0)
