
local S = core.get_translator(whinny.modname)


local use_player_api = core.global_exists("player_api")
local rot_compensate = math.rad(90) -- FIXME: no idea why I need to add rotation compensation

core.register_on_mods_loaded(function()
	local can_feed = false
	for food in pairs(whinny.fill_values) do
		if core.registered_items[food] then
			can_feed = true
			break
		end
	end

	if not can_feed then
		whinny.log("warning", "no compatible foods registered, cannot tame horses.")
	end
end)

local horse_likes = {}
for iname, fill in pairs(whinny.fill_values) do
	table.insert(horse_likes, iname)
end


local sounds_enabled = core.global_exists("sounds")
local sound_horse = sounds_enabled and sounds.horse
local sound_horse_snort = sounds_enabled and sounds.horse_snort
local sound_horse_neigh = sounds_enabled and sounds.horse_neigh
local sound_gallop = sounds_enabled and sounds.gallop
local sound_apple_bite = sounds_enabled and sounds.bite
local sound_entity_hit = sounds_enabled and sounds.entity_hit


-- galloping sounds
local function handle_is_playing(handle)
	return handle > -1
end


local function is_ground(pos)
	local nn = core.get_node(pos).name
	return core.get_item_group(nn, "crumbly") ~= 0 or
	core.get_item_group(nn, "cracky") ~= 0 or
	core.get_item_group(nn, "choppy") ~= 0 or
	core.get_item_group(nn, "snappy") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(speed, yaw, y)
	local x = math.cos(yaw)*speed
	local z = math.sin(yaw)*speed
	return {x=x, y=y, z=z}
end

local function get_speed(velocity)
	return math.sqrt(velocity.x^2+velocity.z^2)
end

-- ===================================================================

local horse_drops = {}
if core.registered_items["mobs:meat_raw"] then
	table.insert(horse_drops, {name="mobs:meat_raw", chance=1, min=2, max=3})
end
if core.registered_items["mobs:leather"] then
	table.insert(horse_drops, {name="mobs:leather", chance=1, min=1, max=1})
end

local function register_wildhorse(color)
	whinny:register_mob("whinny:horse_" .. color, {
		type = "animal",
		hp_min = 10,
		initial_properties = {
			hp_max = 10,
			collisionbox = {-.5, -0.01, -.5, .5, 1.4, .5},
			visual = "mesh",
			mesh = "whinny_horse_wild.x",
			makes_footstep_sound = true
		},
		appetite = whinny.appetite,
		available_textures = {
			total = 1,
			texture_1 = {"whinny_horse_" .. color .. "_mesh.png"},
		},
		drops = horse_drops,
		walk_velocity = 1,
		armor = 100,
		drawtype = "front",
		water_damage = 1,
		lava_damage = 5,
		light_damage = 0,
		animation = {
			speed_normal = 20,
			stand_start = 300,
			stand_end = 460,
			walk_start = 10,
			walk_end = 60
		},
		follow = horse_likes,
		view_range = 5,
		on_rightclick = function(self, clicker)
			local pname = clicker:get_player_name()
			local item = clicker:get_wielded_item()
			local item_name = item:get_name()
			local wants = false

			if type(horse_likes) == "table" then
				for _, i in ipairs(horse_likes) do
					if i == item_name then
						wants = true
						break
					end
				end
			else
				wants = item_name == horse_likes
			end

			if wants then
				local fills = whinny.fill_values[item_name]
				if not fills then fills = 1 end

				self.appetite = self.appetite - fills
				if sound_apple_bite then
					sound_apple_bite(1, {object=self.object})
				end

				if not whinny.creative then
					item:take_item()
					clicker:set_wielded_item(item)
				end

				if self.appetite <= 0 then

					-- replace with tamed horse
					core.add_entity(self.object:get_pos(),
						"whinny:horse_" .. color .. "_tame",
						core.serialize({owner=pname}))
					self.object:remove()

					core.chat_send_player(pname, S("This horse is now tame!"))
					return
				else
					core.chat_send_player(pname, S("This horse is still hungry. Keep feeding it."))
				end
			else
				-- can't ride wild horses
				core.chat_send_player(pname, S("This horse is too wild to ride. Try feeding it."))
			end
		end,

		jump = true,
		step = 1,
		passive = true,
	})
end

-- ===================================================================

