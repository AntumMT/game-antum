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


local function registerDyeRecipes(def)
	for I, T in pairs(def) do
		local dye = 'dye:' .. T[1]
		local ingredients = T[2]
		-- DEBUG
		core.log('action', '[antum_overrides] Registering new recipe for dye:' .. T[1] .. ' with the following ingredients:')
		for i in pairs(ingredients) do
			core.log('action', '[antum_overrides]\t' .. ingredients[i])
		end
		
		core.register_craft({
			output = dye,
			type = 'shapeless',
			recipe = ingredients,
		})
	end
end

local dye_defs = {}

if core.get_modpath('flowers') then
	table.insert(dye_defs, -1, {'brown 4', {'flowers:mushroom_brown'}})
end

registerDyeRecipes(dye_defs)
