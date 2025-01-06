local S = minetest.get_translator("crafting_bench")
local F = minetest.formspec_escape
local C = minetest.colorize

minetest.register_alias("castle:workbench", "crafting_bench:workbench")

local has_mcl = minetest.get_modpath("mcl_formspec")
local has_default = minetest.get_modpath("default")

local usage_help = S("The inventory on the left is for raw materials, the inventory on the right holds finished products. The crafting grid in the center defines what recipe this workbench will make use of; place raw materials into it in the crafting pattern corresponding to what you want to build.")

if ( minetest.get_modpath("hopper") and hopper ~= nil and hopper.add_container ~= nil ) or has_mcl then
	usage_help = usage_help .. "\n\n" .. S("This workbench is compatible with hoppers. Hoppers will insert into the raw material inventory and remove items from the finished goods inventory.")
end


local crafting_rate = tonumber(minetest.settings:get("crafting_bench_crafting_rate")) or 5

if not has_default and not has_mcl then
	error("The crafting bench mod needs either the default mod (minetest game) or mineclonia/mineclone2 to work")
end

local invsize_src = 2 * 4
local invsize_dst = 1 * 4

if has_mcl then
	invsize_src = 2 * 3
	invsize_dst = 1 * 3
end

local groups, mcl_hardness, mcl_blast_res, sounds
local steel_ingot, wood, tree

local formspec
if has_default then
	formspec = 'size[10,10;]' ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		'label[1,0;'..S('Source Material')..']' ..
		'list[context;src;1,1;2,4;]' ..
		'label[4,0;'..S('Recipe to Use')..']' ..
		'list[context;rec;4,1;3,3;]' ..
		'label[7.5,0;'..S('Craft Output')..']' ..
		'list[context;dst;8,1;1,4;]' ..
		'list[current_player;main;1,6;8,4;]' ..
		'listring[current_name;dst]'..
		'listring[current_player;main]'..
		'listring[current_name;src]'..
		'listring[current_player;main]'
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2}
	sounds = default.node_sound_wood_defaults()
elseif has_mcl then
	formspec ='formspec_version[4]'..
		'size[11.75,10.425]'..

		mcl_formspec.get_itemslot_bg_v4(1, 0.75, 2, 3)..
		mcl_formspec.get_itemslot_bg_v4(5, 0.75, 3, 3)..
		mcl_formspec.get_itemslot_bg_v4(10, 0.75, 1, 3)..
		'label[1,0.375;'..S('Source Material')..']' ..
		'list[context;src;1,0.75;2,4;]' ..
		'label[5,0.375;'..S('Recipe to Use')..']' ..
		'list[context;rec;5,0.75;3,3;]' ..
		'label[9.5,0.375;'..S('Craft Output')..']' ..
		'list[context;dst;10,0.75;1,4;]' ..

		'label[0.375,4.7;' .. F(C(mcl_formspec.label_color, S('Inventory'))) .. ']'..
		mcl_formspec.get_itemslot_bg_v4(0.375, 5.1, 9, 3)..
		'list[current_player;main;0.375,5.1;9,3;9]'..
		mcl_formspec.get_itemslot_bg_v4(0.375, 9.05, 9, 1)..
		'list[current_player;main;0.375,9.05;9,1;]'..

		'listring[current_name;dst]'..
		'listring[current_player;main]'..
		'listring[current_name;src]'..
		'listring[current_player;main]'
	groups = {axey=2, handy=1, flammable=-1, container = 4}
	sounds = mcl_sounds.node_sound_wood_defaults()
	mcl_hardness = 3
	mcl_blast_res = 3
end

