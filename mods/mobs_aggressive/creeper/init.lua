creeper = {}

--[[
-- DISABLED!!!
do return end
--]]

dofile(minetest.get_modpath("creeper").."/tnt_function.lua")
dofile(minetest.get_modpath("creeper").."/spawn.lua")

local function jump(self,pos,direction)
	local velocity = self.object:getvelocity()
	if minetest.registered_nodes[minetest.get_node(pos).name].climbable then
		self.object:setvelocity({x=velocity.x,y=4,z=velocity.z})
		return
	end
	
	local spos = {x=pos.x+direction.x,y=pos.y,z=pos.z+direction.z}
	local node = minetest.get_node_or_nil(spos)
	spos.y = spos.y+1
	local node2 = minetest.get_node_or_nil(spos)
	local def,def2 = {}
	if node and node.name then
		def = minetest.registered_items[node.name]
	end
	if node2 and node2.name then
		def2 = minetest.registered_items[node2.name]
	end
	if def and def.walkable
	and def2 and not def2.walkable
	and def.drawtype ~= "fencelike" then
		self.object:setvelocity({
			x=velocity.x*2.2,
			y=self.jump_height,
			z=velocity.z*2.2
		})
	end
end

local function random_turn(self)
	if self.turn_timer > math.random(2,5) then
		local select_turn = math.random(1,3)
		if select_turn == 1 then
			self.turn = "left"
		elseif select_turn == 2 then
			self.turn = "right"
		elseif select_turn == 3 then
			self.turn = "straight"
		end
		self.turn_timer = 0
		self.turn_speed = 0.05*math.random()
	end
end

local def = {
	hp_max = 20,
	physical = true,
	collisionbox = {-0.25,-0.7,-0.25, 0.25,0.8,0.25},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {"creeper.png"},
	makes_footstep_sound = false,

	-- Original
	animation = {
		stand_START = 0,
		stand_END = 79,
		walk_START = 168,
		walk_END = 187
	},
	walk_speed = 1.5,
	jump_height = 5,
	animation_speed = 30,
	knockback_level = 2
}

def.on_activate = function(self,staticdata)
	self.yaw = 0
	self.anim = 1
	self.timer = 0
	self.visualx = 1
	self.jump_timer = 0
	self.turn_timer = 0
	self.turn_speed = 0
	self.powered = false
	self.knockback = false
	self.state = math.random(1,2)
	self.old_y = self.object:getpos().y
	
	local data = minetest.deserialize(staticdata)
	if data and type(data) == "table" then
		if data.powered == true then
			self.powered = true
			self.object:set_properties({textures = {"creeper_powered.png"}})
		end
	else
		if math.random(0,20) == 20 then
			self.powered = true
			self.object:set_properties({textures = {"creeper_powered.png"}})
		end
	end
end

