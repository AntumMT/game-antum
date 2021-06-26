
--- walking_light Methods
--
--  @topic methods


-- list of all players seen by core.register_on_joinplayer
local players = {}
-- all player positions last time light was updated: {player_name : {x, y, z}}
local player_positions = {}
-- all light positions of light that currently is created {player_name : {i: {x, y, z}}
local light_positions = {}
-- last item seen wielded by players
local last_wielded = {}

-- toggles debug mode
local walking_light_debug = false

-- name of light node, changed by toggling debug mode
walking_light_node = nil

--- Sets debugging mode.
--
--  @tparam bool enabled Determines if debugging is enabled.
function walking_light.set_debug(enabled)
	walking_light_debug = enabled
end

-- list of items that use walking light when wielded
local light_items = {}

-- list of items that use walking light when equipped as armor
local light_armor = {}

--- Registers an item to emit light when wielded.
--
--  @tparam string iname Item technical name.
--  @tparam[opt] int radius Distance light will reach (max: 10).
function walking_light.register_item(iname, radius)
	if radius and radius > 10 then
		walking_light.log("warning", "light radius too high, setting to 10")
		radius = 10
	end

	local def = {radius=radius}

	for li in pairs(light_items) do
		if iname == li then
			walking_light.log("warning", "\"" .. iname .. "\" is already light item.")
			return
		end
	end

	light_items[iname] = def
end

--- DEPRECATED
--
--  Use `walking_light.register_item`
function walking_light.addLightItem(item)
	walking_light.log("warning",
		"\"walking_light.addLightItem\" is deprecated, use \"walking_light.register_item\"")

	return walking_light.register_item(item)
end

--- Registers an item to emit light when equipped in armor inventory.
--
--  Note: light radius will be overridden by light-emitting item being wielded.
--
--  @tparam string iname Item technical name.
--  @tparam[opt] int radius Distance light will reach (max: 10).
--  @tparam[opt] bool litem Whether or not this item should also be registered with `walking_light.register_item`.
function walking_light.register_armor(iname, radius, litem)
	if radius and radius > 10 then
		walking_light.log("warning", "light radius too high, setting to 10")
		radius = 10
	end

	local def = {radius=radius}
	if litem == nil then litem = true end

	for la in pairs(light_armor) do
		if iname == la then
			walking_light.log("warning", "\"" .. iname .. "\" is already light armor.")
		end
	end

	light_armor[iname] = def
	if litem then walking_light.register_item(iname, radius) end
end

--- Retrieves list of items registered as emitting light when wielded.
--
--  @treturn table Table indexed by key.
function walking_light.get_light_items()
	return light_items
end

--- DEPRECATED
--
--  Use `walking_light.get_light_items`
function walking_light.getLightItems()
	walking_light.log("warning",
		"\"walking_light.getLightItems\" is deprecated, use \"walking_light.get_light_items\"")

	return walking_light.get_light_items()
end

--- DEPRECATED
function walking_light.register_tool(tool)
	walking_light.log("warning", "\"walking_light.register_tool\" method is deprecated")

	local item, default, definition
	item = "walking_light:" .. tool .. "_mese"
	default = "default:" .. tool .. "_mese"

	definition = table.copy(core.registered_items[default])
	definition.description = definition.description .. " with light"
	definition.inventory_image = "walking_light_mese" .. tool .. ".png"

	core.register_tool(item, definition)
	core.register_craft({
		output = item,
		recipe = {
			{"default:torch"},
			{ default },
		}
	})

	walking_light.register_item(item)
end

-- from http://lua-users.org/wiki/IteratorsTutorial
-- useful for removing things from a table because removing from the middle makes it skip elements otherwise
local function ripairs(t)
	local function ripairs_it(t, i)
		i = i-1
		local v = t[i]
		if v == nil then return v end
		return i, v
	end

	return ripairs_it, t, #t+1
end

-- formats a vector with shorter output than dump
local function dumppos(pos)
	if pos == nil then
		return "nil"
	end
	local x = "nil"
	if pos.x then
		x = pos.x
	end
	local y = "nil"
	if pos.y then
		y = pos.y
	end
	local z = "nil"
	if pos.z then
		z = pos.z
	end

	return "(" .. x .. "," .. y .. "," .. z .. ")"
end

-- formats a table containing vectors with shorter output than dump
local function dumppostable(t)
	if t == nil then
		return "nil"
	end
	if #t == 0 then
		return "0{}"
	end

	ret = #t .. "{\n"
	for i, pos in ipairs(t) do
		ret = ret .. "    " .. dumppos(pos) .. "\n"
	end
	ret = ret .. "}"
	return ret
end

local function mt_get_node_or_nil(pos)
	if pos == nil then
		walking_light.log("error", "mt_get_node_or_nil(), pos is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end

	local node = core.get_node_or_nil(pos)
	if not node then
		-- Load the map at pos and try again
		core.get_voxel_manip():read_from_map(pos, pos)
		node = core.get_node(pos)
	end

	-- If node.name is "ignore" here, the map probably isn't generated at pos.
	return node

end

--- Adds a node to the world.
--
--  @tparam table pos Position.
--  @tparam table sometable
function walking_light.mt_add_node(pos, sometable)
	if pos == nil then
		walking_light.log("error", "walking_light.mt_add_node(), pos is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end
	if sometable == nil then
		walking_light.log("error", "walking_light.mt_add_node(), sometable is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end

	core.add_node(pos, sometable)
end

--- DEPRECATED
--
--  Use `walking_light.mt_add_node`
function mt_add_node(pos, sometable)
	walking_light.log("warning", "\"mt_add_node\" is deprecated, use \"walking_light.mt_add_node\"")

	return walking_light.mt_add_node(pos, sometable)
end

local function round(num)
	return math.floor(num + 0.5)
end

---
--
--  @tparam table pos1
--  @tparam table pos2
--  @treturn bool
function walking_light.poseq(pos1, pos2)
	if pos1 == nil and pos2 == nil then
		return true
	end
	if pos1 == nil or pos2 == nil then
		return false
	end

	return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
end

--- DEPRECATED
--
--  Use `walking_light.poseq`
function poseq(pos1, pos2)
	walking_light.log("warning", "\"poseq\" is deprecated, use \"walking_light.poseq\"")

	return walking_light.poseq(pos1, pos2)
end

-- return true if the player moved since last player_positions update
local function player_moved(player)
	local player_name = player:get_player_name()
	local pos = player:get_pos()
	local rounded_pos = vector.round(pos)
	local oldpos = player_positions[player_name]
	if oldpos == nil or not walking_light.poseq(rounded_pos, oldpos) then
		-- if oldpos is nil, we assume they just logged in, so consider them moved
		return true
	end

	return false
end

-- same as table.remove(t, remove_pos), but uses walking_light.poseq instead of comparing references (does lua have comparator support, so this isn't needed?)
local function table_remove_pos(t, remove_pos)
	for i, pos in ipairs(t) do
		if walking_light.poseq(pos, remove_pos) then
			table.remove(t, i)
			break
		end
	end
end

-- same as t[remove_pos], but uses walking_light.poseq instead of comparing references (does lua have comparator support, so this isn't needed?)
local function table_contains_pos(t, remove_pos)
	for i, pos in ipairs(t) do
		if walking_light.poseq(pos, remove_pos) then
			return true
		end
	end

	return false
end

-- same as table.insert(t, pos) but makes sure it is not duplicated
local function table_insert_pos(t, pos)
	if not table_contains_pos( pos ) then
		table.insert(t, pos)
	end
end

local function is_light(node)
	if node ~= nil and node ~= "ignore" and (node.name == "walking_light:light" or node.name == "walking_light:light_debug") then
		return true
	end
	return false
end

--- Removes light at the given position.
--
--  @tparam[opt] ObjectRef player
--  @tparam table pos Posistion where light will be removed.
function walking_light.remove_light(player, pos)
	local player_name
	if player then
		player_name = player:get_player_name()
	end
	local node = mt_get_node_or_nil(pos)
	if is_light(node) then
		walking_light.mt_add_node(pos, {type="node", name="air"})
		if player_name then
			table_remove_pos(light_positions[player_name], pos)
		end
	else
		if node ~= nil then
			walking_light.log("warning", "walking_light.remove_light(), pos = "
				.. dumppos(pos) .. ", tried to remove light but node was " .. node.name)
			table_remove_pos(light_positions[player_name], pos)
		else
			walking_light.log("warning", "walking_light.remove_light(), pos = "
				.. dumppos(pos) .. ", tried to remove light but node was nil")
		end
	end
end

--- DEPRECATED
--
--  Use `walking_light.remove_light`
function remove_light(player, pos)
	walking_light.log("warning", "\"remove_light\" is deprecated, use \"walking_light.remove_light\"")

	return walking_light.remove_light(player, pos)
end

-- removes all light owned by a player
local function remove_light_player(player)
	local player_name = player:get_player_name()

	for i, old_pos in ripairs(light_positions[player_name]) do
		if old_pos then
			walking_light.remove_light(player, old_pos)
		end
	end
end

local function can_add_light(pos)
	local node  = mt_get_node_or_nil(pos)
	if node == nil or node == "ignore" then
		-- if node is nil (unknown) or ignore (not generated), then we don't do anything.
		return false
	elseif node.name == "air" then
		return true
	elseif is_light(node) then
		return true
	end

	return false
end

-- old function returns pos instead of table, for only one position
local function pick_light_position_regular(player, pos)
	if can_add_light(pos) then
		return {pos}
	end

	local pos2

	-- if pos is not possible, try the old player position first, to make it more likely that it has a line of sight
	local player_name = player:get_player_name()
	local oldplayerpos = player_positions[player_name]
	if oldplayerpos and can_add_light(vector.new(oldplayerpos.x, oldplayerpos.y + 1, oldplayerpos.z)) then
		return oldplayerpos
	end

	-- if not, try all positions around the pos
	pos2 = vector.new(pos.x + 1, pos.y, pos.z)
	if can_add_light(pos2) then
		return {pos2}
	end

	pos2 = vector.new(pos.x - 1, pos.y, pos.z)
	if can_add_light(pos2) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y, pos.z + 1)
	if can_add_light(pos2) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y, pos.z - 1)
	if can_add_light(pos2) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y + 1, pos.z)
	if can_add_light(pos2) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y - 1, pos.z)
	if can_add_light(pos2) then
		return {pos2}
	end

	return nil
end

-- new function, returns table
local function pick_light_position_radius(player, pos, radius)
	local ret = {}
	if can_add_light(pos) then
		table.insert(ret, pos)
	end

	local pos2
	local step = 4
	local unstep = 1/step

	for x = pos.x - radius, pos.x + radius, step do
		for y = pos.y - radius, pos.y + radius, step do
			for z = pos.z - radius, pos.z + radius, step do
				pos2 = vector.new(round(x*unstep)*step, round(y*unstep)*step, round(z*unstep)*step)
				local distance = math.sqrt(math.pow(pos.x - x, 2) + math.pow(pos.y - y, 2) + math.pow(pos.z - z, 2))
				if distance <= radius and can_add_light( pos2 ) then
					table.insert(ret, pos2)
				end
			end
		end
	end

	return ret
end

local function pick_light_position(player, pos, radius)
	if radius then
		return pick_light_position_radius(player, pos, radius)
	end

	return pick_light_position_regular(player, pos)
end

-- adds light at the given position
local function add_light(player, pos)
	local player_name = player:get_player_name()
	local node  = mt_get_node_or_nil(pos)
	if node == nil or node == "ignore" then
		-- don't do anything for nil (non-loaded) or ignore (non-generated) blocks, so we don't want to overwrite anything there
		return false
	elseif node.name == "air" then
		-- when the node that is already there is air, add light
		walking_light.mt_add_node(pos, {type="node", name=walking_light_node})
		if not table_contains_pos(light_positions[player_name], pos) then
			table_insert_pos(light_positions[player_name], pos)
		end

		return true
	elseif is_light(node) then
		-- no point in adding light where it is already, but we should assign it to the player so it gets removed (in case it has no player)
		if not table_contains_pos(light_positions[player_name], pos) then
			table_insert_pos(light_positions[player_name], pos)
		end

		return true
	end

	return false
end

-- returns a string, the name of the item found that is a light item
local function get_wielded_light_item(player)
	local wielded_item = player:get_wielded_item():get_name()
	if wielded_item ~= "" and walking_light.is_light_item(wielded_item) then
		return wielded_item
	end

	-- check equipped armor
	if core.get_modpath("3d_armor") then
		local player_name = player:get_player_name()
		if player_name then
			local armor_inv = core.get_inventory({type="detached", name=player_name.."_armor"})
			if armor_inv then
				for k, stack in pairs(armor_inv:get_list("armor")) do
					local item_name = stack:get_name()
					if walking_light.is_light_armor(item_name) then
						return item_name, true
					end
				end
			end
		end
	end

	return nil
end

-- updates all the light around the player, depending on what they are wielding
local function update_light_player(player)
	-- if there is no player, there can be no update
	if not player then
		return
	end

	-- figure out if they wield light; this will be nil if not
	local wielded_item, is_armor = get_wielded_light_item(player)

	local player_name = player:get_player_name()
	local pos = player:get_pos()
	local rounded_pos = vector.round(pos)

	-- check for a nil node where the player is; if it is nil, we assume the block is not loaded, so we return without updating player_positions
	-- that way, it should add light next step
	local node = mt_get_node_or_nil(rounded_pos)
	if node == nil or node == "ignore" then
		return
	end

	if not player_moved(player) and wielded_item == last_wielded[player_name] then
		-- no update needed if the wiedled light item is the same as before (including nil), and the player didn't move
		return
	end
	last_wielded[player_name] = wielded_item;

	local wantlightpos = nil
	local wantpos = vector.new(rounded_pos.x, rounded_pos.y + 1, rounded_pos.z)
	if wielded_item then
		local radius
		if is_armor then
			radius = light_armor[wielded_item].radius
		else
			radius = light_items[wielded_item].radius
		end

		-- decide where light should be
		wantlightpos = pick_light_position(player, wantpos, radius)
	end

	if wielded_item and wantlightpos then
		-- add light that isn't already there
		for i, newpos in ipairs(wantlightpos) do
			add_light(player, newpos)
		end
	end

	-- go through all light owned by the player to remove all but what should be kept
	for i, oldlightpos in ripairs(light_positions[player_name]) do
		if not wantlightpos or oldlightpos and oldlightpos.x and not table_contains_pos(wantlightpos, oldlightpos) then
			walking_light.remove_light(player, oldlightpos)
		end
	end

	player_positions[player_name] = vector.round(pos)
end

local function update_light_all()
	-- go through all players to check
	for i, player_name in ipairs(players) do
		local player = core.get_player_by_name(player_name)
		update_light_player(player)
	end
end

--- Checks if an item is registered as emitting light when wielded.
--
--  @tparam string iname Item technical name.
--  @treturn bool `true` if item is registered.
function walking_light.is_light_item(iname)
	for li in pairs(light_items) do
		if iname == li then
			return true
		end
	end

	return false
end

--- Checks if an item is registered as emitting light when equipped in armor inventory.
--
--  @tparam string iname Item technical name.
--  @treturn bool `true` if item is registered.
function walking_light.is_light_armor(iname)
	for la in pairs(light_armor) do
		if iname == la then
			return true
		end
	end

	return false
end

--- Checks if player is wielding a light-emitting item.
--
--  @tparam ObjectRef player Player to be checked.
--  @treturn bool `true` if player is wielding registered item.
function walking_light.wields_light(player)
	return get_wielded_light_item(player) ~= nil
end

core.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	table.insert(players, player_name)
	last_wielded[player_name] = get_wielded_light_item(player)
	local pos = player:get_pos()
	player_positions[player_name] = nil
	light_positions[player_name] = {}
	update_light_player(player)
end)

core.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	for i, v in ipairs(players) do
		if v == player_name then
			table.remove(players, i)
		end
	end
	last_wielded[player_name] = false
	remove_light_player(player)
	player_positions[player_name] = nil
end)

core.register_globalstep(function(dtime)
	for i, player_name in ipairs(players) do
		local player = core.get_player_by_name(player_name)
		if player ~= nil then
			update_light_player(player)
		else
			table.remove(players, i)
		end
	end
end)

--- Updates light node texture.
--
--  If debugging, node will display a marker, otherwise will be transparent.
function walking_light.update_node()
	if walking_light_debug then
		walking_light_node = "walking_light:light_debug"
	else
		walking_light_node = "walking_light:light"
	end
end

walking_light.update_node()
