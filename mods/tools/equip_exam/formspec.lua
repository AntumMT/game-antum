
local S = core.get_translator(equip_exam.name)

local general_types = {
	["uses"] = "durability",
}

local tool_node_types = {
	["cracky"] = "mine level",
	["choppy"] = "chop level",
	["crumbly"] = "dig level",
	["snappy"] = "snap level",
	["explody"] = "explosive level",
}

local tool_types = {
	["disable_repair"] = "repair disabled",
	["max_drop_level"] = "node drop level",
}
for k, v in pairs(tool_node_types) do
	tool_types[k] = v
end

local node_types = {
	["attached_node"] = "attached",
	["dig_immediate"] = "dig immediate",
	["fall_damage_add_percent"] = "added fall damage",
	["oddly_breakable_by_hand"] = "hand breakable",
	["bouncy"] = true,
	["ud_param2_colorable"] = "colorable",
	["connect_to_raillike"] = "rail-like",
	["disable_jump"] = "jump disabled",
	["falling_node"] = "fall",
	["float"] = "liquid boyancy",
	["level"] = true,
	["slippery"] = true,
}
for k, v in pairs(tool_node_types) do
	node_types[k] = v
end

local weapon_types = {
	["fleshy"] = "attack",
	["punch_attack_uses"] = "durability",
}

local armor_types = {
	["fleshy"] = "defense",
	["armor_head"] = "head def.",
	["armor_torso"] = "torso def.",
	["armor_legs"] = "legs def.",
	["armor_feet"] = "feet def.",
	["armor_shield"] = "shield def.",
	["armor_use"] = "durability",
	["armor_heal"] = "healing",
	["armor_radiation"] = "radiation",
}

local entity_types = {
	["punch_operable"] = true,
}

local other_types = {
	["flammable"] = true,
	["full_punch_interval"] = "speed interval",
	["immortal"] = true,
	["meat"] = true,
	["eatable"] = true,
	["wool"] = true,
	["metal"] = true,
	["weapon"] = true,
	["heavy"] = true,
}

-- excluded from automatic parsing
local excluded_types = {
	"punch_attack_uses",
	"armor_use",
}

local function is_excluded(spec)
	for _, ex in ipairs(excluded_types) do
		if spec == ex then return true end
	end

	return false
end

local function format_spec(grp, name, value, technical)
	if technical or not grp[name] then return name .. ": " .. value end

	local nname = grp[name]
	if nname == true then
		nname = name:gsub("_", " ")
	end

	return S(nname .. ": @1", value)
end

local function get_durability(value)
	if not value or value == 0 then return "∞" end

	return value
end

