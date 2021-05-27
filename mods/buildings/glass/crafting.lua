--[[ LICENSE HEADER

  GNU Lesser General Public License version 2.1+

  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors

  See: docs/license-LGPL-2.1.txt
]]


--- Glass craft recipes.
--
-- @module crafting


--- Cooking Recipes.
--
-- @section cooking


--- Glass recipe.
--
-- @recipe glass:plain
-- @rtype cooking
-- @output 1
-- @input group:sand
core.register_craft({
	type = "cooking",
	output = "glass:plain",
	recipe = "group:sand",
})


--- Obsidian glass recipe.
--
-- @recipe glass:obsidian
-- @rtype cooking
-- @output 1
-- @input default:obsidian_shard
core.register_craft({
	type = "cooking",
	output = "glass:obsidian",
	recipe = "default:obsidian_shard",
})
