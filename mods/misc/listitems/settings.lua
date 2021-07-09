--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]

--- List Items settings
--
-- @topic settings


listitems.debug = core.settings:get_bool("enable_debug_mods", false)


--- Displays items in a bulleted list.
--
-- FIXME: should be client side only
--
-- @setting listitems.bullet_list
-- @settype boolean
-- @default true
listitems.bullet_list = core.settings:get_bool("listitems.bullet_list", true)


--- Registers "/list&lt;type&gt;" commands.
--
--  @setting listitems.enable_singleword
--  @settype boolean
--  @default true
listitems.enable_singleword = core.settings:get_bool("listitems.enable_singleword", true)
