myfences = {}
myfences.colors = {
	{"red", "Red", "842800ae"},
	{"green", "Green", "0c4916b3"},
	{"white", "White", "ffffffb3"},
	{"black","Black","000000"},
	{"blue","Blue","0B0B3B"},
	{"brown","Brown","190B07"},
	{"cyan","Cyan","00a4e8"},
	{"darkgreen","Dark Green","071907"},
	{"darkgrey","Dark Grey","1C1C1C"},
	{"grey","Grey","848484"},
	{"magenta","Magenta","e8008e"},
	{"orange","Orange","e8b400"},
	{"pink","Pink","FE2E9A"},
	{"violet","Violet","08088A"},
	{"yellow","Yellow","f4dd1b"},
}

dofile(minetest.get_modpath("myfences").."/picket.lua")
dofile(minetest.get_modpath("myfences").."/privacy.lua")
dofile(minetest.get_modpath("myfences").."/garden.lua")
dofile(minetest.get_modpath("myfences").."/post.lua")
if mypaint ~= nil then
	dofile(minetest.get_modpath("myfences").."/paint.lua")
end

minetest.register_craftitem("myfences:board", {
	description = "Default Board",
	inventory_image = "myfences_board.png",
})
minetest.register_craft({
	type = "shapeless",
	output = "myfences:board 4",
	recipe = {"group:wood","group:wood"},
})
