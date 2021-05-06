-- Items for shark mod


local S = core.get_translator("shark")


local mobs = core.global_exists("mobs")

core.register_craftitem(":shark:meat_raw", {
	description = S("Raw Shark Meat"),
	inventory_image = "shark_meat_raw.png",
	on_use = core.item_eat(4),
})
if not mobs then
	core.register_alias("mobs:shark_meat_raw", "shark:meat_raw")
	core.register_alias("mobs:shark_meat", "shark:meat_raw")
end

core.register_craftitem(":shark:meat_cooked", {
	description = S("Cooked Shark Meat"),
	inventory_image = "shark_meat_cooked.png",
	on_use = core.item_eat(9),
})
if not mobs then
	core.register_alias("mobs:shark_meat_cooked", "shark:meat_cooked")
end

core.register_craftitem(":shark:tooth", {
	description = S("Shark Tooth"),
	inventory_image = "shark_tooth.png",
})
if not mobs then
	core.register_alias("mobs:shark_tooth", "shark:tooth")
end

core.register_craftitem(":shark:skin", {
	description = S("Shark Skin"),
	inventory_image = "shark_skin.png",
})
if not mobs then
	core.register_alias("mobs:shark_skin", "shark:skin")
end


core.register_craft({
	type = "cooking",
	output = "shark:meat_cooked",
	recipe = "shark:meat_raw",
	cooktime = 5,
})
