
wdata = {}
wdata.modname = core.get_current_modname()
wdata.modpath = core.get_modpath(wdata.modname)

function wdata.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. wdata.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


dofile(wdata.modpath .. "/api.lua")