def.on_step = function(self, dtime)
	if self.knockback then
		return
	end
	
	local ANIM_STAND = 1
	local ANIM_WALK  = 2
	
	local pos = self.object:getpos()
	local yaw = self.object:getyaw()
	local inside = minetest.get_objects_inside_radius(pos,10)
	local walk_speed = self.walk_speed
	local animation = self.animation
	local anim_speed = self.animation_speed
	local velocity = self.object:getvelocity()
	
	self.timer = self.timer+0.01
	self.turn_timer = self.turn_timer+0.01
	self.jump_timer = self.jump_timer+0.01
	
	if not self.chase
	and self.timer > math.random(2,5) then
		if math.random() > 0.8 then
			self.state = "stand"
		else
			self.state = "walk"
		end
		self.timer = 0
	end

	if self.turn == "right" then
		self.yaw = self.yaw+self.turn_speed
		self.object:setyaw(self.yaw)
	elseif self.turn == "left" then
		self.yaw = self.yaw-self.turn_speed
		self.object:setyaw(self.yaw)
	end
	
	if self.chase and self.visualx < 2 then
		if self.hiss == false then
			minetest.sound_play("creeper_hiss",{pos=pos,gain=1.5,max_hear_distance=2*64})
		end
		self.visualx = self.visualx+0.05
		self.object:set_properties({
			visual_size = {x=self.visualx,y=1}
		})
		self.hiss = true
	elseif self.visualx > 1 then
		self.visualx = self.visualx-0.05
		self.object:set_properties({
			visual_size = {x=self.visualx,y=1}
		})
		self.hiss = false
	end
	
	self.chase = false
	
	for  _,object in ipairs(inside) do
		if object:is_player() then
			self.state = "chase"
		end
	end

	if self.state == "stand" then
		if self.anim ~= ANIM_STAND then
			self.object:set_animation({x=animation.stand_START,y=animation.stand_END},anim_speed,0)
			self.anim = ANIM_STAND
		end
		
		random_turn(self)
		
		if velocity.x ~= 0
		or velocity.z ~= 0 then
			self.object:setvelocity({x=0,y=velocity.y,z=0})
		end
	end

	if self.state == "walk" then
		if self.anim ~= ANIM_WALK then
			self.object:set_animation({x=animation.walk_START,y=animation.walk_END},anim_speed,0)
			self.anim = ANIM_WALK
		end
		
		self.direction = {x=math.sin(yaw)*-1,y=-10,z=math.cos(yaw)}
		if self.direction then
			self.object:setvelocity({x=self.direction.x*walk_speed,y=velocity.y,z=self.direction.z*walk_speed})
		end
		
		random_turn(self)

		local velocity = self.object:getvelocity()
		
		if self.turn_timer > 1 then
			local direction = self.direction
			local npos = {x=pos.x+direction.x,y=pos.y+0.2,z=pos.z+direction.z}
			if velocity.x == 0 or velocity.z == 0
			or minetest.registered_nodes[minetest.get_node(npos).name].walkable then
				local select_turn = math.random(1,2)
				if select_turn == 1 then
					self.turn = "left"
				elseif select_turn == 2 then
					self.turn = "right"
				end
				self.turn_timer = 0
				self.turn_speed = 0.05*math.random()
			end
		end
		
		-- Jump
		if self.jump_timer > 0.2 then
			jump(self,pos,self.direction)
		end
	end
	
	if self.state == "chase" then
		if self.anim ~= ANIM_WALK then
			self.object:set_animation({x=animation.walk_START,y=animation.walk_END},anim_speed,0)
			self.anim = ANIM_WALK
		end
		
		self.turn = "straight"
		
		local inside_2 = minetest.get_objects_inside_radius(pos,2)
		
		-- Boom
		if #inside_2 ~= 0 then
			for  _,object in ipairs(inside_2) do
				if object:is_player() and object:get_hp() ~= 0 then
					self.chase = true
					if self.visualx >= 2 then
						self.object:remove()
						creeper.boom(pos,self.powered)
						minetest.sound_play("creeper_explode",{pos=pos,gain=1.5,max_hear_distance=2*64})
					end
				end
			end
		end
		
		if #inside ~= 0 then
			for  _,object in ipairs(inside) do
				if object:is_player() and object:get_hp() ~= 0 then
					if #inside_2 ~= 0 then
						for _,object in ipairs(inside_2) do
							-- Stop move
							if object:is_player() then
								if self.anim ~= ANIM_STAND then
									self.object:set_animation({x=animation.stand_START,y=animation.stand_END},anim_speed,0)
									self.anim = ANIM_STAND
								end
								self.object:setvelocity({x=0,y=velocity.y,z=0})
								return
							end
						end
					end
				
					local ppos = object:getpos()
					self.vec = {x=ppos.x-pos.x,y=ppos.y-pos.y,z=ppos.z-pos.z}
					self.yaw = math.atan(self.vec.z/self.vec.x)+math.pi^2
					if ppos.x > pos.x then
						self.yaw = self.yaw+math.pi
					end
					self.yaw = self.yaw-2
					self.object:setyaw(self.yaw)
					self.direction = {x=math.sin(self.yaw)*-1,y=0,z=math.cos(self.yaw)}
				
					local direction = self.direction
					self.object:setvelocity({x=direction.x*2.5,y=velocity.y,z=direction.z*2.5})

					-- Jump
					if self.jump_timer > 0.2 then
						jump(self,pos,direction)
					end
				end
			end
		else
			self.state = "stand"
		end
	end
	
	-- Swim
	local node = minetest.get_node(pos)
	if minetest.get_item_group(node.name,"water") ~= 0 then
		self.object:setacceleration({x=0,y=1,z=0})
		local velocity = self.object:getvelocity()
		if self.object:getvelocity().y > 5 then
			self.object:setvelocity({x=0,y=velocity.y-velocity.y/2,z=0})
		else
			self.object:setvelocity({x=0,y=velocity.y+1,z=0})
		end
	else
		self.object:setacceleration({x=0,y=-10,z=0})
	end
end

def.on_punch = function(self,puncher,time_from_last_punch,tool_capabilities,dir)
	if self.knockback == false then
		local knockback_level = self.knockback_level
		self.object:setvelocity({x=dir.x*knockback_level,y=3,z=dir.z*knockback_level})
		self.knockback = true
		minetest.after(0.6,function()
			self.knockback = false
		end)
	end
	if self.object:get_hp() < 1 then
		local pos = self.object:getpos()
		local x = 1/math.random(1,5)*dir.x
		local z = 1/math.random(1,5)*dir.z
		local p = {x=pos.x+x,y=pos.y,z=pos.z+z}
		local node = minetest.get_node_or_nil(p)
		if node == nil or not node.name or node.name ~= "air" then
			p = pos
		end
		local obj = minetest.add_item(p, {name="tnt:gunpowder",count=math.random(0,2)})
	end
end

def.get_staticdata = function(self)
	return minetest.serialize({
		powered = self.powered
	})
end

minetest.register_entity("creeper:creeper",def)

if minetest.get_modpath('spawneggs') and minetest.get_modpath('tnt') then
	minetest.register_craftitem("creeper:spawnegg",{
		description = "Creeper Spawn Egg",
		inventory_image = "creeper_spawnegg.png",
		stack_max = 64,
		on_place = function(itemstack,placer,pointed_thing)
			if pointed_thing.type == "node" then
				local pos = pointed_thing.above
				pos.y = pos.y+1
				minetest.add_entity(pos,"creeper:creeper")
				if not minetest.settings:get_bool("creative_mode") then
					itemstack:take_item()
				end
				return itemstack
			end
		end
	})
	
	minetest.register_craft({
		output = 'creeper:spawnegg',
		type = 'shapeless',
		recipe = {
			'spawneggs:egg', 'tnt:tnt',
		},
	})
	
	minetest.register_alias('spawneggs:creeper', 'creeper:spawnegg')
end
