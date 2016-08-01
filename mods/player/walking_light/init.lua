-- list of all players seen by minetest.register_on_joinplayer
local players = {}
-- all player positions last time light was updated: {player_name : {x, y, z}}
local player_positions = {}
-- all light positions of light that currently is created {player_name : {i: {x, y, z}}
local light_positions = {}
-- last item seen wielded by players
local last_wielded = {}

-- from http://lua-users.org/wiki/IteratorsTutorial
-- useful for removing things from a table because removing from the middle makes it skip elements otherwise
function ripairs(t)
  local function ripairs_it(t,i)
    i=i-1
    local v=t[i]
    if v==nil then return v end
    return i,v
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
	for i,pos in ipairs(t) do
		ret = ret .. "    " .. dumppos(pos) .. "\n"
	end
	ret = ret .. "}"
	return ret
end

function mt_get_node_or_nil(pos)
	if pos == nil then
		print("ERROR: walking_light.mt_get_node_or_nil(), pos is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end
	return minetest.env:get_node_or_nil(pos)
end

function mt_add_node(pos, sometable)
	if pos == nil then
		print("ERROR: walking_light.mt_add_node(), pos is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end
	if sometable == nil then
		print("ERROR: walking_light.mt_add_node(), sometable is nil")
		print(debug.traceback("Current Callstack:\n"))
		return nil
	end
	minetest.env:add_node(pos,sometable)
end

function round(num) 
	return math.floor(num + 0.5) 
end

local function poseq(pos1, pos2)
	if pos1 == nil and pos2 == nil then
		return true
	end
	if pos1 == nil or pos2 == nil then
		return false
	end
	return pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z
end

-- return true if the player moved since last player_positions update
local function player_moved(player)
	local player_name = player:get_player_name()
	local pos = player:getpos()
	local rounded_pos = vector.round(pos)
	local oldpos = player_positions[player_name]
	if oldpos == nil or not poseq(rounded_pos, oldpos) then
		-- if oldpos is nil, we assume they just logged in, so consider them moved
--		print("DEBUG: walking_light, player_moved(); moved = true; rounded_pos = " .. dumppos(rounded_pos) .. ", oldpos = " .. dumppos(oldpos))
		return true
	end
--	print("DEBUG: walking_light, player_moved(); moved = false; rounded_pos = " .. dumppos(rounded_pos) .. ", oldpos = " .. dumppos(oldpos))
	return false
end

-- same as table.remove(t,remove_pos), but uses poseq instead of comparing references (does lua have comparator support, so this isn't needed?)
local function table_remove_pos(t, remove_pos)
--	local DEBUG_oldsize = #t

	for i,pos in ipairs(t) do
		if poseq(pos, remove_pos) then
			table.remove(t, i)
			break
		end
	end

--	local DEBUG_newsize = #t
--	print("DEBUG: walking_light.table_remove_pos(), oldsize = " .. DEBUG_oldsize .. ", newsize = " .. DEBUG_newsize)
end

-- same as t[remove_pos], but uses poseq instead of comparing references (does lua have comparator support, so this isn't needed?)
local function table_contains_pos(t, remove_pos)
	for i,pos in ipairs(t) do
		if poseq(pos, remove_pos) then
			return true
		end
	end
	return false
end

-- same as table.insert(t,pos) but makes sure it is not duplicated
local function table_insert_pos(t, pos)
	if not table_contains_pos( pos ) then
		table.insert(t, pos)
	end
end

-- removes light at the given position
-- player is optional
local function remove_light(player, pos)
	local player_name
	if player then
		player_name = player:get_player_name()
	end
	local node = mt_get_node_or_nil(pos)
	if node ~= nil and node.name == "walking_light:light" then
		mt_add_node(pos,{type="node",name="walking_light:clear"})
		mt_add_node(pos,{type="node",name="air"})
		if player_name then
			table_remove_pos(light_positions[player_name], pos)
		end
	else
		if node ~= nil then
			print("WARNING: walking_light.remove_light(), pos = " .. dumppos(pos) .. ", tried to remove light but node was " .. node.name)
			table_remove_pos(light_positions[player_name], pos)
		else
			print("WARNING: walking_light.remove_light(), pos = " .. dumppos(pos) .. ", tried to remove light but node was nil")
		end
	end
end

-- removes all light owned by a player
local function remove_light_player(player)
	local player_name = player:get_player_name()

    for i,old_pos in ripairs(light_positions[player_name]) do
		if old_pos then
--			print("DEBUG: walking_light.remove_light_player(), removing old light; old_pos = " .. dumppos(old_pos))
			remove_light(player, old_pos)
		end
	end
	print("DEBUG: walking_light.remove_light_player(), done; light_positions = " .. dumppostable(light_positions[player_name]))
end

local function can_add_light(pos)
	local node  = mt_get_node_or_nil(pos)
	if node == nil or node.name == "air" then
--		print("walking_light can_add_light(), pos = " .. dumppos(pos) .. ", true")
		return true
	elseif node.name == "walking_light:light" then
--		print("walking_light can_add_light(), pos = " .. dumppos(pos) .. ", true")
		return true
	end
--	print("walking_light can_add_light(), pos = " .. dumppos(pos) .. ", false")
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
	if oldplayerpos and can_add_light( vector.new(oldplayerpos.x, oldplayerpos.y + 1, oldplayerpos.z) ) then
		return oldplayerpos 
	end

	-- if not, try all positions around the pos
	pos2 = vector.new(pos.x + 1, pos.y, pos.z)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	pos2 = vector.new(pos.x - 1, pos.y, pos.z)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y, pos.z + 1)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y, pos.z - 1)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y + 1, pos.z)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	pos2 = vector.new(pos.x, pos.y - 1, pos.z)
	if can_add_light( pos2 ) then
		return {pos2}
	end

	return nil
end

-- new function, returns table
local function pick_light_position_radius(player, pos, ret, radius)
	local pos2
	local step = 4
	local unstep = 1/step

	for x = pos.x - radius, pos.x + radius, step do
		for y = pos.y - radius, pos.y + radius, step do
			for z = pos.z - radius, pos.z + radius, step do
				pos2 = vector.new(round(x*unstep)*step, round(y*unstep)*step, round(z*unstep)*step)
				distance = math.sqrt(math.pow(pos.x - x, 2) + math.pow(pos.y - y, 2) + math.pow(pos.z - z, 2))
				if distance <= radius and can_add_light( pos2 ) then
					table.insert(ret, pos2)
				end
			end
		end
	end

	return ret
end

local function pick_light_position_mega(player, pos)
	local ret = {}

	if can_add_light(pos) then
		table.insert(ret, pos)
	end
	pick_light_position_radius(player, pos, ret, 10)

	return ret
end

local function pick_light_position(player, pos, light_item)
	if light_item == "walking_light:megatorch" then
		return pick_light_position_mega(player, pos)
	end
	return pick_light_position_regular(player, pos)
end

-- adds light at the given position
local function add_light(player, pos)
	local player_name = player:get_player_name()
	local node  = mt_get_node_or_nil(pos)
	if node == nil then
		-- don't do anything for nil blocks... they are non-loaded blocks, so we don't want to overwrite anything there
--		print("DEBUG: walking_light.add_light(), node is nil, pos = " .. dumppos(pos))
		return false
	elseif node.name == "air" then
		-- when the node that is already there is air, add light
		mt_add_node(pos,{type="node",name="walking_light:light"})
		if not table_contains_pos(light_positions[player_name], pos) then
			table_insert_pos(light_positions[player_name], pos)
		end

--		if node then
--			print("DEBUG: add_light(), node.name = " .. node.name .. ", pos = " .. dumppos(pos))
--		else
--			print("DEBUG: add_light(), node.name = nil, pos = " .. dumppos(pos))
--		end
		return true
	elseif node.name == "walking_light:light" then
		-- no point in adding light where it is already, but we should assign it to the player so it gets removed (in case it has no player)
--		print("DEBUG: add_light(), not adding; node.name = " .. node.name .. ", pos = " .. dumppos(pos))

		if not table_contains_pos(light_positions[player_name], pos) then
			table_insert_pos(light_positions[player_name], pos)
		end

		return true
	end
--	print("DEBUG: add_light(), not adding; node.name = " .. node.name)
	return false
end

-- updates all the light around the player, depending on what they are wielding
local function update_light_player(player)
	-- if there is no player, there can be no update
	if not player then
		return
	end

	-- figure out if they wield light; this will be nil if not
	local wielded_item = get_wielded_light_item(player)

	local player_name = player:get_player_name()
	local pos = player:getpos()
	local rounded_pos = vector.round(pos)

	-- check for a nil node where the player is; if it is nil, we assume the block is not loaded, so we return without updating player_positions
	-- that way, it should add light next step
	local node  = mt_get_node_or_nil(rounded_pos)
	if node == nil then
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
		-- decide where light should be
		wantlightpos = pick_light_position(player, wantpos, wielded_item)
--		print("DEBUG: walking_light update_light_player(); wantpos = " .. dumppos(wantpos) .. ", wantlightpos = " .. dumppos(wantlightpos))
	end

	if wielded_item and wantlightpos then
		-- add light that isn't already there
		for i,newpos in ipairs(wantlightpos) do
			add_light(player, newpos)
		end
	end

	-- go through all light owned by the player to remove all but what should be kept
    for i,oldlightpos in ripairs(light_positions[player_name]) do
        if not wantlightpos or oldlightpos and oldlightpos.x and not table_contains_pos(wantlightpos, oldlightpos) then
			remove_light(player, oldlightpos)
        end
    end

	player_positions[player_name] = vector.round(pos)

--	print("DEBUG: walking_light.update_light_player(): wantlightpos = " .. dumppostable(wantlightpos) .. ", light_positions = " .. dumppostable(light_positions[player_name]))
end

local function update_light_all()
	-- go through all players to check
	for i,player_name in ipairs(players) do
		local player = minetest.env:get_player_by_name(player_name)
		update_light_player(player)
	end
end

-- return true if item is a light item
function is_light_item(item)
	if item == "default:torch" or item == "walking_light:pick_mese" 
			or item == "walking_light:helmet_diamond"
			or item == "walking_light:megatorch" then
		return true
	end
	return false
end

-- returns a string, the name of the item found that is a light item
function get_wielded_light_item(player)
	local wielded_item = player:get_wielded_item():get_name()
	if is_light_item(wielded_item) then
		return wielded_item
	end

	-- check equipped armor - requires unified_inventory maybe
	local player_name = player:get_player_name()
	if player_name then
		local armor_inv = minetest.get_inventory({type="detached", name=player_name.."_armor"})
		if armor_inv then
--            print( dump(armor_inv:get_lists()) )
			local item_name = "walking_light:helmet_diamond"
			local stack = ItemStack(item_name)
			if armor_inv:contains_item("armor", stack) then
				return item_name
			end
		end
	end

	return nil
end

-- return true if player is wielding a light item
function wielded_light(player)
	return get_wielded_light_item(player) ~= nil
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	table.insert(players, player_name)
	last_wielded[player_name] = get_wielded_light_item(player)
	local pos = player:getpos()
	player_positions[player_name] = nil
	light_positions[player_name] = {}
	update_light_player(player)
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	for i,v in ipairs(players) do
		if v == player_name then
			table.remove(players, i)
		end
	end
	last_wielded[player_name] = false
	remove_light_player(player)
	player_positions[player_name]=nil
end)

minetest.register_globalstep(function(dtime)
	for i,player_name in ipairs(players) do
		local player = minetest.env:get_player_by_name(player_name)
		if player ~= nil then
			update_light_player(player)
		else
			table.remove(players, i)
		end
	end
end)

minetest.register_node("walking_light:clear", {
	drawtype = "glasslike",
	tile_images = {"walking_light.png"},
	-- tile_images = {"walking_light_debug.png"},
	--inventory_image = minetest.inventorycube("walking_light.png"),
	--paramtype = "light",
	walkable = false,
	--is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	--light_source = 13,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
})

minetest.register_node("walking_light:light", {
	drawtype = "glasslike",
	tile_images = {"walking_light.png"},
	-- tile_images = {"walking_light_debug.png"},
	inventory_image = minetest.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 13,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
})

minetest.register_tool("walking_light:pick_mese", {
	description = "Mese Pickaxe with light",
	inventory_image = "walking_light_mesepick.png",
	wield_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			crumbly={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			snappy={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3}
		}
	},
})

