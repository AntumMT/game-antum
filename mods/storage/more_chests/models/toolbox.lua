local gen_def = dofile(minetest.get_modpath("more_chests") .. "/utils/base.lua")
local S = minetest.get_translator("more_chests")

local function register_toolbox(description, material, side_tile, craft_item)
	local def = gen_def({
		description = description,
		type = "toolbox",
		size = "big",
		-- node_box = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}, -- makes it two blocks wide
		tiles = {
			side = side_tile,
			front = "toolbox_" .. material .. "_front.png",
			top = "toolbox_" .. material .. "_top.png",
		},
	})
	minetest.register_node("more_chests:toolbox_" .. material, def)
	minetest.register_craft({
		output = "more_chests:toolbox_" .. material,
		recipe = {
			{craft_item, craft_item, craft_item},
			{craft_item, "group:pickaxe", craft_item},
			{craft_item, craft_item, craft_item}
		}
	})
end


register_toolbox(S("Wooden Toolbox"), "wood", "default_wood.png", "default:wood")
register_toolbox(S("Aspen Wood Toolbox"), "aspen", "default_aspen_wood.png", "default:aspen_wood")
register_toolbox(S("Acacia Wood Toolbox"), "acacia", "default_acacia_wood.png", "default:acacia_wood")
register_toolbox(S("Junglewood Toolbox"), "jungle", "default_junglewood.png", "default:junglewood")
register_toolbox(S("Pine Wood Toolbox"), "pine", "default_pine_wood.png", "default:pine_wood")
register_toolbox(S("Steel Toolbox"), "steel", "default_steel_block.png", "default:steel_ingot")
