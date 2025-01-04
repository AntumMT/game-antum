--[[ LICENSE HEADER

  This file is part of boats2 mod for Luanti.

  boats2 is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as
  published by the Free Software Foundation, either version 3 of
  the License, or (at your option) any later version.

  boats2 is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with boats2. If not, see
  <http://www.gnu.org/licenses/>.
]]


boats2 = {}
boats2.modname = core.get_current_modname()
boats2.modpath = core.get_modpath(boats2.modname)

--
-- Helper functions
--
local function is_water(pos)
	local nn = core.get_node(pos).name
	return core.get_item_group(nn, "water") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

--
-- Row boat entity
--

local row_boat = {
	physical = true,
	collisionbox = {-1,-0.5,-1, 1,0.5,1},
	visual = "mesh",
	mesh = "rowboat.b3d",
	textures = {"default_wood.png"},

	driver = nil,
	v = 0,
	stepcount = 0,
	unattended = 0
}

function row_boat.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local name = clicker:get_player_name()
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand" , 30)
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=11,z=-5}, {x=0,y=0,z=0})
		default.player_attached[name] = true
		core.after(0.2, function()
			default.player_set_animation(clicker, "sit" , 30)
		end)
		self.object:setyaw(clicker:get_look_yaw() - math.pi / 2)
	end
end

function row_boat.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal = 1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
	self.last_v = self.v
end

function row_boat.get_staticdata(self)
	return tostring(self.v)
end

function row_boat.on_punch(self, puncher, time_from_last_punch, tool_capabilities, direction)
	if not puncher or not puncher:is_player() or self.removed then
		return
	end
	puncher:set_detach()
	default.player_attached[puncher:get_player_name()] = false

	self.removed = true
	-- delay remove to ensure player is detached
	core.after(0.1, function()
		self.object:remove()
	end)
	if not core.settings:get_bool("creative_mode") then
		puncher:get_inventory():add_item("main", "boats:row_boat")
	end
end

function row_boat.on_step(self, dtime)
	self.v = get_v(self.object:getvelocity()) * get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		local yaw = self.object:getyaw()
		if ctrl.up then
			self.v = self.v + 0.1
		end
		if ctrl.down then
			self.v = self.v - 0.08
		end
		if ctrl.left then
			if ctrl.down then
				self.object:setyaw(yaw - (1 + dtime) * 0.03)
			else
				self.object:setyaw(yaw + (1 + dtime) * 0.03)
			end
		end
		if ctrl.right then
			if ctrl.down then
				self.object:setyaw(yaw + (1 + dtime) * 0.03)
			else
				self.object:setyaw(yaw - (1 + dtime) * 0.03)
			end
		end
	end
	local velo = self.object:getvelocity()
	if self.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		return
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02 * s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x = 0, y = 0, z = 0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5 * get_sign(self.v)
	end

	local p = self.object:getpos()
	p.y = p.y - 0.5
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = 0, z = 0}
	if not is_water(p) then
		local nodedef = core.registered_nodes[core.get_node(p).name]
		if (not nodedef) or nodedef.walkable then
			self.v = 0
			new_acce = {x = 0, y = 1, z = 0}
		else
			new_acce = {x = 0, y = -9.8, z = 0} -- freefall in air -9.81
		end
		new_velo = get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y)
	else
		p.y = p.y + 1
		if is_water(p) then
			new_acce = {x = 0, y = 3, z = 0}
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x = 0, y = 10, z = 0})
			end
			new_velo = get_velocity(self.v, self.object:getyaw(), y)
		else
			new_acce = {x = 0, y = 0, z = 0}
			if math.abs(self.object:getvelocity().y) <= 2 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y) + 0.5
				self.object:setpos(pos)
				new_velo = get_velocity(self.v, self.object:getyaw(), 0)
			else
				new_velo = get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y)
			end
		end
	end
	self.object:setvelocity(new_velo)
	self.object:setacceleration(new_acce)
end

core.register_entity(":boats:row_boat", row_boat)
core.register_alias("boats:rowboat", "boats:row_boat")


core.register_craftitem(":boats:row_boat", {
	description = "Row Boat",
	inventory_image = "rowboat_inventory.png",
	wield_image = "rowboat_wield.png",
	wield_scale = {x = 2, y = 2, z = 1},
	liquids_pointable = true,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if not is_water(pointed_thing.under) then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y + 0.5
		core.add_entity(pointed_thing.under, "boats:row_boat")
		if not core.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})


