
--- Determines handling of punched helicopter.
--
-- If `false`, helicopter is destroyed. Otherwise, it is added to inventory.
--   - Default: false
helicopter.pick_up = minetest.settings:get_bool("helicopter.pick_up", false)

--- Determines default control of helicopter.
--
-- If enabled, helicopter will be controlled via mouse by default.
--   - Default: false
helicopter.mouse_default = minetest.settings:get_bool("helicopter.mouse_default", false)
