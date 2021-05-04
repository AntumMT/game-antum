


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
	-- FIXME:
	if i == nil then i = 0 end

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

	local pname = clicker:get_player_name()

	if not self.owner then
		local wielded = clicker:get_wielded_item()
		-- FIXME: should be done with left click/punch
		if wielded and wielded:get_name() == "default:apple" then
			wielded:set_count(wielded:get_count()-1)
			clicker:set_wielded_item(wielded)
			core.sound_play({name="creatures_apple_bite",}, {clicker:get_pos()})

			if self._appetite == nil then
				self._appetite = 1
			else
				self._appetite = self._appetite + 1

				if self._appetite == 10 then
					self.owner = pname
					self._appetite = nil
					core.chat_send_player(pname, "You now own this horse!")
					return
				end
			end

			core.chat_send_player(pname, "This horse is still hungry. Keep feeding it.")
			return
		else
			-- can't ride wild horses
			core.chat_send_player(pname, "This horse is too wild to ride. Try feeding it some apples.")
			return
		end
	end

	-- only owner can ride
	if self.owner and pname ~= self.owner then
		core.chat_send_player(pname, "This horse is owned by " .. self.owner)
		return
	end

	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
		self.object:set_yaw(clicker:get_look_horizontal())
	end
end


function horse:on_activate(staticdata, dtime_s)
	--self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function horse:get_staticdata()
	return tostring(self.v)
end

function horse:on_punch(puncher, time_from_last_punch, tool_capabilities, dir, damage)
	if puncher and puncher:is_player() then
		local pname = puncher:get_player_name()
		local owner = self.owner

		-- don't allow owned horses to be killed or owned by other players
		if owner and pname ~= owner then
			core.chat_send_player(pname, "This horse is owned by " .. owner)
			return true
		end

		local wielded = puncher:get_wielded_item()
		if wielded then
			local wname = wielded:get_name()
			local idx = wname:find(":")

			-- can be tamed with any item named "lasso"
			if wname and idx and wname:sub(idx+1) == "lasso" then
				if not owner then
					core.chat_send_player(pname, "This horse is too wild to tame. Try feeding it some apples.")
					return true
				else
					local pinv = puncher:get_inventory()
					if not pinv:room_for_item("main", self.name .. "_spawn_egg") then
						core.chat_send_player(pname, "You don't have enought room in your inventory.")
					else
						self.object:remove()
						puncher:get_inventory():add_item("main", self.name .. "_spawn_egg")
					end
					return true
				end
			end
		end
	end

	return false
end


function horse:on_step(dtime)
	if not self.driver then return false end

	-- FIXME: let owners control horse
	self.object:set_velocity({x=0, y=0, z=0})
	self.object:set_animation()

	--[[
	self.v = get_v(self.object:get_velocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+2
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:set_yaw(self.object:get_yaw()+math.pi/120+dtime*math.pi/120)
		end
		if ctrl.right then
			self.object:set_yaw(self.object:get_yaw()-math.pi/120-dtime*math.pi/120)
		end
		if ctrl.jump then
		local p = self.object:get_pos()
		p.y = p.y-0.5
		if is_ground(p) then
		local pos = self.object:get_pos()
				pos.y = math.floor(pos.y)+4
				self.object:set_pos(pos)
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), 0))
		end
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:set_velocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5*get_sign(self.v)
	end

	local p = self.object:get_pos()
	p.y = p.y-0.5
	if not is_ground(p) then
		if minetest.registered_nodes[minetest.get_node(p).name].walkable then
			self.v = 0
		end
		self.object:set_acceleration({x=0, y=-10, z=0})
		self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
	else
		p.y = p.y+1
		if is_ground(p) then
			self.object:set_acceleration({x=0, y=3, z=0})
			local y = self.object:get_velocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:set_acceleration({x=0, y=10, z=0})
			end
			self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), y))
		else
			self.object:set_acceleration({x=0, y=0, z=0})
			if math.abs(self.object:get_velocity().y) < 1 then
				local pos = self.object:get_pos()
				pos.y = math.floor(pos.y)+0.5
				self.object:set_pos(pos)
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), 0))
			else
				self.object:set_velocity(get_velocity(self.v, self.object:get_yaw(), self.object:get_velocity().y))
			end
		end
	end
	]]

	return true
