--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


antum.overrides = {}
antum.overrides.modname = core.get_current_modname()
antum.overrides.modpath = core.get_modpath(antum.overrides.modname)

--local scripts = {
antum.loadScripts({
	"items",
	"misc",
	"nodes",
	"crafting",
})


if not core.registered_items["creatures:flesh"] and core.registered_items["mobs:meat_raw"] then
	core.register_alias("creatures:flesh", "mobs:meat_raw")
end
