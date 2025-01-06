
local S = mobs.intllib

mobs:register_mob("desert_life:armadillo", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 2,
	damage = 1,
	hp_min = 5,
	hp_max = 10,
	armor = 75,
	collisionbox = {-0.35, -0.5, -0.35, 0.35, 0.0, 0.35},
	visual = "mesh",
	mesh = "dl_armadillo.b3d",
	textures = {
		{'dl_armadillo_1.png'},
        {'dl_armadillo_2.png'},
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
		{name = "mobs:meat_raw", chance = 1, min = 1, max =1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -8,
	fear_height = 5,
	animation = {
		speed_normal = 2,
		speed_run = 8,
		stand_start = 45,
		stand_end = 70,
		walk_start = 0,
		walk_end = 40,
		punch_start = 75,
		punch_end = 95,
	},
	follow = {"farming:seed_wheat", "farming:seed_cotton"},
	view_range = 5,
   replace_what = {'group:flora', 'group:plant'},
   replace_with = 'air',
   replace_rate = 10,
})

mobs:spawn({
   name = 'desert_life:armadillo',
   nodes = {'default:desert_sand', 'default:desert_stone'},
   min_height = 0,
   max_height = 100,
   interval = 60,
   chance = 8000,
   active_object_count = 5,
})
