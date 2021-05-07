--localize global functions
local vector_new = vector.new
local math_hypot = math.hypot
local atan = math.atan
local cos = math.cos
local sin = math.sin
local abs = math.abs
local pi = math.pi
local min = math.min

--max speed settings
local max_ballooning_vertical_speed = 1
local max_ballooning_horizontal_speed = 3

local function is_water_is_air(pos)
	local node_name = minetest.get_node(pos).name
	return minetest.get_item_group(node_name, "water") > 0,
		node_name == "air"
end
local function get_vertical_acceleration(self)
	local heat = self.heat
	local vel_y = self.object:getvelocity().y
	local acc_candidate = heat / 1000 - 0.5
	
	--enforce max speed
	if vel_y > max_ballooning_vertical_speed
		and acc_candidate * vel_y > 0
	then
		return 0
	else
		return acc_candidate
	end
end

--if balloon is submerged
local function float_up(self, vel)
	self.submerged = true
	vel.y = 1
	return vel
end

local function swim(self, vel)
	--allow controls, allow up
	local pos = self.object:get_pos()
	--keep y constant or rising
	local acc_y = get_vertical_acceleration(self)
	
	if self.submerged or acc_y < 0
	then
		self.submerged = false
		vel.y = 0
		return 0, vel
	else
		return acc_y, vel
	end
end


local tau = pi * 2
--returns the radian equivalent of a in the range [0, tau)
local function to_radian(a)
	if a < 0
	then
		return to_radian(a + tau)
	elseif a >= tau
	then
		return to_radian(a - tau)
	else
		return a
	end
end
--decides which is the shortest way to rotate towards where the player is looking
local function get_rotate_direction(a, b)
	return to_radian(a - b) < to_radian(b - a)
end

--rotates the balloon towards where the player is looking
local pi_192ths = pi / 192 --radians to turn each step
local function rotate(self, player)
	-- + pi so it finishes rotating when looking towards where the player is looking
	local player_yaw = player:get_look_horizontal() + pi
	local self_yaw = self.object:getyaw()
	
	if get_rotate_direction(player_yaw, self_yaw)
	then
		self.object:setyaw(to_radian(self_yaw - pi_192ths))
	else
		self.object:setyaw(to_radian(self_yaw + pi_192ths))
	end
end

--takes wasd and turns it into a 2d vector
local pi_halves = pi / 2
function get_direction(right, left, up, down)
	local inline, cross = 0, 0
	local move = right or left or up or down
	if left then cross = 1 end
	if right then cross = cross - 1 end
	if up then inline = 1	end
	if down then inline = inline - 1 end
	local arg
	if inline < 0
	then
		return atan(cross / inline) + pi, move
	elseif inline > 0
	then
		return atan(cross / inline), move
	else
		return pi_halves * cross, move
	end
end


--[[
space to rotate where the player is looking
wasd to apply acceleration
shift to let out hot air, cooling the balloon
]]
local function handle_control(self, vel)
	if not self.pilot
	then
		return 0, 0
	end
	local player = minetest.get_player_by_name(self.pilot)
	if not player --player left, balloon should get deleted
	then
		return 0, 0
	end
	local control = player:get_player_control()
	if control.sneak --lowering heat quickly
	then
		local heat = self.heat - 30
		if heat < 0
		then
			self.heat = 0
		else
			self.heat = heat
		end
	end
	
	if control.jump --rotate towards player yaw
	then
		rotate(self, player)
	end
	
	--taking direction from get_direction
	--and turning it into radians.
	--if max speed is reached, only acceleration in the opposite direction is applied.
	local dir_radians, move = get_direction(control.right, control.left, control.up, control.down)
	if move and math_hypot(vel.x, vel.z)
	then
		dir_radians = dir_radians + player:get_look_horizontal()
		local x, z = -sin(dir_radians), cos(dir_radians)
		if math_hypot(vel.x, vel.z) > max_ballooning_horizontal_speed
		then
			if x * vel.x > 0
			then
				x = 0
			end
			if z * vel.z > 0
			then
				z = 0
			end
		end
		return x, z
	end
	return 0, 0
end

--[[handle movement in different cases
movement restrictions:
	-on ground: only vertical movement
	-on water: free movement, though vertical only if up
	-submerged: free movement, vertical goes up automatically
	-in air: completely free movement
]]

return function(self)
	local pos_in = self.object:get_pos()
	local pos_under = vector_new(pos_in.x, pos_in.y - 0.1, pos_in.z)
	local on_water, in_air = is_water_is_air(pos_under)
	local acc = vector_new(0, 0, 0)
	local vel = self.object:getvelocity()
	
	
	if is_water_is_air(pos_in) --if submerged
	then
		vel = float_up(self, vel)
		acc.x, acc.z = handle_control(self, vel)
		self.object:setvelocity(vel)
	elseif on_water --if on water
	then
		acc.y, vel = swim(self, vel)
		self.object:setvelocity(vel)
		acc.x, acc.z = handle_control(self, vel)
	elseif in_air
	then
		--allow controls and height change
		acc.y = get_vertical_acceleration(self)
		acc.x, acc.z = handle_control(self, vel)
	else --if on ground
		--only allow height change
		acc.y = get_vertical_acceleration(self)
		vel.x = 0
		vel.z = 0
		self.object:setvelocity(vel)
	end
	self.object:setacceleration(acc)
end