
core.register_craftitem(":antum:bottled_water", {
	description = "A bottle of water",
	inventory_image = "antum_bottled_water.png",
})

if core.registered_items["bucket:bucket_water"] and core.registered_items["vessels:glass_bottle"] then
	antum.registerCraft({
		output = "antum:bottled_water",
		type = "shapeless",
		recipe = {"bucket:bucket_water", "vessels:glass_bottle",},
		replacements = {
			{"bucket:bucket_water", "bucket:bucket_empty"},
		},
	})
end


-- animalmaterials:contract
core.register_craftitem(":ritems:contract", {
	description = "Contract",
	image = "ritems_contract.png",
	stack_max=10,
})

if core.registered_items["animalmaterials:contract"] then
	core.unregister_item("animalmaterials:contract")
	core.register_alias("animalmaterials:contract", "ritems:contract")
end

if core.get_modpath("default") then
	minetest.register_craft({
		output = "ritems:contract",
		recipe = {
			{"default:paper"},
			{"default:paper"},
		}
	})
end

-- animalmaterials:scale_*
for _, color in pairs({"blue", "golden", "grey", "white"}) do
	core.register_craftitem(":ritems:scale_" .. color, {
		description = "Scale (" .. color .. ")",
		image = "ritems_scale_" .. color .. ".png",
		stack_max = 25
	})

	if core.registered_items["animalmaterials:scale_" .. color] then
		core.unregister_item("animalmaterials:scale_" .. color)
		core.register_alias("animalmaterials:scale_" .. color, "ritems:scale_" .. color)
	end
end
