-- Functions for trampoline mod


local default_bounce = 20


-- Log messages specific to trampoline mod
trampoline.log = function(message)
	minetest.log('action', '[' .. trampoline.modname .. '] ' .. message)
end


-- Define function to add a colored trampoline
trampoline.addColoredTrampNode = function(color, bounce)
	local bounce = default_bounce * bounce
	
	minetest.register_node('trampoline:' .. color, {
		description = color:gsub('^%l', string.upper) .. ' Trampoline',
		drawtype = 'nodebox',
		node_box = trampoline.box,
		selection_box = trampoline.box,
		paramtype = 'light',
		tiles = {
			'top.png',
			'bottom.png',
			'sides.png^sides_overlay_' .. color .. '.png'
		},
		groups = {dig_immediate=2, bouncy=bounce, fall_damage_add_percent=-70},
	})
	
	local aliases = {
		'trampoline:trampoline_' .. color,
		'trampoline:tramp_' .. color,
		'trampoline_' .. color,
		'tramp_' .. color,
		color .. '_trampoline',
		color .. '_tramp',
	}
	
	for I in pairs(aliases) do
		minetest.register_alias(aliases[I], 'trampoline:' .. color)
	end
end


-- Define function to add a colored trampoline craft recipe
trampoline.addColoredTrampCraft = function(color)
	minetest.register_craft({
		output = 'trampoline:' .. color,
		recipe = {
			{'technic:rubber', 'technic:rubber', 'technic:rubber'},
			{'coloredwood:wood_' .. color, 'coloredwood:wood_' .. color, 'coloredwood:wood_' .. color},
			{'default:stick', 'default:stick', 'default:stick'}
		}
	})
end
