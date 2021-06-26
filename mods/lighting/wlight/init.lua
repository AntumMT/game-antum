
wlight = {}
wlight.modname = core.get_current_modname()
wlight.modpath = core.get_modpath(wlight.modname)

-- override walking_light
walking_light = wlight

function wlight.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. wlight.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"api",
	"chat",
	"nodes",
}

for _, sc in ipairs(scripts) do
	dofile(wlight.modpath .. "/" .. sc .. ".lua")
end


if core.registered_items["default:torch"] then
	wlight.register_item("default:torch")
end
