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


-- NOTE: This mod depends on the method 'minetest.unregister_item()' by paly2.
--       As of writing, the Mineteset main branch does not include it.

antum.overrides = {}
antum.overrides.modname = minetest.get_current_modname()
antum.overrides.modpath = minetest.get_modpath(antum.overrides.modname)

local scripts = {
	'items', 'entities', 'misc', 'nodes', 'crafting',
}

for I in pairs(scripts) do
	dofile(antum.overrides.modpath .. '/' .. scripts[I] .. '.lua')
end
