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


local bags = {}
bags.depends = {
	'animalmaterials',
}
bags.satisfied = true

for I in pairs(bags.depends) do
	if not minetest.get_modpath(bags.depends[I]) then
		bags.satisfied = false
	end
end


if bags.satisfied then
	minetest.clear_craft({
		recipe = {
			{"", "default:stick", ""},
			{"default:wood", "default:wood", "default:wood"},
			{"default:wood", "default:wood", "default:wood"},
		},
	})
	minetest.clear_craft({
		recipe = {
			{"bags:small", "bags:small"},
			{"bags:small", "bags:small"},
		},
	})
	minetest.clear_craft({
		recipe = {
			{"bags:medium", "bags:medium"},
			{"bags:medium", "bags:medium"},
		},
	})
	
	antum.register_craft({
		output = 'bags:small',
		recipe = {
			{'', 'group:stick', '',},
			{'group:fur', 'group:fur', 'group:fur',},
			{'group:fur', 'group:fur', 'group:fur',},
		}
	})
	antum.register_craft({
		output = 'bags:medium',
		recipe = {
			{'bags:small', 'bags:small',},
			{'bags:small', 'bags:small',},
			{'bags:small', 'bags:small',},
		}
	})
	antum.register_craft({
		output = 'bags:large',
		recipe = {
			{'bags:medium', 'bags:medium',},
			{'bags:medium', 'bags:medium',},
			{'bags:medium', 'bags:medium',},
		}
	})
end
