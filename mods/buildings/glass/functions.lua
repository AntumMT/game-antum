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
-- @tparam tbl table
function glass.node_sounds(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name="glass_footstep", gain=0.3}
	tbl.dig = tbl.dig or {name="glass_footstep", gain=0.5}
	tbl.dug = tbl.dug or {name="glass_break", gain=1.0}

	default.node_sound_defaults(tbl)
	return tbl
end
