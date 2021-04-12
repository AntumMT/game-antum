local S = minetest.get_translator("building_blocks")

local tool_wear = minetest.settings:get_bool("enable_tool_wear") ~= false

local knife_uses = 100
if not tool_wear then
       knife_uses = 0
end

minetest.register_craftitem("building_blocks:sticks", {
	description = S("Small bundle of sticks"),
	image = "building_blocks_sticks.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem("building_blocks:tar_base", {
	description = S("Tar base"),
	image = "building_blocks_tar_base.png",
})

minetest.register_tool("building_blocks:knife", {
	description = S("Tar Knife"),
	inventory_image = "building_blocks_knife.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=7.50, [3]=2.80}, uses=knife_uses, maxlevel=1},
			fleshy={times={[2]=5.50, [3]=2.80}, uses=knife_uses, maxlevel=1}
		}
	},
})
