
--- Cleaner Chat Commands
--
--  @topic commands


local S = core.get_translator(cleaner.modname)


local aux = dofile(cleaner.modpath .. "/misc_functions.lua")

local function pos_list(ppos, radius)
	local plist = {}

	for x = ppos.x - radius, ppos.x + radius, 1 do
		for y = ppos.y - radius, ppos.y + radius, 1 do
			for z = ppos.z - radius, ppos.z + radius, 1 do
				table.insert(plist, {x=x, y=y, z=z})
			end
		end
	end

	return plist
end

local param_def = {
	radius = {name=S("radius"), desc=S("Search radius.")},
	entity = {name=S("entity"), desc=S("Entity technical name.")},
	node = {name=S("node"), desc=S("Node technical name.")},
	old_node = {name=S("old_node"), desc=S("Technical name of node to be replaced.")},
	new_node = {name=S("new_node"), desc=S("Technical name of node to be used in place.")},
	old_item = {name=S("old_item"), desc=S("Technical name of item to be replaced.")},
	new_item = {name=S("new_item"), desc=S("Technical name of item to be used in place.")},
	ore = {name=S("ore"), desc=S("Ore technical name.")},
}

local cmd_repo = {
	entity = {
		cmd = "remove_entities",
		params = {"entity"},
		oparams = {radius=100},
	},
	rem_node = {
		cmd = "remove_nodes",
		params = {"node"},
		oparams = {radius=5},
	},
	rep_node = {
		cmd = "replace_nodes",
		params = {"old_node", "new_node"},
		oparams = {radius=5},
	},
	find_node = {
		cmd = "find_unknown_nodes",
		oparams = {radius=100},
	},
	item = {
		cmd = "replace_items",
		params = {"old_item", "new_item"},
	},
	ore = {
		cmd = "remove_ores",
		params = {"ore"},
	},
	param = {
		missing = S("Missing parameter."),
		excess = S("Too many parameters."),
		mal_radius = S("Radius must be a number."),
	},
}

for k, def in pairs(cmd_repo) do
	if k ~= "param" then
		local cmd_help = {
			param_string = "",
			usage_string = "/" .. def.cmd,
		}

		if def.params or def.oparams then
			if def.params then
				local params = {}
				for _, p in ipairs(def.params) do
					-- translate
					table.insert(params, S(p))
				end

				cmd_help.param_string = "<" .. table.concat(params, "> <") .. ">"
			end
		end

		if def.oparams then
			for k, v in pairs(def.oparams) do
				local op = k
				if type(op) == "number" then
					op = v
				end

				cmd_help.param_string = cmd_help.param_string .. " [" .. S(op) .. "]"
			end
		end

		if cmd_help.param_string ~= "" then
			cmd_help.usage_string = cmd_help.usage_string .. " " .. cmd_help.param_string
		end

		cmd_repo[k].help = cmd_help
	end
end

local function get_cmd_def(cmd)
	for k, v in pairs(cmd_repo) do
		if v.cmd == cmd then return v end
	end
end

local function format_usage(cmd)
	local def = get_cmd_def(cmd)
	if def then
		return S("Usage:") .. "\n  " .. def.help.usage_string
	end
end

local function format_params(cmd)
	local def = get_cmd_def(cmd)

	local param_count
	local all_params = {}
	if def.params then
		for k, v in ipairs(def.params) do
			table.insert(all_params, p)
		end
	end
	if def.oparams then
		for k, v in pairs(def.oparams) do

		end
	end

	local retval = ""
	local p_count = 0

	if def.params then
		for _, p in ipairs(def.params) do
			if p_count == 0 then
				retval = retval .. S("Params:")
			end

			retval = retval .. "\n  " .. S(p) .. ": " .. param_def[p].desc

			p_count = p_count + 1
		end
	end

	if def.oparams then
		for k, v in pairs(def.oparams) do
			if p_count == 0 then
				retval = retval .. S("Params:")
			end

			local p = k
			local dvalue = v
			if type(p) == "number" then
				p = v
				dvalue = nil
			end

			retval = retval .. "\n  " .. S(p) .. ": " .. param_def[p].desc
			if dvalue then
				retval = retval .. " (" .. S("default: @1", dvalue) .. ")"
			end

			p_count = p_count + 1
		end
	end

	return retval
end

local function format_help(cmd)
	return format_usage(cmd) .. "\n\n" .. format_params(cmd)
end


