
local scripts = {
	"tool",
	"misc",
	"nodes",
	"spawneggs",
}

for _, script in ipairs(scripts) do
	antum.loadScript(script)
end
