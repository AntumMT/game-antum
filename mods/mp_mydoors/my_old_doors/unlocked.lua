local cdoor_list = {   --Number , Description , Inven Image , Image
--	{ "1", "Old Door 1" , "old1", "old1"},
--	{ "2", "Old Door 2" , "old2" , "old2"},
--	{ "3", "Old Door 3" , "old3" , "old3"},
--	{ "4", "Old Door 4" , "old4" , "old4"},	
}
for i in ipairs(cdoor_list) do
	local num = cdoor_list[i][1]
	local desc = cdoor_list[i][2]
	local inv = cdoor_list[i][3]
	local img = cdoor_list[i][4]

mdoors.register_door("my_old_doors:door"..num, {
	description = desc,
	inventory_image = "mydoors_"..inv.."_inv.png",
	groups = {choppy=2,cracky=2,door=1},
	tiles_bottom = {"mydoors_"..img.."_bottom.png", "mydoors_"..img.."_edge.png"},
	tiles_top = {"mydoors_"..img.."_top.png", "mydoors_"..img.."_edge.png"},
	only_placer_can_open = false,
})
end

-- Crafts

minetest.register_craft({
	output = "my_old_doors:door1 1",
	recipe = {
		{"default:glass", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door2 1",
	recipe = {
		{"default:glass", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door3 1",
	recipe = {
		{"default:glass", "coloredwood:wood_gray", ""},
		{"coloredwood:wood_gray", "coloredwood:wood_gray", ""},
		{"coloredwood:wood_gray", "coloredwood:wood_gray", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door4 1",
	recipe = {
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "dye:black", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})



