--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- @script settings


listitems.debug = core.settings:get_bool('enable_debug_mods') or false

--- Enables/Disables "list" chat command.
--
-- @setting listitems.enable_generic
-- @settype boolean
-- @default false
listitems.enable_generic = core.settings:get_bool('listitems.enable_generic') or false

--- Enables/Disables "listmobs" chat command.
--
-- Requires "mobs".
-- 
-- @setting listitems.enable_mobs
-- @settype boolean
-- @default true
listitems.enable_mobs = false
if core.global_exists('mobs') then
	listitems.enable_mobs = core.settings:get_bool('listitems.enable_mobs')
	-- Default: enabled
	listitems.enable_mobs = listitems.enable_mobs == nil or listitems.enable_mobs == true
end
