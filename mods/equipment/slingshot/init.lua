
slingshot = {}
slingshot.modname = minetest.get_current_modname()
slingshot.modpath = minetest.get_modpath(slingshot.modname)

-- Requires rubber band for slingshot craft recipe
slingshot.require_rubber_band = minetest.settings:get_bool('slingshot.require_rubber_band')
if slingshot.require_rubber_band == nil then
	slingshot.require_rubber_band = true
end

if minetest.settings:get_bool('log_mods') then
	minetest.log('action', '[slingshot] Require rubber band: ' .. tostring(slingshot.require_rubber_band))
end


local scripts = {
	'functions',
	'register',
}

for index, script in ipairs(scripts) do
	dofile(slingshot.modpath .. '/' .. script .. '.lua')
end
