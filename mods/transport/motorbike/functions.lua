local function random_string(length, charcode_start, charcode_end)
	local text = ""
	if length <= 0 then return text end
	for _ = 1, length do
		text = text .. string.char(math.random(charcode_start, charcode_end))
	end
	return text
end

local function random_letters(length)
	-- 65 - 90 is the ASCII range for A-Z
	return random_string(length, 65, 90)
end

local function random_digits(length)
	-- 48 - 57 is the ASCII range for 0-9
	return random_string(length, 48, 57)
end

local function license_plate() return random_letters(3) .. "-" .. random_digits(3) end

function biker.get_plate(name)
	-- TODO make configurable
	local custom_plates = {
		Jely = { "Jely-" .. random_digits(2), license_plate() },
		Elkien = { "Elk-" .. random_digits(3), license_plate(), "Sparks-" .. random_digits(3) },
		Bob12 = {
			"Bob-" .. random_digits(3),
			"Boi-" .. random_digits(3),
			"MB-" .. random_digits(4),
			"N1nja-" .. random_digits(3),
			license_plate()
		},
		Extex = {
			"Ex-" .. random_digits(4),
			"Bullet-" .. random_digits(2),
			license_plate(),
			"3xt3x-" .. random_digits(2)
		},
		Merlok = {
			"Mer-" .. random_digits(3),
			"Nipe-" .. random_digits(2),
			"M3RL0k-" .. random_digits(2),
			"N1P3-" .. random_digits(2),
			license_plate(),
			"Snoopy-" .. random_digits(3)
		},
		Nipe = { "Nipe-" .. random_digits(2), "Snoopy-" .. random_digits(3), license_plate() },
		Queen_Vibe = { "QV-" .. random_digits(3), "Vibe-" .. random_digits(2), license_plate() },
		Melkor = {
			"Creator",
			"ModelKing",
			"Melkor",
			license_plate()
		},
		Hype = { "Hobo-" .. random_digits(2), "Hyper-" .. random_digits(1), license_plate() },
		AidanLCB = { "LCB-" .. random_digits(3), license_plate(), "Gold-" .. random_digits(3) },
		irondude = {
			"Iron-" .. random_digits(3),
			license_plate(),
			"Fox-" .. random_digits(3),
			"cndl-" .. random_digits(3)
		}
	}
	if custom_plates[name] and biker.custom_plates then
		return custom_plates[name][math.random(#custom_plates[name])]
	end
	return license_plate()
end

player_api.register_model("motorbike_biker.b3d", {
	animation_speed = 30,
	textures = { "character.png", "blank.png" },
	animations = {
		-- Standard animations.
		stand = { x = 0, y = 79 },
		lay = { x = 162, y = 166 },
		walk = { x = 168, y = 187 },
		mine = { x = 189, y = 198 },
		walk_mine = { x = 200, y = 219 },
		sit = { x = 81, y = 160 }
	},
	collisionbox = {
		-0.3,
		0,
		-0.3,
		0.3,
		1.7,
		0.3
	},
	stepheight = 0.6,
	eye_height = 1.4699999999
})

local function repair(num, p)
	p = p or 3
	return math.floor(num * math.pow(10, p) + 0.5) / math.pow(10, p)
end

local function node_is(pos)
	local nodename = minetest.get_node(pos).name
	if nodename == "air" then return "air" end
	for _, group in ipairs{"liquid", "walkable", "crumbly"} do
		if minetest.get_item_group(nodename, group) ~= 0 then
			return group
		end
	end
	return "other"
end

local function shortAngleDist(a0, a1)
	local max = math.pi * 2
	local da = (a1 - a0) % max
	return 2 * da % max - da
end

local function angleLerp(a0, a1, t)
	local result = repair(a0 + shortAngleDist(a0, a1) * t)
	if math.floor(result) == a1 then return a1 end
	return result
end

local function get_sign(number)
	if not number then
		return 0
	end
	if number > 0 then
		return 1
	elseif number < 0 then
		return -1
	else
		return 0
	end
end

local function get_velocity(speed, yaw, velocity_y)
	local x = -math.sin(yaw) * speed
	local z = math.cos(yaw) * speed
	return { x = x, y = velocity_y, z = z }
end

local function get_speed(velocity) return math.sqrt(velocity.x ^ 2 + velocity.z ^ 2) end

function biker.turn_check(lerp, dest, range)
	if math.floor(lerp) <= dest - math.rad(90) - range then return true end
	if math.floor(lerp) >= dest - math.rad(90) + range then return true end
	return false
end

function biker.clamp(value, min, max) return math.min(math.max(value, min), max) end

function biker.dist(v1, v2)
	-- if v1 - v2 > -math.rad(45) and v1 - v2 < math.rad(45) then return v1 - v2 end
	return biker.clamp(-shortAngleDist(v1, v2), math.rad(-55), math.rad(55))
end
local function force_detach(player, leave)
	local attached_to = player:get_attach()
	if not player:is_player() then return end
	if attached_to then
		local entity = attached_to:get_luaentity()
		assert(entity.driver == player)
		entity.driver = nil
		player:set_detach()
		player:set_eye_offset({ x = 0, y = 0, z = 0 }, { x = 0, y = 0, z = 0 })
		if entity.info and not leave then player_api.set_model(player, entity.info.model) end
	end
end

function biker.detach(player)
	force_detach(player)
	player_api.player_attached[player:get_player_name()] = false
	player_api.set_animation(player, "stand", 30)
end

function biker.wheelspeed(bike)
	if not bike then return end
	if not bike.object then return end
	if not bike.object:getvelocity() then return end
	local direction = 1
	if bike.v then direction = get_sign(bike.v) end
	local v = get_speed(bike.object:get_velocity())
	local fps = v * 4
	bike.object:set_animation({ x = 1, y = 20 }, fps * direction, 0, true)
	if v ~= 0 then
		local i = 16
		while true do
			if i / fps > 1 then i = i / 2
			else break end
		end
		minetest.after(i / fps, biker.wheelspeed, bike)
	end
end

function biker.attach(entity, player)
	local attach_at, eye_offset = {}, {}
	if not entity then return end
	if entity.driver then return end
	if not player:is_player() then return end
	if not entity.driver_attach_at then entity.driver_attach_at = { x = 0, y = 1.1, z = 0.9 } end
	if not entity.driver_eye_offset then entity.driver_eye_offset = { x = 0, y = -2.2, z = 0.3 } end
	attach_at = entity.driver_attach_at
	eye_offset = entity.driver_eye_offset
	entity.driver = player
	local props = player:get_properties()
	entity.info = {}
	entity.info.model = player_api.get_animation(player).model
	if props.textures[2] == nil then props.textures[2] = "blank.png" end
	force_detach(player)
	player:set_attach(entity.object, "", attach_at, entity.player_rotation)
	player_api.player_attached[player:get_player_name()] = true
	player_api.set_model(player, "motorbike_biker.b3d")
	player:set_eye_offset(eye_offset, { x = 0, y = 0, z = 0 })
	player:set_look_yaw(entity.object:getyaw())
end

local timer = 0

function biker.drive(entity, dtime)
	timer = timer + dtime
	local rot_steer, rot_view = math.pi / 2, 0
	local acce_y = 2
	local velo = entity.object:getvelocity()
	entity.v = get_speed(velo) * get_sign(entity.v)
	-- process controls
	if entity.driver then
		if not entity.driver:is_player() then return end
		if entity.v then
			local newv = entity.object:getvelocity()
			if not entity.crash then entity.crash = false end
			local crash = false
			if math.abs(entity.lastv.x) > 5 and newv.x == 0 then crash = true end
			if math.abs(entity.lastv.y) > 10 and newv.y == 0 then crash = true end
			if math.abs(entity.lastv.z) > 5 and newv.z == 0 then crash = true end
			if crash and not entity.crash then
				entity.crash = true
				minetest.after(0.5, function() entity.crash = false end)
				return
			end
		end
		if not entity.wheelie then entity.wheelie = 0 end
		if not entity.lastv then entity.lastv = { x = 0, y = 0, z = 0 } end
		local driverlook = entity.driver:get_look_yaw()
		local rots = entity.object:get_rotation()
		local j = rots.y
		local k = rots.x
		local newrot = j
		local rrot = driverlook - rot_steer
		local ctrl = entity.driver:get_player_control()
		if ctrl.up and not ctrl.sneak then
			if get_sign(entity.v) >= 0 then entity.v = entity.v + biker.acceleration / 10
			else entity.v = entity.v + biker.acceleration / 10 end
		elseif ctrl.down then
			if biker.max_reverse == 0 and entity.v == 0 then return end
			if get_sign(entity.v) < 0 then entity.v = entity.v - biker.acceleration / 10
			else entity.v = entity.v - biker.braking / 10 end
		end
		if ctrl.down and ctrl.sneak and not ctrl.jump and biker.turn_check(angleLerp(newrot, rrot, biker.turn_power) % math.rad(360), rrot, 3.2) then
			if get_sign(entity.v) < 0 then entity.v = entity.v - biker.acceleration / 10
			elseif get_sign(entity.v) > 0 and entity.v > biker.max_speed / 10 - 1 then
				entity.v = entity.v - biker.braking / 10
				minetest.sound_play("motorbike_screech", { max_hear_distance = 48, gain = 0.5, object = entity.object })
				local num = 1
				local pos = entity.object:getpos()
				local d = 0.2
				for _ = 0, 20, 1 do
					local time = math.random(1, 2)
					minetest.add_particle{
						pos = { x = pos.x + math.random(-d, d), y = pos.y + math.random(0, d), z = pos.z + math.random(-d, d) },
						velocity = { x = math.random(-num, num), y = math.random(0, num), z = math.random(-num, num) },
						acceleration = { x = math.random(-num, num), y = math.random(0, num), z = math.random(-num, num) },
						expirationtime = time,
						--glow = 20,
						size = math.random(10, 20),
						collisiondetection = false,
						vertical = false,
						texture = "motorbike_burnout.png",
						animation = {
							type = "vertical_frames",
							aspect_w = 64,
							aspect_h = 64,
							length = time
						}
					}
				end
			end
		end
		local l = rots.z
		if ctrl.jump and entity.v > biker.max_speed / 3 then
			entity.driver:set_eye_offset({ x = 0, y = -6, z = 0 }, { x = 0, y = 0, z = 0 })
			entity.wheelie = repair(angleLerp(k, 45, 0.1))
			l = angleLerp(l, 0, 0.07)
			entity.object:set_rotation{ x = repair(entity.wheelie), y = repair(j), z = repair(l, 3) }
		elseif not ctrl.jump or entity.v < biker.max_speed / 3 then
			entity.driver:set_eye_offset({ x = 0, y = -7, z = 0 }, { x = 0, y = 0, z = 0 })
			if entity.v > 1.1999999999 and entity.wheelie == 0 then
				newrot = angleLerp(newrot, rrot, biker.turn_power) % math.rad(360)
				l = biker.dist(newrot + math.rad(360), rrot + math.rad(360))
			elseif entity.v < 1.1999999999 then l = angleLerp(rots.z, 0, 0.2) end
			entity.wheelie = repair(angleLerp(k, 0, 0.1))
			entity.object:set_rotation{ x = entity.wheelie, y = newrot, z = repair(l, 3) }
		end
		if not ctrl.sneak then
			local s = get_sign(entity.v)
			entity.v = entity.v - 0.04 * s
			if s ~= get_sign(entity.v) then
				entity.object:set_velocity{ x = 0, y = 0, z = 0 }
				entity.v = 0
				return
			end
		end
	elseif not entity.driver then
		entity.object:set_rotation{ x = entity.object:get_rotation().x, y = entity.object:get_rotation().y, z = 0 }
	end
	-- Stop!
	if not entity.driver then
		local s = get_sign(entity.v)
		entity.v = entity.v - 0.04 * s
		if s ~= get_sign(entity.v) then
			entity.object:set_velocity{ x = 0, y = 0, z = 0 }
			entity.v = 0
			return
		end
	end
	-- enforce speed limit forward and reverse
	local p = entity.object:getpos()
	local ni = node_is(p)
	local uni = node_is(vector.add(p, { x = 0, y = -1, z = 0 }))
	local max_spd = biker.max_reverse
	if get_sign(entity.v) >= 0 and ni ~= "liquid" then
		if uni == "crumbly" and uni ~= "other" then max_spd = biker.crumbly_spd
		else max_spd = biker.max_speed end
	elseif ni == "liquid" then max_spd = 2 end
	if uni == "crumbly" and uni ~= "other" then max_spd = biker.crumbly_spd end
	if math.abs(entity.v) > max_spd then entity.v = entity.v - get_sign(entity.v) end
	-- Set position, velocity and acceleration
	local new_velo = { x = 0, y = 0, z = 0 }
	local new_acce = { x = 0, y = -9.8, z = 0 }
	p.y = p.y - 0.5
	new_velo = get_velocity(entity.v, entity.object:getyaw() - rot_view, velo.y)
	new_acce.y = new_acce.y + acce_y
	entity.object:set_velocity(new_velo)
	entity.object:set_acceleration(new_acce)
	if entity.lastv and vector.length(entity.lastv) > 0 and math.abs(entity.v) == 0 then
		biker.wheelspeed(entity)
		if entity.wheelsound then minetest.sound_fade(entity.wheelsound, 30, 0) end
		if entity.windsound then minetest.sound_fade(entity.windsound, 30, 0) end
	end
	if entity.lastv and vector.length(entity.lastv) == 0 and math.abs(entity.v) > 0 then biker.wheelspeed(entity) end
	entity.lastv = entity.object:getvelocity()
	-- sound
	if entity.v > 0 and entity.driver ~= nil then
		entity.timer1 = entity.timer1 + dtime
		if entity.timer1 > 0.1 then
			local rpm = 1
			if entity.v > 7 then rpm = entity.v / 7 + 0.4
			elseif entity.v > 3 then rpm = entity.v / 3 + 0.3
			else rpm = entity.v / 3 + 0.2 end
			minetest.sound_play("motoengine", { max_hear_distance = 48, pitch = rpm + 0.1, object = entity.object })
			entity.timer1 = 0
		end
	end
	entity.timer2 = entity.timer2 + dtime
	local abs_v = math.abs(entity.v)
	if entity.timer2 > 1.5 - abs_v / max_spd * 1.1 then
		if abs_v > 0.2 then
			if math.abs(velo.y) < 0.1 then
				entity.wheelsound = minetest.sound_play("tyresound", {
					max_hear_distance = 48,
					object = entity.object,
					pitch = 1.1 + abs_v / max_spd * 0.6,
					gain = 0.5 + abs_v / max_spd * 2
				})
			elseif entity.windsound then minetest.sound_fade(entity.windsound, 30, 0) end
			entity.windsound = minetest.sound_play("wind", {
				max_hear_distance = 10,
				object = entity.object,
				pitch = 1 + abs_v / max_spd * 0.6,
				gain = 0 + abs_v / max_spd * 4
			})
		end
		entity.timer2 = 0
	end
end

minetest.register_on_leaveplayer(function(player) force_detach(player, true) end)
minetest.register_on_dieplayer(biker.detach)
