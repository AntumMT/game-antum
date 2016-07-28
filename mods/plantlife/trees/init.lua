abstract_trees = {}

dofile(minetest.get_modpath("trees").."/nodes.lua")
dofile(minetest.get_modpath("trees").."/jungletree.lua")
dofile(minetest.get_modpath("trees").."/mangrovetree.lua")
dofile(minetest.get_modpath("trees").."/palmtree.lua")
--dofile(minetest.get_modpath("trees").."/loaftree.lua")
dofile(minetest.get_modpath("trees").."/aliases.lua")
dofile(minetest.get_modpath("trees").."/conifertree.lua")

--testing tool
minetest.register_tool("trees:drawer", {
	description = "palmtree spawner",
	inventory_image = "default_stick.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.under then
			local height = 4+math.ceil(math.random(11))
			abstract_trees.grow_conifertree(pointed_thing.above, height)
		end
	end,
})

