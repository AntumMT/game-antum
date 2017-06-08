local paintables = {
	"myfences:picket", "myfences:picket_corner", "myfences:picketb", "myfences:picketb_corner",
	"myfences:garden", "myfences:garden_corner", "myfences:privacy", "myfences:privacy_corner",
	"myfences:corner_post"
}

local colors = {}
for _, entry in ipairs(myfences.colors) do
	table.insert(colors, entry[1])
end

mypaint.register(paintables, colors)

