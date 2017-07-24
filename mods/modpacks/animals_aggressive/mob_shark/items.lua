-- Items for mob_shark mod


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists('intllib') then
	dofile(core.get_modpath('intllib') .. '/intllib.lua')
	if intllib.make_gettext_pair then
		-- New method using gettext.
		S = intllib.make_gettext_pair(core.get_current_modname())
	else
		-- Old method using text files.
		S = intllib.Getter(core.get_current_modname())
	end
else
	S = function ( s ) return s end
end


core.register_craftitem(':mobs:shark_meat_raw', {
	description = S('Raw Shark Meat'),
	inventory_image = 'mobs_shark_meat_raw.png',
	on_use = core.item_eat(4),
})
core.register_alias('mobs:shark_meat', 'mobs:shark_meat_raw')

core.register_craftitem(':mobs:shark_meat_cooked', {
	description = S('Cooked Shark Meat'),
	inventory_image = 'mobs_shark_meat_cooked.png',
	on_use = core.item_eat(9),
})

core.register_craftitem(':mobs:shark_tooth', {
	description = S('Shark Tooth'),
	inventory_image = 'mobs_shark_tooth.png',
})

core.register_craftitem(':mobs:shark_skin', {
	description = S('Shark Skin'),
	inventory_image = 'mobs_shark_skin.png',
})


core.register_craft({
	type = 'cooking',
	output = 'mobs:shark_meat_cooked',
	recipe = 'mobs:shark_meat_raw',
	cooktime = 5,
})
