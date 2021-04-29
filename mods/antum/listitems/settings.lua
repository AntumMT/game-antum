--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]

--- List Items settings
--
-- @script settings.lua


listitems.debug = core.settings:get_bool("enable_debug_mods", false)


--- Displays items in a bulleted list.
--
-- FIXME: should be client side only
--
-- @setting listitems.bullet_list
-- @settype boolean
-- @default true
listitems.bullet_list = core.settings:get_bool("listitems.bullet_list", true)


--- Registers "/list<type>" commands.
listitems.enable_singleword = core.settings:get_bool("listitems.enable_singleword", true)
