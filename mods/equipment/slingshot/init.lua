
slingshot = {}
slingshot.modname = minetest.get_current_modname()
slingshot.modpath = minetest.get_modpath(slingshot.modname)


local scripts = {
	'functions',
	'register',
}

for index, script in ipairs(scripts) do
	dofile(slingshot.modpath .. '/' .. script .. '.lua')
end
