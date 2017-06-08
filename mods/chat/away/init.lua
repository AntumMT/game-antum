-------------------------------------
-- Away mod by kahrl               --
-- Idea by jordan4ibanez & kahrl   --
-- Version 1.0                     --
-------------------------------------


--
-- Set yourself as away using the server command
--   /away
-- You can also give a reason, as follows:
--   /away Saving the princess
--
-- Each time somebody mentions your nick, the server will print a message
-- that you are currently away (however, not more than once per minute).
--
-- You can set yourself as no longer away with another /away,
-- or by talking. If somebody tried to talk to you while you were away,
-- the server will inform everyone that you're back. Doing something else
-- in-game (e.g. moving around, digging, building, etc.) does not reset
-- the away status.
--
-- You can check your current away status:
--   /away?
-- You can also check any other player's status:
--   /away? name
--
-- Note: an away reason is hidden in case the user in question is
-- missing the 'shout' privilege.
--


-- The mod version
AWAY_VERSION = '1.0'

-- The name of the /away command
AWAY_COMMAND = '/away'

-- The name of the /away? command
AWAYP_COMMAND = '/away?'

-- The minimum time between away notifications, in seconds. Defaults to 60.
AWAY_INFORM_INTERVAL = 60

-- The interval at which the mod looks for disconnected players, and resets
-- their AFK status.
-- This could be removed if a register_on_disconnectplayer callback was added.
AWAY_CHECK_DISCONNECT_INTERVAL = 60


-- Set of away players
local away_players = {}

-- Maps player name to reason or nil if not applicable
local away_reasons = {}

-- Maps player to the time others were last informed about their afk-ness,
-- or nil if not applicable
local away_last_inform = {}

-- List of inform messages to send on globalstep
-- The purpose of this is that inform messages show up *after* the
-- chat message that caused them
local away_inform_outbox = {}


function is_away(name)
	return away_players[name] ~= nil
end

function get_away_reason(name)
	-- If a player's shout privilege has been revoked,
	-- others shouldn't see the away reason
	if is_away(name) and minetest.get_player_privs(name)['shout'] then
		return away_reasons[name]
	else
		return ''
	end
end

function set_away(name, reason)
	if is_away(name) then
		minetest.chat_send_player(name, "You are still marked as away (away reason updated)")
		away_reasons[name] = reason
	else
		minetest.chat_send_player(name, "You are now marked as away")
		away_players[name] = true
		away_reasons[name] = reason
		away_last_inform[name] = nil
	end
end

function unset_away(name)
	if is_away(name) then
		if away_last_inform[name] ~= nil then
			table.insert(away_inform_outbox, name .. " is no longer away")
		else
			minetest.chat_send_player(name, "You are no longer marked as away")
		end
		away_players[name] = nil
		away_reasons[name] = nil
		away_last_inform[name] = nil
	end
end

function toggle_away(name, reason)
	if is_away(name) and reason == '' then
		unset_away(name)
	else
		set_away(name, reason)
	end
end

-- Returns 'present' or 'away' or 'away (<reason>)' or 'disconnected'
function get_away_status(name)
	if minetest.get_player_by_name(name) == nil then
		return 'disconnected'
	elseif is_away(name) then
		reason = get_away_reason(name)
		if reason == '' then
			return 'away'
		else
			return 'away (' .. reason .. ')'
		end
	else
		return 'present'
	end
end


minetest.register_on_chat_message(function(name, message)
	local cmd

	cmd = AWAYP_COMMAND
	if message:sub(1, #cmd) == cmd then
		-- /away?
		local name2 = string.match(message, cmd:gsub("?", "[?]").." (.*)")
		if name2 == nil or name2 == '' or name2 == name then
			name2 = name
			minetest.chat_send_player(name,
				"Your status: " .. get_away_status(name2))
		else
			minetest.chat_send_player(name,
				name2 .. "'s status: " .. get_away_status(name2))
		end
		return true -- Handled chat message
	end

	cmd = AWAY_COMMAND
	if message:sub(1, #cmd) == cmd then
		-- /away
		local reason = string.match(message, AWAY_COMMAND.." (.*)")
		if reason == nil then
			reason = ''
		end
		toggle_away(name, reason)
		return true -- Handled chat message
	end

	if message:sub(1, 1) ~= '/' then
		-- Normal chat message (not a command)
		if not minetest.get_player_privs(name)['shout'] then
			-- Ignore if player has no shout privilege
			return false -- Continue normal processing
		end

		if is_away(name) then
			unset_away(name)
		end

		for awayname, _ in pairs(away_players) do
			-- Does the message contain the name of the away player?
			if message:find(awayname, 1, true) then
				local time = os.time()
				if away_last_inform[awayname] == nil or
					away_last_inform[awayname] <= time - AWAY_INFORM_INTERVAL then
					local info = ''
					local reason = get_away_reason(awayname)
					if reason == '' then
						info = awayname .. ' is away'
					else
						info = awayname .. ' is away: ' .. reason
					end
					table.insert(away_inform_outbox, info)
					away_last_inform[awayname] = time
				end
			end
		end

		return false -- Continue normal processing
	end
end)

local away_check_disconnect_timer = 0
minetest.register_globalstep(function(dtime)
	away_check_disconnect_timer = away_check_disconnect_timer + dtime
	if away_check_disconnect_timer >= AWAY_CHECK_DISCONNECT_INTERVAL then
		away_check_disconnect_timer = 0
		local disconnected = {}
		for name, _ in pairs(away_players) do
			if minetest.get_player_by_name(name) == nil then
				table.insert(disconnected, name)
			end
		end
		for _, name in ipairs(disconnected) do
			away_players[name] = nil
			away_reasons[name] = nil
			away_last_inform[name] = nil
		end
	end

	if #away_inform_outbox ~= 0 then
		for _, message in ipairs(away_inform_outbox) do
			minetest.chat_send_all("Server: " .. message)
		end
		away_inform_outbox = {}
	end
end)



print("away mod version " .. AWAY_VERSION .. " loaded")
