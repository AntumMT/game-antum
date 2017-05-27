--[[ LICENSE HEADER
  
  MIT License
  
  Copyright © 2017 Jordan Irwin
  
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


-- Temporarily remove erroneous craft recipes until fixed

if minetest.get_modpath('homedecor') then
	local outputs = {
		'homedecor:standing_lamp_blue_off',
		'homedecor:standing_lamp_green_off',
		'homedecor:standing_lamp_pink_off',
		'homedecor:standing_lamp_red_off',
		'homedecor:standing_lamp_violet_off',
		'homedecor:standing_lamp_off',
		'homedecor:table_lamp_blue_off',
		'homedecor:table_lamp_green_off',
		'homedecor:table_lamp_pink_off',
		'homedecor:table_lamp_red_off',
		'homedecor:table_lamp_violet_off',
		'homedecor:table_lamp_off',
	}
	
	for I in pairs(outputs) do
		antum.clearCraftOutput(outputs[I])
	end
end

if minetest.get_modpath('stairsplus') then
	local outputs = {
		'brick',
		'cobble',
		'copperblock',
		'desert_stone',
		'sandstone',
		'desert_stone',
		'glass',
		'mossycobble',
		'sandstone',
		'steelblock',
		'stone',
		'wood',
	}
	
	for I in pairs(outputs) do
		antum.clearCraftOutput('stairsplus:corner_' .. outputs[I])
		antum.clearCraftOutput('stairsplus:stair_' .. outputs[I])
	end
end

if minetest.get_modpath('quartz') then
	local outputs = {
		'quartz:chiseled',
	}
	
	for I in pairs(outputs) do
		antum.clearCraftOutput(outputs[I])
	end
end
