--
-- Helper functions
--
local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

--
-- Heli entity
--

local heli = {
	physical = true,
	collisionbox = {-1,-0.6,-1, 1,0.3,1},
	makes_footstep_sound = false,
	collide_with_objects = true,
	
	visual = "mesh",
	mesh = "root.x",
	--Player
	driver = nil,
	
	--Heli mesh
	model = nil,
	--Rotation
	yaw=0,
	--Speeds
	vx=0,
	vy=0,
	vz=0,
	soundHandle=nil
	
	
}
local heliModel = {
	visual = "mesh",
	mesh = "heli.x",
	textures = {"blades.png","blades.png","heli.png","Glass.png"},
}	

function heli:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		clicker:set_detach()
		self.driver = nil
		self.model:set_animation({x=0,y=1},0, 0)
		minetest.sound_stop(self.soundHandle)
	elseif not self.driver then
		self.soundHandle=minetest.sound_play({name="helicopter_motor"},{object = self.object, gain = 2.0, max_hear_distance = 32, loop = true,})
		self.model:set_animation({x=0,y=11},30, 0)
		self.driver = clicker
		clicker:set_attach(self.model, "", {x=0,y=14,z=0}, {x=0,y=0,z=0})
	end
end

function heliModel:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	local is_attached = false
	for _,object in ipairs(minetest.env:get_objects_inside_radius(self.object:getpos(), 2)) do
		if object and object:get_luaentity() and object:get_luaentity().name=="helicopter:heli" then
			if object:get_luaentity().model == nil then
				object:get_luaentity().model = self
			end
			if object:get_luaentity().model == self then
				is_attached = true
			end
		end
	end
	if is_attached == false then
		self.object:remove()
	end
	
end

function heli:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({cracky=80,choppy=80,fleshy=80})
	self.object:set_hp(30)
	self.prev_y=self.object:getpos()
	if self.model == nil then
		self.model = minetest.env:add_entity(self.object:getpos(), "helicopter:heliModel")
		self.model:set_attach(self.object, "", {x=0,y=-5,z=0}, {x=0,y=0,z=0})	
	end
end

function heli:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	if self.object:get_hp() == 0 then
		if self.model ~= nil then
			self.model:remove()
		end
		if self.soundHandle then
			minetest.sound_stop(self.soundHandle)
		end
		self.object:remove()
		
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", "default:steel_ingot 5")
			puncher:get_inventory():add_item("main", "default:mese_crystal")
		end
	end
end
function heliModel:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
end
function heli:on_step(dtime)
	--Prevent multi heli control bug
	if self.driver and ( math.abs(self.driver:getpos().x-self.object:getpos().x)>10*dtime or math.abs(self.driver:getpos().y-self.object:getpos().y)>10*dtime or math.abs(self.driver:getpos().z-self.object:getpos().z)>10*dtime) then
		self.driver = nil
		self.model:set_animation({x=0,y=1},0, 0)
		minetest.sound_stop(self.soundHandle)
	end
	
	if self.driver then
		--self.driver:set_animation({ x= 81, y=160, },10,0)
		self.yaw = self.driver:get_look_yaw()
		self.vx = self.object:getvelocity().x
		self.vy = self.object:getvelocity().y
		self.vz = self.object:getvelocity().z
		local ctrl = self.driver:get_player_control()
		--Forward/backward
		if ctrl.up then
			self.vx = self.vx + math.cos(self.driver:get_look_yaw())*0.1
			self.vz = self.vz + math.sin(self.driver:get_look_yaw())*0.1
		end
		if ctrl.down then
			self.vx = self.vx-math.cos(self.driver:get_look_yaw())*0.1
			self.vz = self.vz-math.sin(self.driver:get_look_yaw())*0.1
		end
		--Left/right
		if ctrl.left then
			self.vz = self.vz+math.cos(self.driver:get_look_yaw())*0.1
			self.vx = self.vx+math.sin(math.pi+self.driver:get_look_yaw())*0.1
		end
		if ctrl.right then
			self.vz = self.vz-math.cos(self.driver:get_look_yaw())*0.1
			self.vx = self.vx-math.sin(math.pi+self.driver:get_look_yaw())*0.1
		end
		--up/down
		if ctrl.jump then
			if self.vy<1.5 then
				self.vy = self.vy+0.2
			end
		end
		if ctrl.sneak then
			if self.vy>-1.5 then
				self.vy = self.vy-0.2
			end
		end
		--
	end
	if self.vx==0 and self.vz==0 and self.vy==0 then
		return
	end
	--Decelerating
	local sx=get_sign(self.vx)
	self.vx = self.vx - 0.02*sx
	local sz=get_sign(self.vz)
	self.vz = self.vz - 0.02*sz
	local sy=get_sign(self.vy)
	self.vy = self.vy-0.01*sy
	
	--Stop
	if sx ~= get_sign(self.vx) then
		self.vx = 0
	end
	if sz ~= get_sign(self.vz) then
		self.vz = 0
	end
	if sy ~= get_sign(self.vy) then
		self.vy = 0
	end
	
	--Speed limit
	if math.abs(self.vx) > 4.5 then
		self.vx = 4.5*get_sign(self.vx)
	end
	if math.abs(self.vz) > 4.5 then
		self.vz = 4.5*get_sign(self.vz)
	end
	if math.abs(self.vy) > 4.5 then
		self.vz = 4.5*get_sign(self.vy)
	end
	
	--Set speed to entity
	
	self.object:setvelocity({x=self.vx, y=self.vy,z=self.vz})
	if self.model then
		self.model:set_attach(self.object,"Root", {x=0,y=0,z=5}, {
			x=-90+self.vx*3*math.cos(self.yaw)+self.vz*3*math.sin(self.yaw), 
			y=0-self.vx*3*math.sin(self.yaw)+self.vz*3*math.cos(self.yaw), 
			z=(self.yaw-math.pi/2)*57})
	end
end

--
--Registration
--

minetest.register_entity("helicopter:heli", heli)
minetest.register_entity("helicopter:heliModel", heliModel)

--
--Craft items
--

--Blades
minetest.register_craftitem("helicopter:blades",{
	description = "Blades",
	inventory_image = "blades_inv.png",
	wield_image = "blades_inv.png",
})
--Cabin
minetest.register_craftitem("helicopter:cabin",{
	description = "Cabin for heli",
	inventory_image = "cabin_inv.png",
	wield_image = "cabin_inv.png",
})
--Heli
minetest.register_craftitem("helicopter:heli", {
	description = "Helicopter",
	inventory_image = "heli_inv.png",
	wield_image = "heli_inv.png",
	wield_scale = {x=1, y=1, z=1},
	liquids_pointable = false,
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if minetest.get_node(pointed_thing.above).name ~= "air" then
			return
		end
		minetest.env:add_entity(pointed_thing.above, "helicopter:heli")
		itemstack:take_item()
		return itemstack
	end,
})

--
--Craft
--

minetest.register_craft({
	output = 'helicopter:blades',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'group:stick', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
	}
})
minetest.register_craft({
	output = 'helicopter:cabin',
	recipe = {
		{'', 'group:wood', ''},
		{'group:wood', 'default:mese_crystal','default:glass'},
		{'group:wood','group:wood','group:wood'},		
	}
})		
minetest.register_craft({
	output = 'helicopter:heli',
	recipe = {
		{'', 'helicopter:blades', ''},
		{'helicopter:blades', 'helicopter:cabin',''},	
	}
})	