local function get_item_specs(item, technical)
	if not item then return nil end

	local specs = {}
	local name = item.short_description
	if not name then name = item.description end
	local id = item.name

	-- remove multi-lines
	if name:find("\n") then name = name:split("\n")[1]:trim() end
	name = core.formspec_escape(name)

	local groups = item.groups or {}
	local tool_capabilities = item.tool_capabilities or {}
	tool_capabilities.damage_groups = tool_capabilities.damage_groups or {}
	tool_capabilities.groupcaps = tool_capabilities.groupcaps or {}
	local armor_groups = item.armor_groups or {}

	local specs_tool = {}
	local specs_weapon = {}
	local specs_armor = {}
	local specs_node = {}
	local specs_entity = {}
	local specs_other = {}

	local item_types = {}
	item_types.tool = groups.tool ~= nil and groups.tool > 0
	item_types.node = core.registered_nodes[item.name] ~= nil
	item_types.entity = core.registered_entities[item.name] ~= nil

	for k, v in pairs(tool_capabilities) do
		if not is_excluded(k) then
			if type(v) ~= "table" then
				if tool_types[k] then
					table.insert(specs_tool, format_spec(tool_types, k, v, technical))
					item_types.tool = true
				elseif weapon_types[k] then
					table.insert(specs_weapon, format_spec(weapon_types, k, v, technical))
					item_types.weapon = true
				elseif armor_types[k] then
					table.insert(specs_armor, format_spec(armor_types, k, v, technical))
					item_types.armor = true
				else
					table.insert(specs_other, format_spec(other_types, k, v, technical))
				end
			end
		end
	end

	for k, v in pairs(tool_capabilities.groupcaps) do
		if type(v) ~= "table" then
			table.insert(specs_other, k .. ": " .. v)
		else
			if v.maxlevel then
				if tool_types[k] then
					table.insert(specs_tool, format_spec(tool_types, k, v.maxlevel, technical))
					table.insert(specs_tool, format_spec(general_types, "uses", get_durability(v.uses), technical))
					item_types.tool = true
				else
					table.insert(specs_other, format_spec(other_types, k, v.maxlevel, technical))
					table.insert(specs_other, format_spec(general_types, "uses", get_durability(v.uses), technical))
				end
			end
		end
	end

	for k, v in pairs(tool_capabilities.damage_groups) do
		if weapon_types[k] then
			table.insert(specs_weapon, format_spec(weapon_types, k, v, technical))
			item_types.weapon = true
		else
			table.insert(specs_other, format_spec(other_types, k, v, technical))
		end
	end

	for k, v in pairs(armor_groups) do
		if not is_excluded(k) then
			if armor_types[k] then
				if v ~= 0 then
					table.insert(specs_armor, format_spec(armor_types, k, v, technical))
					item_types.armor = true
				end
			else
				table.insert(specs_other, format_spec(other_types, k, v, technical))
			end
		end
	end

	local type_group = tool_types
	local spec_group = specs_tool
	if item_types.node then
		type_group = node_types
		spec_group = specs_node
	end

	for k, v in pairs(groups) do
		if not is_excluded(k) then
			if type_group[k] then
				table.insert(spec_group, format_spec(type_group, k, v, technical))
				if not item_types.node then
					item_types.tool = true
				end
			elseif weapon_types[k] then
				table.insert(specs_weapon, format_spec(weapon_types, k, v, technical))
				item_types.weapon = true
			elseif armor_types[k] then
				if v ~= 0 then
					table.insert(specs_armor, format_spec(armor_types, k, v, technical))
					item_types.armor = true
				end
			elseif entity_types[k] then
				table.insert(specs_entity, format_spec(entity_types, k, v, technical))
				item_types.entity = true
			else
				table.insert(specs_other, format_spec(other_types, k, v, technical))
			end
		end
	end

	if item_types.weapon then
		table.insert(specs_weapon, format_spec(weapon_types, "punch_attack_uses",
			get_durability(tool_capabilities.punch_attack_uses), technical))
	end

	if item_types.armor then
		local armor_use = groups.armor_use or armor_groups.armor_use
		table.insert(specs_armor, format_spec(armor_types, "armor_use",
			get_durability(armor_use), technical))
	end

	local imeta = ItemStack(item):get_meta()
	local color = imeta:get_string("color")
	if color ~= "" then
		-- FIXME:
		table.insert(specs_other, S("color: @1", color))
	end

	--[[
	if item.color then
		table.insert(specs_other, S("color: @1", item.color))
	end
	]]

	if name then
		table.insert(specs, S("Name: @1", name))
	end
	table.insert(specs, S("ID: @1", id))

	local it = {}
	for k, v in pairs(item_types) do
		if v then table.insert(it, k) end
	end

	if #it > 0 then
		table.insert(specs, S("Type: @1", core.formspec_escape(table.concat(it, ", "))))
	end

	if #specs_tool > 0 then
		table.insert(specs, S("Tool:"))
		for _, sp in ipairs(specs_tool) do
			table.insert(specs, "  " .. sp)
		end
	end
	if #specs_weapon > 0 then
		table.insert(specs, S("Weapon:"))
		for _, sp in ipairs(specs_weapon) do
			table.insert(specs, "  " .. sp)
		end
	end
	if #specs_armor > 0 then
		table.insert(specs, S("Armor:"))
		for _, sp in ipairs(specs_armor) do
			table.insert(specs, "  " .. sp)
		end
	end
	if #specs_node > 0 then
		table.insert(specs, S("Node:"))
		for _, sp in ipairs(specs_node) do
			table.insert(specs, " " .. sp)
		end
	end
	if #specs_other > 0 then
		table.insert(specs, S("Other:"))
		for _, sp in ipairs(specs_other) do
			table.insert(specs, "  " .. sp)
		end
	end

	if not specs then return end

	return table.concat(specs, ",")
end


--- Retrieves formspec string.
--
--  @function equip_exam:get_formspec
--  @param item The item name string.
--  @param empty If *true*, no stats information will be printed.
function equip_exam:get_formspec(item, empty, nmeta)
	local specs
	local show_technical = nmeta:get_string("show_technical") == "true"
	if not empty then
		specs = get_item_specs(core.registered_items[item], show_technical)
	else
		specs = "" -- empty
	end

	if not specs then
		specs = S("Specs unavailable")
	end

	local formspec = "formspec_version[4]"
		.. "size[13,9]"
		.. "list[context;input;1,1;1,1;0]"
		.. "checkbox[0.25,2.55;techname;" .. S("Technical Names"):gsub(" ", "\n") .. ";"
			.. tostring(show_technical) .. "]"
		.. "button_exit[0.25,3.1;2.5,0.8;close;" .. S("Close") .. "]"
		.. "label[3,0.7;" .. S("Specs:") .. "]"
		.. "textlist[3.5,1;8,3;speclist;" .. specs .. ";1;false]"
		.. "list[current_player;main;1.65,4.1;8,4;0]"

	return formspec
end