--- Removes nearby entities.
--
--  @chatcmd remove_entities
--  @param entity Entity technical name.
--  @tparam[opt] int radius
core.register_chatcommand(cmd_repo.entity.cmd, {
	privs = {server=true},
	description = S("Remove an entity from game.") .. "\n\n"
		.. format_params(cmd_repo.entity.cmd),
	params = cmd_repo.entity.help.param_string,
	func = function(name, param)
		local entity
		local radius = cmd_repo.entity.oparams.radius
		if param:find(" ") then
			entity = param:split(" ")
			radius = tonumber(entity[2])
			entity = entity[1]
		else
			entity = param
		end

		local err
		if not entity or entity:trim() == "" then
			err = cmd_repo.param.missing
		elseif not radius then
			err = cmd_repo.param.mal_radius
		end

		if err then
			return false, err .. "\n\n" .. format_help(cmd_repo.entity.cmd)
		end

		local player = core.get_player_by_name(name)

		local total_removed = 0
		for _, object in ipairs(core.get_objects_inside_radius(player:get_pos(), radius)) do
			local lent = object:get_luaentity()

			if lent then
				if lent.name == entity then
					object:remove()
					total_removed = total_removed + 1
				end
			else
				if object:get_properties().infotext == entity then
					object:remove()
					total_removed = total_removed + 1
				end
			end
		end

		return true, S("Removed @1 entities.", total_removed)
	end,
})

--- Removes nearby nodes.
--
--  @chatcmd remove_nodes
--  @param node Node technical name.
--  @tparam[opt] int radius
core.register_chatcommand(cmd_repo.rem_node.cmd, {
	privs = {server=true},
	description = S("Remove a node from game.") .. "\n\n"
		.. format_params(cmd_repo.rem_node.cmd),
	params = cmd_repo.rem_node.help.param_string,
	func = function(name, param)
		local nname
		local radius = cmd_repo.rem_node.oparams.radius
		if param:find(" ") then
			nname = param:split(" ")
			radius = tonumber(nname[2])
			nname = nname[1]
		else
			nname = param
		end

		local err
		if not nname or nname:trim() == "" then
			err = cmd_repo.param.missing
		elseif not radius then
			err = cmd_repo.param.mal_radius
		end

		if err then
			return false, err .. "\n\n" .. format_help(cmd_repo.rem_node.cmd)
		end

		local ppos = core.get_player_by_name(name):get_pos()

		local total_removed = 0
		for _, npos in ipairs(pos_list(ppos, radius)) do
			local node = core.get_node_or_nil(npos)
			if node and node.name == nname then
				core.remove_node(npos)
				total_removed = total_removed + 1
			end
		end

		return true, S("Removed @1 nodes.", total_removed)
	end,
})

--- Replaces an item.
--
--  @chatcmd replace_items
--  @param old_item Technical name of item to replace.
--  @param new_item Technical name of item to be used in place.
core.register_chatcommand(cmd_repo.item.cmd, {
	privs = {server=true},
	description = S("Replace an item in game.") .. "\n\n"
		.. format_params(cmd_repo.item.cmd),
	params = cmd_repo.item.help.param_string,
	func = function(name, param)
		if not param:find(" ") then
			return false, cmd_repo.param.missing .. "\n\n" .. format_help(cmd_repo.item.cmd)
		end

		local src = param:split(" ")
		local tgt = src[2]
		src = src[1]

		local retval, msg = cleaner.replace_item(src, tgt, true)
		if not retval then
			return false, msg
		end

		return true, S("Success!")
	end,
})

--- Replaces nearby nodes.
--
--  @chatcmd replace_nodes
--  @param old_node Technical name of node to replace.
--  @param new_node Technical name of node to be used in place.
--  @tparam[opt] int radius
core.register_chatcommand(cmd_repo.rep_node.cmd, {
	privs = {server=true},
	description = S("Replace a node in game.") .. "\n\n"
		.. format_params(cmd_repo.rep_node.cmd),
	params = cmd_repo.rep_node.help.param_string,
	func = function(name, param)
		local help = format_help(cmd_repo.rep_node.cmd)

		if not param:find(" ") then
			return false, cmd_repo.param.missing .. "\n\n" .. help
		end

		local radius = cmd_repo.rep_node.oparams.radius
		local params = param:split(" ")

		local src = params[1]
		local tgt = tostring(params[2])
		if #params > 2 then
			radius = tonumber(params[3])
		end

		if not radius then
			return false, cmd_repo.param.mal_radius .. "\n\n" .. help
		end

		if not core.registered_nodes[tgt] then
			return false, S('Cannot use unknown node "@1" as replacement.', tgt)
		end

		local total_replaced = 0
		local ppos = core.get_player_by_name(name):get_pos()
		for _, npos in ipairs(pos_list(ppos, radius)) do
			local node = core.get_node_or_nil(npos)
			if node and node.name == src then
				if core.swap_node(npos, {name=tgt}) then
					total_replaced = total_replaced + 1
				else
					cleaner.log("error", "could not replace node at " .. core.pos_to_string(npos, 0))
				end
			end
		end

		return true, S("Replaced @1 nodes.", total_replaced)
	end,
})

