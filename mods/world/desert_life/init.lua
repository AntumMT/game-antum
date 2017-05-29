desert_life = {}

if minetest.get_modpath('mymonths') then
   desert_life.bloom = true
   print 'mymonths is here, lets make things bloom.'
end

dofile(minetest.get_modpath('desert_life')..'/functions.lua')
dofile(minetest.get_modpath('desert_life')..'/prickly_pear.lua')
dofile(minetest.get_modpath('desert_life')..'/barrel_cacti.lua')

if minetest.get_modpath('mobs') then
	dofile(minetest.get_modpath('desert_life')..'/ostrich.lua')
end