local function register_basehorse(name, craftitem, horse)
	if craftitem ~= nil then
		function craftitem.on_place(itemstack, placer, pointed_thing)
			if pointed_thing.above then
				local ent = core.add_entity(pointed_thing.above, name, core.serialize({owner=placer:get_player_name()}))
				if ent then
					ent:set_yaw(placer:get_look_horizontal() + rot_compensate)
				end

				if not whinny.creative then
					itemstack:take_item()
				end
			end

			return itemstack
		end

		core.register_craftitem(name, craftitem)
	end

	function horse:set_animation(type)
		if type == self.animation_current then return end

		if type == self.animation.mode_stand then
			if self.animation.stand_start and self.animation.stand_end and self.animation.speed_normal then
				self.object:set_animation(
					{x=self.animation.stand_start,y=self.animation.stand_end},
					self.animation.speed_normal * 0.6,
					0
				)
				self.animation_current = self.animation.mode_stand
			end
		elseif type == self.animation.mode_walk  then
			if self.animation.walk_start and self.animation.walk_end and self.animation.speed_normal then
				self.object:set_animation(
					{x=self.animation.walk_start,y=self.animation.walk_end},
					self.animation.speed_normal * 3,
					0
				)
				self.animation_current = self.animation.mode_walk
			end
		elseif type == self.animation.mode_gallop  then
			if self.animation.gallop_start and self.animation.gallop_end and self.animation.speed_normal then
				self.object:set_animation(
					{x=self.animation.gallop_start,y=self.animation.gallop_end},
					self.animation.speed_normal * 2,
					0
				)
				self.animation_current = self.animation.mode_gallop
			end
		end
	end

	-- sounds played while riding
	horse.gallop_handle_1 = -1
	horse.gallop_handle_2 = -1

	function horse:stop_gallop()
		if self.gallop_handle_1 > -1 then
			core.sound_stop(self.gallop_handle_1)
			self.gallop_handle_1 = -1
		end

		if self.gallop_handle_2 > -1 then
			core.sound_stop(self.gallop_handle_2)
			self.gallop_handle_2 = -1
		end

		return self.gallop_handle_1 < 0 and self.gallop_handle_2 < 0
	end

	function horse:start_gallop(stage)
		if sound_gallop then
			if stage == 1 and self.gallop_handle_1 < 0 then
				self.gallop_handle_1 = sound_gallop(stage, {object=self.object, loop=true})
				return self.gallop_handle_1 and self.gallop_handle_1 >= 0
			elseif stage == 2 and self.gallop_handle_2 < 0 then
				self.gallop_handle_2 = sound_gallop(stage, {object=self.object, loop=true})
				return self.gallop_handle_2 and self.gallop_handle_2 >= 0
			end
		end
	end

	function horse:on_step(dtime)
		local p = self.object:get_pos()
		p.y = p.y - 0.1
		local on_ground = is_ground(p)
		local inside_block = self.object:get_pos()
		inside_block.y = inside_block.y + 1

		self.speed = get_speed(self.object:get_velocity())*get_sign(self.speed)

		if self.driver then
			-- galloping sounds
			if self.speed > 5 then
				if handle_is_playing(self.gallop_handle_1) then self:stop_gallop() end

				if not handle_is_playing(self.gallop_handle_2) then
					if not self:start_gallop(2) then
						whinny.log("warning", "Failed to start gallop stage 2 sound")
					end
				end
			elseif self.speed > 1 then
				if handle_is_playing(self.gallop_handle_2) then self:stop_gallop() end

				if not handle_is_playing(self.gallop_handle_1) then
					if not self:start_gallop(1) then
						whinny.log("warning", "Failed to start gallop stage 1 sound")
					end
				end
			else
				if handle_is_playing(self.gallop_handle_1) or handle_is_playing(self.gallop_handle_2) then
					if not self:stop_gallop() then
						whinny.log("warning", "Failed to stop gallop sounds")
					end
				end
			end

			-- driver controls
			local ctrl = self.driver:get_player_control()

			-- rotation (the faster we go, the less we rotate)
			if whinny.turn_player_look then
				-- FIXME: turning should be gradual
				local driver_look = self.driver:get_look_horizontal()
				if driver_look then
					self.object:set_yaw(driver_look + rot_compensate)
				end
			else
				if ctrl.left then
					self.object:set_yaw(self.object:get_yaw()+2*(1.5-math.abs(self.speed/self.max_speed))*math.pi/90 +dtime*math.pi/90)
				end
				if ctrl.right then
					self.object:set_yaw(self.object:get_yaw()-2*(1.5-math.abs(self.speed/self.max_speed))*math.pi/90 -dtime*math.pi/90)
				end
			end

			-- jumping (only if on ground)
			if ctrl.jump then
				if on_ground then
					local v = self.object:get_velocity()
					local vel = 3
					--v.y = (self.jump_speed or 3)
					v.y = vel
					self.object:set_velocity(v)
				end
			end

			-- forwards/backwards
			if ctrl.up then
				self.speed = self.speed + self.forward_boost
			elseif ctrl.down then
				if self.speed >= -2.9 then
					self.speed = self.speed - self.forward_boost
				end
			elseif self.speed < 3 then
				--decay speed if not going fast
				self.speed = self.speed * 0.85
			end
		else
			if math.abs(self.speed) < 1 then
				self.speed = 0
			else
				self.speed = self.speed * 0.90
			end

			if sound_horse then
				if math.random(1, 500) == 1 then
					sound_horse({object=self.object})
				end
			end
		end

		if math.abs(self.speed) < 1 then
			self.object:set_velocity({x=0,y=0,z=0})
			self:set_animation(self.animation.mode_stand)
		elseif self.speed > 5 then
			self:set_animation(self.animation.mode_gallop)
		else
			self:set_animation(self.animation.mode_walk)
		end

		-- make sure we don't go past the limit
		if core.get_item_group(core.get_node(inside_block).name, "water") ~= 0 then
			if math.abs(self.speed) > self.max_speed * .2 then
				self.speed = self.max_speed*get_sign(self.speed)*.2
			end
		else
			if math.abs(self.speed) > self.max_speed then
				self.speed = self.max_speed*get_sign(self.speed)
			end
		end

		local p = self.object:get_pos()
		p.y = p.y+1
		if not is_ground(p) then
			if core.registered_nodes[core.get_node(p).name].walkable then
				self.speed = 0
			end
			self.object:set_acceleration({x=0, y=-10, z=0})
			self.object:set_velocity(get_velocity(self.speed, self.object:get_yaw(), self.object:get_velocity().y))
		else
			self.object:set_acceleration({x=0, y=0, z=0})
			-- falling
			if math.abs(self.object:get_velocity().y) < 1 then
				local pos = self.object:get_pos()
				pos.y = math.floor(pos.y)+0.5
				self.object:set_pos(pos)
				self.object:set_velocity(get_velocity(self.speed, self.object:get_yaw(), 0))
			else
				self.object:set_velocity(get_velocity(self.speed, self.object:get_yaw(), self.object:get_velocity().y))
			end
		end

		if self.object:get_velocity().y > 0.1 then
				local yaw = self.object:get_yaw()
				if self.drawtype == "side" then
						yaw = yaw+(math.pi/2)
				end
				local x = math.sin(yaw) * -2
				local z = math.cos(yaw) * 2
				if core.get_item_group(core.get_node(inside_block).name, "water") ~= 0 then
						self.object:set_acceleration({x = x, y = .1, z = z})
				else
						self.object:set_acceleration({x = x, y = -10, z = z})
				end
		else
				if core.get_item_group(core.get_node(inside_block).name, "water") ~= 0 then
						self.object:set_acceleration({x = 0, y = .1, z = 0})
				else
						self.object:set_acceleration({x = 0, y = -10, z = 0})
				end
		end
	end

	function horse:on_rightclick(clicker)
		if not clicker or not clicker:is_player() then return end

		if self.driver and clicker == self.driver then
			self.driver = nil
			clicker:set_detach()
			clicker:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})

			if use_player_api then
				player_api.player_attached[clicker:get_player_name()] = false
				player_api.set_animation(clicker, "stand", 30)
			end

			-- stop galloping sounds
			if handle_is_playing(self.gallop_handle_1) or handle_is_playing(self.gallop_handle_2) then
				if not self:stop_gallop() then
					whinny.log("warning", "Failed to stop gallop sounds")
				end
			end
		elseif not self.driver then
			local pname = clicker:get_player_name()

			local wielded = clicker:get_wielded_item():get_name()
			if wielded == whinny.pickup_with then
				if self.owner and self.owner ~= pname then
					core.chat_send_player(pname, S("You cannot take @1's horse.", self.owner))
				else
					local inv = clicker:get_inventory()
					local stack = ItemStack(self.name)
					if not inv:room_for_item("main", stack) then
						core.chat_send_player(pname, S("You do not have room in your inventory."))
					else
						inv:add_item("main", stack)
						self.object:remove()
					end
				end

				return true
			end

			if self.owner and self.owner ~= pname then
				core.chat_send_player(pname, S("You cannot ride @1's horse.", self.owner))
				return true
			end

			local attach_x = 0
			local attach_y = 18
			if core.features.object_independent_selectionbox then
				attach_y = 10
			end

			if use_player_api then
				attach_x = attach_x - 2
				attach_y = attach_y + 4
			end

			self.driver = clicker
			clicker:set_attach(self.object, "", {x=attach_x, y=attach_y, z=0}, {x=0, y=90, z=0})
			clicker:set_eye_offset({x=0, y=8, z=0}, {x=0, y=0, z=0})
			-- face same direction as horse
			clicker:set_look_horizontal(self.object:get_yaw() - rot_compensate)

			if use_player_api then
				player_api.player_attached[pname] = true
				player_api.set_animation(clicker, "sit", 30)
			end
		end
	end

	function horse:on_activate(staticdata, dtime_s)
		self.object:set_armor_groups({fleshy=100})
		if staticdata then
			local data = core.deserialize(staticdata)
			if data then
				self.speed = data.speed
				self.owner = data.owner
			end
		end
	end

	function horse:get_staticdata()
		local data = {
			speed = self.speed,
			owner = self.owner,
		}

		return core.serialize(data)
	end

	function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, dir, damage)
		if puncher:is_player() then
			local pname = puncher:get_player_name()

			-- don't allow owned horses to be killed or owned by other players
			if self.owner and pname ~= self.owner then
				core.chat_send_player(pname, S("Don't kill @1's horse!!!", self.owner))
				return true
			end

			-- don't damage your own horse while mounted
			-- FIXME: horse still flashes
			if self.driver then return true end
		end

		-- do damage
		self.object:set_hp(self.object:get_hp() - damage)

		local hp = self.object:get_hp()

		if hp > 0 then
			if sound_entity_hit then
				sound_entity_hit({object=self.object})
			end
			if sound_horse_neigh then
				sound_horse_neigh(2, {object=self.object})
			end
		else
			if sound_horse_snort then
				sound_horse_snort(2, {object=self.object})
			end

			local pos = self.object:get_pos()
			self.object:remove()

			if horse_drops then
				for _, drop in ipairs(horse_drops) do
					if math.random(1, drop.chance) == 1 then
						core.add_item(pos, drop.name .. " "
							.. tostring(math.random(drop.min, drop.max)))
					end
				end
			end
		end

		return true
	end

	core.register_entity(name, horse)
