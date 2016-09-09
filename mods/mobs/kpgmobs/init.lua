dofile(minetest.get_modpath("kpgmobs").."/api.lua")

local v = 0

minetest.register_node("kpgmobs:uley", {
	description = "Uley",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles ={"uley.png"},
	inventory_image = "uley.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="kpgmobs:uley", param2=1})
			minetest.env:add_entity(pos, "kpgmobs:bee")
		end
	end,
	
})


--HORSE go go goooo :)
local horse = {
    
	
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "mobs_horseh1.x",
	textures = {"mobs_horseh1.png"},
		
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horse:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horse:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horse:get_staticdata()
	return tostring(v)
end

function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kpgmobs:horseh1")
	end
end


function horse:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+2
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
		if is_ground(p) then
		local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+4
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
		end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end
end

--horse white

local horsepeg = {
    
	
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "mobs_horseh1.x",
	textures = {"mobs_horsepegh1.png"},
		
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horsepeg:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horsepeg:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horsepeg:get_staticdata()
	return tostring(v)
end

function horsepeg:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kpgmobs:horsepegh1")
	end
end


function horsepeg:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+2
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
		if is_ground(p) then
		local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+4
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
		end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end
end

--horse arabik
  local horseara = {
    
	
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "mobs_horseh1.x",
	textures = {"mobs_horsearah1.png"},
		
	driver = nil,
	v = 0,
}


local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function horseara:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw())
	end
end


function horseara:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horseara:get_staticdata()
	return tostring(v)
end

function horseara:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "kpgmobs:horsearah1")
	end
end


function horseara:on_step(dtime)

	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+3
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
		end
		if ctrl.jump then
		local p = self.object:getpos()
		p.y = p.y-0.5
		if is_ground(p) then
		local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+4
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
		end
		end
		
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5*get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
		else
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
		end
	end
end

--END HORSE

--[[ DISABLE sheep (using sheep from creatures_mod_engine)
kpgmobs:register_mob("kpgmobs:sheep", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_sheep.png"},
	visual = "mesh",
	mesh = "mobs_sheep.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	sounds = {
		random = "mobs_sheep",
	},
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
			if not self.tamed then
				if not minetest.setting_getbool("creative_mode") then
					item:take_item()
					clicker:set_wielded_item(item)
				end
				self.tamed = true
			elseif self.naked then
				if not minetest.setting_getbool("creative_mode") then
					item:take_item()
					clicker:set_wielded_item(item)
				end
				self.food = (self.food or 0) + 1
				if self.food >= 8 then
					self.food = 0
					self.naked = false
					self.object:set_properties({
						textures = {"mobs_sheep.png"},
						mesh = "mobs_sheep.x",
					})
				end
			end
			return
		end
		if clicker:get_inventory() and not self.naked then
			self.naked = true
			if minetest.registered_items["wool:white"] then
				clicker:get_inventory():add_item("main", ItemStack("wool:white "..math.random(1,3)))
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.x",
			})
		end
	end,
})
kpgmobs:register_spawn("kpgmobs:sheep", {"default:dirt_with_grass"}, 20, 8, 9000, 1, 31000)
--]]


minetest.register_craftitem("kpgmobs:meat_raw", {
	description = "Raw Meat",
	inventory_image = "mobs_meat_raw.png",
})

minetest.register_craftitem("kpgmobs:meat", {
	description = "Meat",
	inventory_image = "mobs_meat.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "kpgmobs:meat",
	recipe = "kpgmobs:meat_raw",
	cooktime = 5,
})

kpgmobs:register_mob("kpgmobs:rat", {
	type = "animal",
	hp_max = 1,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.x",
	textures = {"mobs_rat.png"},
	makes_footstep_sound = false,
	walk_velocity = 1,
	armor = 200,
	drops = {},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "kpgmobs:rat")
			self.object:remove()
		end
	end,
})
kpgmobs:register_spawn("kpgmobs:rat", {"default:dirt_with_grass", "default:stone"}, 20, -1, 7000, 1, 31000)

minetest.register_craftitem("kpgmobs:rat", {
	description = "Rat",
	inventory_image = "mobs_rat_inventory.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kpgmobs:rat")
			itemstack:take_item()
		end
		return itemstack
	end,
})
	
