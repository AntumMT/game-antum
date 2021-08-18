
sounds = {}
sounds.modname = core.get_current_modname()
sounds.modpath = core.get_modpath(sounds.modname)

sounds.log = function(lvl, msg)
	if not msg then
		msg = lvl
		lvl = nil
	end

	msg = "[" .. sounds.modname .. "] " .. msg

	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end


local scripts = {
	"override",
	"api",
	"groups",
	"groups_animal",
	"groups_creature",
	"groups_node",
	"groups_weather",
	"node",
}

for _, s in ipairs(scripts) do
	dofile(sounds.modpath .. "/" .. s .. ".lua")
end


-- cache available sound files
sounds.cache = {}
core.register_on_mods_loaded(function()
	sounds.log("action", "caching sound files ...")

	for _, modname in ipairs(core.get_modnames()) do
		local s_dir = core.get_modpath(modname) .. "/sounds"
		for _, ogg in ipairs(core.get_dir_list(s_dir, false)) do
			if ogg:find("%.ogg$") then
				local basename = ogg:gsub("%.ogg$", "")
				-- files for playing randomly by core must have suffix trimmed
				if basename:find("%.[0-9]$") then
					basename = basename:gsub("%.[0-9]$", "")
				end

				sounds.cache[basename] = true
			end
		end
	end
end)
