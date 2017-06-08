mypaint = {}
mypaint.colors = {
	red = 			{"Red", 			"ff0000"},
	green = 		{"Green", 			"00ff00"},
	white = 		{"White", 			"ffffff"},
	black = 		{"Black",			"000000"},
	blue = 			{"Blue",			"0000ff"},
	brown = 		{"Brown",			"190B07"},
	cyan = 			{"Cyan",			"00ffff"},
	darkgreen =	 	{"Dark Green",			"005000"},
	darkgrey = 		{"Dark Grey",			"1C1C1C"},
	grey = 			{"Grey",			"848484"},
	magenta = 		{"Magenta",			"ff00ff"},
	orange = 		{"Orange",			"ff7700"},
	pink = 			{"Pink",			"FE2E9A"},
	violet = 		{"Violet",			"7f007f"},
	yellow = 		{"Yellow",			"ffff00"},
}
mypaint.paintables = {}

mypaint.register = function(names, colors)
	local ctable = {}
	for _, color in ipairs(colors) do
		ctable[color] = true
	end
	for _, name in ipairs(names) do
		mypaint.paintables[name] = ctable
	end
end

dofile(minetest.get_modpath("mypaint").."/paint.lua")
