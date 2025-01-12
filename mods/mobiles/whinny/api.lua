
local yaw = {}

local sounds_enabled = core.global_exists("sounds")
local sound_horse = sounds_enabled and sounds.horse
local sound_horse_snort = sounds_enabled and sounds.horse_snort
local sound_horse_neigh = sounds_enabled and sounds.horse_neigh
local sound_entity_hit = sounds_enabled and sounds.entity_hit

function whinny:register_mob(name, def)
	core.register_entity(name, {
		name = name,
		hp_min = def.hp_min,
		initial_properties = {
			hp_max = def.hp_max,
			physical = true,
			collisionbox = def.collisionbox,
			visual = def.visual,
			visual_size = def.visual_size,
			mesh = def.mesh,
			makes_footstep_sound = def.makes_footstep_sound
		},
		appetite = def.appetite,
		view_range = def.view_range,
		walk_velocity = def.walk_velocity,
		run_velocity = def.run_velocity,
		damage = def.damage,
		light_damage = def.light_damage,
		water_damage = def.water_damage,
		lava_damage = def.lava_damage,
		disable_fall_damage = def.disable_fall_damage,
		drops = def.drops,
		armor = def.armor,
		drawtype = def.drawtype,
		on_rightclick = def.on_rightclick,
		type = def.type,
		attack_type = def.attack_type,
		arrow = def.arrow,
		shoot_interval = def.shoot_interval,
		sounds = def.sounds,
		animation = def.animation,
		follow = def.follow,
		jump = def.jump or true,
		exp_min = def.exp_min or 0,
		exp_max = def.exp_max or 0,
		walk_chance = def.walk_chance or 50,
		attacks_monsters = def.attacks_monsters or false,
		group_attack = def.group_attack or false,
		step = def.step or 0,
		fov = def.fov or 120,
		passive = def.passive or false,

		stimer = 0,
		timer = 0,
		env_damage_timer = 0, -- only if state = "attack"
		attack = {player=nil, dist=nil},
		state = "stand",
		v_start = false,
		old_y = nil,
		lifetimer = 600,
		tamed = false,

		do_attack = function(self, player, dist)
			if self.state ~= "attack" then
				if self.sounds.war_cry then
					if math.random(0,100) < 90 then
						core.sound_play(self.sounds.war_cry, {object=self.object})
					end
				end

				self.state = "attack"
				self.attack.player = player
				self.attack.dist = dist
			end
		end,

		set_velocity = function(self, v)
			local yaw = self.object:get_yaw()
			if yaw then
				if self.drawtype == "side" then
					yaw = yaw + (math.pi / 2)
				end

				local x = math.sin(yaw) * -v
				local y = self.object:get_velocity().y
				local z = math.cos(yaw) * v

				for _, coord in ipairs({x, y, z}) do
					if core.is_nan(coord) then
						coord = 0
					end
				end

				self.object:set_velocity({x=x, y=y, z=z})
			end
		end,

		get_velocity = function(self)
			local v = self.object:get_velocity()
			if v then
				return (v.x^2 + v.z^2)^(0.5)
			end

			return 0.0
		end,

		in_fov = function(self,pos)
			-- checks if POS is in self's FOV
			local yaw = self.object:get_yaw()
			if self.drawtype == "side" then
				yaw = yaw + (math.pi / 2)
			end

			local vx = math.sin(yaw)
			local vz = math.cos(yaw)
			local ds = math.sqrt(vx^2 + vz^2)
			local ps = math.sqrt(pos.x^2 + pos.z^2)
			local d = {x = vx / ds, z = vz / ds}
			local p = {x = pos.x / ps, z = pos.z / ps}

			local an = (d.x * p.x) + (d.z * p.z)

			local a = math.deg(math.acos(an))

			if a > (self.fov / 2) then
				return false
			else
				return true
			end
		end,

		set_animation = function(self, type)
			if not self.animation then return end

			if not self.animation.current then
				self.animation.current = ""
			end

			if type == "stand" and self.animation.current ~= "stand" then
				if self.animation.stand_start and self.animation.stand_end and
						self.animation.speed_normal then
					self.object:set_animation(
						{
							x = self.animation.stand_start,
							y = self.animation.stand_end,
						},
						self.animation.speed_normal, 0)
					self.animation.current = "stand"
				end
			elseif type == "walk" and self.animation.current ~= "walk"  then
				if self.animation.walk_start and self.animation.walk_end and
						self.animation.speed_normal then
					self.object:set_animation(
						{
							x = self.animation.walk_start,
							y = self.animation.walk_end,
						},
						self.animation.speed_normal, 0)
					self.animation.current = "walk"
				end
			elseif type == "run" and self.animation.current ~= "run"  then
				if self.animation.run_start and self.animation.run_end and
						self.animation.speed_run then
					self.object:set_animation(
						{
							x = self.animation.run_start,
							y = self.animation.run_end,
						},
						self.animation.speed_run, 0)
					self.animation.current = "run"
				end
			elseif type == "punch" and self.animation.current ~= "punch"  then
				if self.animation.punch_start and self.animation.punch_end and
						self.animation.speed_normal then
					self.object:set_animation(
						{
							x = self.animation.punch_start,
							y = self.animation.punch_end,
						},
						self.animation.speed_normal, 0)
					self.animation.current = "punch"
				end
			end
		end,

		on_step = function(self, dtime)
			if self.type == "monster" and whinny.peaceful_only then
				self.object:remove()
				return
			end

			self.lifetimer = self.lifetimer - dtime

			-- RJK:
			if self.lifetimer <= 0 and not self.tamed and self.name ~= "whinny:ent" then
				local player_count = 0
				for _,obj in ipairs(core.get_objects_inside_radius(self.object:get_pos(), 10)) do
					if obj:is_player() then
						player_count = player_count+1
					end
				end

				if player_count == 0 and self.state ~= "attack" then
					core.log("action", "lifetimer expired, removed mob " .. self.name)
					self.object:remove()
					return
				end
			end

			if self.object:get_velocity().y > 0.1 then
				local yaw = self.object:get_yaw()
				if self.drawtype == "side" then
					yaw = yaw + (math.pi / 2)
				end

				local x = math.sin(yaw) * -2
				local z = math.cos(yaw) * 2

				if core.get_item_group(core.get_node(self.object:get_pos()).name, "water") ~= 0 then
					self.object:set_acceleration({x=x, y=1.5, z=z})
				else
					self.object:set_acceleration({x=x, y=-14.5, z=z})
				end
			else
				if core.get_item_group(core.get_node(self.object:get_pos()).name, "water") ~= 0 then
					self.object:set_acceleration({x=0, y=1.5, z=0})
				else
					self.object:set_acceleration({x=0, y=-14.5, z=0})
				end
			end

			if self.disable_fall_damage and self.object:get_velocity().y == 0 then
				if not self.old_y then
					self.old_y = self.object:get_pos().y
				else
					local d = self.old_y - self.object:get_pos().y
					if d > 5 then
						local damage = d-5
						self.object:set_hp(self.object:get_hp() - damage)
						if self.object:get_hp() == 0 then
							self.object:remove()
						end
					end

					self.old_y = self.object:get_pos().y
				end
			end

			self.timer = self.timer + dtime
			if self.state ~= "attack" then
				if self.timer < 1 then return end

				self.timer = 0
			end

			if sound_horse then
				if math.random(1, 500) == 1 then
					sound_horse({object=self.object})
				end
			end

			local do_env_damage = function(self)
			local pos = self.object:get_pos()
			local n = core.get_node(pos)

			if self.light_damage and self.light_damage ~= 0 and pos.y > 0 and
					core.get_node_light(pos) and core.get_node_light(pos) > 4 and
					core.get_timeofday() > 0.2 and core.get_timeofday() < 0.8 then
				self.object:set_hp(self.object:get_hp() - self.light_damage)
				if self.object:get_hp() == 0 then
					self.object:remove()
				end
			end

			if self.water_damage and self.water_damage ~= 0 and
					core.get_item_group(n.name, "water") ~= 0 then
				self.object:set_hp(self.object:get_hp() - self.water_damage)
				if self.object:get_hp() == 0 then
					self.object:remove()
				end
			end

			if self.lava_damage and self.lava_damage ~= 0 and
					core.get_item_group(n.name, "lava") ~= 0 then
				self.object:set_hp(self.object:get_hp() - self.lava_damage)
				if self.object:get_hp() == 0 then
					self.object:remove()
				end
			end
			end -- FIXME: missplaced end???

			self.env_damage_timer = self.env_damage_timer + dtime
			if self.state == "attack" and self.env_damage_timer > 1 then
				self.env_damage_timer = 0
				do_env_damage(self)
			elseif self.state ~= "attack" then
				do_env_damage(self)
			end

			-- FIND SOMEONE TO ATTACK
			if (self.type == "monster" or self.type == "barbarian") and
					whinny.enable_damage and self.state ~= "attack" then

				local s = self.object:get_pos()
				local inradius = core.get_objects_inside_radius(s, self.view_range)
				local player = nil
				local type = nil
				for _, oir in ipairs(inradius) do
					if oir:is_player() then
						player = oir
						type = "player"
					else
						local obj = oir:get_luaentity()
						if obj then
							player = obj.object
							type = obj.type
						end
					end

					if type == "player" or type == "npc" then
						local s = self.object:get_pos()
						local p = player:get_pos()
						local sp = s
						p.y = p.y + 1
						sp.y = sp.y + 1 -- aim higher to make looking up hills more realistic
						local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
						if dist < self.view_range and self.in_fov(self, p) then
							if core.line_of_sight(sp, p, 2) == true then
								self.do_attack(self, player, dist)
								break
							end
						end
					end
				end
			end

			-- NPC FIND A MONSTER TO ATTACK
			if self.type == "npc" and self.attacks_monsters and self.state ~= "attack" then
				local s = self.object:get_pos()
				local inradius = core.get_objects_inside_radius(s, self.view_range)
				for _, oir in pairs(inradius) do
					local obj = oir:get_luaentity()
					if obj then
						if obj.type == "monster" or obj.type == "barbarian" then
							-- attack monster
							local p = obj.object:get_pos()
							local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
							print("attack monster at "..core.pos_to_string(obj.object:get_pos()))
							self.do_attack(self, obj.object, dist)
							break
						end
					end
				end
			end

			local follow = false
			local follow_multiple = type(self.follow) == "table"

			if follow_multiple then
				follow = #self.follow > 0
			else
				follow = self.follow ~= ""
			end

			if follow and not self.following then
				for _, player in pairs(core.get_connected_players()) do
					local s = self.object:get_pos()
					local p = player:get_pos()

					if s and p then
						local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
						if self.view_range and dist < self.view_range then
							self.following = player
							break
						end
					end
				end
			end

			if self.following and self.following:is_player() then
				local wielded = self.following:get_wielded_item():get_name()
				local likes_wielded = false

				if follow_multiple then
					for _, i in ipairs(self.follow) do
						if i == wielded then
							likes_wielded = true
							break
						end
					end
				else
					likes_wielded = wielded == self.follow
				end

				if not likes_wielded then
					self.following = nil
				else
					local s = self.object:get_pos()
					local p = self.following:get_pos()
					local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
					if dist > self.view_range then
						self.following = nil
						self.v_start = false
					else
						local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
						local yaw = math.atan(vec.z / vec.x) + math.pi / 2
						if self.drawtype == "side" then
							yaw = yaw + (math.pi / 2)
						end
						if p.x > s.x then
							yaw = yaw + math.pi
						end
						self.object:set_yaw(yaw)
						if dist > 2 then
							if not self.v_start then
								self.v_start = true
								self.set_velocity(self, self.walk_velocity)
							else
								if self.jump and self.get_velocity(self) <= 1.5 and self.object:get_velocity().y == 0 then
									local v = self.object:get_velocity()
									v.y = 6
									self.object:set_velocity(v)
								end
								self.set_velocity(self, self.walk_velocity)
							end
							self:set_animation("walk")
						else
							self.v_start = false
							self.set_velocity(self, 0)
							self:set_animation("stand")
						end

						return
					end
				end
			end

			if self.state == "stand" then
				-- randomly turn
				if math.random(1, 4) == 1 then
					-- if there is a player nearby look at them
					local lp = nil
					local s = self.object:get_pos()
					if self.type == "npc" then
						local o = core.get_objects_inside_radius(self.object:get_pos(), 3)

						local yaw = 0
						for _, o in ipairs(o) do
							if o:is_player() then
								lp = o:get_pos()
								break
							end
						end
					end

					if lp ~= nil then
						local vec = {x=lp.x-s.x, y=lp.y-s.y, z=lp.z-s.z}
						yaw = math.atan(vec.z / vec.x) + math.pi / 2
						if self.drawtype == "side" then
							yaw = yaw+(math.pi / 2)
						end

						if lp.x > s.x then
							yaw = yaw + math.pi
						end
					else
						yaw = self.object:get_yaw()
						if yaw then
							yaw = yaw + ((math.random(0, 360) - 180) / 180 * math.pi)
						end
					end

					self.object:set_yaw(yaw)
				end

				self.set_velocity(self, 0)
				self.set_animation(self, "stand")
				if math.random(1, 100) <= self.walk_chance then
					self.set_velocity(self, self.walk_velocity)
					self.state = "walk"
					self.set_animation(self, "walk")
				end
			elseif self.state == "walk" then
				if math.random(1, 100) <= 30 then
					local yaw = self.object:get_yaw()
					if yaw then
						self.object:set_yaw(yaw + ((math.random(0, 360) - 180) / 180 * math.pi))
					end
				end

				local vel = self.object:get_velocity()
				if self.jump and self.get_velocity(self) <= 0.5 and vel and vel.y == 0 then
					local v = self.object:get_velocity()
					v.y = 6
					self.object:set_velocity(v)
				end

				self:set_animation("walk")
				self.set_velocity(self, self.walk_velocity)

				if math.random(1, 100) <= 30 then
					self.set_velocity(self, 0)
					self.state = "stand"
					self:set_animation("stand")
				end
			elseif self.state == "attack" and self.attack_type == "dogfight" then
				if not self.attack.player or not self.attack.player:get_pos() then
					print("stop attacking")
					self.state = "stand"
					self:set_animation("stand")
					return
				end

				local s = self.object:get_pos()
				local p = self.attack.player:get_pos()
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5

				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)
					self.attack = {player=nil, dist=nil}
					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z / vec.x) + math.pi / 2
				if self.drawtype == "side" then
					yaw = yaw + (math.pi / 2)
				end

				if p.x > s.x then
					yaw = yaw + math.pi
				end

				self.object:set_yaw(yaw)
				if self.attack.dist > 2 then
					if not self.v_start then
						self.v_start = true
						self.set_velocity(self, self.run_velocity)
					else
						if self.jump and self.get_velocity(self) <= 0.5 and self.object:get_velocity().y == 0 then
							local v = self.object:get_velocity()
							v.y = 6
							self.object:set_velocity(v)
						end

						self.set_velocity(self, self.run_velocity)
					end

					self:set_animation("run")
				else
					self.set_velocity(self, 0)
					self:set_animation("punch")
					self.v_start = false

					if self.timer > 1 then
						self.timer = 0
						local p2 = p
						local s2 = s
						p2.y = p2.y + 1.5
						s2.y = s2.y + 1.5

						if core.line_of_sight(p2, s2) == true then
							if self.sounds and self.sounds.attack then
								core.sound_play(self.sounds.attack, {object = self.object})
							end

							self.attack.player:punch(self.object, 1.0,
								{
									full_punch_interval = 1.0,
									damage_groups = {fleshy=self.damage},
								},
								vec
							)

							if math.random(0,3) == 3 and self.attack.player:is_player() then
								local snum = math.random(1, 4)
								core.sound_play("default_hurt" .. tostring(snum),
									{
										object = self.attack.player,
									}
								)
							end

							if self.attack.player:get_hp() <= 0 then
								self.state = "stand"
								self:set_animation("stand")
							end
						end
					end
				end
			elseif self.state == "attack" and self.attack_type == "shoot" then
				if not self.attack.player or not self.attack.player:is_player() then
					self.state = "stand"
					self:set_animation("stand")
					return
				end

				local s = self.object:get_pos()
				local p = self.attack.player:get_pos()
				p.y = p.y - .5
				s.y = s.y + .5
				local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5

				if dist > self.view_range or self.attack.player:get_hp() <= 0 then
					self.state = "stand"
					self.v_start = false
					self.set_velocity(self, 0)

					if self.type ~= "npc" then
						self.attack = {player=nil, dist=nil}
					end

					self:set_animation("stand")
					return
				else
					self.attack.dist = dist
				end

				local vec = {x=p.x-s.x, y=p.y-s.y, z=p.z-s.z}
				local yaw = math.atan(vec.z / vec.x) + math.pi / 2

				if self.drawtype == "side" then
					yaw = yaw + (math.pi / 2)
				end

				if p.x > s.x then
								yaw = yaw + math.pi
				end

				self.object:set_yaw(yaw)
				self.set_velocity(self, 0)

				if self.timer > self.shoot_interval and math.random(1, 100) <= 60 then
					self.timer = 0

					self:set_animation("punch")

					if self.sounds and self.sounds.attack then
						core.sound_play(self.sounds.attack, {object = self.object})
					end

					local p = self.object:get_pos()
					local box = self.object:get_properties().collisionbox
					p.y = p.y + (box[2] + box[5]) / 2
					local obj = core.add_entity(p, self.arrow)
					local amount = (vec.x^2 + vec.y^2 + vec.z^2)^0.5
					local v = obj:get_luaentity().velocity
					vec.y = vec.y + 1
					vec.x = vec.x * v / amount
					vec.y = vec.y * v / amount
					vec.z = vec.z * v / amount
					obj:set_velocity(vec)
				end
			end
		end,

		on_activate = function(self, staticdata, dtime_s)
			-- reset HP
			local pos = self.object:get_pos()
			local distance_rating = ((get_distance({x=0, y=0, z=0}, pos)) / 20000)
			local props = self.object:get_properties()
			local newHP = self.hp_min + math.floor(props.hp_max * distance_rating)
			self.object:set_hp(newHP)

			self.object:set_armor_groups({fleshy=self.armor})
			self.object:set_acceleration({x=0, y=-10, z=0})
			self.state = "stand"
			self.object:set_velocity({x=0, y=self.object:get_velocity().y, z=0})
			self.object:set_yaw(math.random(1, 360) / 180 * math.pi)

			if self.type == "monster" and whinny.peaceful_only then
				self.object:remove()
			end

			if self.type ~= "npc" then
				self.lifetimer = 600 - dtime_s
			end

			if staticdata then
				local tmp = core.deserialize(staticdata)
				if tmp and tmp.lifetimer then
					self.lifetimer = tmp.lifetimer - dtime_s
				end
				if tmp and tmp.tamed then
					self.tamed = tmp.tamed
				end
				--[[if tmp and tmp.textures then
					self.object:set_properties(tmp.textures)
				end]]
			end

			if self.lifetimer <= 0 and not self.tamed and self.type ~= "npc" then
				self.object:remove()
			end
		end,

		get_staticdata = function(self)
			local tmp = {
				lifetimer = self.lifetimer,
				tamed = self.tamed,
				textures = def.available_textures["texture_" .. math.random(1, def.available_textures["total"])],
			}

			self.object:set_properties(tmp)
			return core.serialize(tmp)
		end,

		on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
			-- do damage
			self.object:set_hp(self.object:get_hp() - damage)

			local weapon = puncher:get_wielded_item()
			if weapon:get_definition().tool_capabilities ~= nil then
				local wear = (weapon:get_definition().tool_capabilities.full_punch_interval / 75) * 9000
				weapon:add_wear(wear)
				puncher:set_wielded_item(weapon)
			end

			if weapon:get_definition().sounds ~= nil then
				local s = math.random(0, #weapon:get_definition().sounds)
				core.sound_play(weapon:get_definition().sounds[s], {object=puncher,})
			elseif sound_entity_hit then
				sound_entity_hit({object=puncher})
			end

			local hp = self.object:get_hp()

			if hp > 0 then
				if sound_entity_hit then
					sound_entity_hit({object=self.object})
				end
			else
				if sound_horse_snort then
					sound_horse_snort(2, {object=self.object})
				end

				local pos = self.object:get_pos()
				self.object:remove()

				if self.drops then
					for _, drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							core.add_item(pos, drop.name .. " "
								.. tostring(math.random(drop.min, drop.max)))
						end
					end
				end
			end

			return true
		end,
	})
