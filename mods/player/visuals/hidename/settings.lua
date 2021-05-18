--[[ MIT LICENSE HEADER

  Copyright © 2017 Jordan Irwin (AntumDeluge)

  See: LICENSE.txt
]]


--- *hidename* settings
--
--  @script settings.lua


--- Use alpha color level to hide nametag instead of clearing text.
--
--  @setting hidename.use_alpha
--  @settype bool
--  @default false
hidename.use_alpha = core.settings:get_bool("hidename.use_alpha", false)
