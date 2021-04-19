-- NOTE: `require` is not allowed with mod security on
-- `dofile` with a return on the module is used instead
generate_formspec_string = dofile(minetest.get_modpath("more_chests").."/utils/formspec.lua")
local actions = dofile(minetest.get_modpath("more_chests").."/utils/actions.lua")
local S = minetest.get_translator("more_chests")

local function parse_action(value, default_getter)
	if value == false then -- model disabled this attribute
		return nil
	elseif value == nil then -- model wants the default attribute
		return default_getter()
	else -- model provided its own attribute
		return value
	end
end

function generate_chest_def(def)
	-- TODO assert def.size in ("big", "small")
	local out = {
		description = def.description,
		tiles = {
			def.tiles.top or def.tiles.side,
			def.tiles.top or def.tiles.side,
			def.tiles.side,
			def.tiles.side,
			def.tiles.side,
			def.tiles.front
		},
		paramtype2 = "facedir",
		legacy_facedir_simple = true,
		groups = {
			snappy=2,
			choppy=2,
			oddly_breakable_by_hand=2
		},
		sounds = def.sounds or default.node_sound_wood_defaults(),
		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")
			meta:set_string("infotext", S("@1 (owned by @2)", def.description, meta:get_string("owner")))
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local formspec_str = def.formspec or generate_formspec_string(def.size, def.inventory_name or nil)
			meta:set_string("formspec", formspec_str)
			meta:set_string("infotext", def.description)
			meta:set_string("owner", "")
			if def.inventory_name == nil or def.inventory_name == "main" then
				local inv = meta:get_inventory()
				local chest_size = def.size == "big" and 14*5 or 8*4
				inv:set_size("main", chest_size)
			end
		end,
		can_dig = function(pos,player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:is_empty("main")
		end,
	}
	-- register log actions, NOTE passing an anonymous function to avoid getting the default if not necessary
	out.allow_metadata_inventory_move = parse_action(def.allow_metadata_inventory_move, function() actions.get_allow_metadata_inventory_move{def.type} end)
	out.allow_metadata_inventory_put = parse_action(def.allow_metadata_inventory_put, function() actions.get_allow_metadata_inventory_put{def.type} end)
	out.allow_metadata_inventory_take = parse_action(def.allow_metadata_inventory_take, function() actions.get_allow_metadata_inventory_take{def.type} end)
	out.on_metadata_inventory_move = parse_action(def.on_metadata_inventory_move, function() actions.get_on_metadata_inventory_move(def.type) end)
	out.on_metadata_inventory_put = parse_action(def.on_metadata_inventory_put, function() actions.get_on_metadata_inventory_put(def.type) end)
	out.on_metadata_inventory_take = parse_action(def.on_metadata_inventory_take, function() actions.get_on_metadata_inventory_take(def.type) end)
	-- if model is not a simple block handle node_box attribute
	if def.node_box then
		out.drawtype = "nodebox"
		out.node_box = {
			type = "fixed",
			fixed = def.node_box,
		}
	end
	-- add pipeworks compatibility, TODO needs proper testing
	if def.pipeworks_enabled == true then
		out.groups.tubedevice = 1
		out.groups.tubedevice_receiver = 1
		out.tube = {
			insert_object = function(pos, node, stack, direction)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				return inv:add_item("main", stack)
			end,
			can_insert = function(pos, node, stack, direction)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				return inv:room_for_item("main", stack)
			end,
			input_inventory = "main",
			connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
		}
	end
	return out
end


return generate_chest_def
