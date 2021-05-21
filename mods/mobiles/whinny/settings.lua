
-- common settings

whinny.creative = core.settings:get_bool("creative_mode", false)

whinny.enable_damage = core.settings:get_bool("enable_damage", true)


-- mobs_redo settings

whinny.display_spawn = core.settings:get_bool("display_mob_spawn", false) -- deprecated?


-- unique settings

whinny.peaceful_only = core.settings:get_bool("whinny.peaceful_only", true)

whinny.spawn_chance = tonumber(core.settings:get("whinny.spawn_chance") or 50000)

whinny.spawn_height_min = tonumber(core.settings:get("whinny.spawn_height_min") or -500)

whinny.spawn_height_max = tonumber(core.settings:get("whinny.spawn_height_max") or 500)

whinny.enable_mouse_ctrl = core.settings:get_bool("whinny.enable_mouse_ctrl", true)
