--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


--- Logging functions.
--
-- @script logging.lua


--- Custom logging function.
--
-- @function override.log
-- @tparam string level Level at which to output message.
-- @tparam string msg Message to log.
function override.log(level, msg)
	local prefix = '[' .. override.modname .. '] '
	
	if level == 'debug' then
		if override.debug then
			core.log(prefix .. 'DEBUG: ' .. msg)
		end
	else
		if msg == nil then
			core.log(prefix .. level)
		else
			core.log(level, prefix .. msg)
		end
	end
end


--- Custom debug logging function.
--
-- @function override.logDebug
-- @tparam string msg Message to log.
function override.logDebug(msg)
	override.log('debug', msg)
end