minetest.register_craftitem("kpgmobs:rat_cooked", {
	description = "Cooked Rat",
	inventory_image = "mobs_cooked_rat.png",
	
	on_use = minetest.item_eat(3),
})


kpgmobs:register_mob("kpgmobs:bee", {
	type = "animal",
	hp_max = 1,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_bee.x",
	textures = {"mobs_bee.png"},
	makes_footstep_sound = false,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:med_cooked",
		chance = 1,
		min = 1,
		max = 2,},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 1,
	light_damage = 0,
	
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
	},
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "kpgmobs:bee")
			self.object:remove()
		end
	end,
})
kpgmobs:register_spawn("kpgmobs:bee", {"default:dirt_with_grass"}, 20, -1, 7000, 1, 31000)

minetest.register_craftitem("kpgmobs:bee", {
	description = "bee",
	inventory_image = "mobs_bee_inventar.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kpgmobs:bee")
			itemstack:take_item()
		end
		return itemstack
	end,
})
	
minetest.register_craftitem("kpgmobs:med_cooked", {
	description = "Cooked med",
	inventory_image = "mobs_med_inventar.png",
	
	on_use = minetest.item_eat(6),
})


minetest.register_craft({
	output = 'kpgmobs:uley',
	recipe = {
		{'kpgmobs:bee','kpgmobs:bee','kpgmobs:bee'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "kpgmobs:med_cooked",
	recipe = "kpgmobs:bee",
	cooktime = 5,
})

kpgmobs:register_mob("kpgmobs:deer", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_deer.png"},
	visual = "mesh",
	mesh = "mobs_deer2.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
		{name = "animalmaterials:bone", -- Added temporarily by AntumDeluge
		chance = 0.5,
		min = 1,
		max = 1,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
	
})
kpgmobs:register_spawn("kpgmobs:deer", {"default:dirt_with_grass"}, 20, 8, 9000, 1, 31000)

kpgmobs:register_mob("kpgmobs:horse", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_horse.png"},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "kpgmobs:horseh1")
			self.object:remove()
		end
	end,
	
})
kpgmobs:register_spawn("kpgmobs:horse", {"default:dirt_with_grass"}, 20, 8, 9000, 1, 31000)

minetest.register_craftitem("kpgmobs:horseh1", {
	description = "Horse",
	inventory_image = "mobs_horse_inventar.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kpgmobs:horseh1")
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_entity("kpgmobs:horseh1", horse)

minetest.register_craftitem("kpgmobs:horsepegh1", {
	description = "HorseWhite",
	inventory_image = "mobs_horse_inventar.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kpgmobs:horsepegh1")
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_entity("kpgmobs:horsepegh1", horsepeg)

minetest.register_craftitem("kpgmobs:horsearah1", {
	description = "HorseBlack",
	inventory_image = "mobs_horse_inventar.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.env:add_entity(pointed_thing.above, "kpgmobs:horsearah1")
			itemstack:take_item()
		end
		return itemstack
	end,
})
minetest.register_entity("kpgmobs:horsearah1", horseara)

kpgmobs:register_mob("kpgmobs:wolf", {
	type = "monster",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_wolf.png"},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	makes_footstep_sound = true,
	view_range = 7,
	walk_velocity = 2,
	run_velocity = 3,
	damage = 2,
	armor = 200,
	attack_type = "dogfight",
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
		{name = "animalmaterials:bone", -- Added temporarily by AntumDeluge
		chance = 0.75,
		min = 1,
		max = 1,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	on_rightclick = nil,

	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 10,
		stand_end = 20,
		walk_start = 75,
		walk_end = 100,
		run_start = 100,
		run_end = 130,
		punch_start = 135,
		punch_end = 155,
	},
})
kpgmobs:register_spawn("kpgmobs:wolf", {"default:dirt_with_grass","default:dirt","default:desert_sand"}, 10, -1, 11000, 3, 31000)

kpgmobs:register_mob("kpgmobs:pumba", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_pumba.png"},
	visual = "mesh",
	mesh = "mobs_pumba.x",
	makes_footstep_sound = true,
	walk_velocity = 2,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 55,
		walk_start = 70,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
})
kpgmobs:register_spawn("kpgmobs:pumba", {"default:desert_sand"}, 20, 8, 9000, 1, 31000)

kpgmobs:register_mob("kpgmobs:horse3", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_horseara.png"},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "kpgmobs:horsearah1")
			self.object:remove()
		end
	end,
})
kpgmobs:register_spawn("kpgmobs:horse3", {"default:desert_sand"}, 20, 8, 9000, 1, 31000)

kpgmobs:register_mob("kpgmobs:horse2", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_horsepeg.png"},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 75,
		walk_start = 75,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
	on_rightclick = function(self, clicker)
		if clicker:is_player() and clicker:get_inventory() then
			clicker:get_inventory():add_item("main", "kpgmobs:horsepegh1")
			self.object:remove()
		end
	end,
})
kpgmobs:register_spawn("kpgmobs:horse2", {"default:dirt_with_grass"}, 20, 8, 10000, 1, 31000)

