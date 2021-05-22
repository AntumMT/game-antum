
whinny = {}
whinny.modname = core.get_current_modname()
whinny.modpath = core.get_modpath(whinny.modname)

whinny.log = function(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. whinny.modname .. "] " .. msg

	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"api",
	"horse",
}

for _, script in ipairs(scripts) do
	dofile(whinny.modpath .. "/" .. script .. ".lua")
end
