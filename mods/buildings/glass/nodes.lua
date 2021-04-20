--[[ LICENSE HEADER

  GNU Lesser General Public License version 2.1+

  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors

  See: docs/license-LGPL-2.1.txt
]]


--- Glass nodes.
--
-- @module nodes


local S = core.get_translator()


local enable_colors = core.global_exists('unifieddyes') or core.get_modpath('unifieddyes')


--- Extracts glass type from string.
--
-- @function get_glass_type
-- @local
-- @param g string to be parsed
-- @return string representing glass type or `nil`
local function get_glass_type(g)
	local glass_type = nil
	local idx = g:find(':')
	if idx then
		glass_type = g:sub(idx+1)
	end

	idx = glass_type:find('_glass')
	if idx then
		glass_type = glass_type:sub(1, idx-1)
	end

	if glass_type == 'glass' then
		glass_type = 'plain'
	end

	return glass_type
end


if enable_colors then
	local to_color = {
		'default:glass',
		'default:obsidian_glass',
	}

	for _, old_glass in ipairs(to_color) do
		local glass_type = get_glass_type(old_glass)
		if not glass_type then goto continue end
		local new_glass = 'glass:' .. glass_type

		local glass_def = {}
		for k, v in pairs(core.registered_nodes[old_glass]) do
			glass_def[k] = v
		end

		glass_def.paramtype2 = 'color'
		glass_def.palette = 'unifieddyes_palette_extended.png'
		glass_def.groups['ud_param2_colorable'] = 1
		glass_def.on_dig = unifieddyes.on_dig

		-- register new node
		core.register_node(new_glass, glass_def)

		-- unregister old node
		core.unregister_item(old_glass)
		core.registered_nodes[old_glass] = nil
		core.registered_aliases[old_glass] = nil
		core.register_alias(old_glass, new_glass)

		::continue::
	end

	-- misc. aliases
	if core.registered_nodes['glass:plain'] then
		core.register_alias('glass', 'glass:plain')
		core.register_alias('glass:glass', 'glass:plain')
	end

	if core.registered_nodes['glass:obsidian'] then
		core.register_alias('obsidian_glass', 'glass:obsidian')
	end
end
