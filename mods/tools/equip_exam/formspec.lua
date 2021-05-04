
local S = core.get_translator(equip_exam.name)


local function get_item_specs(item)
	if not item then return nil end

	local specs = nil
	local name = item.short_description
	if not name then name = item.description end
	local id = item.name

	if not name then
		specs = S("ID: @1", id)
	else
		specs = S("Name: @1", name) .. "," .. S("ID: @1", id)
	end

	local tool_capabilities = item.tool_capabilities
	local armor_groups = item.armor_groups

	-- is a tool
	if tool_capabilities then
		if tool_capabilities.damage_groups and tool_capabilities.damage_groups.fleshy then
			specs = specs .. "," .. S("Attack: @1", tool_capabilities.damage_groups.fleshy)
		end

		if tool_capabilities.groupcaps then
			local cracky = tool_capabilities.groupcaps.cracky -- mining/pick axe
			local choppy = tool_capabilities.groupcaps.choppy -- cutting/axe
			local crumbly = tool_capabilities.groupcaps.crumbly -- digging/shovel
			local snappy = tool_capabilities.groupcaps.snappy -- ???/sword

			if cracky and cracky.maxlevel then
				specs = specs .. "," .. S("Mine level: @1", cracky.maxlevel)
			end
			if choppy and choppy.maxlevel then
				specs = specs .. "," .. S("Chop level: @1", choppy.maxlevel)
			end
			if crumbly and crumbly.maxlevel then
				specs = specs .. "," .. S("Dig level: @1", crumbly.maxlevel)
			end
			if snappy and snappy.maxlevel then
				specs = specs .. "," .. S("Snap level: @1", snappy.maxlevel)
			end
		end

	-- is armor
	elseif armor_groups and armor_groups.fleshy then
		specs = specs .. "," .. S("Defense: @1", armor_groups.fleshy)
	end

	return specs
end


--- Retrieves formspec string.
--
--  @function equip_exam:get_formspec
--  @param item The item name string.
--  @param empty If *true*, no stats information will be printed.
function equip_exam:get_formspec(item, empty)
	local specs
	if not empty then
		specs = get_item_specs(core.registered_items[item])
	else
		specs = "" -- empty
	end

	if not specs then
		specs = S("Specs unavailable")
	end

	local formspec = "formspec_version[4]"
		.. "size[12,9]"
		.. "list[context;input;1,1;1,1;0]"
		.. "button_exit[0.25,3.1;2.5,0.8;close;" .. S("Close") .. "]"
		.. "label[3,0.7;" .. S("Specs:") .. "]"
		.. "textlist[3,1;8,3;speclist;" .. specs .. ";1;false]"
		.. "list[current_player;main;1.15,4.1;8,4;0]"

	return formspec
end


--- Displays the formspec to a player.
--
--  @function equip_exam:show_formspec
--  @param pos The coordinates where the node is located.
--  @param player Player object to whom formspec will be displayed.
function equip_exam:show_formspec(pos, player)
	local playername = player:get_player_name()
	if not playername or not player:is_player() then return end

	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	local contents = inv:get_list("input")[1]

	core.show_formspec(playername, equip_exam.name, equip_exam:get_formspec(contents:get_name(), inv:is_empty("input")))
end
