
--  The MIT License (MIT)
--  
--  Copyright © 2016 Jordan Irwin
--  
--  Permission is hereby granted, free of charge, to any person obtaining a copy of
--  this software and associated documentation files (the "Software"), to deal in
--  the Software without restriction, including without limitation the rights to
--  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
--  of the Software, and to permit persons to whom the Software is furnished to do
--  so, subject to the following conditions:
--  
--    The above copyright notice and this permission notice shall be included in
--    all copies or substantial portions of the Software.
--  
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.


local modname = "stained_wood"

core.log("action", "[MOD] Loading '" .. modname .. "' ...")


logMessage = function(message)
	core.log("action", "[" .. modname .. "] " .. message)
end


-- Get stained_wood mod path
local modpath = minetest.get_modpath("stained_wood")

-- Initialize stained_wood
stained_wood = {}


-- Define function to titleize labels (for description purposes)
titleize = function(string)
	local string = string:gsub("^%l", string.upper)
	return string
end


-- Define function to retrieve total number of stained wood colors
getWoodColorsCount = function(colors)
	local color_count = 0
	
	for _ in pairs(colors) do
		color_count = color_count + 1
	end
	
	return color_count
end


-- Set stained wood colors
wood_colors = {"blue", "brown", "gray", "green", "violet", "red",
	"white", "yellow"}

wood_colors_count = getWoodColorsCount(wood_colors)


-- Load sub-scripts
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/crafting.lua")


core.log("action", "[MOD] '" .. modname .. "' loaded")
