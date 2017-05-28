-- Functions for sneeker mod


-- Displays a message in log output
function sneeker.log(message)
	minetest.log('action', '[' .. sneeker.modname .. '] ' .. message)
end

-- Displays a message in log output only if 'sneeker.debug' is set to 'true'
function sneeker.log_debug(message)
	if sneeker.debug then
		sneeker.log('[DEBUG] ' .. message)
	end
end
