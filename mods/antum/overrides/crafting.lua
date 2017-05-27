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


antum.clearCraftOutput = function(o)
	antum.logAction('Clearing craft by output: ' .. o)
	minetest.clear_craft({
		output = o
	})
end

antum.clearCraftRecipe = function(r)
	local recipe_string = ''
	local icount = 0
	for I in pairs(r) do
		icount = icount + 1
	end
	
	for I in pairs(r) do
		if I == icount then
			recipe_string = recipe_string .. ' ' .. r[I]
		elseif I > 1 then
			recipe_string = recipe_string .. ' + ' .. r[I]
		else
			recipe_string = r[I]
		end
	end
	
	
	antum.logAction(' Clearing craft by recipe: ' .. recipe_string)
	minetest.clear_craft({
		recipe = {r}
	})
end

local modoverrides = {
	'bags',
	'carts',
	'coloredwood',
	'craftguide',
	'dye',
	'farming',
	'helicopter',
	'invisibility',
--	'temp-removals',
}

for I in pairs(modoverrides) do
	local modname = modoverrides[I]
	if minetest.get_modpath(modname) then
		antum.logAction('DEBUG: found mod \"' .. modname .. '\"')
		antum.loadScript('crafting/' .. modname)
	end
end
