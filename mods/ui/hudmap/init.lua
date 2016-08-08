HUDMAP_UPDATE_TIME = 1
HUDMAP_MARKER_SIZE = {x=15, y=15}
HUDMAP_PLAYER_MARKERS = true
HUDMAP_PLAYER_NAMETAGS = true
HUDMAP_DEFAULT_PREFS = {visible=false, scale=1, players=false, names=false}

hudmap = {
	marker = {},
	map = {},
	pref = {},
	player = {},
	registered_maps = {},
}

function hudmap:register_map(name, def)
	local scale_size = {
		x = def.maxp.x - def.minp.x,
		z = def.maxp.z - def.minp.z,
	}
	table.insert(hudmap.registered_maps, {
		name = name,
		size = def.size,
		minp = def.minp,
		maxp = def.maxp,
		area = scale_size.x * scale_size.z,
		texture = def.texture,
		scale = {
			x = scale_size.x / def.size.x,
			y = scale_size.z / def.size.y,
		},
	})
	table.sort(hudmap.registered_maps, function(a, b)
		return a.area < b.area
	end)
end

local modpath = minetest.get_modpath(minetest.get_current_modname())
local input = io.open(modpath.."/hudmap.conf", "r")
if input then
	dofile(modpath.."/hudmap.conf")
	input:close()
	input = nil
end
local timer = 0
local marker_offset = {
	x = math.ceil(HUDMAP_MARKER_SIZE.x / 2),
	y = math.ceil(HUDMAP_MARKER_SIZE.y / 2),
}

local function pos_inside_map(pos, map)
	return pos.x >= map.minp.x and pos.x <= map.maxp.x and
		pos.y >= map.minp.y and pos.y <= map.maxp.y and
		pos.z >= map.minp.z and pos.z <= map.maxp.z
end

local function get_marker_pos(pos, map, name)
	local x = pos.x - map.minp.x
	local y = pos.z - map.minp.z
	x = map.size.x - x / map.scale.x - marker_offset.x
	y = map.size.y - y / map.scale.y - marker_offset.y
	return {
		x = -x * hudmap.pref[name].scale,
		y = y * hudmap.pref[name].scale,
	}
end

local function get_map(player)
	local name = player:get_player_name()
	local pos = hudmap.player[name].pos
	if name and pos.x and pos.z then
		for _, map in ipairs(hudmap.registered_maps) do
			if pos_inside_map(pos, map) then
				return map
			end
		end
	end
end

local function remove_nametags(player, name, markers)
	for k, v in pairs(hudmap.player) do
		if k ~= name then
			if v.marker[name] and markers == true then
				player:hud_remove(v.marker[name])
				v.marker[name] = nil
			end
			if v.nametag[name] then
				player:hud_remove(v.nametag[name])
				v.nametag[name] = nil
			end
		end
	end
end

local function remove_hud(player, name)
	player:hud_remove(hudmap.map[name])
	player:hud_remove(hudmap.marker[name])
	hudmap.map[name] = nil
	hudmap.marker[name] = nil
	remove_nametags(player, name, true)
end

local function update_hud(player)
	local name = player:get_player_name()
	if hudmap.pref[name].visible == false then
		return
	end
	local map = get_map(player)
	local scale = hudmap.pref[name].scale
	if map then
		local pos = get_marker_pos(hudmap.player[name].pos, map, name)
		if pos then
			if hudmap.map[name] then
				player:hud_change(hudmap.map[name], "text", map.texture)
				player:hud_change(hudmap.marker[name], "offset", pos)
			else
				hudmap.map[name] = player:hud_add({
					hud_elem_type = "image",
					position = {x=1,y=0},
					scale = {x=scale, y=scale},
					text = map.texture,
					offset = {x=0,y=0},
					alignment = {x=-1,y=1},
				})
				hudmap.marker[name] = player:hud_add({
					hud_elem_type = "image",
					position = {x=1,y=0},
					scale = {x=scale, y=scale},
					text = "hudmap_marker_1.png",
					offset = pos,
					alignment = {x=-1,y=1},
				})
			end
		else
			return
		end
	else
		remove_hud(player, name)
		return
	end
	if HUDMAP_PLAYER_MARKERS == true and
			hudmap.pref[name].players == true then
		for k, v in pairs(hudmap.player) do
			if k ~= name and v.pos.x and v.pos.z then
				if pos_inside_map(v.pos, map) then
					local pos = get_marker_pos(v.pos, map, name)
					if v.marker[name] then
						player:hud_change(v.marker[name], "offset", pos)
					else
						v.marker[name] = player:hud_add({
							hud_elem_type = "image",
							position = {x=1,y=0},
							scale = {x=scale, y=scale},
							text = "hudmap_marker_2.png",
							offset = pos,
							alignment = {x=-1,y=1},
						})
					end
					if HUDMAP_PLAYER_NAMETAGS == true and
							hudmap.pref[name].names == true then
						pos.x = pos.x + HUDMAP_MARKER_SIZE.x
						pos.y = pos.y - HUDMAP_MARKER_SIZE.y
						if v.nametag[name] then
							player:hud_change(v.nametag[name], "offset", pos)
						else
							v.nametag[name] = player:hud_add({
								hud_elem_type = "text",
								position = {x=1,y=0},
								text = k,
								offset = pos,
								alignment = {x=-1,y=1},
								number = 0xFFFFFF,
							})
						end
					end
				else
					if v.marker[name] then
						player:hud_remove(v.marker[name])
						v.marker[name] = nil
					end
					if v.nametag[name] then
						player:hud_remove(v.nametag[name])
						v.nametag[name] = nil
					end
				end
			end
		end
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	hudmap.pref[name] = HUDMAP_DEFAULT_PREFS
	hudmap.player[name] = {nametag={}, marker={}, pos={x=0, z=0}}
	minetest.after(1, function(player)
		if player then
			update_hud(player)
		end
	end, player)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	remove_nametags(player, name, true)
	hudmap.player[name] = nil
end)

minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer > HUDMAP_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local pos = player:getpos()
			if name and pos then
				hudmap.player[name].pos = pos
				update_hud(player)
			end
		end
		timer = 0
	end
end)

minetest.register_chatcommand("hudmap", {
	params = "<cmd> [args]",
	description = "Hudmap",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if param == nil or player == nil then
			return
		end
		local cmd, args = string.match(param, "([^ ]+) (.+)")
		cmd = cmd or param
		if cmd == "on" then
			hudmap.pref[name].visible = true
			update_hud(player)
		elseif cmd == "off" then
			hudmap.pref[name].visible = false
			remove_hud(player, name)
		elseif cmd == "scale" then
			if args then
				scale = tonumber(args)
				if scale then
					if scale > 0 then
						hudmap.pref[name].scale = scale
						remove_hud(player, name)
						update_hud(player)
						return
					end
				end
			end
			minetest.chat_send_player(name, "Invalid scale!")
		elseif cmd == "players" then
			if args == "on" then
				hudmap.pref[name].players = true
			elseif args == "off" then
				hudmap.pref[name].players = false
				hudmap.pref[name].names = false
				remove_nametags(player, name, true)
			end
			update_hud(player)
		elseif cmd == "names" then
			if args == "on" then
				hudmap.pref[name].names = true
				hudmap.pref[name].players = true
				update_hud(player)
			elseif args == "off" then
				hudmap.pref[name].names = false
				remove_nametags(player, name, false)
			end
		end
	end,
})

