local cdoor_list = {   --Number , Description , Inven Image , Image
	{ "1", "Old Door 1" , "old1"},
	{ "2", "Old Door 2" , "old2"},
	{ "3", "Old Door 3" , "old3"},
	{ "4", "Old Door 4" , "old4"},
}

local function add_door(num, desc, img)
	doors.register_door("my_old_doors:door"..num.."_locked", {
		description = desc.." Locked",
		inventory_image = "mydoors_"..img.."_inv.png",
		groups = {choppy=2,cracky=2,door=1},
		tiles = {{ name = "mydoors_"..img..".png", backface_culling = true }},
		protected = true,
	})
end

for _,cdoor in ipairs(cdoor_list) do
	add_door(unpack(cdoor))
end


-- Crafts

minetest.register_craft({
	output = "my_old_doors:door1_locked 1",
	recipe = {
		{"default:glass", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", "default:steel_ingot"},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door2_locked 1",
	recipe = {
		{"default:glass", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", "default:steel_ingot"},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door3_locked 1",
	recipe = {
		{"default:glass", "coloredwood:wood_grey", ""},
		{"coloredwood:wood_grey", "coloredwood:wood_grey", "default:steel_ingot"},
		{"coloredwood:wood_grey", "coloredwood:wood_grey", ""}
	}
})
minetest.register_craft({
	output = "my_old_doors:door4_locked 1",
	recipe = {
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "dye:black", "default:steel_ingot"},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
