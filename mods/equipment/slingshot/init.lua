
slingshot = {}
slingshot.modname = core.get_current_modname()
slingshot.modpath = core.get_modpath(slingshot.modname)


if core.settings:get_bool('log_mods') then
	core.log('action', '[slingshot] Require rubber band: ' .. tostring(slingshot.require_rubber_band))
end


local scripts = {
	'settings',
	'api',
	'weapons',
}

for index, script in ipairs(scripts) do
	dofile(slingshot.modpath .. '/' .. script .. '.lua')
end
