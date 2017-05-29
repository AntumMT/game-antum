--[[

Deploy Nodes for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-deploy_nodes
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-deploy_nodes/master/LICENSE

Shape based on WorldEdit mod by Temperest: http://minetest.net/forum/viewtopic.php?id=2398

PYRAMID

]]--


-- expose api
deploy_pyramid = {}


-- deploy
deploy_pyramid.deploy =  function(pos,placer,nodename,height)

	-- check for space
	if deploy_nodes.check_for_space==true then
		for x=-height*0.5,height*0.5 do
		for y=0,height do
		for z=-height*0.5,height*0.5 do
			if x~=0 or y~=0 or z~=0 then
				local checkpos = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
				local checknode = minetest.env:get_node(checkpos).name
				if checknode~="air" then
					minetest.chat_send_player(placer:get_player_name(), "[deploy_pyramid] no room to build because "..checknode.." is in the way at "..dump(checkpos).."")
					return
				end
			end
		end
		end
		end
	end

	-- remove pyramid node
	minetest.env:remove_node(pos)

	-- build the pyramid
	local pos1 = {x=pos.x-height, y=pos.y, z=pos.z-height}
	local pos2 = {x=pos.x+height, y=pos.y+height, z=pos.z+height}
	local np = {x=0, y=pos1.y, z=0}
	local node = {name=nodename}
	while np.y <= pos2.y do --each vertical level of the pyramid
		np.x = pos1.x
		while np.x <= pos2.x do
			np.z = pos1.z
			while np.z <= pos2.z do
				minetest.env:add_node({x=np.x-height*0.5,y=np.y,z=np.z-height*0.5}, node)
				np.z = np.z + 1
			end
			np.x = np.x + 1
		end
		np.y = np.y + 1
		pos1.x, pos2.x = pos1.x + 1, pos2.x - 1
		pos1.z, pos2.z = pos1.z + 1, pos2.z - 1
	end

end


-- register
deploy_pyramid.register = function(label,name,material,texture)

	-- small
	minetest.register_node("deploy_pyramid:"..name.."_small", {
		description = "Small "..label.." Pyramid",
		tiles = {texture.."^deploy_pyramid_small.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_pyramid.deploy(pos,placer,material,3,1,1)
		end,
	})
	minetest.register_craft({
		output = "deploy_pyramid:"..name.."_small",
		recipe = {
			{"deploy_pyramid:blueprint", material, material},
		},
	})

	-- medium
	minetest.register_node("deploy_pyramid:"..name.."_medium", {
		description = "Medium "..label.." Pyramid",
		tiles = {texture.."^deploy_pyramid_medium.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_pyramid.deploy(pos,placer,material,6,2,2)
		end,
	})
	minetest.register_craft({
		output = "deploy_pyramid:"..name.."_medium",
		recipe = {
			{"deploy_pyramid:blueprint", "deploy_pyramid:"..name.."_small", "deploy_pyramid:"..name.."_small"},
		},
	})

	-- large
	minetest.register_node("deploy_pyramid:"..name.."_large", {
		description = "Large "..label.." Pyramid",
		tiles = {texture.."^deploy_pyramid_large.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_pyramid.deploy(pos,placer,material,12,4,3)
		end,
	})
	minetest.register_craft({
		output = "deploy_pyramid:"..name.."_large",
		recipe = {
			{"deploy_pyramid:blueprint", "deploy_pyramid:"..name.."_medium", "deploy_pyramid:"..name.."_medium"},
		},
	})

	-- arrow
	table.insert(arrows,{"deploy_pyramid:"..name.."_arrow", "deploy_pyramid:"..name.."_arrow_entity"})
	minetest.register_craftitem("deploy_pyramid:"..name.."_arrow", {
		description = label.." Pyramid Arrow",
		inventory_image = "deploy_pyramid_arrow.png",
	})
	minetest.register_node("deploy_pyramid:"..name.."_arrow_box", {
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
		tiles = {"deploy_pyramid_arrow.png", "deploy_pyramid_arrow.png", "deploy_pyramid_arrow_back.png", "deploy_pyramid_arrow_front.png", "deploy_pyramid_arrow_2.png", "deploy_pyramid_arrow.png"},
	})
	minetest.register_entity("deploy_pyramid:"..name.."_arrow_entity", {
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"deploy_pyramid:"..name.."_arrow_box"},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		player = "",
		on_step = function(self, dtime)
			self.timer=self.timer+dtime
			local pos = self.object:getpos()
			local node = minetest.env:get_node(pos)
			if self.timer>0.2 then
				local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
				for k, obj in pairs(objs) do
					if obj:get_luaentity() ~= nil then
						if obj:get_luaentity().name ~= "deploy_pyramid:"..name.."_arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							if self.player ~= "" then
								self.player:setpos(pos)
								self.player:get_inventory():add_item("main", ItemStack("deploy_pyramid:"..name.."_arrow"))
							end
							self.object:remove()
						end
					else
						if self.player ~= "" then
							self.player:setpos(pos)
							self.player:get_inventory():add_item("main", ItemStack("deploy_pyramid:"..name.."_arrow"))
						end
						self.object:remove()
					end
				end
			end
			if self.lastpos.x~=nil then
				if node.name ~= "air" then
					deploy_pyramid.deploy(self.lastpos,self.player,material,3,1,1)
					self.object:remove()
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end,
	})
	minetest.register_craft({
		output = "deploy_pyramid:"..name.."_arrow",
		recipe = {
			{"default:stick", "default:stick", "deploy_pyramid:"..name.."_small"},
		}
	})
	
end


-- register pyramids
deploy_pyramid.register("Dirt","dirt","default:dirt","default_dirt.png")
deploy_pyramid.register("Wood","wood","default:wood","default_wood.png")
deploy_pyramid.register("Brick","brick","default:brick","default_brick.png")
deploy_pyramid.register("Cobble","cobble","default:cobble","default_cobble.png")
deploy_pyramid.register("Stone","stone","default:stone","default_stone.png")
deploy_pyramid.register("Glass","glass","default:glass","default_glass.png")


-- blueprint
minetest.register_craftitem("deploy_pyramid:blueprint", {
	description = "Pyramid Blueprint",
	inventory_image = "deploy_nodes_blueprint.png^deploy_pyramid_blueprint.png",
})
minetest.register_craft({
	output = "deploy_pyramid:blueprint",
	recipe = {
		{"", "deploy_nodes:blueprint", ""},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
