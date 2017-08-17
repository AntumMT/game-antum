-- Registrations for slinghot mod


if core.global_exists('technic') then
	core.register_craftitem('slingshot:rubber_band', {
		description = 'Rubber band',
		inventory_image = 'slingshot_rubber_band.png',
	})
	
	core.register_craft({
		output = 'slingshot:rubber_band 20',
		type = 'shapeless',
		recipe = {'technic:rubber'},
	})
	
	core.register_craft({
		output = 'slingshot:rubber_band 2',
		recipe = {
			{'technic:raw_latex', 'technic:raw_latex', ''},
			{'technic:raw_latex', '', 'technic:raw_latex'},
			{'', 'technic:raw_latex', 'technic:raw_latex'},
		}
	})
end


-- A wooden slingshot
slingshot.register('wood', {
	description = 'Wooden slingshot',
	damage_groups = {fleshy=2},
	velocity = 10,
	wear_rate = 500,
	ingredient = 'group:stick',
	aliases = {
		slingshot.modname .. ':wooden',
		'wood_slingshot',
		'wooden_slingshot',
	}
})


-- A stronger iron slingshot
slingshot.register('iron', {
	description = 'Iron Slingshot',
	damage_groups = {fleshy=4},
	velocity = 15,
	wear_rate = 250,
	ingredient = 'default:steel_ingot',
	aliases = {
		slingshot.modname,
		slingshot.modname .. ':slingshot',
		'iron_slingshot',
	},
})
