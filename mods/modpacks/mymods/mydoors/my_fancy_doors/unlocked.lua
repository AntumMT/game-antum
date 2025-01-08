local fdoor_list = {   --Number , Description , Inven Image , Image
	{"Fancy Door 1" , "door1"},
	{"Fancy Door 2" , "door2"},
	{"Fancy Door 3" , "door3"},
	{"Fancy Door 4" , "door4"},
	{"Fancy Door 5" , "door5"},
	{"Fancy Door 6" , "door6"},
	{"Fancy Door 7" , "door7"},
	{"Fancy Door 8" , "door8"},
}

local function add_door(desc, img)
	doors.register_door("my_fancy_doors:"..img, {
		description = desc,
		inventory_image = "myfdoors_"..img.."_inv.png",
		groups = {choppy=2,cracky=2,door=1},
		tiles = {{ name = "myfdoors_"..img..".png", backface_culling = true }},
		protected = false,
	})
end

for _,fdoor in ipairs(fdoor_list) do
	add_door(unpack(fdoor))
end


-- Crafts

minetest.register_craft({
	output = "my_fancy_doors:door1 1",
	recipe = {
		{"coloredwood:wood_yellow", "default:glass", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "default:glass", ""}
	}
})

minetest.register_craft({
	output = "my_fancy_doors:door2 1",
	recipe = {
		{"coloredwood:wood_yellow", "default:glass", ""},
		{"coloredwood:wood_yellow", "default:steel_ingot", ""},
		{"coloredwood:wood_yellow", "default:glass", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door3 1",
	recipe = {
		{"coloredwood:wood_white", "default:glass", ""},
		{"coloredwood:wood_white", "coloredwood:wood_white", ""},
		{"coloredwood:wood_white", "default:glass", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door4 1",
	recipe = {
		{"coloredwood:wood_red", "coloredwood:wood_dark_grey", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "coloredwood:wood_dark_grey", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door5 1",
	recipe = {
		{"default:glass", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "default:glass", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door6 1",
	recipe = {
		{"default:glass", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "default:glass", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door7 1",
	recipe = {
		{"coloredwood:wood_red", "default:glass", ""},
		{"coloredwood:wood_red", "default:glass", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_fancy_doors:door8 1",
	recipe = {
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"default:glass", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
