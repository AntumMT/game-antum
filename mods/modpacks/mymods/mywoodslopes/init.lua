
dofile(minetest.get_modpath("mywoodslopes").."/slopes.lua")
dofile(minetest.get_modpath("mywoodslopes").."/long_slopes.lua")

if minetest.get_modpath("moretrees") then
	dofile(minetest.get_modpath("mywoodslopes").."/moretrees.lua")
		return
	end

if minetest.get_modpath("ethereal") then
	dofile(minetest.get_modpath("mywoodslopes").."/ethereal.lua")
		return
	end
