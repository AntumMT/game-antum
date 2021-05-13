--[[
  This is the 'mobs_m:velociraptor' extracted from 'mobs_farlands', part
  of the 'farlands' sub-game (https://forum.minetest.net/viewtopic.php?t=16921).
  
  License: LGPL / CC BY-SA (See: LICENSE.txt)
]]


local modname = core.get_current_modname()

core.log('info', 'MOD: ' .. modname .. ' loading ...')

local mob_name = 'mobs:' .. modname


-- MOBS REGISTRATION

local texture = modname
if core.settings:get_bool('mobs.velociraptor_feathered') then
	texture = texture .. '_feathered'
end

mobs:register_mob(':' .. mob_name, {
	type = 'monster',
	reach = 1.5,
	damage = 4,
	attack_type = 'dogfight',
	hp_min = 42,
	hp_max = 52,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 0.5, 0.4},
	runaway = true,
	pathfinding = true,
	visual = 'mesh',
	mesh = 'velociraptor.b3d',
	textures = {
		{'mobs_' .. texture .. '.png'},
	},
	blood_texture = 'mobs_blood.png',
	visual_size = {x=1.5, y=1.5},
	makes_footstep_sound = true,
	walk_velocity = 2.5,
	run_velocity = 3,
	jump = true,
	drops = {
		{name='mobs:meat_raw', chance=3, min=1, max=2},
	},
	on_activate = function(self)
		if math.random(1,5) == 1 then
		self.type = 'animal'
		end
	end,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 8,
	follow = {'mobs:meat_raw'},
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 18,
		walk_start = 45,
		walk_end = 65,
		stand_start = 16,
		stand_end = 42,
		run_start = 45,
		run_end = 65,
		punch_start = 1,
		punch_end = 16,
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end
		
		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})


-- SPAWNING

local interval = tonumber(core.settings:get('mobs.velociraptor_interval'))
local chance = tonumber(core.settings:get('mobs.velociraptor_chance'))
local min_light = tonumber(core.settings:get('mobs.velociraptor_min_light'))
local max_light = tonumber(core.settings:get('mobs.velociraptor_max_light'))
--local min_height = tonumber(core.settings:get('mobs.velociraptor_min_height'))
local max_height = tonumber(core.settings:get('mobs.velociraptor_max_height'))
local day_toggle = core.settings:get('mobs.velociraptor_spawn_time')

if interval == nil then
	interval = 30
end
if chance == nil then
	chance = 32000
end
if min_light == nil then
	min_light = 10
end
if max_light == nil then
	max_light = 14
end
if max_height == nil then
	max_height = 31000
end
if day_toggle ~= nil then
	if day_toggle == 'day' then
		day_toggle = true
	elseif day_toggle == 'night' then
		day_toggle = false
	else
		day_toggle = nil
	end
end

mobs:spawn({
	name = mob_name,
	nodes = {'default:junglegrass'},
	interval = interval,
	chance = chance,
	min_light = min_light,
	max_light = max_light,
	max_height = max_height,
	day_toggle = day_toggle,
	active_object_count = 2,
})

mobs:register_egg(':' .. mob_name, 'Velociraptor', 'wool_orange.png', 1)


core.log('info', 'MOD: ' .. modname .. ' loaded')
