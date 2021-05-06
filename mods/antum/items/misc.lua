
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