local sail_boat = {
	physical = true,
	collisionbox = {-1,-0.5,-1, 1,2,1},
	visual = "mesh",
	mesh = "sailboat.b3d",
	textures = {"sailboat.png"},
	driver = nil,
	v = 0,
	stepcount = 0,
	unattended = 0
}


function sail_boat.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local name = clicker:get_player_name()
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand" , 30)
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=11,z=0}, {x=0,y=0,z=0})
		default.player_attached[name] = true
		core.after(0.2, function()
			default.player_set_animation(clicker, "sit" , 30)
		end)
		self.object:setyaw(clicker:get_look_yaw() - math.pi / 2)
	end
end

function sail_boat.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal = 1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
	self.last_v = self.v
end

function sail_boat.get_staticdata(self)
	return tostring(self.v)
end

function sail_boat.on_punch(self, puncher, time_from_last_punch, tool_capabilities, direction)
	if not puncher or not puncher:is_player() or self.removed then
		return
	end
	puncher:set_detach()
	default.player_attached[puncher:get_player_name()] = false

	self.removed = true
	-- delay remove to ensure player is detached
	core.after(0.1, function()
		self.object:remove()
	end)
	if not core.settings:get_bool("creative_mode") then
		puncher:get_inventory():add_item("main", "boats:sail_boat")
	end
end

function sail_boat.on_step(self, dtime)
	self.v = get_v(self.object:getvelocity()) * get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		local yaw = self.object:getyaw()
		if ctrl.up then
			self.v = self.v + 0.1
		end
		if ctrl.down then
			self.v = self.v - 0.08
		end
		if ctrl.left then
			if ctrl.down then
				self.object:setyaw(yaw - (1 + dtime) * 0.03)
			else
				self.object:setyaw(yaw + (1 + dtime) * 0.03)
			end
		end
		if ctrl.right then
			if ctrl.down then
				self.object:setyaw(yaw + (1 + dtime) * 0.03)
			else
				self.object:setyaw(yaw - (1 + dtime) * 0.03)
			end
		end
	end
	local velo = self.object:getvelocity()
	if self.v == 0 and velo.x == 0 and velo.y == 0 and velo.z == 0 then
		return
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.015 * s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x = 0, y = 0, z = 0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 4.5 then
		self.v = 4.5 * get_sign(self.v)
	end

	local p = self.object:getpos()
	p.y = p.y - 0.5
	local new_velo = {x = 0, y = 0, z = 0}
	local new_acce = {x = 0, y = 0, z = 0}
	if not is_water(p) then
		local nodedef = core.registered_nodes[core.get_node(p).name]
		if (not nodedef) or nodedef.walkable then
			self.v = 0
			new_acce = {x = 0, y = 1, z = 0}
		else
			new_acce = {x = 0, y = -9.8, z = 0} -- freefall in air -9.81
		end
		new_velo = get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y)
	else
		p.y = p.y + 1
		if is_water(p) then
			new_acce = {x = 0, y = 3, z = 0}
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
				self.object:setacceleration({x = 0, y = 10, z = 0})
			end
			new_velo = get_velocity(self.v, self.object:getyaw(), y)
		else
			new_acce = {x = 0, y = 0, z = 0}
			if math.abs(self.object:getvelocity().y) <= 2 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y) + 0.5
				self.object:setpos(pos)
				new_velo = get_velocity(self.v, self.object:getyaw(), 0)
			else
				new_velo = get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y)
			end
		end
	end
	self.object:setvelocity(new_velo)
	self.object:setacceleration(new_acce)
end

core.register_entity(":boats:sail_boat", sail_boat)
core.register_alias("boats:sailboat", "boats:sail_boat")

core.register_craftitem(":boats:sail_boat", {
	description = "Sail Boat",
	inventory_image = "sailboat_inventory.png",
	wield_image = "sailboat_wield.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if not is_water(pointed_thing.under) then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y+0.5
		core.add_entity(pointed_thing.under, "boats:sail_boat")
		if not core.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})


local scripts = {
	"crafting",
}

for index, script in ipairs(scripts) do
	dofile(boats2.modpath .. "/" .. script .. ".lua")
end
