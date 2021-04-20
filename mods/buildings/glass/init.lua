--[[ LICENSE HEADER

  GNU Lesser General Public License version 2.1+

  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors

  See: docs/license-LGPL-2.1.txt
]]

--- Glass initialization script.
--
-- @module init


glass = {}
glass.name = core.get_current_modname()
glass.path = core.get_modpath(glass.name)


local scripts = {
	'functions',
	'nodes',
	'crafting',
}

for _, s in ipairs(scripts) do
	dofile(glass.path .. '/' .. s .. '.lua')
end
