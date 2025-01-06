
local S = core.get_translator(core.get_current_modname())


-- WORMS --------------------------------------------------

core.register_node("glow:cave_worms", {
	description = S("Glow Worms"),
	drawtype = "nodebox",
	tiles = { "worms.png" },
	inventory_image = "worms.png",
	wield_image = "worms.png",
	groups = { dig_immediate = 2 },
	sounds = default.node_sound_stone_defaults(),
	drop = "glow:cave_worms",
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = { -1/2, -1/2, -1/2, 1/2, -15/32, 1/2 },
	},
	selection_box = {
		type = "fixed",
		fixed = { -1/2, -1/2, -1/2, 1/2, -7/16, 1/2 },
	},
	on_place = core.rotate_node,
})

local function near_surface(pos)
	for dx = -1, 1, 1 do
		for dy = -1, 1, 1 do
			for dz = -1, 1, 1 do
				local dpos = { x=pos.x+dx, y=pos.y+dy, z=pos.z+dz }
				local light = core.get_node_light(dpos, 0.5) -- 0.5 means noon
				if light and light > 5 then
					return true
				end
			end
		end
	end
	return false
end

local function place_worms(pos)
	local axes = {
		{ x=pos.x,   y=pos.y-1, z=pos.z   },
		{ x=pos.x,   y=pos.y,   z=pos.z-1 },
		{ x=pos.x,   y=pos.y,   z=pos.z+1 },
		{ x=pos.x-1, y=pos.y,   z=pos.z   },
		{ x=pos.x+1, y=pos.y,   z=pos.z   },
		{ x=pos.x,   y=pos.y+1, z=pos.z   },
	}
	for i, cpos in ipairs(axes) do
		if core.get_node(cpos).name == "default:stone" then
			local facedir = (i-1) * 4 + math.random(0, 3) -- see 6d facedir info
			core.set_node(pos, { name = "glow:cave_worms", param2 = facedir })
			return
		end
	end
end

local function make_worms(pos)
	local spot = core.find_node_near(pos, 1, "air")
	if not spot or near_surface(spot) then
		return
	end
	local minp = vector.subtract(pos, 6)
	local maxp = vector.add(pos, 6)
	if  #(core.find_nodes_in_area(minp, maxp, "default:lava_source")) == 0
	and #(core.find_nodes_in_area(minp, maxp, "glow:cave_worms")) == 0
	and #(core.find_nodes_in_area(minp, maxp, "group:water")) > 1 then
		place_worms(spot)
	end
end

core.register_on_generated(function(minp, maxp)
	for _,pos in pairs(core.find_nodes_in_area(minp, maxp, "default:stone")) do
		if math.random() < 0.001 then
			make_worms(pos)
		end
	end
end)

core.register_abm({
	nodenames = { "default:stone" },
	neighbors = { "air" },
	interval = 120.0,
	chance = 200,
	action = make_worms,
})

core.register_abm({
	nodenames = { "glow:cave_worms" },
	interval = 60.0,
	chance = 10,
	action = function(pos)
		if math.random() < 0.7 then
			local minp = vector.subtract(pos, 2)
			local maxp = vector.add(pos, 2)
			local worms_count = #(core.find_nodes_in_area(minp, maxp, "glow:cave_worms"))
			if worms_count < 20 then
				local spot = core.find_node_near(pos, 3, "air")
				if spot and not near_surface(spot) then
					place_worms(spot)
					return
				end
			end
		end
		core.remove_node(pos)
	end,
})

--[[
function is_facing(pos, nodename)
	for d = -1, 1, 2 do
		if nodename == core.get_node({pos.x+d, pos.y,   pos.z  }).name then return true end
		if nodename == core.get_node({pos.x,   pos.y+d, pos.z  }).name then return true end
		if nodename == core.get_node({pos.x,   pos.y,   pos.z+d}).name then return true end
	end
	return false
end--]]

-- clean up stupid way of doing worms ---------------------

