--[[

The original code for the Sleeping Mat node is from the Cottages mod  v2.0 by Sokomine.

-- License: GPLv3

The code for sleep/spawn/respawn functions  is based on the
original Beds mod by PilzAdam and Thefamilygrog66

Depends: default, wool

License of code : WTFPL

]]

local players_in_bed = 0

minetest.register_node("campfire:sleeping_mat_bottom", {
        description = "Sleeping mat",
        drawtype = 'nodebox',
        tiles = {"[combine:16x16:0,0=wool_brown.png:0,10=wool_brown.png"},
        wield_image = "[combine:16x16:0,0=wool_white.png:0,6=wool_brown.png",
        inventory_image = "[combine:16x16:0,0=wool_white.png:0,6=wool_brown.png",
        stack_max = 1,
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        is_ground_content = false,
        walkable = true,
        groups = {snappy = 3, flammable = 3,oddly_breakable_by_hand=3},
        sounds = default.node_sound_leaves_defaults(),
        selection_box = {
                        type = "wallmounted",
                        },
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.5,  0.48, -0.45, 0.5},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {-0.5, -0.5, -0.5, 0.5, -0.35, 1.5},
                        }
        },

		after_place_node = function(pos, placer, itemstack)
			local node = minetest.get_node(pos)
			local p = {x = pos.x, y = pos.y, z = pos.z}
			local param2 = node.param2
			node.name = "campfire:sleeping_mat_top"
			if param2 == 0 then
				pos.z = pos.z + 1
			elseif param2 == 1 then
				pos.x = pos.x + 1
			elseif param2 == 2 then
				pos.z = pos.z - 1
			elseif param2 == 3 then
				pos.x = pos.x - 1
			end
			if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to then
				minetest.set_node(pos, node)
			else
				minetest.remove_node(p)
				return true
			end
		end,

		on_destruct = function(pos)
			local node = minetest.get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if (minetest.get_node({x = pos.x, y = pos.y, z = pos.z}).name == "campfire:sleeping_mat_top") then
				if (minetest.get_node({x = pos.x, y = pos.y, z = pos.z}).param2 == param2) then
					minetest.remove_node(pos)
				end
			end
		end,

		on_rightclick = function(pos, node, clicker)
			if not clicker or not clicker:is_player() then return end
	  local name = clicker:get_player_name()
			local meta = minetest.get_meta(pos)
			local param2 = node.param2

			if param2 == 0 then
				pos.z = pos.z + 0.45
			elseif param2 == 1 then
				pos.x = pos.x + 0.45
			elseif param2 == 2 then
				pos.z = pos.z - 0.45
			elseif param2 == 3 then
				pos.x = pos.x - 0.45
			end

			if clicker:get_player_name() == meta:get_string("player") then

		  if param2 == 0 then
					pos.x = pos.x - 1
				elseif param2 == 1 then
					pos.z = pos.z + 1
				elseif param2 == 2 then
					pos.x = pos.x + 1
				elseif param2 == 3 then
					pos.z = pos.z - 1
				end

				clicker:set_physics_override({speed = 1.0, jump = 1.0, sneak = true})
				pos.y = pos.y -0.45
				clicker:setpos(pos)
				clicker:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
				meta:set_string("player", "")
				clicker:set_detach()
		  default.player_attached[name] = false
		  default.player_set_animation(clicker, "stand" , 10)
				players_in_bed = players_in_bed - 1
			 elseif meta:get_string("player") == "" then
				clicker:set_physics_override({speed = 0.0, jump = 0.0, sneak = false})
				pos.y = pos.y -0.45
				--pos.z = pos.z -0.45
				clicker:setpos(pos)
				clicker:set_eye_offset({x = 0, y =  0, z = 0}, {x = 0, y = 0, z = 0})
				clicker:set_detach()
		  default.player_attached[name] = true
		  default.player_set_animation(clicker, "lay" , 0)
				if param2 == 0 then
					clicker:set_look_yaw(math.pi)
				elseif param2 == 1 then
					clicker:set_look_yaw(0.5 * math.pi)
				elseif param2 == 2 then
					clicker:set_look_yaw(0)
				elseif param2 == 3 then
					clicker:set_look_yaw(1.5 * math.pi)
				end

				meta:set_string("player", clicker:get_player_name())
				players_in_bed = players_in_bed + 1
			end
		end
	})

	minetest.register_node("campfire:sleeping_mat_top", {
         description = "Sleeping mat (top)",
	        drawtype = 'nodebox',
        tiles = { "[combine:16x16:0,0=wool_white.png:0,6=wool_brown.png" },
        wield_image ="[combine:16x16:0,0=wool_white.png:0,6=wool_brown.png",
        inventory_image = "[combine:16x16:0,0=wool_white.png:0,6=wool_brown.png",
        sunlight_propagates = true,
        paramtype = 'light',
        paramtype2 = "facedir",
        is_ground_content = false,
        drop = '',
        walkable = true,
        groups = {snappy = 3, flammable = 3,oddly_breakable_by_hand=3, not_in_creative_inventory =1},
        sounds = default.node_sound_leaves_defaults(),
        selection_box = {
                        type = "wallmounted",
                        },
        node_box = {
                type = "fixed",
                fixed = {
                                        {-0.48, -0.5,-0.5,  0.48, -0.45, 0.5},
                        }
        },
        selection_box = {
                type = "fixed",
                fixed = {
                                        {0, 0, 0, 0, 0, 0},
                        }
        }
	})


minetest.register_alias("campfire:sleeping_mat", "campfire:sleeping_mat_bottom")

minetest.register_craft({
	output = "campfire:sleeping_mat_bottom",
	recipe = {
		{"wool:white", "wool:brown", "wool:brown"}
	}
})

minetest.register_craft({
	output = "campfire:sleeping_mat",
	recipe = {
		{ "wool:brown", "wool:brown", "wool:white"}
	}
})

--minetest.register_alias("campfire:sleeping_mat_bottom", "campfire:sleeping_mat")
--minetest.register_alias("campfire:sleeping_mat_top", "campfire:sleeping_mat")




campfire_player_spawns = {}

local file = io.open(minetest.get_worldpath().."/beds.txt", "r")
if file then
	campfire_player_spawns = minetest.deserialize(file:read("*all"))
	file:close()
end

local timer = 0
local wait = false

minetest.register_globalstep(function(dtime)
	if timer < 2 then
		timer = timer + dtime
		return
	end
	timer = 0

	local players = #minetest.get_connected_players()
	if players ~= 0 and players * 0.5 < players_in_bed then
		if minetest.get_timeofday() < 0.2 or minetest.get_timeofday() > 0.8 then
			if not wait then
				minetest.chat_send_all("[zzz] " .. players_in_bed .. " of " .. players .. " players slept, skipping to day.")
				minetest.after(2, function()
					minetest.set_timeofday(0.23)
					wait = false
				end)
				wait = true
				for _,player in ipairs(minetest.get_connected_players()) do
					campfire_player_spawns[player:get_player_name()] = player:getpos()
				end
				local file = io.open(minetest.get_worldpath().."/beds.txt", "w")
				if file then
					file:write(minetest.serialize(campfire_player_spawns))
					file:close()
				end
			end
		end
	end
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	if campfire_player_spawns[name] then
		player:setpos(campfire_player_spawns[name])
		return true
	end
end)
