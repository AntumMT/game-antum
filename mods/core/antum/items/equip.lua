
if core.global_exists("wlight") then
	local mese_pick = core.registered_items["default:pick_mese"]
	if mese_pick then
		mese_pick = table.copy(mese_pick)

		mese_pick.description = mese_pick.description .. " with light"
		mese_pick.inventory_image = "wlight_inv_underlay.png^" .. mese_pick.inventory_image
		mese_pick.wield_image = "default_tool_mesepick.png"

		local light_name = "wlight:pick_mese"
		core.register_craftitem(":" .. light_name, mese_pick)
		wlight.register_item(light_name)

		-- backward compat
		local legacy_name = "walking_light:pick_mese"
		core.register_alias(legacy_name, light_name)
		wlight.register_item(legacy_name)

		core.register_craft({
			output = light_name,
			recipe = {
				{"default:torch"},
				{"default:pick_mese"},
			}
		})
	end

	if core.global_exists("armor") then
		local helmets = {
			["3d_armor"] = {
				"bronze",
				"cactus",
				"crystal",
				"diamond",
				"gold",
				"mithril",
				"steel",
				"wood",
			},
			["technic_armor"] = {
				"brass",
				"carbon",
				"cast",
				"lead",
				"silver",
				"stainless",
				"tin",
			},
			["xtraarmor"] = {
				"chainmail",
				"copper",
				"leather",
				"leather_black",
				"leather_blue",
				"leather_brown",
				"leather_cyan",
				"leather_dark_green",
				"leather_dark_grey",
				"leather_green",
				"leather_grey",
				"leather_magenta",
				"leather_orange",
				"leather_pink",
				"leather_red",
				"leather_violet",
				"leather_white",
				"leather_yellow",
				"mese",
				"studded",
			},
			["amber"] = {
				"amber",
				{"ancient", 10},
			},
			["rainbow_ore"] = {
				{"rainbow", 10},
			},
		}

		for modname, materials in pairs(helmets) do
			for _, material in ipairs(materials) do
				local radius
				if type(material) == "table" then
					radius = material[2]
					material = material[1]
				end

				local orig_name
				if modname == "amber" and material == "amber" then
					orig_name = modname .. ":helmet"
				elseif modname == "rainbow_ore" then
					orig_name = modname .. ":" .. "rainbow_ore_helmet"
				else
					orig_name = modname .. ":helmet_" .. material
				end

				local old_def = core.registered_items[orig_name]
				if old_def then
					local def = table.copy(old_def)

					def.description = def.description .. " with light"
					def.inventory_image = "wlight_inv_underlay.png^" .. def.inventory_image
					if not def.wield_image then
						def.wield_image = old_def.inventory_image
					end
					if not def.preview then
						if modname == "rainbow_ore" then
							def.preview = "rainbow_ore_rainbow_ore_helmet_preview.png"
						else
							def.preview = modname .. "_helmet_" .. material .. "_preview.png"
						end
					end

					local light_name = "wlight:helmet_"
					if modname == "amber" and material == "ancient" then
						light_name = light_name .. "amber_ancient"
					else
						light_name = light_name .. material
					end

					armor:register_armor(":" .. light_name, def)
					wlight.register_armor(light_name, radius)

					-- backward compat
					local legacy_name = light_name:gsub("^wlight%:", "walking_light:")
					core.register_alias(legacy_name, light_name)
					wlight.register_armor(legacy_name, radius)

					core.register_craft({
						output = light_name,
						recipe = {
							{"default:torch"},
							{orig_name},
						},
					})
				else
					antum.log("warning", "\"" .. orig_name .. "\" not registered, not adding light item")
				end
			end
		end
	end
end
