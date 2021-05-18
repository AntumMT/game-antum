
--- Tools
--
--  @module tools.lua


local S = core.get_translator(alternode.modname)

local use_s_protect = core.global_exists("s_protect")
local misc = dofile(alternode.modpath .. "/misc_functions.lua")


local function check_permissions(player)
	local pname = player:get_player_name()

	local granted, missing = core.check_player_privs(pname, {server=true,})
	if not granted then
		core.chat_send_player(pname,
			S("You do not have privileges to use this item (missing priviliges: @1)", table.concat(missing, ", ")))
		return false
	end

	return true
end

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

--- Checks if a thing pointed at is a node.
--
--  @local
--  @function check_node
--  @param target pointed_thing
--  @param pname Name of player pointing.
--  @return `pos`, `node` if the pointed_thing is a node, `nil` otherwise.
local function check_node(target, pname)
	if not target then return false end

	local pos = nil
	local node = nil
	if target.type == "node" then
		pos = core.get_pointed_thing_position(target, false)
		node = core.get_node_or_nil(pos)
		if not node then
			pos = nil
		end
	end

	if not pos then
		core.chat_send_player(pname, S("This item only works on nodes"))
	end

	return pos, node
end


--- Admin tool to retrieve node node coordinates, name, & some select meta info.
--
--  Only players with the `server` privilege can use this item
--
--  @craftitem alternode:wand
--  @use Opens formspec to retrieve & set/unset meta attributes.
--  @place Print node coordinates, name, & some select meta info.
--  @image alternode_wand.png
core.register_craftitem(alternode.modname .. ":wand", {
	description = S("Tool for retrieving & setting node meta data"),
	short_description = S("Node Wand"),
	inventory_image = "alternode_wand.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if not user:is_player() then return end
		if not check_permissions(user) then return end

		local pname = user:get_player_name()
		local pos, node = check_node(pointed_thing, pname)
		if not pos then return end

		-- store pos info for retrieval in callbacks
		local pmeta = user:get_meta()
		pmeta:set_string(alternode.modname .. ":pos", core.serialize(pos))
		pmeta:set_string(alternode.modname .. ":node", core.serialize(node))

		core.show_formspec(pname, alternode.modname .. ":wand",
			alternode.get_wand_formspec(pos, node, user))
	end,
	on_place = function(itemstack, placer, pointed_thing)
		if not placer:is_player() then return end
		if not check_permissions(placer) then return end

		local pname = placer:get_player_name()
		local pos, node = check_node(pointed_thing, pname)
		if not pos then return end

		local nmeta = core.get_meta(pos)

		local infostring = S("Pos: x@=@1, y@=@2, z@=@3; Name: @4; Select meta info:",
			tostring(pos.x), tostring(pos.y), tostring(pos.z), node.name)
		-- some commonly used meta keys
		infostring = infostring .. misc.format_meta_values(nmeta, {"id", "infotext", "owner"})

		core.chat_send_player(pname, infostring)
	end,
})
core.register_alias(alternode.modname .. ":infostick", alternode.modname .. ":wand")


--- Player tool to alter *infotext* meta value.
--
--  @craftitem alternode:pencil
--  @use Opens formspec to set/unset infotext meta attribute.
--  @image alternode_pencil.png
core.register_craftitem(alternode.modname .. ":pencil", {
	description = S("Tool for editing node infotext"),
	short_description = S("Node Pencil"),
	inventory_image = "alternode_pencil.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if not user:is_player() then return end

		local pname = user:get_player_name()
		local pos = check_node(pointed_thing, pname)
		if not pos then return end

		if not is_area_owner(pos, pname) then
			core.chat_send_player(pname, S("You cannot alter nodes in areas you do not own"))
			return
		end

		-- store pos info for retrieval in callbacks
		user:get_meta():set_string(alternode.modname .. ":pos", core.serialize(pos))
		core.show_formspec(pname, alternode.modname .. ":pencil",
			alternode.get_pencil_formspec(pos))
	end,
})


--- Player tool to set/unset *owner* meta value.
--
--  @craftitem alternode:key
--  @use Sets/Unsets user as owner.
--  @place Prints owner status to chat log.
--  @image alternode_key.png
core.register_craftitem(alternode.modname .. ":key", {
	description = S("Tool for setting node owner"),
	short_description = S("Node Key"),
	inventory_image = "alternode_key.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if not user:is_player() then return end

		local pname = user:get_player_name()
		local pos = check_node(pointed_thing, pname)
		if not pos then return end

		local nmeta = core.get_meta(pos)
		local node_owner = nmeta:get_string("owner")

		if node_owner ~= "" and pname ~= node_owner then
			core.chat_send_player(pname, S("You cannot take ownership of a node owned by @1", node_owner))
			return
		end

		local unown = false
		if pname == node_owner then unown = true end

		if unown then
			nmeta:set_string("owner", nil)
			core.chat_send_player(pname, S("You no longer own this node"))
		else
			if not is_area_owner(pos, pname) then
				core.chat_send_player(pname, S("You cannot take ownership of nodes in areas you do not own"))
				return
			end

			nmeta:set_string("owner", pname)
			core.chat_send_player(pname, S("You now own this node"))
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		if not placer:is_player() then return end

		local pname = placer:get_player_name()
		local pos = check_node(pointed_thing, pname)
		if not pos then return end

		local node_owner = core.get_meta(pos):get_string("owner")

		if node_owner == "" then
			core.chat_send_player(pname, S("This node is unowned"))
		else
			core.chat_send_player(pname, S("This node is owned by @1", node_owner))
		end
	end,
})
core.register_alias("ownit:wand", alternode.modname .. ":key")
