
slingshot = {}
slingshot.modname = minetest.get_current_modname()
slingshot.modpath = minetest.get_modpath(slingshot.modname)
slingshot.require_rubber_band = minetest.setting_getbool('slingshot.require_rubber_band') or true


local scripts = {
	'functions',
	'register',
}

for index, script in ipairs(scripts) do
	dofile(slingshot.modpath .. '/' .. script .. '.lua')
end
