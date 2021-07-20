
local excluded = {}

local to_exclude = core.settings:get("lighted_helmets.exclude")
if to_exclude then
	if to_exclude:find(",") then
		for _, tmp in ipairs(to_exclude:split(",")) do
			excluded[tmp:trim()] = true
		end
	else
		excluded[to_exclude:trim()] = true
	end
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
			{"ancient", 14},
		},
		["rainbow_ore"] = {
			{"rainbow", 12},
		},
	}

	for modname, materials in pairs(helmets) do
		if not excluded[modname] then
			for _, material in ipairs(materials) do
				local lvalue
				if type(material) == "table" then
					lvalue = material[2]
					material = material[1]
				end

				local orig_name
				if modname == "amber" and material == "amber" then
					orig_name = modname .. ":helmet"
				elseif modname == "rainbow_ore" then
					orig_name = modname .. ":rainbow_ore_helmet"
				else
					orig_name = modname .. ":helmet_" .. material
				end

				if not excluded[orig_name] then
					local orig_def = core.registered_items[orig_name]
					if orig_def then
						local def = table.copy(orig_def)

						def.description = def.description .. " with light"
						def.inventory_image = "lighted_helmets_inv_underlay.png^" .. orig_def.inventory_image
						if not def.texture then
							if modname == "rainbow_ore" then
								def.texture = "rainbow_ore_rainbow_ore_helmet.png"
							else
								def.texture = modname .. "_helmet_" .. material .. ".png"
							end
						end
						if not def.wield_image then
							def.wield_image = orig_def.inventory_image
						end
						if not def.preview then
							if modname == "rainbow_ore" then
								def.preview = "rainbow_ore_rainbow_ore_helmet_preview.png"
							else
								def.preview = modname .. "_helmet_" .. material .. "_preview.png"
							end
						end

						local helmet_name = "lighted_helmets:"
						if modname == "amber" and material == "ancient" then
							helmet_name = helmet_name .. "amber_ancient"
						else
							helmet_name = helmet_name .. material
						end

						armor:register_armor(":" .. helmet_name, def)
						armor_light.register(helmet_name, lvalue)

						if core.registered_items["default:mese_crystal"] and core.registered_items["default:torch"] then
							core.register_craft({
								output = helmet_name,
								recipe = {
									{"default:torch"},
									{"default:mese_crystal"},
									{orig_name},
								},
							})
						end
					end
				end
			end
		end
	end
end
