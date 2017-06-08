
dofile(minetest.get_modpath("mylights").."/lightbox.lua")
dofile(minetest.get_modpath("mylights").."/lightbulbs.lua")
dofile(minetest.get_modpath("mylights").."/ws.lua")
dofile(minetest.get_modpath("mylights").."/cubes.lua")
dofile(minetest.get_modpath("mylights").."/lamppost.lua")
dofile(minetest.get_modpath("mylights").."/lantern.lua")
dofile(minetest.get_modpath("mylights").."/sewer_light.lua")
dofile(minetest.get_modpath("mylights").."/ceilinglights.lua")
dofile(minetest.get_modpath("mylights").."/machine_bulbs.lua")
dofile(minetest.get_modpath("mylights").."/machine_cubes.lua")
dofile(minetest.get_modpath("mylights").."/aliases.lua")
print ("mylights loaded")

if minetest.get_modpath("ilights") then
	dofile(minetest.get_modpath("mylights").."/ilights.lua")
		return
	end

