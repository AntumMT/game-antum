--[[ From TNT

License of source code
----------------------

The MIT License (MIT)
Copyright (C) 2014-2016 PilzAdam
Copyright (C) 2014-2016 ShadowNinja
Copyright (C) 2016 sofar (sofar@foo-projects.org)
Copyright (C) 2014-2016 Various Minetest developers and contributors

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

For more details:
https://opensource.org/licenses/MIT

===================================

Licenses of media
-----------------

Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
Copyright (C) 2014-2016 BlockMen
Copyright (C) 2014-2016 ShadowNinja
Copyright (C) 2015-2016 Wuzzy
Copyright (C) 2016 sofar (sofar@foo-projects.org)
Copyright (C) 2018 paramat

You are free to:
Share — copy and redistribute the material in any medium or format.
Adapt — remix, transform, and build upon the material for any purpose, even commercially.
The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:

Attribution — You must give appropriate credit, provide a link to the license, and
indicate if changes were made. You may do so in any reasonable manner, but not in any way
that suggests the licensor endorses you or your use.

ShareAlike — If you remix, transform, or build upon the material, you must distribute
your contributions under the same license as the original.

No additional restrictions — You may not apply legal terms or technological measures that
legally restrict others from doing anything the license permits.

Notices:

You do not have to comply with the license for elements of the material in the public
domain or where your use is permitted by an applicable exception or limitation.
No warranties are given. The license may not give you all of the permissions necessary
for your intended use. For example, other rights such as publicity, privacy, or moral
rights may limit how you use the material.

For more details:
http://creativecommons.org/licenses/by-sa/3.0/

====================================================

CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
for audio files (found in sounds folder)
TumeniNodes
steveygos93
theneedle.tv
frankelmedico

No Copyright

The person who associated a work with this deed has dedicated the work to the public domain
by waiving all of his or her rights to the work worldwide under copyright law, including all
related and neighboring rights, to the extent allowed by law.

You can copy, modify, distribute and perform the work, even for commercial purposes, all
without asking permission. See Other Information below.

In no way are the patent or trademark rights of any person affected by CC0, nor are the
rights that other persons may have in the work or in how the work is used, such as publicity
or privacy rights.

Unless expressly stated otherwise, the person who associated a work with this deed makes no
warranties about the work, and disclaims liability for all uses of the work, to the fullest
extent permitted by applicable law.

When using or citing the work, you should not imply endorsement by the author or the affirmer.

This license is acceptable for Free Cultural Works.
For more Information:
https://creativecommons.org/publicdomain/zero/1.0/
]]


local cid_data = {}
local radius = tonumber(core.settings:get("tnt_radius") or 3)
local large_radius = 5
local loss_prob = {
	["default:cobble"] = 3,
	["default:dirt"] = 4,
}
core.after(0, function()
	for name, def in pairs(core.registered_nodes) do
		cid_data[core.get_content_id(name)] = {
			name = name,
			drops = def.drops,
			flammable = def.groups.flammable,
		}
	end
end)

local function rand_pos(center, pos, radius)
	pos.x = center.x + math.random(-radius, radius)
	pos.z = center.z + math.random(-radius, radius)
end

local function eject_drops(drops, pos, radius)
	local drop_pos = vector.new(pos)
	for _, item in pairs(drops) do
		local count = item:get_count()
		local max = item:get_stack_max()
		if count > max then
			item:set_count(max)
		end
		while count > 0 do
			if count < max then
				item:set_count(count)
			end
			rand_pos(pos, drop_pos, radius)
			local obj = core.add_item(drop_pos, item)
			if obj then
				obj:get_luaentity().collect = true
				obj:set_acceleration({x=0, y=-10, z=0})
				obj:set_velocity({x=math.random(-3, 3), y=10,
						z=math.random(-3, 3)})
			end
			count = count - max
		end
	end
end

local function add_drop(drops, item)
	item = ItemStack(item)
	local name = item:get_name()
	if loss_prob[name] ~= nil and math.random(1, loss_prob[name]) == 1 then
		return
	end

	local drop = drops[name]
	if drop == nil then
		drops[name] = item
	else
		drop:set_count(drop:get_count() + item:get_count())
	end
end

