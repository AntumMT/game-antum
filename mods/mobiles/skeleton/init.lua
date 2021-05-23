
cmer_skeleton = {}
cmer_skeleton.modname = core.get_current_modname()
cmer_skeleton.modpath = core.get_modpath(cmer_skeleton.modname)

function cmer_skeleton.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. cmer_skeleton.modname .. "] " .. msg

	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"settings",
	"entity",
}

for _, script in ipairs(scripts) do
	dofile(cmer_skeleton.modpath .. "/" .. script .. ".lua")
end
