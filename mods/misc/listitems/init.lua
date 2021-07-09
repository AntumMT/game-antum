--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin (AntumDeluge)

  See: LICENSE.txt
--]]


listitems = {}
listitems.modname = core.get_current_modname()
listitems.modpath = core.get_modpath(listitems.modname)

function listitems.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	local prefix = "[" .. listitems.modname .. "]"
	if lvl == "debug" then
		if not listitems.debug then return end

		prefix = prefix .. "[DEBUG]"
	end

	msg = prefix .. " " .. msg

	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"logging",
	"api",
	"chat",
}

for index, script in ipairs(scripts) do
	dofile(listitems.modpath .. "/" .. script .. ".lua")
end

-- DEBUG:
listitems.logDebug("Loaded")
