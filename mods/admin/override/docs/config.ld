title = 'Overrides Mod for Minetest'
project = 'overrides'
format = 'markdown'
not_luadoc = true
--wrap = true
boilerplate = true

local function tagoutput(value)
	return '<i>' .. value .. '</i>'
end

new_type('setting', 'Settings')
new_type('chatcmd', 'Chat Commands', false, 'chatparam')
custom_tags = {
	{'default',
		format = tagoutput,
	},
	{'type2',
		title = 'Type',
		format = tagoutput,
	},
	{'dfield',
		title = 'Definition Fields',
	},
	{'chatparam',
		title = 'Parameters',
	},
	{'option',
		title = 'Options',
		--[[
		format = function(item, handler)
			print(type(handler))
			print(type(item))
			print(item)
			return '<b><i>' .. name .. '</i></b>'
		end,
		]]
	},
	{'settype',
		title = 'Type',
		format = function(item)
			return '<i>' .. item .. '</i>'
		end,
	}
}

alias('tchatparam', 'chatparam')

local function chatcmd_handler(item)
	local output = item.name
	for i, p in ipairs(item.tags.chatparam) do
		output = output .. ' ' .. p
	end
	
	return output
end

function custom_display_name_handler(item, default_handler)
	if item.type == 'chatcmd' then
		return chatcmd_handler(item)
	end
	--[[
	if not is_list(item) then
		print('Not list')
	else
		print('Is list')
	end
	]]
	
	return default_handler(item)
end

file = {'api.lua', 'logging.api',}
