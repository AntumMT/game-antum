local function get_inventory_auth_string(player, meta, pos, label)
	return player:get_player_name() .. " tried to access a locked " .. label .. " belonging to " .. meta:get_string("owner") .. " at " .. minetest.pos_to_string(pos)
end


function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end


function get_allow_metadata_inventory_move(t)
	setmetatable(t, {__index={check_privs=has_locked_chest_privilege}})
	local label, check_privs = t[1], t.check_privs
	return function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not check_privs(meta, player) then
			minetest.log("action", get_inventory_auth_string(player, meta, pos, label))
			return 0
		end
		return count
	end
end

function get_allow_metadata_inventory_put(t)
	setmetatable(t, {__index={check_privs=has_locked_chest_privilege}})
	local label, check_privs = t[1], t.check_privs
	return function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not check_privs(meta, player) then
			minetest.log("action", get_inventory_auth_string(player, meta, pos, label))
			return 0
		end
		return stack:get_count()
	end
end

function get_allow_metadata_inventory_take(t)
	setmetatable(t, {__index={check_privs=has_locked_chest_privilege}})
	local label, check_privs = t[1], t.check_privs
	return function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not check_privs(meta, player) then
			minetest.log("action", get_inventory_auth_string(player, meta, pos, label))
			return 0
		end
		return stack:get_count()
	end
end



local function get_inventory_action_string(player, pos, action, label)
	return player:get_player_name() .. " moves stuff " .. action .. " locked " .. label .. " at " .. minetest.pos_to_string(pos)
end


function get_on_metadata_inventory_move(label)
	return function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", get_inventory_action_string(player, pos, "in", label)
		)
	end
end

function get_on_metadata_inventory_put(label)
	return function(pos, listname, index, stack, player)
		minetest.log("action", get_inventory_action_string(player, pos, "to", label))
	end
end

function get_on_metadata_inventory_take(label)
	return function(pos, listname, index, stack, player)
		minetest.log("action", get_inventory_action_string(player, pos, "from", label))
	end
end



actions = {
		has_locked_chest_privilege = has_locked_chest_privilege,
		get_allow_metadata_inventory_move = get_allow_metadata_inventory_move,
		get_allow_metadata_inventory_put = get_allow_metadata_inventory_put,
		get_allow_metadata_inventory_take = get_allow_metadata_inventory_take,
		get_on_metadata_inventory_move = get_on_metadata_inventory_move,
		get_on_metadata_inventory_put = get_on_metadata_inventory_put,
		get_on_metadata_inventory_take = get_on_metadata_inventory_take,
}
return actions
