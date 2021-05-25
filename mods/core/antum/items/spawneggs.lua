
if core.global_exists("asm") then
	local kitty_image = "spawneggs_cat.png"
	if core.registered_entities["mobs:kitten"] then
		kitty_image = "mobs_kitten_inv.png"
	end

	if core.registered_entities["mobs:kitten"] then
		asm.addEgg({
			name = "kitten",
			title = "Kitten",
			inventory_image = kitty_image,
			spawn = "mobs:kitten",
		})
		core.register_alias("mobs:kitten", "spawneggs:kitten")
		core.register_alias("spawneggs:cat", "spawneggs:kitten")

		if core.registered_items["farming:string"] then
			asm.addEggRecipe("kitten", "farming:string")
		end
	end

	if core.registered_entities["creatures:shark"] then
		if core.registered_items["spawneggs:shark"] and core.registered_items["shark:tooth"] then
			asm.addEggRecipe("shark", "shark:tooth")
		end
	end

	if core.registered_entities["mobs:cow"] and core.registered_items["mobs:bucket_milk"] then
		asm.addEgg({
			name = "cow",
			inventory_image = "mobs_cow_inv.png",
			spawn = "mobs:cow",
			ingredients = "mobs:bucket_milk",
		})
	end
end
