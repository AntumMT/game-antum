
local lighted_helmets = core.get_modpath("lighted_helmets") ~= nil

if core.global_exists("wielded_light") then
	local mese_pick = core.registered_items["default:pick_mese"]
	if mese_pick then
		mese_pick = table.copy(mese_pick)

		mese_pick.description = mese_pick.description .. " with light"
		if lighted_helmets then
			mese_pick.inventory_image = "lighted_helmets_inv_underlay.png^" .. mese_pick.inventory_image
		end
		mese_pick.wield_image = "default_tool_mesepick.png"

		local light_name = "wlight:pick_mese"
		core.register_craftitem(":" .. light_name, mese_pick)
		wielded_light.register_item_light(light_name, 10)

		-- backward compat
		local legacy_name = "walking_light:pick_mese"
		core.register_alias(legacy_name, light_name)

		core.register_craft({
			output = light_name,
			recipe = {
				{"default:torch"},
				{"default:pick_mese"},
			}
		})
	end

	-- update helmets with lighted_helmets
	if lighted_helmets then
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
				"ancient",
			},
			["rainbow_ore"] = {
				"rainbow",
			},
		}

		for modname, materials in pairs(helmets) do
			for _, material in ipairs(materials) do
					local old_name = "wlight:helmet_"
					if modname == "amber" and material == "ancient" then
						old_name = old_name .. "amber_ancient"
					else
						old_name = old_name .. material
					end

					local new_name = "lighted_helmets:"
					if modname == "amber" and material == "ancient" then
						new_name = new_name .. "amber_ancient"
					else
						new_name = new_name .. material
					end

					-- backward compat
					core.register_alias(old_name, new_name)
					local legacy_name = old_name:gsub("^wlight%:", "walking_light:")
					core.register_alias(legacy_name, new_name)
			end
		end
	end
end
