--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]


-- LOGGING FUNCTIONS

-- Custom logging function
function listitems.log(level, msg)
	local prefix = "[" .. listitems.modname .. "] "

	if msg == nil then
		core.log(prefix .. level)
	else
		core.log(level, prefix .. msg)
	end
end


-- Custom "info" level logging function
function listitems.logInfo(msg)
	listitems.log("info", msg)
end


-- Custom "warning" level logging function
function listitems.logWarn(msg)
	listitems.log("warning", msg)
end


-- Custom debug logging function
function listitems.logDebug(msg)
	if listitems.debug then
		core.log("[DEBUG: " .. listitems.modname .. "] " .. msg)
	end
end
