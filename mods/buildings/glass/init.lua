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
glass.modname = core.get_current_modname()
glass.modpath = core.get_modpath(glass.modname)

function glass.log(lvl, msg)
		if not msg then
			msg = lvl
			lvl = nil
		end

		msg = "[" .. glass.modname .. "] " .. msg
		if not lvl then
			core.log(msg)
		else
			core.log(lvl, msg)
		end
end


local scripts = {
	--"functions",
	"nodes",
	--"crafting",
}

for _, s in ipairs(scripts) do
	dofile(glass.modpath .. "/" .. s .. ".lua")
end