minetest.register_tool("walking_light:helmet_diamond", {
	description = "Diamond Helmet with light",
	inventory_image = "walking_light_inv_helmet_diamond.png",
	wield_image = "3d_armor_inv_helmet_diamond.png",
	groups = {armor_head=15, armor_heal=12, armor_use=100},
	wear = 0,
})

minetest.register_node("walking_light:megatorch", {
    description = "Megatorch",
    drawtype = "torchlike",
    tiles = {
        {
            name = "default_torch_on_floor_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 3.0
            },
        },
        {
            name="default_torch_on_ceiling_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 3.0
            },
        },
        {
            name="default_torch_animated.png",
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 3.0
            },
        },
    },
    inventory_image = "default_torch_on_floor.png",
    wield_image = "default_torch_on_floor.png",
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    is_ground_content = false,
    walkable = false,
    light_source = 13,
    selection_box = {
        type = "wallmounted",
        wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
        wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
        wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
    },
    groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1},
    legacy_wallmounted = true,
    --sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = 'walking_light:pick_mese',
	recipe = {
		{'default:torch'},
		{'default:pick_mese'},
	}
})

minetest.register_craft({
	output = 'walking_light:helmet_diamond',
	recipe = {
		{'default:torch'},
		{'3d_armor:helmet_diamond'},
	}
})