end


whinny.spawning_whinny = {}

function whinny:register_spawn(name, nodes, max_light, min_light, chance, active_object_count, min_height, max_height, spawn_func)
	whinny.spawning_whinny[name] = true

	-- RJK: Add this:
	if name == "whinny:rohan_guard"  or
			name == "whinny:gondor_guard" or
			name == "whinny:dunlending"   or
			name == "whinny:hobbit"       or
			name == "whinny:orc"          or
			name == "whinny:half_troll"   or
			name == "whinny:troll"        or
			name == "whinny:dwarf"        or
			name == "whinny:dead_men" then
		chance = chance * 1
	end

	core.register_abm({
		nodenames = nodes,
		--neighbors = {"air"},
		interval = 30,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)
			if active_object_count_wider > active_object_count then return end
			if not whinny.spawning_whinny[name] then return end

			--[[ don't spawn inside of blocks
			local p2 = pos
			p2.y = p2.y + 1
			local p3 = p2
			p3.y = p3.y + 1
			if core.registered_nodes[core.get_node(p2).name].walkable == false or core.registered_nodes[core.get_node(p3).name].walkable == false then
							return
			end]]

			pos.y = pos.y + 1

			if not core.get_node_light(pos) then return end
			if core.get_node_light(pos) > max_light then return end
			if core.get_node_light(pos) < min_light then return end
			if pos.y > max_height then return end
			if pos.y < min_height then return end

			local get_node_pos
			local get_node_pos_name
			local registered_node

			get_node_pos = core.get_node(pos)
			if get_node_pos == nil then return end

			get_node_pos_name = get_node_pos.name
			if get_node_pos_name == nil then return end

			registered_node = core.registered_nodes[get_node_pos_name]
			if registered_node == nil then return end

			if registered_node.walkable == true or registered_node.walkable == nil then return end

			pos.y = pos.y + 1

			get_node_pos = core.get_node(pos)
			if get_node_pos == nil then return end

			get_node_pos_name = get_node_pos.name
			if get_node_pos_name == nil then return end

			registered_node = core.registered_nodes[get_node_pos_name]
			if registered_node == nil then return end

			if registered_node.walkable == true or registered_node.walkable == nil then return end

			if spawn_func and not spawn_func(pos, node) then return end

			if whinny.display_spawn then
				core.chat_send_all("[whinny] Add " .. name .. " at " .. core.pos_to_string(pos))
			end

			local mob = core.add_entity(pos, name)

			-- setup the hp, armor, drops, etc... for this specific mob
			local distance_rating = ((get_distance({x=0,y=0,z=0}, pos)) / 15000)
			if mob then
				mob = mob:get_luaentity()
				local props = mob.object:get_properties()
				local newHP = mob.hp_min + math.floor(props.hp_max * distance_rating)
				mob.object:set_hp(newHP)
			end

		end
	})
end

function whinny:register_arrow(name, def)
	core.register_entity(name, {
		initial_properties = {
			physical = false,
			visual = def.visual,
			visual_size = def.visual_size,
			textures = def.textures
		},
		velocity = def.velocity,
		hit_player = def.hit_player,
		hit_node = def.hit_node,

		on_step = function(self, dtime)
			local pos = self.object:get_pos()
			if core.get_node(self.object:get_pos()).name ~= "air" then
				self.hit_node(self, pos, node)
				self.object:remove()
				return
			end
			pos.y = pos.y - 1
			for _, player in pairs(core.get_objects_inside_radius(pos, 1)) do
				if player:is_player() then
					self.hit_player(self, player)
					self.object:remove()
					return
				end
			end
		end
	})
end

function get_distance(pos1, pos2)
	if (pos1 ~= nil and pos2 ~= nil) then
		return math.abs(math.floor(math.sqrt((pos1.x - pos2.x)^2 + (pos1.z - pos2.z)^2)))
	else
		return 0
	end
end
