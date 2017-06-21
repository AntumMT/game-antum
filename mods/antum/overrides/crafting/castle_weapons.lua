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


-- ** castle_weapons **

-- Recipe for 'throwing:arrow' conflicts with 'castle_weapons:crossbow_bolt'
-- TODO: 'antum:feather' item should be moved to 'antum_items' mod
if antum.dependsSatisfied({'throwing', 'antum_core'}) then
	-- TODO: Possible alternate solutions:
	--   * Allow 'throwing:arrow' to be used as ammo for 'castle_weapons:crossbow'
	
	-- FIXME: Cannot use 'antum.overrideCraftOutput' because 'minetest.clear_craft' does not allow
	--        clearing craft by output with quantity. E.g., 'castle_weapons:crossbow_bolt 6'.
	--  - Solution 1: Parse whitespace in 'output'
	antum.clearCraftOutput('castle_weapons:crossbow_bolt')
	
	-- New recipe
	antum.registerCraft({
		output = 'castle_weapons:crossbow_bolt 6',
		recipe = {
			{'antum:feather', 'default:stick', 'default:steel_ingot'},
		},
	})
	
	-- Same recipe but reversed
	antum.registerCraft({
		output = 'castle_weapons:crossbow_bolt 6',
		recipe = {
			{'default:steel_ingot', 'default:stick', 'antum:feather'},
		},
	})
end
