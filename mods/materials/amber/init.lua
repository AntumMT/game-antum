-- Loading the files --
amber = {}
local amber_path = minetest.get_modpath("amber")
dofile(amber_path.."/tools.lua")
dofile(amber_path.."/nodes.lua")
dofile(amber_path.."/craftitems.lua")
dofile(amber_path.."/mapgen.lua")
dofile(amber_path.."/crafts.lua")
if minetest.get_modpath("3d_armor") then
dofile(amber_path.."/armor.lua")
end
