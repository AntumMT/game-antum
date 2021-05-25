--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


core.register_tool(":walking_light:helmet_gold", {
	description = "Gold Helmet with light",
	inventory_image = "walking_light_inv_helmet_gold.png",
	wield_image = "3d_armor_inv_helmet_gold.png",
	groups = {armor_head=10, armor_heal=6, armor_use=250},
	wear = 0,
})

--[[
walking_light.addLightItem("walking_light", {
	"helmet_gold",
	}
)
--]]
