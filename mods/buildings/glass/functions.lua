--[[ LICENSE HEADER

  GNU Lesser General Public License version 2.1+

  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors

  See: docs/license-LGPL-2.1.txt
]]


--- Glass functions.
--
-- @module functions


--- Sounds
--
-- @section sounds


--- Retrieves sounds for glass nodes.
--
-- @function glass.node_sounds
-- @tparam table table
function glass.node_sounds(table)
	table = table or {}
	table.footstep = table.footstep or {name='glass_footstep', gain=0.3}
	table.dig = table.dig or {name='glass_footstep', gain=0.5}
	table.dug = table.dug or {name='glass_break', gain=1.0}

	default.node_sound_defaults(table)
	return table
end
