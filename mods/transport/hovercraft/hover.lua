
function hover:register_hovercraft(name, def)
	minetest.register_entity(name, {
		physical = true,
		collisionbox = {-0.8,0,-0.8, 0.8,1.2,0.8},
		visual = "mesh",
		mesh = "hovercraft.x",
		textures = def.textures,
		max_speed = def.max_speed,
		acceleration = def.acceleration,
		deceleration = def.deceleration,
		jump_velocity = def.jump_velocity,
		fall_velocity = def.fall_velocity,
		bounce = def.bounce,
		player = nil,
		sound = nil,
		thrust = 0,
		velocity = {x=0, y=0, z=0},
		last_pos = {x=0, y=0, z=0},
		timer = 0,
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({immortal=1})
			self.object:set_animation({x=0, y=24}, 30)

			local sdata = core.deserialize(staticdata)
			self.owner = sdata.owner
		end,
		on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
			if not puncher or not puncher:is_player() then return end

			if self.player then
				return
			end

			local pname = puncher:get_player_name()
			if hover.ownable and self.owner and pname ~= self.owner then
				core.chat_send_player(pname, "You cannot take " .. self.owner .. "'s hovercraft.")
				return
			end

			local stack = ItemStack(name)
			local pinv = puncher:get_inventory()
			if not pinv:room_for_item("main", stack) then
				core.chat_send_player(pname, "You don't have room in your inventory.")
				return
			end

			if self.sound then
				minetest.sound_stop(self.sound)
			end
			self.object:remove()
			pinv:add_item("main", stack)
		end,
		on_rightclick = function(self, clicker)
			if not clicker or not clicker:is_player() then
				return
			end

			local pos = self.object:get_pos()
			if self.player and clicker == self.player then
				if self.sound then
					minetest.sound_stop(self.sound)
					minetest.sound_play("hovercraft_thrust_fade", {object = self.object})
					self.sound = nil
				end
				self.thrust = 0
				self.player = nil
				self.object:set_animation({x=0, y=24}, 30)
				clicker:set_animation({x=0, y=0})
				clicker:set_detach()
			elseif not self.player then
				local pname = clicker:get_player_name()
				if hover.ownable and self.owner and pname ~= self.owner then
					core.chat_send_player(pname, "You cannot ride " .. self.owner .. "'s hovercraft.")
					return
				end

				self.player = clicker

				local attach_y = 16.5
				if core.features.object_independent_selectionbox then
					attach_y = 5.75
				end

				clicker:set_attach(self.object, "", {x=-2,y=attach_y,z=0}, {x=0,y=90,z=0})
				clicker:set_animation({x=81, y=81})
				local yaw = clicker:get_look_horizontal()
				self.object:set_yaw(yaw)
				self.yaw = yaw
				pos.y = pos.y + 0.5
				minetest.sound_play("hovercraft_jump", {object = self.object})
				self.object:set_animation({x=0, y=0})
			end
			self.last_pos = vector.new(pos)
			self.object:set_pos(pos)
		end,
		on_step = function(self, dtime)
			self.timer = self.timer + dtime
			if self.player then
				local yaw = nil
				local p_look = self.player:get_look_horizontal()
				if p_look then
					yaw = p_look + math.rad(90)
				end
				if not yaw then
					return
				end
				self.object:set_yaw(yaw)
				local ctrl = self.player:get_player_control()
				if ctrl.up then
					if self.thrust < self.max_speed then
						self.thrust = self.thrust + self.acceleration
					end
					local velocity = hover:get_velocity(self.thrust, self.velocity.y, 0, yaw)
					if velocity.x <= self.velocity.x - self.acceleration then
						self.velocity.x = self.velocity.x - self.acceleration
					elseif velocity.x >= self.velocity.x + self.acceleration then
						self.velocity.x = self.velocity.x + self.acceleration
					end
					if velocity.z <= self.velocity.z - self.acceleration then
						self.velocity.z = self.velocity.z - self.acceleration
					elseif velocity.z >= self.velocity.z + self.acceleration then
						self.velocity.z = self.velocity.z + self.acceleration
					end
					if not self.sound then
						self.object:set_animation({x=25, y=75}, 30)
						self.sound = minetest.sound_play("hovercraft_thrust_loop", {
							object = self.object,
							loop = true,
						})
					end
				elseif self.thrust > 0 then
					self.thrust = self.thrust - 0.1
					if self.sound then
						minetest.sound_stop(self.sound)
						minetest.sound_play("hovercraft_thrust_fade", {object = self.object})
						self.sound = nil
					end
				else
					self.object:set_animation({x=0, y=0})
					self.thrust = 0
				end
				if ctrl.jump and self.velocity.y == 0 then
					self.velocity.y = self.jump_velocity
					self.timer = 0
					minetest.sound_play("hovercraft_jump", {object = self.object})
				end
				if ctrl.sneak then
					self.player:set_animation({x=81, y=81})
				end
			end
			local pos = self.object:get_pos()
			if self.timer > 0.5 then
				local node = minetest.get_node({x=pos.x, y=pos.y-0.5, z=pos.z})
				if node.name == "air" or node.name == "ignore" then
					self.velocity.y = 0 - self.fall_velocity
				else
					self.velocity.y = 0
					pos.y = math.floor(pos.y) + 0.5
					self.object:set_pos(pos)
				end
				self.timer = 0
			end
			if self.last_pos.x == pos.x and math.abs(self.velocity.x) > 0.5 then
				self.velocity.x = self.velocity.x * (0 - self.bounce)
				self.thrust = 0
				minetest.sound_play("hovercraft_bounce", {object = self.object})
			end
			if self.last_pos.z == pos.z and math.abs(self.velocity.z) > 0.5 then
				self.velocity.z = self.velocity.z * (0 - self.bounce)
				self.thrust = 0
				minetest.sound_play("hovercraft_bounce", {object = self.object})
			end
			self.last_pos = vector.new(pos)
			if self.thrust < 1 then
				if self.velocity.x > self.deceleration then
					self.velocity.x = self.velocity.x - self.deceleration
				elseif self.velocity.x < 0 - self.deceleration then
					self.velocity.x = self.velocity.x + self.deceleration
				else
					self.velocity.x = 0
				end
				if self.velocity.z > self.deceleration then
					self.velocity.z = self.velocity.z - self.deceleration
				elseif self.velocity.z < 0 - self.deceleration then
					self.velocity.z = self.velocity.z + self.deceleration
				else
					self.velocity.z = 0
				end
			end
			self.object:set_velocity(self.velocity)
		end,

		get_staticdata = function(self)
			local sdata = {
				owner = self.owner,
			}

			return core.serialize(sdata)
		end,
	})

	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		liquids_pointable = true,
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			pointed_thing.under.y = pointed_thing.under.y + 0.5
			minetest.add_entity(pointed_thing.under, name, core.serialize({owner=placer:get_player_name()}))
			itemstack:take_item()
			return itemstack
		end,
	})
end

function hover:get_velocity(vx, vy, vz, yaw)
	local x = math.cos(yaw) * vx + math.cos(math.pi / 2 + yaw) * vz
	local z = math.sin(yaw) * vx + math.sin(math.pi / 2 + yaw) * vz
	return {x=x, y=vy, z=z}
end

