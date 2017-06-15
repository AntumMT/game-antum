--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


listitems = {}
listitems.modname = minetest.get_current_modname()
listitems.modpath = minetest.get_modpath(listitems.modname)

dofile(listitems.modpath .. '/register.lua')