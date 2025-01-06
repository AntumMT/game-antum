
local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)

local scripts = {
	"item",
	"craft",
}

for _, script in ipairs(scripts) do
	dofile(modpath .. "/" .. script .. ".lua")
end
