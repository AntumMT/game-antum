
if core.global_exists("walking_light") then
	local mese_pick = core.registered_items["default:pick_mese"]
	if mese_pick then
		mese_pick = table.copy(mese_pick)

		mese_pick.description = mese_pick.description .. " with light"
		mese_pick.inventory_image = "walking_light_underlay.png^" .. mese_pick.inventory_image
		mese_pick.wield_image = "default_tool_mesepick.png"

		local light_name = "walking_light:pick_mese"
		core.register_craftitem(":" .. light_name, mese_pick)
		walking_light.register_item(light_name)

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
			["rainbow_ore"] = {
				"rainbow",
			},
		}

		for modname, materials in pairs(helmets) do
			for _, material in ipairs(materials) do
				local orig_name
				local radius
				if modname == "rainbow_ore" then
					orig_name = modname .. ":" .. "rainbow_ore_helmet"
					radius = 10
				else
					orig_name = modname .. ":helmet_" .. material
				end

				local def = core.registered_items[orig_name]
				if def then
					def = table.copy(def)

					def.description = def.description .. " with light"
					def.inventory_image = "walking_light_underlay.png^" .. def.inventory_image
					if not def.wield_image then
						if modname == "rainbow_ore" then
							def.wield_image = "rainbow_ore_helmet_inv.png"
						else
							def.wield_image = modname .. "_inv_helmet_" .. material .. ".png"
						end
					end
					if not def.preview then
						if modname == "rainbow_ore" then
							def.preview = "rainbow_ore_rainbow_ore_helmet_preview.png"
						else
							def.preview = modname .. "_helmet_" .. material .. "_preview.png"
						end
					end

					local light_name = "walking_light:helmet_" .. material
					armor:register_armor(":" .. light_name, def)
					walking_light.register_armor(light_name, radius)

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
