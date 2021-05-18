
--- Chat Commands
--
--  @module commands.lua


local S = core.get_translator(alternode.modname)


--- Retrieves node meta value of a given key.
--
--  @chatcmd getmeta
--  @tparam number x X-coordinate of node.
--  @tparam number y Y-coordinate of node.
--  @tparam number z Z-coordinate of node.
--  @tparam string key Key to be checked.
core.register_chatcommand("getmeta", {
	params = S("<x> <y> <z> <key>"),
	description = S("Retrieve meta data of a node"),
	privs = {server=true,},
	func = function(player, param)
		local plist = string.split(param, " ")

		if #plist < 3 then
			core.chat_send_player(player, S("You must supply proper coordinates"))
			return false
		end

		for _, p in ipairs({plist[1], plist[2], plist[3]}) do
			if tonumber(p) == nil then
				core.chat_send_player(player, S("You must supply proper coordinates"))
				return false
			end
		end

		local pos = {
			x = tonumber(plist[1]),
			y = tonumber(plist[2]),
			z = tonumber(plist[3]),
		}

		local key = plist[4]
		if key then key = key:trim() end

		if not key or key == "" then
			core.chat_send_player(player, S("You must supply a key parameter"))
			return false
		end

		local value = alternode.get(pos, key)
		if not value or value == "" then
			core.chat_send_player(player,
				S('"@1" key value not present in node meta data', key))
		else
			core.chat_send_player(player,
				S("Meta value: @1@=@2", key, value))
		end

		return true
	end,
})

--- Sets node meta value of a given key.
--
--  @chatcmd setmeta
--  @tparam number x X-coordinate of node.
--  @tparam number y Y-coordinate of node.
--  @tparam number z Z-coordinate of node.
--  @tparam string key Key to be set.
--  @tparam string value Value to be set for `key`.
core.register_chatcommand("setmeta", {
	params = S("<x> <y> <z> <key> <value>"),
	description = S("Set meta data of a node"),
	privs = {server=true,},
	func = function(player, param)
		local plist = string.split(param, " ")

		if #plist < 3 then
			core.chat_send_player(player, S("You must supply proper coordinates"))
			return false
		end

		for _, p in ipairs({plist[1], plist[2], plist[3]}) do
			if tonumber(p) == nil then
				core.chat_send_player(player, S("You must supply proper coordinates"))
				return false
			end
		end

		local pos = {
			x = tonumber(plist[1]),
			y = tonumber(plist[2]),
			z = tonumber(plist[3]),
		}

		local key = plist[4]
		if key then key = key:trim() end

		if not key or key == "" then
			core.chat_send_player(player, S("You must supply a key parameter"))
			return false
		end

		local value = {}
		for idx, word in ipairs(plist) do
			if idx > 4 then
				table.insert(value, word)
			end
		end

		if #value == 0 then
			core.chat_send_player(player, S("You must supply a value parameter"))
			return false
		end

		local retval = alternode.set(pos, key, table.concat(value, " "):trim())

		if not retval then
			core.chat_send_player(player,
				S("Failed to set node meta at @1,@2,@3",
					tostring(pos.x), tostring(pos.y), tostring(pos.z)))
		else
			core.chat_send_player(player,
				S('Set meta "@1@=@2" for node at @3,@4,@5',
					key, core.get_meta(pos):get_string(key),
					tostring(pos.x), tostring(pos.y), tostring(pos.z)))
		end

		return retval
	end,
})

--- Unsets node meta value of a given key.
--
--  @chatcmd unsetmeta
--  @tparam number x X-coordinate of node.
--  @tparam number y Y-coordinate of node.
--  @tparam number z Z-coordinate of node.
--  @tparam string key Key to be unset.
core.register_chatcommand("unsetmeta", {
	params = S("<x> <y> <z> <key>"),
	description = S("Unset meta data of a node"),
	privs = {server=true,},
	func = function(player, param)
		local plist = string.split(param, " ")

		if #plist < 3 then
			core.chat_send_player(player, S("You must supply proper coordinates"))
			return false
		end

		for _, p in ipairs({plist[1], plist[2], plist[3]}) do
			if tonumber(p) == nil then
				core.chat_send_player(player, S("You must supply proper coordinates"))
				return false
			end
		end

		local pos = {
			x = tonumber(plist[1]),
			y = tonumber(plist[2]),
			z = tonumber(plist[3]),
		}

		local key = plist[4]
		if key then key = key:trim() end

		if not key or key == "" then
			core.chat_send_player(player, S("You must supply a key parameter"))
			return false
		end

		local retval = alternode.unset(pos, key)
		if not retval then
			core.chat_send_player(player,
				S("Failed to unset node meta at @1,@2,@3",
					tostring(pos.x), tostring(pos.y), tostring(pos.z)))
		else
			core.chat_send_player(player,
				S('Unset meta "@1" for node at @2,@3,@4',
					key, tostring(pos.x), tostring(pos.y), tostring(pos.z)))
		end

		return retval
	end,
})
