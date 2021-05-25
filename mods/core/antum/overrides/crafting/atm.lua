--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


if not core.settings:get_bool("allow_atm_craft", true) then
	core.clear_craft({output="atm:atm"})
	core.clear_craft({output="atm:wtt"})
end
