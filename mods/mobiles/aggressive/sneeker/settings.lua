-- Settings for sneeker mod


sneeker.debug = minetest.settings:get_bool('sneeker.debug')
if sneeker.debug == nil then
	sneeker.debug = false
end
