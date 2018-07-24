-- pvp_areas
-- Original   : Copyright 2016 James Stevenson (everamzah)
-- Additional : Copyright Tai Kedzierski (DuCake)
-- LGPL v2.1+

local pvp_areas_worlddir = minetest.get_worldpath()
local pvp_areas_modname = minetest.get_current_modname()

local hasareasmod = minetest.get_modpath("areas")

local safemode = minetest.setting_getbool("pvp_areas.safemode") or false
local area_label = minetest.setting_get("pvp_areas.label") or "Defined area."
-- if false Mob does Damage
local mobsDoNoDamage = false

local pvp_areas_store = AreaStore()
pvp_areas_store:from_file(pvp_areas_worlddir .. "/pvp_areas_store.dat")

local pvp_default = minetest.is_yes(minetest.setting_getbool("pvp_areas_enable_pvp"))
minetest.log("action", "[" .. pvp_areas_modname .. "] PvP by Default: " .. tostring(pvp_default))

local pvp_areas_players = {}
local pvp_areas = {}

local function update_pvp_areas()
	local counter = 0
	pvp_areas = {}
	while pvp_areas_store:get_area(counter) do
		table.insert(pvp_areas, pvp_areas_store:get_area(counter))
		counter = counter + 1
	end
end
update_pvp_areas()

local function save_pvp_areas()
	pvp_areas_store:to_file(pvp_areas_worlddir .. "/pvp_areas_store.dat")
end

local function areas_entity(pos,num)
	if hasareasmod then
		local obj = minetest.add_entity(pos, "areas:pos"..tostring(num))
		local ent = obj:get_luaentity()
		ent.active = true
	end
end

-- Register privilege and chat command.
minetest.register_privilege("pvp_areas_admin", "Can set and remove PvP areas.")

minetest.register_chatcommand("pvp_areas", {
	description = "Mark and set areas for PvP.",
	params = "<pos1> <pos2> <set> <remove>",
	privs = "pvp_areas_admin",
	func = function(name, param)
		local pos = vector.round(minetest.get_player_by_name(name):getpos())
		if param == "pos1" then
			if not pvp_areas_players[name] then
				pvp_areas_players[name] = {pos1 = pos}
			else
				pvp_areas_players[name].pos1 = pos
			end
			minetest.chat_send_player(name, "Position 1: " .. minetest.pos_to_string(pos))
		elseif param == "pos2" then
			if not pvp_areas_players[name] then
				pvp_areas_players[name] = {pos2 = pos}
			else
				pvp_areas_players[name].pos2 = pos
			end
			minetest.chat_send_player(name, "Position 2: " .. minetest.pos_to_string(pos))
		elseif param == "set" then
			if not pvp_areas_players[name] or not pvp_areas_players[name].pos1 then
				minetest.chat_send_player(name, "Position 1 missing, use \"/pvp_areas pos1\" to set.")
			elseif not pvp_areas_players[name].pos2 then
				minetest.chat_send_player(name, "Position 2 missing, use \"/pvp_areas pos2\" to set.")
			else
				pvp_areas_store:insert_area(pvp_areas_players[name].pos1, pvp_areas_players[name].pos2, "pvp_areas", #pvp_areas)
				table.insert(pvp_areas, pvp_areas_store:get_area(#pvp_areas))
				update_pvp_areas()
				save_pvp_areas()
				pvp_areas_players[name] = nil
				minetest.chat_send_player(name, "Area set.")
			end
		elseif param:sub(1, 6) == "remove" then
			local n = tonumber(param:sub(8, -1))
			if n and pvp_areas_store:get_area(n) then
				pvp_areas_store:remove_area(n)
				if pvp_areas_store:get_area(n + 1) then
					-- Insert last entry in new empty (removed) slot.
					local a = pvp_areas_store:get_area(#pvp_areas - 1)
					pvp_areas_store:remove_area(#pvp_areas - 1)
					pvp_areas_store:insert_area(a.min, a.max, "pvp_areas", n)
				end
				update_pvp_areas()
				save_pvp_areas()
				minetest.chat_send_player(name, "Removed " .. tostring(n))
			else
				minetest.chat_send_player(name, "Invalid argument.  You must enter a valid area identifier.")
			end
		elseif param ~= "" then
			minetest.chat_send_player(name, "Invalid usage.  Type \"/help pvp_areas\" for more information.")
		else
			for k, v in pairs(pvp_areas) do
				minetest.chat_send_player(name, k - 1 .. ": " ..
						minetest.pos_to_string(v.min) .. " " ..
						minetest.pos_to_string(v.max))
			end
		end
	end
})

local KILL_NO = true
local KILL_OK = false

local AREA_ACTIVATE = KILL_OK
local AREA_NOACTIVATE = KILL_NO

local savemodeToString = "FALSCH" -- only for debugging
if safemode then
	AREA_ACTIVATE = KILL_NO
	AREA_NOACTIVATE = KILL_OK
	savemodeToString = "WAHR"
end

-- Register punchplayer callback.
minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	local isPlayer = hitter:is_player()
	
	if hitter:is_player() == false then
		return mobsDoNoDamage -- if this is a MOB then give Damage
	end
	--[[
	local IsPlayerToString = "PLAYER"	-- only for debugging
	if isplayer then 
		IsPlayerToString = "PLAYER"			-- only for debugging
	else
		IsPlayerToString = "MOB"				-- only for debugging
		return mobsDoNoDamage -- if this is a MOB then give Damage
	end
	]]--
	
	local playername = player:get_player_name() 
	for k, v in pairs(pvp_areas_store:get_areas_for_pos(player:getpos())) do
		if k then
			--minetest.chat_send_player(playername, "in loop - safemode"..savemodeToString.." isPlayer "..IsPlayerToString)
			return AREA_ACTIVATE --KILL_NO
		end
	end
	--minetest.chat_send_player(playername, "after - safemode"..savemodeToString.." isPlayer "..IsPlayerToString)
	return AREA_NOACTIVATE --KILL_OK
end)

if hasareasmod then
	if areas.registerHudHandler then

		local function advertise_nokillzone(pos, list)
			for k, v in pairs(pvp_areas_store:get_areas_for_pos(pos)) do
				if k then
					table.insert(list, {
						id = "PvP Control Area "..tostring(k),
						name = area_label,
					} )
					return
				end
			end
		end

		areas:registerHudHandler(advertise_nokillzone)
	else
		minetest.log("info","Your version of `areas` does not support registering hud handlers.")
	end
end
