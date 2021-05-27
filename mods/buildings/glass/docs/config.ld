title = 'Glass'
project = 'Glass Mod for Minetest mods'
format = 'discount'
not_luadoc = true

local function italic(value)
	return '<i>' .. value .. '</i>'
end

new_type('node', 'Nodes')
new_type('recipe', 'Craft Recipes')
custom_tags = {
	{'rtype',
		title = 'Recipe type',
	},
	{'output',
		title = 'Output',
	},
	{'input',
		title = 'Input',
	},
}
