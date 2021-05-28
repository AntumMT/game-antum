
pbmarks.max = tonumber(core.settings:get("pbmarks.max")) or 5

if pbmarks.max < 1 then
	pbmarks.log("warning", "bookmark count too low, setting to 1")
	pbmarks.max = 1
elseif pbmarks.max > 5 then
	pbmarks.log("warning", "bookmark count too hight, setting to 5")
	pbmarks.max = 5
end
