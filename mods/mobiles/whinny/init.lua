
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

-- TODO:
-- - can be removed in future
-- - only meant to replace current horse instances
if core.global_exists("mobs") then
	for _, color in ipairs({"brown", "white", "black"}) do
		mobs:alias_mob("creatures:horse_" .. color, "whinny:horse_" .. color)
	end
end
