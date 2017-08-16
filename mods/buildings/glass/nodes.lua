--[[ LICENSE HEADER
  
  GNU Lesser General Public License version 2.1+
  
  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors
  
  See: docs/license-LGPL-2.1.txt
]]


--- Glass nodes.
--
-- @module nodes


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


local enable_colors = core.global_exists('unifieddyes') or core.get_modpath('unifieddyes')


local function dig_glass(pos, node, digger)
	local inv = digger:get_inventory()
	local can_dig = not core.is_protected(pos, digger:get_player_name())
	local drops = {}
	
	if digger:is_player() then
		local meta = core.get_meta(pos)
		
		if can_dig then
			if not inv:room_for_item('main', node.name) then
				table.insert(drops, node.name)
			else
				inv:add_item('main', node.name)
			end
			
			if meta then
				local dye = meta:get_string('dye')
				
				if dye and dye ~= '' then
					if not inv:room_for_item('main', dye) then
						table.insert(drops, dye)
					else
						inv:add_item('main', dye)
					end
				end
			end
		end
	end
	
	if can_dig then
		core.remove_node(pos)
		core.handle_node_drops(pos, drops, digger)
	end
end


local glass_def = {
	description = S('Glass'),
	drawtype = 'glasslike_framed_optional',
	tiles = {'glass_plain.png', 'glass_plain_detail.png'},
	paramtype = 'light',
	paramtype2 = 'glasslikeliquidlevel',
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = glass.node_sounds(),
}

if enable_colors then
	glass_def.paramtype2 = 'color'
	glass_def.palette = 'unifieddyes_palette.png'
	glass_def.groups['ud_param2_colorable'] = 1
	glass_def.on_dig = dig_glass
end


--- Plain glass.
--
-- @node glass:plain
core.register_node('glass:plain', glass_def)


--- Obsidian glass.
--
-- @node glass:obsidian
core.register_node('glass:obsidian', {
	description = S('Obsidian Glass'),
	drawtype = 'glasslike_framed_optional',
	tiles = {'glass_obsidian.png', 'glass_obsidian_detail.png'},
	paramtype = 'light',
	paramtype2 = 'glasslikeliquidlevel',
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = glass.node_sounds(),
})


-- Compatibility

if core.get_modpath('default') then
	local glass_overrides = {
		'glass',
		'obsidian_glass',
	}
	
	for _, item in pairs(glass_overrides) do
		core.unregister_item(item)
		core.registered_nodes[item] = nil
		core.registered_aliases[item] = nil
	end
end

core.register_alias('glass', 'glass:plain')
core.register_alias('glass:glass', 'glass:plain')
core.register_alias('obsidian_glass', 'glass:obsidian')

-- Nodes from 'default'
core.register_alias_force('default:glass', 'glass:plain')
core.register_alias_force('default:obsidian_glass', 'glass:obsidian')
