-- Functions for sneaker mod


-- Displays a message in log output
function sneaker.log(message)
	minetest.log('action', '[' .. sneaker.modname .. '] ' .. message)
end

-- Displays a message in log output only if 'sneaker.debug' is set to 'true'
function sneaker.log_debug(message)
	if sneaker.debug then
		sneaker.log('[DEBUG] ' .. message)
	end
end