kpgmobs:register_mob("kpgmobs:jeraf", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_jeraf.png"},
	visual = "mesh",
	mesh = "mobs_jeraf.x",
	makes_footstep_sound = true,
	walk_velocity = 2,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 70,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
	
})
kpgmobs:register_spawn("kpgmobs:jeraf", {"default:desert_sand"}, 20, 8, 9000, 1, 31000)

kpgmobs:register_mob("kpgmobs:medved", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_medved.png"},
	visual = "mesh",
	mesh = "mobs_medved.x",
	makes_footstep_sound = true,
	view_range = 7,
	walk_velocity = 1,
	run_velocity = 2,
	damage = 10,
	armor = 200,
	attack_type = "dogfight",
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 5,
		max = 10,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,

	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
		run_start = 105,
		run_end = 135,
		punch_start = 70,
		punch_end = 100,
	},
})
kpgmobs:register_spawn("kpgmobs:medved", {"default:dirt_with_grass","default:dirt","default:desert_sand"}, 20, 0, 11000, 3, 31000)

kpgmobs:register_mob("kpgmobs:cow", {
	type = "animal",
	hp_max = 5,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_cow.png"},
	visual = "mesh",
	mesh = "mobs_cow.x",
	makes_footstep_sound = true,
	view_range = 7,
	walk_velocity = 1,
	run_velocity = 2,
	damage = 10,
	armor = 200,
	drops = {
		{name = "kpgmobs:meat_raw",
		chance = 1,
		min = 5,
		max = 10,},
		{name = 'mobs:leather',
		chance = 1,
		min = 1,
		max = 1,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
    follow = "farming:wheat",
	view_range = 5,
	-- ADDED TenPlus1 (right-clicking cow with empty bucket gives bucket of milk and moo sound)
	on_rightclick = function(self, clicker)
		tool = clicker:get_wielded_item():get_name()
		if tool == "bucket:bucket_empty" then
			if self.milked then
				minetest.sound_play("cow", {
					object = self.object,
					gain = 1.0, -- default
					max_hear_distance = 32, -- default
					loop = false,
				})
				do return end
			end
			clicker:get_inventory():remove_item("main", "bucket:bucket_empty")
			clicker:get_inventory():add_item("main", "kpgmobs:bucket_milk")
			if math.random(1,2) > 1 then self.milked = true	end
		end
	end,


	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
		run_start = 105,
		run_end = 135,
		punch_start = 70,
		punch_end = 100,
	},
})
kpgmobs:register_spawn("kpgmobs:cow", {"default:dirt_with_grass","default:dirt","default:desert_sand"}, 20, 0, 11000, 3, 31000)

-- ADDED Tenplus1 (Bucket of Milk gives 4 hearts and returns empty bucket)
minetest.register_craftitem("kpgmobs:bucket_milk", {
	description = "Bucket of Milk",
	inventory_image = "bucket_milk.png",
	on_use = minetest.item_eat(8, "bucket:bucket_empty"),
})

if minetest.setting_get("log_mods") then
	minetest.log("action", "kpgmobs loaded")
end
