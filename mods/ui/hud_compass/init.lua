-- hud_compass
-- Optionally place a compass and 24-hour clock on the screen.
-- A HUD version of my realcompass mod.
-- By David_G (kestral246@gmail.com)
-- 2019-12-31

local hud_compass = {}
local storage = minetest.get_mod_storage()

-- State of hud_compass
--   1 = NE, 2 = SE, 3 = SW, 4 = NW (just compass)
--   5 = NE, 6 = SE, 7 = SW, 8 = NW (both compass and clock)
--   positive == enabled, negative == disabled

-- Define default (if not overridden): SE corner, compass only, off by default
local default_corner = tonumber(minetest.settings:get("compass_default_corner") or -2)

local lookup_compass = {
	{hud_elem_type="image", text="", position={x=1,y=0}, scale={x=4,y=4}, alignment={x=-1,y=1}, offset={x=-8,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=1}, scale={x=4,y=4}, alignment={x=-1,y=-1}, offset={x=-8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=1}, scale={x=4,y=4}, alignment={x=1,y=-1}, offset={x=8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=0}, scale={x=4,y=4}, alignment={x=1,y=1}, offset={x=8,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=0}, scale={x=4,y=4}, alignment={x=-1,y=1}, offset={x=-76,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=1}, scale={x=4,y=4}, alignment={x=-1,y=-1}, offset={x=-76,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=1}, scale={x=4,y=4}, alignment={x=1,y=-1}, offset={x=76,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=0}, scale={x=4,y=4}, alignment={x=1,y=1}, offset={x=76,y=4}}
}
local lookup_clock = {
	{hud_elem_type="image", text="", position={x=1,y=0}, scale={x=4,y=4}, alignment={x=-1,y=1}, offset={x=-8,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=1}, scale={x=4,y=4}, alignment={x=-1,y=-1}, offset={x=-8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=1}, scale={x=4,y=4}, alignment={x=1,y=-1}, offset={x=8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=0}, scale={x=4,y=4}, alignment={x=1,y=1}, offset={x=8,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=0}, scale={x=4,y=4}, alignment={x=-1,y=1}, offset={x=-8,y=4}},
	{hud_elem_type="image", text="", position={x=1,y=1}, scale={x=4,y=4}, alignment={x=-1,y=-1}, offset={x=-8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=1}, scale={x=4,y=4}, alignment={x=1,y=-1}, offset={x=8,y=-4}},
	{hud_elem_type="image", text="", position={x=0,y=0}, scale={x=4,y=4}, alignment={x=1,y=1}, offset={x=8,y=4}}
}

minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	local corner = default_corner
	if storage:get(pname) and tonumber(storage:get(pname)) then  -- validate mod storage value
		local temp = math.floor(tonumber(storage:get(pname)))
		if temp ~= nil and temp ~= 0 and temp >= -8 and temp <= 8 then
			corner = temp
		end
	end
	hud_compass[pname] = {
		id_compass = player:hud_add(lookup_compass[math.abs(corner)]),
		last_image_compass = -1,
		id_clock = player:hud_add(lookup_clock[math.abs(corner)]),
		last_image_clock = -1,
		state = corner,
	}
end)

minetest.register_chatcommand("compass", {
	params = "[<corner>]",
	description = "Change display of HUD Compass.",
	privs = {},
	func = function(pname, params)
		local player = minetest.get_player_by_name(pname)
		if params and string.len(params) > 0 then  -- includes corner parameter
			local corner = tonumber(string.match(params, "^%d$"))
			if corner and corner == 0 then  -- disable compass and clock
				player:hud_change(hud_compass[pname].id_compass, "text", "") -- blank hud compass
				hud_compass[pname].last_image_compass = -1
				player:hud_change(hud_compass[pname].id_clock, "text", "") -- blank hud clock
				hud_compass[pname].last_image_clock = -1
				hud_compass[pname].state = -1 * math.abs(hud_compass[pname].state)
				storage:set_string(pname, hud_compass[pname].state)
			elseif corner and corner > 0 and corner <= 4 then  -- enable compass only to given corner
				player:hud_remove(hud_compass[pname].id_compass)  -- remove old hud compass
				hud_compass[pname].last_image_compass = -1
				player:hud_remove(hud_compass[pname].id_clock)  -- remove old hud clock
				hud_compass[pname].last_image_clock = -1
				hud_compass[pname].id_compass = player:hud_add(lookup_compass[corner])  -- place new hud compass at requested corner
				hud_compass[pname].state = corner
				storage:set_string(pname, corner)
			elseif corner and corner >= 5 and corner <= 8 then  -- enable compass and clock to given corner
				player:hud_remove(hud_compass[pname].id_compass)  -- remove old hud compass
				hud_compass[pname].last_image_compass = -1
				player:hud_remove(hud_compass[pname].id_clock)  -- remove old hud clock
				hud_compass[pname].last_image_clock = -1
				hud_compass[pname].id_compass = player:hud_add(lookup_compass[corner])  -- place new hud compass at requested corner
				hud_compass[pname].id_clock = player:hud_add(lookup_clock[corner])  -- place new hud clock at requested corner
				hud_compass[pname].state = corner
				storage:set_string(pname, corner)
			end
		else  -- just toggle hud
			if hud_compass[pname].state > 0 then  -- is enabled
				player:hud_change(hud_compass[pname].id_compass, "text", "")  -- blank hud compass
				hud_compass[pname].last_image_compass = -1
				player:hud_change(hud_compass[pname].id_clock, "text", "")  -- blank hud clock
				hud_compass[pname].last_image_clock = -1
			end
			hud_compass[pname].state = -1 * hud_compass[pname].state  -- toggle state
			storage:set_string(pname, hud_compass[pname].state)
		end
	end,
})

minetest.register_on_leaveplayer(function(player)
	local pname = player:get_player_name()
	if hud_compass[pname] then
		hud_compass[pname] = nil
	end
end)

minetest.register_globalstep(function(dtime)
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
		local pname = player:get_player_name()
		local dir = player:get_look_horizontal()
		-- Calculate image indexes for compass and clock.
		local angle_relative = math.deg(dir)
		local image_compass = math.floor((angle_relative/22.5) + 0.5)%16
		local image_clock = math.floor(24 * minetest.get_timeofday())

		if hud_compass[pname].state > 0 and image_compass ~= hud_compass[pname].last_image_compass then
			local rc = player:hud_change(hud_compass[pname].id_compass, "text", "realcompass_"..image_compass..".png")
			-- Check return code, seems to fix occasional startup glitch.
			if rc == 1 then
				hud_compass[pname].last_image_compass = image_compass
			end
		end
		if hud_compass[pname].state >= 5 and image_clock ~= hud_compass[pname].last_image_clock then
			local rc = player:hud_change(hud_compass[pname].id_clock, "text", "hud_24hr_clock_"..image_clock..".png")
			-- Check return code, seems to fix occasional startup glitch.
			if rc == 1 then
				hud_compass[pname].last_image_clock = image_clock
			end
		end
	end
end)
