-- Registrations for slinghot mod


-- A metal slingshot
slingshot.register('slingshot', {
	description = 'Slingshot',
	damage_groups = {fleshy=4},
	velocity = 15,
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'', 'default:steel_ingot', ''},
	},
	aliases = {
		'slingshot',
	},
})


-- A weaker slingshot
slingshot.register('wood', {
	description = 'Wooden slingshot',
	damage_groups = {fleshy=2},
	velocity = 10,
	recipe = {
		{'default:stick', '', 'default:stick'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	},
	aliases = {
		'wood_slingshot',
	}
})
