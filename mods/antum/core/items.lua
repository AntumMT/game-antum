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


-- Feather

--[[
  The following mods have 'feather' items & should be added as soft dependencies to be overridden:
    - mobs_animal
    - animalmaterials
]]

local feathers = antum.getItemNames('feather')
for index, feather in ipairs(feathers) do
	antum.convertItemToAlias(feather, 'antum:feather')
end

core.register_craftitem(':antum:feather', {
	description = 'Feather',
	inventory_image = 'antum_feather_white.png',
})
core.register_alias('antum:feather_white', 'antum:feather')


local depends_satisfied = true

local depends = {
	'bucket',
	'vessels',
}

for I in pairs(depends) do
	if not core.get_modpath(depends[I]) then
		depends_satisfied = false
	end
end


core.register_craftitem(':antum:bottled_water', {
	description = 'A bottle of water',
	inventory_image = 'antum_bottled_water.png',
})


if depends_satisfied then
	antum.registerCraft({
		output = 'antum:bottled_water',
		type = 'shapeless',
		recipe = {
			'bucket:bucket_water', 'vessels:glass_bottle',
		},
		replacements = {
			{'bucket:bucket_water', 'bucket:bucket_empty'},
		},
	})
else
	antum.logWarn(antum.modname, 'Not registering craft for "' .. antum.modname .. ':bottled_water", dependency not satisfied')
end
