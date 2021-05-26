

core.register_craftitem(":creatures:rotten_flesh", {
	description = "Rotten Flesh",
	inventory_image = "creatures_rotten_flesh.png",
	on_use = core.item_eat(1),
})