core.register_node("glow:stone_with_worms", {
	description = S("Glow Worms in Stone"),
	tiles = { "default_stone.png^worms.png" },
	is_ground_content = true,
	groups = { cracky = 1 },
	sounds = default.node_sound_stone_defaults(),
	drop = "glow:stone_with_worms",
	paramtype = "light",
	light_source = 4,
})

core.register_abm({
	nodenames = { "glow:stone_with_worms" },
	interval = 60.0,
	chance = 1,
	action = function(pos)
		core.set_node(pos, { name = "default:stone" })
	end,
})


-- SHROOMS -------------------------------------------------

core.register_node("glow:shrooms", {
	description = S("Glow Shrooms"),
	drawtype = "plantlike",
	tiles = { "shrooms.png" },
	inventory_image = "shrooms.png",
	wield_image = "shrooms.png",
	drop = 'glow:shrooms',
	groups = { snappy=3, flammable=2, flower=1, flora=1, attached_node=1 },
	sunlight_propagates = true,
	walkable = false,
	pointable = true,
	diggable = true,
	climbable = false,
	buildable_to = true,
	paramtype = "light",
	light_source = 3,
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, 0.0, 0.4 },
	},
})

local function add_shrooms(pos)
	if core.find_node_near(pos, 2, "glow:shrooms") then
		return
	end
	for nx = -1, 1, 2 do
		for nz = -1, 1, 2 do
			for ny = 1, -1, -1 do
				if math.random() < 0.2 then
					local p = { x=pos.x+nx, y=pos.y-1+ny, z=pos.z+nz }
					if core.get_item_group(core.get_node(p).name, "soil") ~= 0 then
						p.y = p.y+1
						if core.get_node(p).name == "air" then
							core.set_node(p, { name = "glow:shrooms" })
						end
						break
					end
				end
			end
		end
	end
end

core.register_on_generated(function(minp, maxp)
	for _,pos in pairs(core.find_nodes_in_area(minp, maxp, "default:tree")) do
		if math.random() < 0.2
		and core.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name ~= "default:tree" then
			add_shrooms(pos)
		end
	end
end)

core.register_abm({
	nodenames = { "default:tree" },
	neighbors = {
		"air",
		"group:soil",
	},
	interval = 60.0,
	chance = 60,
	action = function(pos)
		local minp = vector.subtract(pos, 1)
		local maxp = vector.add(pos, 1)
		local shroom_count = #(core.find_nodes_in_area(minp, maxp, "glow:shrooms"))
		if shroom_count == 0 or (shroom_count == 1 and math.random() < 0.3) then
			add_shrooms(pos)
		end
	end,
})

core.register_abm({
	nodenames = { "glow:shrooms" },
	neighbors = {
		"air",
		"group:soil",
	},
	interval = 40.0,
	chance = 10,
	action = function(pos)
		if math.random() < 0.3 then
			add_shrooms(pos)
		else
			core.remove_node(pos)
		end
	end,
})


-- FIREFLIES ----------------------------------------------

core.register_node("glow:fireflies", {
	description = S("Fireflies"),
	drawtype = "glasslike",
	tiles = {
		{
			name = "fireflies.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	[core.features.use_texture_alpha and "use_texture_alpha" or "alpha"] = core.features.use_texture_alpha and "clip" or 100,
	paramtype = "light",
	light_source = 4,
	walkable = false,
	pointable = false,
	diggable = false,
	climbable = false,
	buildable_to = true,
	drop = "",
})

core.register_abm({
	nodenames = { "air" },
	neighbors = {
		"default:grass_1",
		"default:grass_2",
		"default:grass_3",
		"default:grass_4",
		"default:grass_5",
	},
	interval = 2.0,
	chance = 300,
	action = function(pos)
		local time = core.get_timeofday()
		if time <= 0.74 and time >= 0.22 then
			return
		end
		if not core.find_node_near(pos, 9, "glow:fireflies") then
			core.set_node(pos, {name = "glow:fireflies"})
		end
	end,
})

core.register_abm({
	nodenames = {"glow:fireflies"},
	interval = 1.0,
	chance = 2,
	action = core.remove_node,
})
