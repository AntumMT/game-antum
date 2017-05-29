--[[

Deploy Nodes for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-deploy_nodes
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-deploy_nodes/master/LICENSE

Shape based on Maze mod by Echo: http://minetest.net/forum/viewtopic.php?id=2814

MAZE

]]--


-- expose api
deploy_maze = {}


-- deploy
deploy_maze.deploy = function(originpos, placer, material, size, floors)

	-- set the pos to the center of the node
	originpos.x = math.floor(originpos.x+0.5)
	originpos.y = math.floor(originpos.y+0.5)
	originpos.z = math.floor(originpos.z+0.5)
	
	-- setup some variables
	--math.randomseed(os.time())
	local min_size = 11
	local maze_size_x = tonumber(size)
	if maze_size_x == nil then maze_size_x = 20 end
	if maze_size_x < min_size then maze_size_x = min_size end
	local maze_size_z = tonumber(size)
	if maze_size_z == nil then maze_size_z = 20 end
	if maze_size_z < min_size then maze_size_z = min_size end
	local maze_size_l = tonumber(floors)
	if maze_size_l == nil then maze_size_l = 3 end
	if maze_size_l < 1 then maze_size_l = 1 end

	-- get transform factors to place the maze in "look_dir" of player
	local player_dir = placer:get_look_dir()
	local cosine = 1
	local sine = 0
	if math.abs(player_dir.x) > math.abs(player_dir.z) then 
		if player_dir.x > 0 then 
			cosine = 1
			sine = 0
		else
			cosine = -1
			sine = 0
		end
	else
		if player_dir.z < 0 then 
			cosine = 0
			sine = -1
		else
			cosine = 0
			sine = 1
		end
	end

	-- check for space
	if deploy_nodes.check_for_space==true then
		for z = 0, maze_size_l*3+1 do
		for y = 0, maze_size_z - 1, 1 do
		for x = 0, maze_size_x - 1, 1 do
			if x~=0 or y~=0 or z~=0 then
				local checkpos = {}
				checkpos.x = cosine * x - sine * (y - math.floor(maze_size_z / 2)) + originpos.x
				checkpos.z = sine * x + cosine * (y - math.floor(maze_size_z / 2)) + originpos.z
				checkpos.y = originpos.y + y
				local checknode = minetest.env:get_node(checkpos).name
				if checknode~="air" then
					minetest.chat_send_player(placer:get_player_name(), "[deploy_cylinder_y] no room to build because "..checknode.." is in the way at "..dump(checkpos).."")
					return
				end
			end
		end
		end
		end
	end

	-- remove maze node
	minetest.env:remove_node(originpos)

	-- tweak the pos
	originpos.y = originpos.y+1

	-- fill the table with walls
	local maze = {}
	for l = 0, maze_size_l-1, 1 do
		maze[l] = {}
		for x = 0, maze_size_x-1, 1 do
			maze[l][x] = {}
			for y = 0, maze_size_z-1, 1 do
				maze[l][x][y] = true
			end
		end
	end

	-- create maze map
	local start_x = 0
	local start_y = math.floor(maze_size_z/2)
	local start_l = 0
	local pos_x = start_x
	local pos_y = start_y
	local pos_l = start_l
	maze[pos_l][pos_x][pos_y] = false -- the entrance
	local moves = {}
	local updowns = {}
	local possible_ways = {}
	local direction = ""
	local pos = {x = 0, y = 0, l = 0}
	local forward = true
	local dead_end = {}
	table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
	repeat
		possible_ways = {}
		-- is D possible?
		if 
			pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_z - 1 and
			pos_l < maze_size_l - 1 and
			maze[pos_l + 1][pos_x - 1][pos_y - 1] and
			maze[pos_l + 1][pos_x - 1][pos_y] and
			maze[pos_l + 1][pos_x - 1][pos_y + 1] and
			maze[pos_l + 1][pos_x][pos_y - 1] and
			maze[pos_l + 1][pos_x][pos_y] and
			maze[pos_l + 1][pos_x][pos_y + 2] and
			maze[pos_l + 1][pos_x + 1][pos_y - 1] and
			maze[pos_l + 1][pos_x + 1][pos_y] and
			maze[pos_l + 1][pos_x + 1][pos_y + 1]
		then
			table.insert(possible_ways, "D")
		end
		-- is U possible?
		if
			pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_z - 1 and
			pos_l > 0 and
			maze[pos_l - 1][pos_x - 1][pos_y - 1] and
			maze[pos_l - 1][pos_x - 1][pos_y] and
			maze[pos_l - 1][pos_x - 1][pos_y + 1] and
			maze[pos_l - 1][pos_x][pos_y - 1] and
			maze[pos_l - 1][pos_x][pos_y] and
			maze[pos_l - 1][pos_x][pos_y + 2] and
			maze[pos_l - 1][pos_x + 1][pos_y - 1] and
			maze[pos_l - 1][pos_x + 1][pos_y] and
			maze[pos_l - 1][pos_x + 1][pos_y + 1]
		then
			table.insert(possible_ways, "U")
		end
		-- is N possible?
		if
			pos_y - 2 >= 0 and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and 
			maze[pos_l][pos_x][pos_y - 1] and -- N is wall
			maze[pos_l][pos_x][pos_y - 2] and -- N from N is wall
			maze[pos_l][pos_x - 1][pos_y - 2] and -- NW from N is wall
			maze[pos_l][pos_x + 1][pos_y - 2] and -- NE from N is wall
			maze[pos_l][pos_x - 1][pos_y - 1] and -- W from N is wall
			maze[pos_l][pos_x + 1][pos_y - 1] -- E from N is wall
		then
			table.insert(possible_ways, "N")
			table.insert(possible_ways, "N") -- twice as possible as U and D
		end
		-- is E possible?
		if
			pos_x + 2 < maze_size_x and pos_y - 1 >= 0 and pos_y + 1 < maze_size_z and 
			maze[pos_l][pos_x + 1][pos_y] and -- E is wall
			maze[pos_l][pos_x + 2][pos_y] and -- E from E is wall
			maze[pos_l][pos_x + 2][pos_y - 1] and -- NE from E is wall
			maze[pos_l][pos_x + 2][pos_y + 1] and -- SE from E is wall
			maze[pos_l][pos_x + 1][pos_y - 1] and -- N from E is wall
			maze[pos_l][pos_x + 1][pos_y + 1] -- S from E is wall
		then
			table.insert(possible_ways, "E")
			table.insert(possible_ways, "E") -- twice as possible as U and D
		end
		-- is S possible?
		if
			pos_y + 2 < maze_size_z and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and 
			maze[pos_l][pos_x][pos_y + 1] and -- S is wall
			maze[pos_l][pos_x][pos_y + 2] and -- S from S is wall
			maze[pos_l][pos_x - 1][pos_y + 2] and -- SW from S is wall
			maze[pos_l][pos_x + 1][pos_y + 2] and -- SE from S is wall
			maze[pos_l][pos_x - 1][pos_y + 1] and -- W from S is wall
			maze[pos_l][pos_x + 1][pos_y + 1] -- E from S is wall
		then
			table.insert(possible_ways, "S")
			table.insert(possible_ways, "S") -- twice as possible as U and D
		end
		-- is W possible?
		if
			pos_x - 2 >= 0 and pos_y - 1 >= 0 and pos_y + 1 < maze_size_z and 
			maze[pos_l][pos_x - 1][pos_y] and -- W is wall
			maze[pos_l][pos_x - 2][pos_y] and -- W from W is wall
			maze[pos_l][pos_x - 2][pos_y - 1] and -- NW from W is wall
			maze[pos_l][pos_x - 2][pos_y + 1] and -- SW from W is wall
			maze[pos_l][pos_x - 1][pos_y - 1] and -- N from W is wall
			maze[pos_l][pos_x - 1][pos_y + 1] -- S from W is wall
		then
			table.insert(possible_ways, "W")
			table.insert(possible_ways, "W") -- twice as possible as U and D
		end
		if #possible_ways > 0 then
			forward = true
			direction = possible_ways[math.random(# possible_ways)]
			if direction == "N" then 
				pos_y = pos_y - 1
			elseif direction == "E" then 
				pos_x = pos_x + 1
			elseif direction == "S" then 
				pos_y = pos_y + 1
			elseif direction == "W" then 
				pos_x = pos_x - 1
			elseif direction == "D" then 
				table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way down
				pos_l = pos_l + 1
			elseif direction == "U" then 
				pos_l = pos_l - 1
				table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way up = down from level above
			end
			table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
			maze[pos_l][pos_x][pos_y] = false
		else -- there is no possible way forward
			if forward then -- the last step was forward, now back, so we're in a dead end
				-- mark dead end for possible braid
				if not maze[pos_l][pos_x - 1][pos_y] then -- dead end to E, only way is W
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 1, dy = 0})
				elseif not maze[pos_l][pos_x + 1][pos_y] then -- dead end to W, only way is E
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = -1, dy = 0})
				elseif not maze[pos_l][pos_x][pos_y - 1] then -- dead end to S, only way is N
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 0, dy = 1})
				elseif not maze[pos_l][pos_x][pos_y + 1] then -- dead end to N, only way is S
					table.insert(dead_end, {x = pos_x, y = pos_y, l = pos_l, dx = 0, dy = -1})
				end
				forward = false
			end
			pos = table.remove(moves)
			pos_x = pos.x
			pos_y = pos.y
			pos_l = pos.l
		end
	until pos_x == start_x and pos_y == start_y

	-- create partial braid maze, about 20%
	if size > 15 then
		for _, braid_pos in pairs(dead_end) do
			-- print(braid_pos.x.."/"..braid_pos.y.."/"..braid_pos.l.." "..braid_pos.dx.."/"..braid_pos.dy)
			x = braid_pos.x + braid_pos.dx * 2
			y = braid_pos.y + braid_pos.dy * 2
			if math.random(5) == 1 and x > 0 and x < maze_size_x - 1 and y > 0 and y < maze_size_z - 1 and not maze[braid_pos.l][x][y] then
				-- remove wall if behind is corridor with 20% chance
				maze[braid_pos.l][braid_pos.x + braid_pos.dx][braid_pos.y + braid_pos.dy] = false
				-- print("removed "..braid_pos.l.."/"..braid_pos.x + braid_pos.dx.."/"..braid_pos.y + braid_pos.dy)
			end
		end
	end

	-- create exit on opposite end of maze and make sure it is reachable
	local exit_x = maze_size_x - 1 -- exit always on opposite side of maze
	local exit_y = math.random(maze_size_z - 3) + 1
	local exit_l = math.random(maze_size_l) - 1
	local exit_reachable = false
	repeat
		maze[exit_l][exit_x][exit_y] = false
		exit_reachable = not maze[exit_l][exit_x - 1][exit_y] or not maze[exit_l][exit_x][exit_y - 1] or not maze[exit_l][exit_x][exit_y + 1]
		exit_x = exit_x - 1
	until exit_reachable

	-- build maze in minetest-world
	local offset_x = 1
	local offset_y = 1
	local line = ""
	local pos = {x = 0, y = 0, z = 0}
	local change_level_down = false
	local change_level_up = false
	local ladder_direction = 2
	for l = maze_size_l - 1, 0, -1 do
		for y = 0, maze_size_z - 1, 1 do
			if l == 0 and y == math.floor(maze_size_z / 2) then line = "<-" else line = "  " end
			for x = 0, maze_size_x - 1, 1 do
				-- rotate the maze in players view-direction and move it to his position
				pos.x = cosine * x - sine * (y - math.floor(maze_size_z / 2)) + originpos.x
				pos.z = sine * x + cosine * (y - math.floor(maze_size_z / 2)) + originpos.z
				pos.y = originpos.y - 1 - 3 * l + (maze_size_l*3-2)
				
				change_level_down = false
				change_level_up = false
				for i, v in ipairs(updowns) do
					if v.x == x and v.y == y and v.l == l then 
						change_level_down = true
						-- find direction for the ladders
						ladder_direction = 2
						if maze[l][x - 1][y] and maze[l + 1][x - 1][y] then ladder_direction = 3 end
						if maze[l][x + 1][y] and maze[l + 1][x + 1][y] then ladder_direction = 2 end
						if maze[l][x][y - 1] and maze[l + 1][x][y - 1] then ladder_direction = 5 end
						if maze[l][x][y + 1] and maze[l + 1][x][y + 1] then ladder_direction = 4 end
					end
					if v.x == x and v.y == y and v.l == l - 1 then
						change_level_up = true
						-- find direction for the ladders
						ladder_direction = 2
						-- if maze[l - 1][x - 1][y] and maze[l][x - 1][y] then ladder_direction = 3 end
						-- if maze[l - 1][x + 1][y] and maze[l][x + 1][y] then ladder_direction = 2 end
						-- if maze[l - 1][x][y - 1] and maze[l][x][y - 1] then ladder_direction = 5 end
						-- if maze[l - 1][x][y + 1] and maze[l][x][y + 1] then ladder_direction = 4 end
						if maze[l][x - 1][y] then ladder_direction = 3 end
						if maze[l][x + 1][y] then ladder_direction = 2 end
						if maze[l][x][y - 1] then ladder_direction = 5 end
						if maze[l][x][y + 1] then ladder_direction = 4 end
					end
				end
				-- rotate direction for the ladders
				if cosine == -1 then
					if ladder_direction == 2 then ladder_direction = 3
					elseif ladder_direction == 3 then ladder_direction = 2
					elseif ladder_direction == 4 then ladder_direction = 5
					elseif ladder_direction == 5 then ladder_direction = 4 end
				end
				if sine == -1 then
					if ladder_direction == 2 then ladder_direction = 5
					elseif ladder_direction == 3 then ladder_direction = 4
					elseif ladder_direction == 4 then ladder_direction = 2
					elseif ladder_direction == 5 then ladder_direction = 3 end
				end
				if sine == 1 then
					if ladder_direction == 2 then ladder_direction = 4
					elseif ladder_direction == 3 then ladder_direction = 5
					elseif ladder_direction == 4 then ladder_direction = 3
					elseif ladder_direction == 5 then ladder_direction = 2 end
				end
				if not change_level_down then 
					minetest.env:add_node(pos, {type = "node", name = material})
				end
				if maze[l][x][y] then 
					line = "X" .. line
					pos.y = pos.y + 1
					minetest.env:add_node(pos, {type = "node", name = material})
					pos.y = pos.y + 1
					minetest.env:add_node(pos, {type = "node", name = material})
				else
					line = " " .. line
					pos.y = pos.y + 1
					minetest.env:add_node(pos, {type = "node", name = "air"})
					if change_level_up then minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction}) end
					pos.y = pos.y + 1
					minetest.env:add_node(pos, {type = "node", name = "air"})
					if change_level_up then minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction}) end
				end
				pos.y = pos.y + 1
				if change_level_up then 
					minetest.env:add_node(pos, {type = "node", name = "air"})
					minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction})
				else
					minetest.env:add_node(pos, {type = "node", name = material})
				end
			end
			if l==exit_l and y==exit_y then line = "<-" .. line else line = "  " .. line end
		end
	end