--- Checks for nearby unknown nodes.
--
--  @chatcmd find_unknown_nodes
--  @tparam[opt] int radius Search radius.
core.register_chatcommand(cmd_repo.find_node.cmd, {
	privs = {server=true},
	description = S("Find names of unknown nodes.") .. "\n\n"
		.. format_params(cmd_repo.find_node.cmd),
	params = cmd_repo.find_node.help.param_string,
	func = function(name, param)
		local help = format_help(cmd_repo.find_node.cmd)

		if param:find(" ") then
			return false, cmd_repo.param.excess .. "\n\n" .. help
		end

		local radius = cmd_repo.find_node.oparams.radius
		if param and param:trim() ~= "" then
			radius = tonumber(param)
		end

		if not radius then
			return false, cmd_repo.param.mal_radius .. "\n\n" .. help
		end

		local ppos = core.get_player_by_name(name):get_pos()

		local checked_nodes = {}
		local unknown_nodes = {}
		for _, npos in ipairs(pos_list(ppos, radius)) do
			local node = core.get_node_or_nil(npos)
			if node and not checked_nodes[node.name] then
				if not core.registered_nodes[node.name] then
					table.insert(unknown_nodes, node.name)
				end

				checked_nodes[node.name] = true
			end
		end

		local msg
		if #unknown_nodes > 0 then
			msg = S("Found unknown nodes: @1", table.concat(unknown_nodes, ", "))
		else
			msg = S("No unknown nodes found.")
		end

		return true, msg
	end,
})


--- Unsafe commands.
--
--  Enabled with `cleaner.unsafe` setting.
--
--  @section unsafe


if cleaner.unsafe then
	--- Registers an ore to be removed.
	--
	--  @chatcmd remove_ores
	--  @param ore Ore technical name.
	core.register_chatcommand(cmd_repo.ore.cmd, {
		privs = {server=true},
		description = S("Remove an ore from game.") .. "\n\n"
			.. format_params(cmd_repo.ore.cmd),
		params = cmd_repo.ore.help.param_string,
		func = function(name, param)
			local err
			if not param or param:trim() == "" then
				err = cmd_repo.param.missing
			elseif param:find(" ") then
				err = cmd_repo.param.excess
			end

			if err then
				return false, err .. "\n\n" .. format_help(cmd_repo.ore.cmd)
			end

			local success = false
			local msg
			local registered, total_removed = cleaner.remove_ore(param)

			if not registered then
				msg = S('Ore "@1" not found, not unregistering.', param)
			else
				msg = S("Unregistered @1 ores (this will be undone after server restart).", total_removed)
				success = true
			end

			return success, msg
		end
	})
end

--- @section end


--- Manages settings for wielded cleaner tool.
--
--  @chatcmd cleaner
--  @param action Action to execute. Can be "status", "setmode", or "setnode".
--  @param value Mode or node to be set for tool.
core.register_chatcommand("cleaner", {
	privs = {server=true},
	description = S("Manage settings for wielded cleaner tool.") .. "\n\n"
		.. S("Params:") .. "\n  action: Action to execute. Can be one of \"status\", \"setmode\", or \"setnode\"."
		.. "\n  value: Mode or node to be set for tool.",
	params = "<action> <value>",
	func = function(name, param)
		local action, value = param
		local idx = param:find(" ")
		if idx then
			param = string.split(param, " ")
			action = param[1]
			value = param[2]
		end

		local player = core.get_player_by_name(name)
		local stack = player:get_wielded_item()
		local iname = aux.tool:format_name(stack)
		local imeta = stack:get_meta()

		if iname ~= "cleaner:pencil" then
			return false, S("Unrecognized wielded item: @1", iname)
		end

		if action == "status" then
			core.chat_send_player(name, iname .. ": "
				.. S("mode=@1, node=@2", imeta:get_string("mode"), imeta:get_string("node")))
			return true
		end

		if not action or not value then
			return false, S("Missing parameter.")
		end

		if action == "setmode" then
			stack = aux.tool:set_mode(stack, value, name)
		elseif action == "setnode" then
			stack = aux.tool:set_node(stack, value, name)
		else
			return false, S("Unrecognized action: @1", action)
		end

		return player:set_wielded_item(stack)
	end,
})
