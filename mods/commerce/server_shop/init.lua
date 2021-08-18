
server_shop = {}
local ss = server_shop

ss.modname = core.get_current_modname()
ss.modpath = core.get_modpath(ss.modname)

function ss.log(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. ss.modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end

local scripts = {
	"settings",
	"api",
	"deposit",
	"formspec",
	"node",
	"command",
}

for _, script in ipairs(scripts) do
	dofile(ss.modpath .. "/" .. script .. ".lua")
end


ss.file_load()
core.register_on_mods_loaded(ss.prune_shops)
