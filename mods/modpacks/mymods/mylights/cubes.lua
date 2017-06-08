local light_list = {
	{ "White Light Cube", "white"},
	{ "Green Light Cube", "green"},	
	{ "Red Light Cube", "red"},
	{ "Blue Light Cube", "blue"},
	{ "Orange Light Cube", "orange"},
	{ "Yellow Light Cube", "yellow"},
	{ "Aqua Light Cube", "aqua"},
}


for i in ipairs(light_list) do
	local lightdesc = light_list[i][1]
	local colour = light_list[i][2]



--------------------------------------------------------------------------------
minetest.register_node("mylights:light_cube_30_"..colour, {
	description = lightdesc.." 30 watt",
	tiles = {"mylights_black_frame.png", "mylights_cube_"..colour..".png"},
	drawtype = "glasslike_framed",
	paramtype = "light",
	groups = {oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	light_source = 5,

})
--------------------------------------------------------------------------------
minetest.register_node("mylights:light_cube_60_"..colour, {
	description = lightdesc.." 60 watt",
	tiles = {"mylights_black_frame.png", "mylights_cube_"..colour..".png"},
	drawtype = "glasslike_framed",
	paramtype = "light",
	groups = {oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	light_source = 8,

})
--------------------------------------------------------------------------------
minetest.register_node("mylights:light_cube_90_"..colour, {
	description = lightdesc.." 90 watt",
	tiles = {"mylights_black_frame.png", "mylights_cube_"..colour..".png"},
	drawtype = "glasslike_framed",
	paramtype = "light",
	groups = {oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	light_source = 11,

})
--------------------------------------------------------------------------------
minetest.register_node("mylights:light_cube_120_"..colour, {
	description = lightdesc.." 120 watt",
	tiles = {"mylights_black_frame.png", "mylights_cube_"..colour..".png"},
	drawtype = "glasslike_framed",
	paramtype = "light",
	groups = {oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	light_source = 14,

})
end

