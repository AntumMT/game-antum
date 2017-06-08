--[[

Deploy Nodes for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-deploy_nodes
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-deploy_nodes/master/LICENSE

SPIRAL

]]--


-- expose api
deploy_spiral = {}


-- deploy
deploy_spiral.deploy =  function(pos,placer,nodename,width,height,spacer)

	-- set the pos to the center of the node
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+0.5)
	pos.z = math.floor(pos.z+0.5)

	height = tonumber(height)-1
	if height < 0 then height = 0 end
	spacer = tonumber(spacer)+1
	if spacer < 1 then spacer = 1 end

	-- check for space
	if deploy_nodes.check_for_space==true then
		for x=width*spacer*-0.5,width*spacer*0.5 do
		for y=0,height-1 do
		for z=width*spacer*-0.5,width*spacer*0.5 do
			if x~=0 or y~=0 or z~=0 then
				local checkpos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
				local checknode = minetest.get_node(checkpos).name
				if checknode~="air" then
					minetest.chat_send_player(placer:get_player_name(), "[deploy_spiral] no room to build because "..checknode.." is in the way at "..dump(checkpos).."")
					return
				end
			end
		end
		end
		end
	end

	-- remove spiral node
	minetest.remove_node(pos)

	-- build the spiral
	-- spiral matrix - http://rosettacode.org/wiki/Spiral_matrix#Lua
	av, sn = math.abs, function(s) return s~=0 and s/av(s) or 0 end
	local function sindex(z, x) -- returns the value at (x, z) in a spiral that starts at 1 and goes outwards
		if z == -x and z >= x then return (2*z+1)^2 end
		local l = math.max(av(z), av(x))
		return (2*l-1)^2+4*l+2*l*sn(x+z)+sn(z^2-x^2)*(l-(av(z)==l and sn(z)*x or sn(x)*z)) -- OH GOD WHAT
	end
	local function spiralt(side)
		local ret, id, start, stop = {}, 0, math.floor((-side+1)/2), math.floor((side-1)/2)
		for i = 1, side do
			for j = 1, side do
				local id = side^2 - sindex(stop - i + 1,start + j - 1)
				ret[id] = {x=i,z=j}
			end
		end
		return ret
	end
	-- connect the joined parts
	local spiral = spiralt(width)
	local node = {name=nodename}
	local np,lp
	for y=0,height do
		lp = nil
		for _,v in ipairs(spiral) do
			np = {
				x=pos.x+v.x*spacer-spacer-width*spacer*0.5, 
				y=pos.y+y, 
				z=pos.z+v.z*spacer-spacer-width*spacer*0.5,
			}
			if lp~=nil then
				if lp.x~=np.x then 
					if lp.x<np.x then 
						for i=lp.x+1,np.x do
							minetest.add_node({x=i, y=np.y, z=np.z}, node)
						end
					else
						for i=np.x,lp.x-1 do
							minetest.add_node({x=i, y=np.y, z=np.z}, node)
						end
					end
				end
				if lp.z~=np.z then 
					if lp.z<np.z then 
						for i=lp.z+1,np.z do
							minetest.add_node({x=np.x, y=np.y, z=i}, node)
						end
					else
						for i=np.z,lp.z-1 do
							minetest.add_node({x=np.x, y=np.y, z=i}, node)
						end
					end
				end
			end
			lp = np
		end
	end
	
end


-- register
deploy_spiral.register = function(label,name,material,texture)

	-- small
	minetest.register_node("deploy_spiral:"..name.."_small", {
		description = "Small "..label.." Spiral",
		tiles = {texture.."^deploy_spiral_small.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_spiral.deploy(pos,placer,material,3,1,1)
		end,
	})
	minetest.register_craft({
		output = "deploy_spiral:"..name.."_small",
		recipe = {
			{"deploy_spiral:blueprint", material, material},
		},
	})

	-- medium
	minetest.register_node("deploy_spiral:"..name.."_medium", {
		description = "Medium "..label.." Spiral",
		tiles = {texture.."^deploy_spiral_medium.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_spiral.deploy(pos,placer,material,6,2,2)
		end,
	})
	minetest.register_craft({
		output = "deploy_spiral:"..name.."_medium",
		recipe = {
			{"deploy_spiral:blueprint", "deploy_spiral:"..name.."_small", "deploy_spiral:"..name.."_small"},
		},
	})

	-- large
	minetest.register_node("deploy_spiral:"..name.."_large", {
		description = "Large "..label.." Spiral",
		tiles = {texture.."^deploy_spiral_large.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_spiral.deploy(pos,placer,material,12,4,3)
		end,
	})
	minetest.register_craft({
		output = "deploy_spiral:"..name.."_large",
		recipe = {
			{"deploy_spiral:blueprint", "deploy_spiral:"..name.."_medium", "deploy_spiral:"..name.."_medium"},
		},
	})

	-- arrow
	table.insert(arrows,{"deploy_spiral:"..name.."_arrow", "deploy_spiral:"..name.."_arrow_entity"})
	minetest.register_craftitem("deploy_spiral:"..name.."_arrow", {
		description = label.." Spiral Arrow",
		inventory_image = "deploy_spiral_arrow.png",
	})
	minetest.register_node("deploy_spiral:"..name.."_arrow_box", {
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
		tiles = {"deploy_spiral_arrow.png", "deploy_spiral_arrow.png", "deploy_spiral_arrow_back.png", "deploy_spiral_arrow_front.png", "deploy_spiral_arrow_2.png", "deploy_spiral_arrow.png"},
	})
	minetest.register_entity("deploy_spiral:"..name.."_arrow_entity", {
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"deploy_spiral:"..name.."_arrow_box"},
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
						if obj:get_luaentity().name ~= "deploy_spiral:"..name.."_arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							if self.player ~= "" then
								self.player:setpos(pos)
								self.player:get_inventory():add_item("main", ItemStack("deploy_spiral:"..name.."_arrow"))
							end
							self.object:remove()
						end
					else
						if self.player ~= "" then
							self.player:setpos(pos)
							self.player:get_inventory():add_item("main", ItemStack("deploy_spiral:"..name.."_arrow"))
						end
						self.object:remove()
					end
				end
			end
			if self.lastpos.x~=nil then
				if node.name ~= "air" then
					deploy_spiral.deploy(self.lastpos,self.player,material,3,1,1)
					self.object:remove()
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end,
	})
	minetest.register_craft({
		output = "deploy_spiral:"..name.."_arrow",
		recipe = {
			{"default:stick", "default:stick", "deploy_spiral:"..name.."_small"},
		}
	})
	
end


-- register spirals
deploy_spiral.register("Dirt","dirt","default:dirt","default_dirt.png")
deploy_spiral.register("Wood","wood","default:wood","default_wood.png")
deploy_spiral.register("Brick","brick","default:brick","default_brick.png")
deploy_spiral.register("Cobble","cobble","default:cobble","default_cobble.png")
deploy_spiral.register("Stone","stone","default:stone","default_stone.png")
deploy_spiral.register("Glass","glass","default:glass","default_glass.png")


-- blueprint
minetest.register_craftitem("deploy_spiral:blueprint", {
	description = "Spiral Blueprint",
	inventory_image = "deploy_nodes_blueprint.png^deploy_spiral_blueprint.png",
})
minetest.register_craft({
	output = "deploy_spiral:blueprint",
	recipe = {
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", ""},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", ""},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
