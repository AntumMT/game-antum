
sneeker = {}
sneeker.modname = core.get_current_modname()
sneeker.modpath = core.get_modpath(sneeker.modname)

local debugging = core.settings:get_bool("enable_debug_mods", false)
sneeker.log = function(lvl, msg)
	if lvl == "debug" and not debugging then return end

	if msg == nil then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. sneeker.modname .. "] " .. msg
	if lvl == "debug" then
		msg = "[DEBUG]" .. msg
		lvl = nil;
	end

	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end

local scripts = {
	"settings",
	"tnt_function",
	"spawn",
	"entity",
}

for _, script in ipairs(scripts) do
	dofile(sneeker.modpath .. "/" .. script .. ".lua")
end
