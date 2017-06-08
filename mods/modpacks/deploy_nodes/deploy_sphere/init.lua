--[[

Deploy Nodes for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-deploy_nodes
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-deploy_nodes/master/LICENSE

Shape based on Multinode mod by mauvebic: http://minetest.net/forum/viewtopic.php?id=2398

SPHERE

]]--


-- expose api
deploy_sphere = {}


-- deploy
deploy_sphere.deploy =  function(pos,placer,nodename,radius)

	-- set the pos to the center of the node
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+0.5)
	pos.z = math.floor(pos.z+0.5)

	-- check for space
	if deploy_nodes.check_for_space==true then
		for x=-radius,radius do
		for y=-radius,radius do
		for z=-radius,radius do
			if x*x+y*y+z*z <= radius * radius + radius then
				if x~=0 or y~=radius*-1 or z~=0 then
					local checkpos = {x=pos.x+x,y=pos.y+y+radius,z=pos.z+z}
					local checknode = minetest.get_node(checkpos).name
					if checknode~="air" then
						minetest.chat_send_player(placer:get_player_name(), "[deploy_sphere] no room to build because "..checknode.." is in the way at "..dump(checkpos).."")
						return
					end
				end
			end
		end
		end
		end
	end

	-- remove sphere node
	minetest.remove_node(pos)

	-- build the sphere
	local hollow = 1
	for x=-radius,radius do
	for y=-radius,radius do
	for z=-radius,radius do
		if x*x+y*y+z*z >= (radius-hollow) * (radius-hollow) + (radius-hollow) and x*x+y*y+z*z <= radius * radius + radius then
			minetest.add_node({x=pos.x+x,y=pos.y+y+radius,z=pos.z+z},{name=nodename})
		end
	end
	end
	end
	
end


-- register
deploy_sphere.register = function(label,name,material,texture)

	-- small
	minetest.register_node("deploy_sphere:"..name.."_small", {
		description = "Small "..label.." Sphere",
		tiles = {texture.."^deploy_sphere_small.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_sphere.deploy(pos,placer,material,3)
		end,
	})
	minetest.register_craft({
		output = "deploy_sphere:"..name.."_small",
		recipe = {
			{"deploy_sphere:blueprint", material, material},
		},
	})

	-- medium
	minetest.register_node("deploy_sphere:"..name.."_medium", {
		description = "Medium "..label.." Sphere",
		tiles = {texture.."^deploy_sphere_medium.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_sphere.deploy(pos,placer,material,6)
		end,
	})
	minetest.register_craft({
		output = "deploy_sphere:"..name.."_medium",
		recipe = {
			{"deploy_sphere:blueprint", "deploy_sphere:"..name.."_small", "deploy_sphere:"..name.."_small"},
		},
	})

	-- large
	minetest.register_node("deploy_sphere:"..name.."_large", {
		description = "Large "..label.." Sphere",
		tiles = {texture.."^deploy_sphere_large.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_sphere.deploy(pos,placer,material,12)
		end,
	})
	minetest.register_craft({
		output = "deploy_sphere:"..name.."_large",
		recipe = {
			{"deploy_sphere:blueprint", "deploy_sphere:"..name.."_medium", "deploy_sphere:"..name.."_medium"},
		},
	})
	
	-- arrow
	table.insert(arrows,{"deploy_sphere:"..name.."_arrow", "deploy_sphere:"..name.."_arrow_entity"})
	minetest.register_craftitem("deploy_sphere:"..name.."_arrow", {
		description = label.." Sphere Arrow",
		inventory_image = "deploy_sphere_arrow.png",
	})
	minetest.register_node("deploy_sphere:"..name.."_arrow_box", {
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
		tiles = {"deploy_sphere_arrow.png", "deploy_sphere_arrow.png", "deploy_sphere_arrow_back.png", "deploy_sphere_arrow_front.png", "deploy_sphere_arrow_2.png", "deploy_sphere_arrow.png"},
	})
	minetest.register_entity("deploy_sphere:"..name.."_arrow_entity", {
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"deploy_sphere:"..name.."_arrow_box"},
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
						if obj:get_luaentity().name ~= "deploy_sphere:"..name.."_arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							if self.player ~= "" then
								self.player:setpos(pos)
								self.player:get_inventory():add_item("main", ItemStack("deploy_sphere:"..name.."_arrow"))
							end
							self.object:remove()
						end
					else
						if self.player ~= "" then
							self.player:setpos(pos)
							self.player:get_inventory():add_item("main", ItemStack("deploy_sphere:"..name.."_arrow"))
						end
						self.object:remove()
					end
				end
			end
			if self.lastpos.x~=nil then
				if node.name ~= "air" then
					deploy_sphere.deploy(self.lastpos,self.player,material,3)
					self.object:remove()
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end,
	})
	minetest.register_craft({
		output = "deploy_sphere:"..name.."_arrow",
		recipe = {
			{"default:stick", "default:stick", "deploy_sphere:"..name.."_small"},
		}
	})

end


-- register spheres
deploy_sphere.register("Dirt","dirt","default:dirt","default_dirt.png")
deploy_sphere.register("Wood","wood","default:wood","default_wood.png")
deploy_sphere.register("Brick","brick","default:brick","default_brick.png")
deploy_sphere.register("Cobble","cobble","default:cobble","default_cobble.png")
deploy_sphere.register("Stone","stone","default:stone","default_stone.png")
deploy_sphere.register("Glass","glass","default:glass","default_glass.png")


-- blueprint
minetest.register_craftitem("deploy_sphere:blueprint", {
	description = "Sphere Blueprint",
	inventory_image = "deploy_nodes_blueprint.png^deploy_sphere_blueprint.png",
})
minetest.register_craft({
	output = "deploy_sphere:blueprint",
	recipe = {
		{"", "deploy_nodes:blueprint", ""},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
		{"", "deploy_nodes:blueprint", ""},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