end

local function register_tamehorse(color, description)
	register_basehorse("whinny:horse_" .. color .. "_tame",
		{
			description = description,
			inventory_image = "whinny_horse_" .. color .. "_inv.png",
		},
		{
			initial_properties = {
				physical = true,
				collisionbox = {-.5, -0.01, -.5, .5, 1.4, .5},
				visual = "mesh",
				visual_size = {x=1, y=1},
				mesh = "whinny_horse_tame.x",
				textures = {"whinny_horse_" .. color .. "_mesh.png"},
				stepheight = 1.1
			},
			animation = {
				speed_normal = 20,
				stand_start = 300,
				stand_end = 460,
				walk_start = 10,
				walk_end = 59,
				gallop_start = 70,
				gallop_end = 119,
				mode_stand = 1,
				mode_walk = 2,
				mode_gallop = 3,
			},
			animation_current = 0,
			max_speed = 7,
			forward_boost = .2,
			jump_boost = 4,
			speed = 0,
			driver = nil,
		}
	)
end

for color, name in pairs({["brown"]="Brown Horse", ["white"]="White Horse", ["black"]="Black Horse",}) do
	register_tamehorse(color, name)
	register_wildhorse(color)

	whinny:register_spawn("whinny:horse_" .. color, whinny.spawn_nodes, 20, 6,
		whinny.spawn_chance, 1, whinny.spawn_height_min, whinny.spawn_height_max)

	-- to simplify item handling
	core.register_alias("whinny:horse_" .. color, "whinny:horse_" .. color .. "_tame")
end