minetest.register_node("crafting_bench:workbench",{
	description = S("Workbench"),
	_doc_items_longdesc = S("A workbench that does work for you. Set a crafting recipe and provide raw materials and items will magically craft themselves once every @1 seconds.", crafting_rate),
	_doc_items_usagehelp = usage_help,
	tiles = {
		"crafting_bench_workbench_top.png",
		"crafting_bench_workbench_bottom.png",
		"crafting_bench_workbench_side.png",
		"crafting_bench_workbench_side.png",
		"crafting_bench_workbench_back.png",
		"crafting_bench_workbench_front.png"
		},
	paramtype2 = "facedir",
	paramtype = "light",
	groups = groups,
	sounds = sounds,
	drawtype = "normal",
	_mcl_hardness = mcl_hardness,
	_mcl_blast_resistance = mcl_blast_res,
	on_construct = function ( pos )
		local meta = minetest.get_meta( pos )
		meta:set_string( 'formspec', formspec)
		meta:set_string( 'infotext', S('Workbench'))
		local inv = meta:get_inventory()
		inv:set_size( 'src', invsize_src )
		inv:set_size( 'rec', 3 * 3 )
		inv:set_size( 'dst', invsize_dst )
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("src") and inv:is_empty("rec") and inv:is_empty("dst")
	end,
	on_blast = function(pos) end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name().." put "..stack:to_string().." in workbench at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name().." takes "..stack:to_string().." from workbench at "..minetest.pos_to_string(pos))
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if not minetest.is_player(player) or minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end

		if to_list == "dst" then
			-- Only allow to take from the output
			return 0
		elseif to_list == "rec" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local stack = inv:get_stack(from_list, from_index)
			stack:set_count(1)
			inv:set_stack(to_list, to_index, stack)

			if from_list == "rec" then
				-- For convenience: emulate movement instead of duplication
				inv:set_stack(from_list, from_index, "")
			end
			return 0
		elseif from_list == "rec" then
			-- Remove recipe stack
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_stack(from_list, from_index, "")
			return 0
		end

		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if not minetest.is_player(player) or minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end

		if listname == "rec" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			stack:set_count(1)
			inv:set_stack("rec", index, stack)
			return 0
		elseif listname == "dst" then
			return 0
		end

		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if not minetest.is_player(player) or minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end

		if listname == "rec" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			inv:set_stack("rec", index, "")
			return 0
		end

		return stack:get_count()
	end,
})
local get_recipe = function ( inv )
	local output, needed, decremented_input
	needed = inv:get_list( 'rec' )

	output, decremented_input = minetest.get_craft_result( {
		method = 'normal',
		width = 3,
		items = needed
	})

	local totalneed = {}

	if output.item:is_empty() then
		output = nil
	else
		output = output.item
		for _, item in ipairs( needed ) do
			if item ~= nil and not item:is_empty() and not inv:contains_item( 'src', item ) then
				output = nil
				break
			end
			if item ~= nil and not item:is_empty() then
				if totalneed[item:get_name()] == nil then
					totalneed[item:get_name()] = 1
				else
					totalneed[item:get_name()] = totalneed[item:get_name()] + 1
				end
			end
		end
		for name, number in pairs( totalneed ) do
			local totallist = inv:get_list( 'src' )
			for i, srcitem in pairs( totallist ) do
				if srcitem:get_name() == name then
					local taken = srcitem:take_item( number )
					number = number - taken:get_count()
					totallist[i] = srcitem
				end
				if number <= 0 then
					break
				end
			end
			if number > 0 then
				output = nil
				break
			end
		end
	end

	return needed, decremented_input, output
end

minetest.register_abm( {
	nodenames = { 'crafting_bench:workbench' },
	interval = crafting_rate,
	chance = 1,
	action = function ( pos, node )
		local meta = minetest.get_meta( pos )
		local inv = meta:get_inventory()
		local output, decremented_input, needed
		if not inv:is_empty( 'src' ) then
			-- Check for a valid recipe and sufficient resources to craft it
			needed, decremented_input, output = get_recipe( inv )
			if output ~= nil and inv:room_for_item( 'dst', output) then
				inv:add_item( 'dst', output)
				for _, item in pairs( needed ) do
					if item ~= nil and item ~= '' then
						inv:remove_item( 'src', ItemStack( item ) )
					end
				end
				for i = 1, 9 do
					inv:add_item( 'dst', decremented_input.items[i] )
				end
			end
		end
	end
} )

-- Make sure that all stacks in the 'recipe' inv count 1 item.
-- Bigger stacks result in item duplication, see issue#14
minetest.register_lbm({
	name = "crafting_bench:cleanup_rec_inv",
	label = "remove multiple-item-stacks from recipe inv",
	nodenames = {"crafting_bench:workbench"},
	run_at_every_load = false,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		-- `get_list` may return `nil` when the node was placed without calling `on_construct`
		for i, item in ipairs(inv:get_list("rec") or {}) do
			-- Limit to stack size 1 (or keep empty)
			inv:set_stack("rec", i, item:peek_item())
			local leftover = inv:add_item("dst", item)
			if not leftover:is_empty() then
				minetest.log("action", "[crafting_bench] deleting leftover " ..
					item:to_string() .. " from recipe inv at " .. minetest.pos_to_string(pos))
			end
		end
	end
})

-- Crafting recipe compatibility.
if has_default then
	steel_ingot = "default:steel_ingot"
	wood = "default:wood"
	tree = "default:tree"
elseif has_mcl then
	steel_ingot = "mcl_core:iron_ingot"
	wood = "mcl_core:wood"
	tree = "mcl_core:tree"
end

minetest.register_craft({
	output = "crafting_bench:workbench",
	recipe = {
		{steel_ingot, steel_ingot, steel_ingot},
		{wood, wood, steel_ingot},
		{tree, tree, steel_ingot},
	}
})

-- Hopper compatibility
if minetest.get_modpath("hopper") and hopper ~= nil and hopper.add_container ~= nil then
	hopper:add_container({
		{"top", "crafting_bench:workbench", "dst"},
		{"side", "crafting_bench:workbench", "src"},
		{"bottom", "crafting_bench:workbench", "src"},
	})
end
