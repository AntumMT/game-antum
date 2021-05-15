
local use_s_protect = core.global_exists("s_protect")

local function is_area_owner(pos, pname)
	if not pname then return false end

	if use_s_protect then
		local claim = s_protect.get_claim(pos)
		if claim then return pname == claim.owner end
	else
		return core.is_protected(pos, pname)
	end

	return false
end

local function check_node_pos(target)
		if target.type ~= "node" then return end
		local pos = core.get_pointed_thing_position(target, false)
		if not core.get_node_or_nil(pos) then return end

		return pos
end


core.register_craftitem(ownit.modname .. ":wand", {
	description = "Tool for setting node owner",
	short_description = "Ownit Wand",
	inventory_image = "ownit_wand.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if not user:is_player() then return end
		local pos = check_node_pos(pointed_thing)
		if not pos then return end

		local pname = user:get_player_name()
		local nmeta = core.get_meta(pos)
		local node_owner = nmeta:get_string("owner")

		if node_owner ~= "" and pname ~= node_owner then
			core.chat_send_player(pname, "You cannot take ownership of a node owned by " .. node_owner)
			return
		end

		local unown = false
		if pname == node_owner then unown = true end

		if unown then
			nmeta:set_string("owner", nil)
			core.chat_send_player(pname, "You no longer own this node")
		else
			if not is_area_owner(pos, pname) then
				core.chat_send_player(pname, "You cannot take ownership of a node that is not in an area owned by you")
				return
			end

			nmeta:set_string("owner", pname)
			core.chat_send_player(pname, "You now own this node")
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		if not placer:is_player() then return end
		local pos = check_node_pos(pointed_thing)
		if not pos then return end

		local pname = placer:get_player_name()
		local node_owner = core.get_meta(pos):get_string("owner")

		if node_owner == "" then
			core.chat_send_player(pname, "This node is unowned")
		else
			core.chat_send_player(pname, "This node is owned by " .. node_owner)
		end
	end,
})
