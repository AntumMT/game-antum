
--- Personal Bookmarks Settings
--
--  @module settings.lua


--- Number of allowed bookmarks.
--
--  - min: 1
--  - max: 5
--
--  @setting pbmarks.max
--  @settype int
--  @default 5
pbmarks.max = tonumber(core.settings:get("pbmarks.max")) or 5

if pbmarks.max < 1 then
	pbmarks.log("warning", "bookmark count too low, setting to 1")
	pbmarks.max = 1
elseif pbmarks.max > 5 then
	pbmarks.log("warning", "bookmark count too hight, setting to 5")
	pbmarks.max = 5
end

--- Don't allow bookmarks to be set in areas not accessible to player.
--
--  @setting pbmarks.disallow_protected
--  @settype bool
--  @default true
pbmarks.disallow_protected = core.settings:get_bool("pbmarks.disallow_protected", true)