end


--[[
local likes = {"default:apple"}
if core.global_exists("farming") then
	table.insert(likes, "farming:wheat")
end
]]

local drops = {}
if core.global_exists("mobs") then
	table.insert(drops, {"mobs:meat_raw", {min=2, max=3}, 1.0})
	table.insert(drops, {"mobs:leather", 1, 1.0})
end


local sounds = {
	neigh = {
		name = "creatures_horse_neigh_01",
		gain = 1.0,
	},
	snort1 = {
		name = "creatures_horse_snort_01",
		gain = 1.0,
	},
	snort2 = {
		name = "creatures_horse_snort_02",
		gain = 1.0,
	},
	distress = {
		name = "creatures_horse_neigh_02",
		gain = 1.0,
	},
}

-- FIXME:
-- - mounted horse movement is incorrect
local base_def = {
	--name = "creatures:horse_brown",
	ownable = true,
	stats = {
		hp = 16,
		hostile = false,
		lifetime = 300,
		can_jump = 0, -- FIXME: should only not be able to jump over certain nodes for coralling
		--can_swim = true,
		can_panic = true,
		has_kockback = true,
	},
	modes = {
		idle = {
			chance = 0.3,
		},
		walk = {chance=0.7, moving_speed=1,},
		--attack = {},
		--[[
		follow = {
			chance = 0.7,
			moving_speed = 1,
			--items = likes,
		},
		]]
		--eat = {},
	},
	model = {
		mesh = "mobs_horse.x",
		--textures = {"mobs_horse.png"},
		collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
		rotation = -90.0,
		--backface_culling = ,
		animations = {
			idle = {
				start = 25,
				stop = 75,
				speed = 15,
			},
			walk = {start=75, stop=100, speed=15,},
			--attack = {},
			--[[
			follow = {
				start = 75,
				stop = 100,
				speed = 15,
			},
			]]
			--eat = {},
		},
	},
	sounds = {
		on_damage = sounds.distress,
		on_death = sounds.snort2,
		random = {
			idle = sounds.snort1,
			follow = sounds.neigh,
		}
	},
	drops = drops,
	--[[
	combat = {
	},
	]]
	spawning = {
		abm_nodes = {
			spawn_on = {"default:dirt_with_grass"},
			neighbors = {},
		},
		abm_interval = 60,
		abm_chance = 9000,
		max_number = 2,
		--number = 1,
		--time_range = {},
		light = {min=8, max=20},
		height_limit = {min=-50, max=31000},
		spawn_egg = {
			--description = "Brown Horse",
			--texture = "mobs_horse_inv.png",
		},
		--spawner = {},
	},
	on_rightclick = function(self, clicker)
		return horse.on_rightclick(self, clicker)
	end,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
		return horse.on_punch(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
	end,
	on_step = function(self, dtime)
		return horse.on_step(self, dtime)
	end,
	on_activate = function(self, staticdata)
		return horse.on_activate(self, staticdata)
	end,
	get_staticdata = function(self)
		return horse.get_staticdata(self)
	end,
}


local horses = {
	{
		name = "creatures:horse_brown",
		description = "Brown Horse",
		textures = {"mobs_horse.png"},
		inventory_image = "mobs_horse_brown_inv.png",
	},
	{
		name = "creatures:horse_white",
		description = "White Horse",
		textures = {"mobs_horsepeg.png"},
		inventory_image = "mobs_horse_white_inv.png",
	},
	{
		name = "creatures:horse_black",
		description = "Black Horse",
		textures = {"mobs_horseara.png"},
		inventory_image = "mobs_horse_black_inv.png",
	},
}

for _, horse in ipairs(horses) do
	local def = table.copy(base_def)
	def.name = horse.name
	def.model.textures = horse.textures
	def.spawning.spawn_egg.description = horse.description
	def.spawning.spawn_egg.texture = horse.inventory_image

	creatures.register_mob(def)
end

if not core.global_exists("mobs") then
	creatures.register_alias("mob_horse:horse", "creatures:horse_brown")
end

if core.settings:get_bool("log_mods", false) then
	core.log("action", "horse loaded")
end
