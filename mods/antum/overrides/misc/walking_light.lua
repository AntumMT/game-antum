--[[ LICENSE HEADER
  
  The MIT License (MIT)
  
  Copyright © 2016 Jordan Irwin
  
  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:
  
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  
--]]


local addLightItems = function(mod, itemlist)
	for I in pairs(itemlist) do
		walking_light.addLightItem(mod .. ':' .. itemlist[I])
	end
end


-- Illuminate glow_glass & super_glow_glass
if minetest.get_modpath('moreblocks') then
	local mod = 'moreblocks'
	local mod_items = {'glow_glass', 'super_glow_glass'}
	
	addLightItems(mod, mod_items)
end


-- Illuminate homedecor candles
if minetest.get_modpath('homedecor') then
	local mod = 'homedecor'
	local mod_items = {
		'candle', 'candle_thin', 'candlestick_brass',
		'candlestick_wrought_iron',
	}
	
	addLightItems(mod, mod_items)
end

local light_items = walking_light.getLightItems()
for I in pairs(light_items) do
	minetest.log('warning', '[walking_light] Light item: \"' .. light_items[I] .. '\"')
end
