-- default to 0/0/0
local default_spawn = {x=0, y=0, z=0}
-- default to static spawnpoint (overwrites 0/0/0)
local default_spawn_settings = minetest.setting_get("static_spawnpoint")
if (default_spawn_settings) then
	pos1 = string.find(default_spawn_settings, ",", 0)
	default_spawn.x = tonumber(string.sub(default_spawn_settings, 0, pos1 - 1))
	pos2 = string.find(default_spawn_settings, ",", pos1 + 1)
	default_spawn.y = tonumber(string.sub(default_spawn_settings, pos1 + 1, pos2 - 1))
	default_spawn.z = tonumber(string.sub(default_spawn_settings, pos2 + 1))
end

local last_time_spawns_read = "default"
local pilzadams_spawns = {}
local sethome_spawns = {}
function read_spawns()
	-- read PilzAdams bed-mod positions
	local pilzadams_file = io.open(minetest.get_worldpath().."/beds_player_spawns", "r")
	if pilzadams_file then
		pilzadams_spawns = minetest.deserialize(pilzadams_file:read("*all"))
		pilzadams_file:close()
	end
	-- read sethome-mod positions
	if minetest.get_modpath('sethome') then
		local sethome_file = io.open(minetest.get_modpath('sethome')..'/homes', "r")
		if sethome_file then
			while true do
				local x = sethome_file:read("*n")
				if x == nil then
					break
				end
				local y = sethome_file:read("*n")
				local z = sethome_file:read("*n")
				local name = sethome_file:read("*l")
				sethome_spawns[name:sub(2)] = {x = x, y = y, z = z}
			end
			io.close(sethome_file)
		end
	end
end

minetest.register_globalstep(function(dtime)
	if last_time_spawns_read ~= os.date("%M") then
		last_time_spawns_read = os.date("%M")
		read_spawns()
	end
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
		-- try to get position from PilzAdams bed-mod spawn
		local spawn = pilzadams_spawns[player:get_player_name()]
		-- fallback to sethome position
		if spawn == nil then 
			spawn = sethome_spawns[player:get_player_name()]
		end
		-- fallback to default
		if spawn == nil then
			spawn = default_spawn;
		end
		pos = player:getpos()
		dir = player:get_look_yaw()
		local angle_north = math.deg(math.atan2(spawn.x - pos.x, spawn.z - pos.z))
		if angle_north < 0 then angle_north = angle_north + 360 end
		angle_dir = 90 - math.deg(dir)
		local angle_relative = (angle_north - angle_dir) % 360
		local compass_image = math.floor((angle_relative/30) + 0.5)%12

		local wielded_item = player:get_wielded_item():get_name()
		if string.sub(wielded_item, 0, 8) == "compass:" then
			player:set_wielded_item("compass:"..compass_image)
		else
			if player:get_inventory() then 
				for i,stack in ipairs(player:get_inventory():get_list("main")) do
					if i<9 and string.sub(stack:get_name(), 0, 8) == "compass:" then
						player:get_inventory():remove_item("main", stack:get_name())
						player:get_inventory():add_item("main", "compass:"..compass_image)
					end
				end
			end
		end
	end
end)

local images = {
	"compass_0.png",
	"compass_1.png",
	"compass_2.png",
	"compass_3.png",
	"compass_4.png",
	"compass_5.png",
	"compass_6.png",
	"compass_7.png",
	"compass_8.png",
	"compass_9.png",
	"compass_10.png",
	"compass_11.png",
}

local i
for i,img in ipairs(images) do
	local inv = 1
	if i == 1 then
		inv = 0
	end
	minetest.register_tool("compass:"..(i-1), {
		description = "Compass",
		inventory_image = img,
		wield_image = img,
		groups = {not_in_creative_inventory=inv}
	})
end

minetest.register_craft({
	output = 'compass:1',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''}
	}
})