
--- wlight Chat Commands
--
--  @topic commands


local S = core.get_translator(wlight.modname)


--- Manages lighted nodes and debugging.
--
--  **Parameters:**
--
--  @chatcmd wlight
--  @tparam command Command action to be executed.
--  @tparam[opt] radius Area radius (default: 20).
--  @usage /wlight <command> [radius]
--
--  Commands:
--    - add:    Add lighting to current position.
--    - remove: Remove lighting from current position.
--    - debug:  Toggle illuminated nodes visible mark for debugging.
--
--  Options:
--    - radius: Area radius (add default: 0, remove default: 20).
--
--  Example:
--    /wlight add 5
core.register_chatcommand(wlight.modname, {
	params = "<" .. S("command") .. "> [" .. S("radius") .. "]",
	privs = {server=true},
	description = S("Manage lighted nodes and debugging.")
		.. "\n\n" .. S("Commands:")
		.. "\n  add:    " .. S("Add lighting to current position.")
		.. "\n  remove: " .. S("Remove lighting from current position.")
		.. "\n  debug:  " .. S("Toggle illuminated nodes visible mark for debugging.")
		.. "\n\n" .. S("Options:")
		.. "\n  " .. S("radius") .. ": " .. S("Area radius (add default: 0, remove default: 20)."),
	func = function(name, param)
		local command
		local radius
		if param:find(" ") then
			local params = param:split(" ")
			command = params[1]
			radius = tonumber(params[2])
		else
			command = param
		end

		if not radius then
			radius = 0
			if command == "remove" then
				radius = 20
			end
		end

		if command == "" then
			core.chat_send_player(name, "\n" .. S("Missing command parameter."))
			return false
		end

		if (command == "add" or command == "remove") and not radius then
			core.chat_send_player(name, "\n" .. S("Missing radius parameter."))
			return false
		end

		local pos = vector.round(core.get_player_by_name(name):get_pos())

		if command == "debug" then
			wlight.set_debug(not wlight.debug_enabled())
			wlight.update_node()
		elseif command == "add" then
			pos = vector.new(pos.x, pos.y + 1, pos.z)
			if pos then
				local pmin = {x=pos.x-radius, y=pos.y-radius, z=pos.z-radius}
				local pmax = {x=pos.x+radius, y=pos.y+radius, z=pos.z+radius}
				local near_nodes = core.find_nodes_in_area(pmin, pmax, "air", true)
				if near_nodes.air then
					for _, npos in ipairs(near_nodes.air) do
						wlight.mt_add_node(npos, {type="node", name=wlight_node})
					end
				end
			end
		elseif command == "remove" then
			for _, v in ipairs({"wlight:light", "wlight:light_debug"}) do
				local point = core.find_node_near(pos, radius, v)
				while point do
					wlight.remove_light(nil, point)
					local oldpoint = point
					point = core.find_node_near(pos, radius, v)
					if wlight.poseq(oldpoint, point) then
						return false, S("Failed... infinite loop detected.")
					end
				end
			end
		else
			core.chat_send_player(name, "\n" .. S("Unknown command: @1", command))
			return false
		end

		return true, S("Done.")
	end,
})
