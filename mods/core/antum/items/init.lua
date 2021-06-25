
local scripts = {
	"tool",
	"misc",
	"nodes",
	"spawneggs",
	"equip",
}

for _, script in ipairs(scripts) do
	antum.loadScript(script)
end
