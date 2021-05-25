--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


local addLightItems = function(mod, itemlist)
	if core.get_modpath(mod) then
		for _, i in ipairs(itemlist) do
			walking_light.addLightItem(mod .. ":" .. i)
		end
	end
end


-- Illuminate glow_glass & super_glow_glass
addLightItems("moreblocks", {
	"glow_glass", "super_glow_glass",
})


-- Illuminate homedecor candles
addLightItems("homedecor", {
	"candle", "candle_thin", "candlestick_brass",
	"candlestick_wrought_iron",
})


-- Illuminate ethereal:candle
addLightItems("ethereal", {
		"candle",
})
