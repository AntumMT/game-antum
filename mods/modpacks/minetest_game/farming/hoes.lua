
local t_uses = {}
local tool_wear = minetest.settings:get_bool("enable_tool_wear")
if tool_wear == nil then
	-- Default is enabled
	tool_wear = true
end

if tool_wear then
	t_uses.wood = 30
	t_uses.stone = 90
	t_uses.steel = 200
	t_uses.bronze = 220
	t_uses.mese = 350
	t_uses.diamond = 500
else
	t_uses.wood = 0
	t_uses.stone = 0
	t_uses.steel = 0
	t_uses.bronze = 0
	t_uses.mese = 0
	t_uses.diamond = 0
end


farming.register_hoe(":farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	max_uses = t_uses.wood,
	material = "group:wood",
	groups = {flammable = 2},
})

farming.register_hoe(":farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	max_uses = t_uses.stone,
	material = "group:stone"
})

farming.register_hoe(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	max_uses = t_uses.steel,
	material = "default:steel_ingot"
})

farming.register_hoe(":farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	max_uses = t_uses.bronze,
	material = "default:bronze_ingot"
})

farming.register_hoe(":farming:hoe_mese", {
	description = "Mese Hoe",
	inventory_image = "farming_tool_mesehoe.png",
	max_uses = t_uses.mese,
	material = "default:mese_crystal"
})

farming.register_hoe(":farming:hoe_diamond", {
	description = "Diamond Hoe",
	inventory_image = "farming_tool_diamondhoe.png",
	max_uses = t_uses.diamond,
	material = "default:diamond"
})