minetest.register_craft({
	output = 'walking_light:megatorch',
	recipe = {
		{'default:torch', 'default:torch', 'default:torch'},
		{'default:torch', 'default:torch', 'default:torch'},
		{'default:torch', 'default:torch', 'default:torch'},
	}
})

minetest.register_chatcommand("mapclearlight", {
	params = "<size>",
	description = "Remove walking_light:light from the area",
	func = function(name, param)
		if not minetest.check_player_privs(name, {server=true}) then
			return false, "You need the server privilege to use mapclearlight"
		end

		local pos = vector.round(minetest.get_player_by_name(name):getpos())
		local size = tonumber(param) or 40

		point = minetest.find_node_near(pos, size/2, "walking_light:light")
		while point do
			remove_light(nil, point)
			oldpoint = point
			point = minetest.find_node_near(pos, size/2, "walking_light:light")
			if poseq(oldpoint, point) then
				return false, "Failed... infinite loop detected"
			end
		end
		return true, "Done."
	end,
})

minetest.register_chatcommand("mapaddlight", {
	params = "<size>",
	description = "Add walking_light:light to a position, without a player owning it",
	func = function(name, param)
		if not minetest.check_player_privs(name, {server=true}) then
			return false, "You need the server privilege to use mapaddlight"
		end

		local pos = vector.round(minetest.get_player_by_name(name):getpos())
		pos = vector.new(pos.x, pos.y + 1, pos.z)

		if pos then
			mt_add_node(pos,{type="node",name="walking_light:light"})
		end

		return true, "Done."
	end,
})

