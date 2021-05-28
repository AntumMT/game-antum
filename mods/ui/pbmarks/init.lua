
pbmarks = {}
pbmarks.modname = core.get_current_modname()
pbmarks.modpath = core.get_modpath(pbmarks.modname)

function pbmarks.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. pbmarks.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"api",
	"formspec",
	"ui",
}

for _, scr in ipairs(scripts) do
	dofile(pbmarks.modpath .. "/" .. scr .. ".lua")
end
