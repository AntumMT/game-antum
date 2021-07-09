--[[ LICENSE HEADER

  MIT Licensing

  Copyright © 2017 Jordan Irwin

  See: LICENSE.txt
--]]


-- LOGGING FUNCTIONS

-- Custom logging function


-- Custom "info" level logging function
function listitems.logInfo(msg)
	listitems.log("warning", "\"listitems.logInfo\" is deprecated, use \"listitems.log\"")

	listitems.log("info", msg)
end


-- Custom "warning" level logging function
function listitems.logWarn(msg)
	listitems.log("warning", "\"listitems.logWarn\" is deprecated, use \"listitems.log\"")

	listitems.log("warning", msg)
end


-- Custom debug logging function
function listitems.logDebug(msg)
	listitems.log("warning", "\"listitems.logDebug\" is deprecated, use \"listitems.log\"")

	if listitems.debug then
		core.log("[DEBUG: " .. listitems.modname .. "] " .. msg)
	end
end
