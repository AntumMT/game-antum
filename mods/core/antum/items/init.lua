
local scripts = {
	"animal",
	"tool",
	"misc",
	"spawneggs",
}

for _, script in ipairs(scripts) do
	antum.loadScript(script)
end
