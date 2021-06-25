
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
			"diamond",
			"gold",
		}

		for _, material in ipairs(helmets) do
			local def = core.registered_items["3d_armor:helmet_" .. material]
			if def then
				def = table.copy(def)

				def.description = def.description .. " with light"
				def.inventory_image = "walking_light_underlay.png^3d_armor_inv_helmet_" .. material .. ".png"
				def.wield_image = "3d_armor_inv_helmet_" .. material .. ".png"
				def.preview = "3d_armor_helmet_" .. material .. "_preview.png"

				local light_name = "walking_light:helmet_" .. material
				armor:register_armor(":" .. light_name, def)
				walking_light.register_armor(light_name)

				core.register_craft({
					output = light_name,
					recipe = {
						{"default:torch"},
						{"3d_armor:helmet_" .. material},
					},
				})
			end
		end
	end
end
