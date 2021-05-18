
if core.global_exists("asm") then
	if core.registered_entities["mobs:kitten"] then
		asm.addEgg({
			name = "cat",
			inventory_image = "spawneggs_cat.png",
			spawn = "mobs:kitten",
		})

		if core.registered_items["farming:string"] then
			asm.addEggRecipe("cat", "farming:string")
		end
	end

	if core.registered_entities["creatures:shark"] then
		if core.registered_items["spawneggs:shark"] and core.registered_items["shark:tooth"] then
			asm.addEggRecipe("shark", "shark:tooth")
		end
	end
end