end


-- register
deploy_maze.register = function(label,name,material,texture)

	-- small
	minetest.register_node("deploy_maze:"..name.."_small", {
		description = "Small "..label.." Maze",
		tiles = {texture.."^deploy_maze_small.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_maze.deploy(pos,placer,material,11,1)
		end,
	})
	minetest.register_craft({
		output = "deploy_maze:"..name.."_small",
		recipe = {
			{"deploy_maze:blueprint", material, material},
		},
	})

	-- medium
	minetest.register_node("deploy_maze:"..name.."_medium", {
		description = "Medium "..label.." Maze",
		tiles = {texture.."^deploy_maze_medium.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_maze.deploy(pos,placer,material,22,2)
		end,
	})
	minetest.register_craft({
		output = "deploy_maze:"..name.."_medium",
		recipe = {
			{"deploy_maze:blueprint", "deploy_maze:"..name.."_small", "deploy_maze:"..name.."_small"},
		},
	})

	-- large
	minetest.register_node("deploy_maze:"..name.."_large", {
		description = "Large "..label.." Maze",
		tiles = {texture.."^deploy_maze_large.png"},
		groups = {dig_immediate=3},
		after_place_node = function(pos,placer)
			deploy_maze.deploy(pos,placer,material,44,4)
		end,
	})
	minetest.register_craft({
		output = "deploy_maze:"..name.."_large",
		recipe = {
			{"deploy_maze:blueprint", "deploy_maze:"..name.."_medium", "deploy_maze:"..name.."_medium"},
		},
	})

	-- arrow
	table.insert(arrows,{"deploy_maze:"..name.."_arrow", "deploy_maze:"..name.."_arrow_entity"})
	minetest.register_craftitem("deploy_maze:"..name.."_arrow", {
		description = label.." Maze Arrow",
		inventory_image = "deploy_maze_arrow.png",
	})
	minetest.register_node("deploy_maze:"..name.."_arrow_box", {
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
		tiles = {"deploy_maze_arrow.png", "deploy_maze_arrow.png", "deploy_maze_arrow_back.png", "deploy_maze_arrow_front.png", "deploy_maze_arrow_2.png", "deploy_maze_arrow.png"},
	})
	minetest.register_entity("deploy_maze:"..name.."_arrow_entity", {
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"deploy_maze:"..name.."_arrow_box"},
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
						if obj:get_luaentity().name ~= "deploy_maze:"..name.."_arrow_entity" and obj:get_luaentity().name ~= "__builtin:item" then
							if self.player ~= "" then
								self.player:setpos(pos)
								self.player:get_inventory():add_item("main", ItemStack("deploy_maze:"..name.."_arrow"))
							end
							self.object:remove()
						end
					else
						if self.player ~= "" then
							self.player:setpos(pos)
							self.player:get_inventory():add_item("main", ItemStack("deploy_maze:"..name.."_arrow"))
						end
						self.object:remove()
					end
				end
			end
			if self.lastpos.x~=nil then
				if node.name ~= "air" then
					deploy_maze.deploy(self.lastpos,self.player,material,11,1)
					self.object:remove()
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end,
	})
	minetest.register_craft({
		output = "deploy_maze:"..name.."_arrow",
		recipe = {
			{"default:stick", "default:stick", "deploy_maze:"..name.."_small"},
		}
	})
	
end


-- register mazes
deploy_maze.register("Dirt","dirt","default:dirt","default_dirt.png")
deploy_maze.register("Wood","wood","default:wood","default_wood.png")
deploy_maze.register("Brick","brick","default:brick","default_brick.png")
deploy_maze.register("Cobble","cobble","default:cobble","default_cobble.png")
deploy_maze.register("Stone","stone","default:stone","default_stone.png")
deploy_maze.register("Glass","glass","default:glass","default_glass.png")

-- blueprint
minetest.register_craftitem("deploy_maze:blueprint", {
	description = "Maze Blueprint",
	inventory_image = "deploy_nodes_blueprint.png^deploy_maze_blueprint.png",
})
minetest.register_craft({
	output = "deploy_maze:blueprint",
	recipe = {
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
		{"", "deploy_nodes:blueprint", "deploy_nodes:blueprint"},
		{"deploy_nodes:blueprint", "deploy_nodes:blueprint", ""},
	},
})

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
