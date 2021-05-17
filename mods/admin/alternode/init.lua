
alternode = {}
alternode.modname = core.get_current_modname()
alternode.modpath = core.get_modpath(alternode.modname)

function alternode.log(lvl, msg)
	core.log(lvl, "[" .. alternode.modname .. "] " .. msg)
end


local scripts = {
	"api",
	"commands",
	"formspec",
	"tools",
	"crafts",
}

for _, script in ipairs(scripts) do
	dofile(alternode.modpath .. "/" .. script .. ".lua")
end
