
spidermob = {}
cmer_spider.modname = core.get_current_modname()
cmer_spider.modpath = core.get_modpath(cmer_spider.modname)

dofile(cmer_spider.modpath .. "/settings.lua")
--dofile(cmer_spider.modpath .. "/api.lua")


local spider_drops = {}
if core.registered_items["farming:string"] then
	table.insert(spider_drops, {"farming:string", {min=1, max=3}, chance=0.5})
end


creatures.register_mob({
	name = ":creatures:spider",
	nametag = creatures.feature_nametags and "Spider" or nil,
	stats = {
		hp = 30,
		hostile = true,
		lifetime = cmer_spider.lifetime,
		can_jump = 1,
	},
	modes = {
		idle = {chance=0.7, duration=3.0,},
		walk = {chance=0.3, duration=5.5, moving_speed=1,},
		--follow = {chance=0, moving_speed=3, radius=15,},
		attack = {chance=0, moving_speed=3},
	},
	model = {
		mesh = "spider_model.x",
		textures = {"spidermob_spider.png"},
		collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
		scale = {x=7, y=7},
		rotation = -90.0,
		animations = {
			idle = {start=1, stop=1, speed=15,},
			walk = {start=20, stop=40, speed=15,},
			--follow = {start=20, stop=40, speed=15,},
			attack = {start=50, stop=90, speed=15,},
		},
	},
	sounds = {
		on_death = {name="mobs_howl", gain=1.0,},
	},
	drops = spider_drops,
	combat = {
		attack_damage = 3,
		attack_radius = 1.3,
		search_enemy = true,
		search_radius = 15,
		search_type = "player",
	},
	spawning = {
		abm_nodes = {
			spawn_on = {
				"group:leaves",
				"default:junglegrass",
				"default:jungletree",
				"default:dirt_with_grass",
			},
		},
		abm_interval = cmer_spider.spawn_interval,
		abm_chance = cmer_spider.spawn_chance,
		max_number = 3,
		number = {min=1, max=2},
		time_range = {min=0, max=23999},
		light = {min=0, max=core.LIGHT_MAX},
		height_limit = {min=-500, max=31000},
	},
})

--[[
local spider_drops = {}
if core.registered_items["farming:string"] then
	table.insert(spider_drops, {
		name = "farming:string",
		chance = 2,
		min = 1,
		max = 3,
	})
end


spidermob:register_mob("spidermob:spider", {
	type = "monster",
	hp_min = 15,
	hp_max = 30,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	textures = {"spidermob_spider.png"},
	visual_size = {x=7,y=7},
	visual = "mesh",
	mesh = "spider_model.x",
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	armor = 200,
	damage = 3,
	drops = spider_drops,
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 50,
		punch_end = 90,
	},
	jump = true,
	step = 1,
	blood_texture = "spidermob_blood.png",
	sounds = {
		war_cry = "mobs_eerie",
		death = "mobs_howl",
		attack = "mobs_oerkki_attack",
	},
})

spidermob:register_spawn(
	"spidermob:spider",
	{
		"default:junglegrass",
		"default:jungleleaves",
		"default:jungletree",
	},
	20, -10, 7500, 3, 31000)
]]
