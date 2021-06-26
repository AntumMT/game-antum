
--- walking_light Chat Commands
--
--  @topic commands


local S = core.get_translator(walking_light.modname)


--- Removes light added with walking_light from nearby nodes.
--
--  @chatcmd walking_light_clear_light
--  @param size Diameter of which light should be removed.
core.register_chatcommand("walking_light_clear_light", {
	params = "<size>",
	description = S("Remove light nodes from the area."),
	func = function(name, param)
		if not core.check_player_privs(name, {server=true}) then
			return false, S("You need the server privilege to use @1", "walking_light_clear_light")
		end

		local pos = vector.round(core.get_player_by_name(name):get_pos())
		local size = tonumber(param) or 40

		for i, v in ipairs({"walking_light:light", "walking_light:light_debug"}) do
			local point = core.find_node_near(pos, size/2, v)
			while point do
				walking_light.remove_light(nil, point)
				local oldpoint = point
				point = core.find_node_near(pos, size/2, v)
				if walking_light.poseq(oldpoint, point) then
					return false, S("Failed... infinite loop detected")
				end
			end
		end
		return true, S("Done.")
	end,
})

--- Adds light to nearby nodes.
--
--  FIXME: only adds one node, does not make use of "size" parameter
--
--  @chatcmd walking_light_add_light
--  @param size Diameter of which light should be added.
core.register_chatcommand("walking_light_add_light", {
	params = "<size>",
	description = S("Add walking_light:light to a position, without a player owning it."),
	func = function(name, param)
		if not core.check_player_privs(name, {server=true}) then
			return false, S("You need the server privilege to use @1", "walking_light_add_light")
		end

		local pos = vector.round(core.get_player_by_name(name):get_pos())
		pos = vector.new(pos.x, pos.y + 1, pos.z)

		if pos then
			walking_light.mt_add_node(pos, {type="node", name=walking_light_node})
		end

		return true, S("Done.")
	end,
})

--- Toggles debugging mode.
--
--  If enabled, nodes with added light will be visibly marked.
--
--  @chatcmd walking_light_debug
core.register_chatcommand("walking_light_debug", {
	description = S("Change to debug mode, so light blocks are visible."),
	func = function(name, param)
		if not core.check_player_privs(name, {server=true}) then
			return false, S("You need the server privilege to use @1", "walking_light_debug")
		end

		-- toggle debug mode
		walking_light.set_debug(not walking_light_debug)
		walking_light.update_node()

		return true, S("Done.")
	end,
})
