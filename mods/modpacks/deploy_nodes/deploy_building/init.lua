--[[

Deploy Nodes for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-deploy_nodes
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-deploy_nodes/master/LICENSE

Shape based on livehouse mod by neko259: http://minetest.net/forum/viewtopic.php?id=1675

BUILDING

]]--


-- expose api
deploy_building = {}


-- get_files 
deploy_building.get_files = function(size)
	local modpath = minetest.get_modpath("deploy_building")
	local output
	if os.getenv('HOME')~=nil then 
		os.execute('\\ls -a "'..modpath..'/buildings/'..size..'/" | grep .we > "'..modpath..'/buildings/'..size..'/_buildings"') -- linux/mac
		local file, err = io.open(modpath..'/buildings/'..size..'/_buildings', "rb")
		if err ~= nil then
			return
		end
		output = file:lines()
	else
		output = io.popen('dir "'..modpath..'\\buildings\\'..size..'\\*.we" /b'):lines()  -- windows
	end
    local i, t = 0, {}
    for filename in output do
        i = i + 1
        t[i] = filename
    end
    return t
end


-- deploy
deploy_building.deploy = function(originpos, placer, size)

	-- load building data
	local files = deploy_building.get_files(size)
	local filepath = minetest.get_modpath("deploy_building").."/buildings/"..size.."/"..files[math.random(#files)]
	local file, err = io.open(filepath, "rb")
	if err ~= nil then
		minetest.chat_send_player(placer:get_player_name(), "[deploy_building] error: could not open file \"" .. filepath .. "\"")
		return
	end
	local contents = file:read("*a")
	file:close()
	
	-- check for space
	if deploy_nodes.check_for_space==true then
		local minpos = {x=0,y=0,z=0}
		local maxpos = {x=0,y=0,z=0}
		for x, y, z, name, param1, param2 in contents:gmatch("([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([^%s]+)%s+(%d+)%s+(%d+)[^\r\n]*[\r\n]*") do
			x = tonumber(x)
			y = tonumber(y)
			z = tonumber(z)
			if x < minpos.x then minpos.x = x end
			if y < minpos.y then minpos.y = y end
			if z < minpos.z then minpos.z = z end
			if x > maxpos.x then maxpos.x = x end
			if y > maxpos.y then maxpos.y = y end
			if z > maxpos.z then maxpos.z = z end
		end
		for x=minpos.x,maxpos.x do
		for y=minpos.y,maxpos.y do
		for z=minpos.z,maxpos.z do
			if x~=0 or y~=0 or z~=0 then
			local checkpos = {x=originpos.x+x,y=originpos.y+y,z=originpos.z+z}
			local checknode = minetest.get_node(checkpos).name
				if checknode~="air" then
					minetest.chat_send_player(placer:get_player_name(), "[deploy_building] no room to build because "..checknode.." is in the way at "..dump(checkpos).."")
					return
				end
			end
		end
		end
		end
	end
	
	-- remove building node
	minetest.remove_node(originpos)
	
	-- create building
	local pos = {x=0, y=0, z=0}
	local node = {name="", param1=0, param2=0}
	for x, y, z, name, param1, param2 in contents:gmatch("([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([^%s]+)%s+(%d+)%s+(%d+)[^\r\n]*[\r\n]*") do
		pos.x = originpos.x + tonumber(x)
		pos.y = originpos.y + tonumber(y)
		pos.z = originpos.z + tonumber(z)
		node.name = name
		node.param1 = param1
		node.param2 = param2
		minetest.add_node(pos, node)
	end
	
end


-- small
minetest.register_node("deploy_building:small", {
    description = "Small Building",
    tiles = {"default_wood.png^deploy_building_small.png"},
    groups = {dig_immediate=3},
	after_place_node = function(pos,placer)
		deploy_building.deploy(pos,placer,"small")
	end,
})
minetest.register_craft({
    output = "deploy_building:small",
    recipe = {
		{"deploy_building:blueprint", "default:wood", "default:stone"},
    },
})

-- medium
minetest.register_node("deploy_building:medium", {
    description = "Medium Building",
    tiles = {"default_wood.png^deploy_building_medium.png"},
    groups = {dig_immediate=3},
	after_place_node = function(pos,placer)
		deploy_building.deploy(pos,placer,"medium")
	end,
})
minetest.register_craft({
    output = "deploy_building:medium",
    recipe = {
		{"deploy_building:blueprint", "deploy_building:small", "deploy_building:small"},
    },
})

-- large
minetest.register_node("deploy_building:large", {
    description = "Large Building",
    tiles = {"default_wood.png^deploy_building_large.png"},
    groups = {dig_immediate=3},
	after_place_node = function(pos,placer)
		deploy_building.deploy(pos,placer,"large")
	end,
})
minetest.register_craft({
    output = "deploy_building:large",
    recipe = {
		{"deploy_building:blueprint", "deploy_building:medium", "deploy_building:medium"},
    },
})

-- arrow
table.insert(arrows,{"deploy_building:arrow", "deploy_building:arrow_entity"})
minetest.register_craftitem("deploy_building:arrow", {
	description = "Building Arrow",
	inventory_image = "deploy_building_arrow.png",
})
minetest.register_node("deploy_building:arrow_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"deploy_building_arrow.png", "deploy_building_arrow.png", "deploy_building_arrow_back.png", "deploy_building_arrow_front.png", "deploy_building_arrow_2.png", "deploy_building_arrow.png"},
})
minetest.register_entity("deploy_building:arrow_entity", {
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"deploy_building:arrow_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	player = "",
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)
		if self.timer>0.2 then
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "deploy_building:arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
						if self.player ~= "" then
							self.player:setpos(pos)
							self.player:get_inventory():add_item("main", ItemStack("deploy_building:arrow"))
						end
						self.object:remove()
					end
				else
					if self.player ~= "" then
						self.player:setpos(pos)
						self.player:get_inventory():add_item("main", ItemStack("deploy_building:arrow"))
					end
					self.object:remove()
				end
			end
		end
		if self.lastpos.x~=nil then
			if node.name ~= "air" then
				deploy_building.deploy(self.lastpos,self.player,"small")
				self.object:remove()
			end
		end
		self.lastpos={x=pos.x, y=pos.y, z=pos.z}
	end,
})
minetest.register_craft({
	output = "deploy_building:arrow",
	recipe = {
		{"default:stick", "default:stick", "deploy_building:small"},
	}
})

-- blueprint
minetest.register_craftitem("deploy_building:blueprint", {
	description = "Building Blueprint",
	inventory_image = "deploy_nodes_blueprint.png^deploy_building_blueprint.png",
})
minetest.register_craft({
	output = "deploy_building:blueprint",
	recipe = {
		{"deploy_nodes:blueprint", "", "deploy_nodes:blueprint"},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
