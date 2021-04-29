
trampoline = {}
trampoline.modname = minetest.get_current_modname()
trampoline.modpath = minetest.get_modpath(trampoline.modname)


-- Log messages specific to trampoline mod
trampoline.log = function(lvl, msg)
	if msg == nil then
		msg = lvl
		lvl = nil
	end

	if lvl == nil then
		core.log(msg)
	else
		core.log(lvl, "[" .. trampoline.modname .. "] " .. msg)
	end
end

trampoline.log("action", "loading ...")


local scripts = {
	"settings",
	"api",
	"nodes",
	"crafting",
}

for I in pairs(scripts) do
	dofile(trampoline.modpath .. "/" .. scripts[I] .. ".lua")
end


trampoline.log("action", "loaded")
