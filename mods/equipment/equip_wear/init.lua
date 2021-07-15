
local tool_wear = core.settings:get_bool("tool_wear", true)
local weapon_wear = core.settings:get_bool("weapon_wear", true)
local armor_wear = core.settings:get_bool("armor_wear", true)

core.register_on_mods_loaded(function()
	-- hook into ItemStack meta table method
	if not weapon_wear then
		local mt = getmetatable(ItemStack(""))
		local add_wear_old = mt.add_wear
		mt.add_wear = function(self, ...)
			local r_item = core.registered_items[self:get_name()]
			if r_item and r_item.subtype == "weapon" then
				return true
			end

			return add_wear_old(self, ...)
		end
	end

	-- hook into 3d_armor API
	--[[ doesn't seem to be necessary if "armor_use" set to "0" or "nil"
	if not armor_wear and core.global_exists("armor") then
		local armor_damage_old, armor_punch_old = armor.damage, armor.punch

		armor.damage = function(self, player, index, stack, use)
			return armor_damage_old(self, player, index, stack, 0)
		end

		armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
			return armor_punch_old(self, player, hitter, time_from_last_punch, tool_capabilities)
		end
	end
	]]

	-- override items
	for tname, tdef in pairs(core.registered_tools) do
		local new_def = table.copy(tdef)
		local override = false

		if new_def.tool_capabilities then
			if new_def.tool_capabilities.punch_attack_uses then
				new_def.subtype = "weapon"
				override = true
			end

			if not weapon_wear then
				new_def.tool_capabilities.punch_attack_uses = nil
				override = true
			end

			if new_def.tool_capabilities.groupcaps then
				for k, v in pairs(new_def.tool_capabilities.groupcaps) do
					-- FIXME: should "fleshy" only be modified for weapon wear?
					if not tool_wear then
						new_def.tool_capabilities.groupcaps[k].uses = 0
						override = true
					end
				end
			end

			--[[ NOTE: anything useful here?
			for t, tc in pairs(new_def.tool_capabilities) do
			end
			]]

			--[[ NOTE: should we check for "fleshy" here to set "weapon" sub-type?
			if new_def.tool_capabilities.damage_groups then
			end
			]]
		end

		if new_def.groups then
			if new_def.groups.armor_use then
				new_def.subtype = "armor"
				override = true

				if not armor_wear then
					new_def.groups.armor_use = 0
				end
			end
		end

		if override then
			core.unregister_item(tname)
			core.register_tool(":" .. tname, new_def)
		end
	end
end)