local function is_protected(pos, name) return core.is_protected(pos, name) end
if core.global_exists("s_protect") then
	is_protected = function(pos, name)
		local s_protect_name = name
		-- simple_protection ignores names with empty strings
		if s_protect_name == "" then
			s_protect_name = " "
		end

		return core.is_protected(pos, name) or not s_protect.can_access(pos, s_protect_name)
	end
end

local function destroy(drops, pos, cid)
	if is_protected(pos, "") then
		return
	end
	local def = cid_data[cid]
	if def and def.on_blast then
		def.on_blast(vector.new(pos), 1)
		return
	end
	core.remove_node(pos)
	if def then
		local node_drops = core.get_node_drops(def.name, "")
		for _, item in ipairs(node_drops) do
			add_drop(drops, item)
		end
	end
end


local function calc_velocity(pos1, pos2, old_vel, power)
	local vel = vector.direction(pos1, pos2)
	vel = vector.normalize(vel)
	vel = vector.multiply(vel, power)

	-- Divide by distance
	local dist = vector.distance(pos1, pos2)
	dist = math.max(dist, 1)
	vel = vector.divide(vel, dist)

	-- Add old velocity
	vel = vector.add(vel, old_vel)
	return vel
end

local function entity_physics(pos, radius)
	-- Make the damage radius larger than the destruction radius
	radius = radius * 2
	local objs = core.get_objects_inside_radius(pos, radius)
	for _, obj in pairs(objs) do
		local obj_pos = obj:get_pos()
		local obj_vel = obj:get_velocity()
		local dist = math.max(1, vector.distance(pos, obj_pos))

		if obj_vel ~= nil then
			obj:set_velocity(calc_velocity(pos, obj_pos,
					obj_vel, radius * 10))
		end

		local damage = (5 / dist) * radius
		obj:set_hp(obj:get_hp() - damage)
	end
end

local function add_effects(pos, radius)
	core.add_particlespawner({
		amount = 128,
		time = 1,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x=-20, y=-20, z=-20},
		maxvel = {x=20,  y=20,  z=20},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 1,
		maxexptime = 3,
		minsize = 8,
		maxsize = 16,
		texture = "sneeker_smoke.png",
	})
end


local function explode(pos, radius)
	local pos = vector.round(pos)
	local vm = VoxelManip()
	local pr = PseudoRandom(os.time())
	local p1 = vector.subtract(pos, radius)
	local p2 = vector.add(pos, radius)
	local minp, maxp = vm:read_from_map(p1, p2)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	local drops = {}
	local p = {}

	local c_air = core.get_content_id("air")
	local c_tnt = nil
	if core.settings:get_bool("enable_tnt", false) then
		c_tnt = core.get_content_id("tnt:tnt")
	end

	local c_tnt_burning = core.get_content_id("tnt:tnt_burning")
	local c_gunpowder = core.get_content_id("tnt:gunpowder")
	local c_gunpowder_burning = core.get_content_id("tnt:gunpowder_burning")
	local c_boom = core.get_content_id("tnt:boom")

	for z = -radius, radius do
	for y = -radius, radius do
	local vi = a:index(pos.x + (-radius), pos.y + y, pos.z + z)
	for x = -radius, radius do
		if (x * x) + (y * y) + (z * z) <=
				(radius * radius) + pr:next(-radius, radius) then
			local cid = data[vi]
			p.x = pos.x + x
			p.y = pos.y + y
			p.z = pos.z + z
			if cid == c_tnt or cid == c_gunpowder then
				burn(p)
			elseif cid ~= c_tnt_burning and
					cid ~= c_gunpowder_burning and
					cid ~= c_air and
					cid ~= c_boom then
				destroy(drops, p, cid)
			end
		end
		vi = vi + 1
	end
	end
	end

	return drops
end

function sneeker.boom(pos, large)
	if not pos then return end

	local radius = radius
	if large then
		radius = large_radius
	end
	core.sound_play("sneeker_explode", {pos=pos, gain=1.5, max_hear_distance=2*64})
	core.set_node(pos, {name="tnt:boom"})
	core.get_node_timer(pos):start(0.5)
	local drops = explode(pos, radius)
	entity_physics(pos, radius)
	eject_drops(drops, pos, radius)
	add_effects(pos, radius)
	core.remove_node(pos)
end
