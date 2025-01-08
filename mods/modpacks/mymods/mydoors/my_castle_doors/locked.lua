local cdoor_list = {   --Number , Description , Inven Image , Image
	{"Castle Door 1" , "door1"},
	{"Castle Door 2" , "door2"},
	{"Castle Door 3" , "door3"},
	{"Castle Door 4" , "door4"},
	{"Castle Door 5" , "door5"},
	{"Castle Door 6" , "door6"},
	{"Castle Door 7" , "door7"},
	{"Castle Door 8" , "door8"},
	{"Castle Door 9" , "door9"},
	{"Castle Door 10" , "door10"},
	{"Castle Door 11" , "door11"},
	{"Castle Door 12" , "door12"},
	{"Castle Door 13" , "door13"},
}

local function add_door(desc, img)
	doors.register_door("my_castle_doors:"..img.."_locked", {
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


---[[ Crafts

minetest.register_craft({
	output = "my_castle_doors:door1_locked 1",
	recipe = {
		{"default:steel_ingot", "default:glass", ""},
		{"coloredwood:wood_dark_grey", "coloredwood:wood_dark_grey", "default:steel_ingot"},
		{"coloredwood:wood_dark_grey", "default:steel_ingot", ""}
	}
})

minetest.register_craft({
	output = "my_castle_doors:door2_locked 1",
	recipe = {
		{"default:steel_ingot", "default:glass", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", "default:steel_ingot"},
		{"coloredwood:wood_red", "default:steel_ingot", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door3_locked 1",
	recipe = {
		{"coloredwood:wood_yellow", "default:steel_ingot", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", "default:steel_ingot"},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door4_locked 1",
	recipe = {
		{"default:junglewood", "default:junglewood", ""},
		{"default:junglewood", "default:steel_ingot", "default:steel_ingot"},
		{"default:junglewood", "default:junglewood", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door5_locked 1",
	recipe = {
		{"coloredwood:wood_yellow", "default:steel_ingot", ""},
		{"coloredwood:wood_white", "coloredwood:wood_yellow", "default:steel_ingot"},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door6_locked 1",
	recipe = {
		{"coloredwood:wood_grey", "coloredwood:wood_grey", ""},
		{"coloredwood:wood_grey", "default:steel_ingot", "default:steel_ingot"},
		{"coloredwood:wood_grey", "coloredwood:wood_grey", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door7_locked 1",
	recipe = {
		{"coloredwood:wood_red", "coloredwood:wood_red", ""},
		{"coloredwood:wood_red", "default:steel_ingot", "default:steel_ingot"},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door8_locked 1",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", ""},
		{"coloredwood:wood_dark_grey", "coloredwood:wood_dark_grey", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door9_locked 1",
	recipe = {
		{"default:steel_ingot", "coloredwood:wood_yellow", ""},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", "default:steel_ingot"},
		{"coloredwood:wood_yellow", "coloredwood:wood_yellow", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door10_locked 1",
	recipe = {
		{"coloredwood:wood_red", "default:steel_ingot", ""},
		{"coloredwood:wood_red", "coloredwood:wood_red", "default:steel_ingot"},
		{"coloredwood:wood_red", "coloredwood:wood_red", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door11_locked 1",
	recipe = {
		{"default:junglewood", "default:steel_ingot", ""},
		{"default:junglewood", "default:junglewood", "default:steel_ingot"},
		{"default:junglewood", "default:junglewood", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door12_locked 1",
	recipe = {
		{"default:junglewood", "default:steel_ingot", ""},
		{"coloredwood:wood_grey", "default:junglewood", "default:steel_ingot"},
		{"default:junglewood", "default:junglewood", ""}
	}
})
minetest.register_craft({
	output = "my_castle_doors:door13_locked 1",
	recipe = {
		{"default:junglewood", "default:junglewood", "default:steel_ingot"},
		{"default:junglewood", "default:junglewood", "default:steel_ingot"},
		{"default:junglewood", "default:junglewood", "default:steel_ingot"}
	}
})


--]]
