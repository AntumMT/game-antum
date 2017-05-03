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


antum.entities = {}
antum.entities.modname = minetest.get_current_modname()
antum.entities.modpath = minetest.get_modpath(antum.entities.modname)


local function logAction(message)
	minetest.log('action', '[' .. antum.entities.modname .. '] ' .. message)
end


-- Loading entity definitions
logAction('Loading entity definitions ...')

antum.def = {}
local defs = {
	'visual', 'movement', 'battle',
}

for I in pairs(defs) do
	dofile(antum.entities.modpath .. '/definitions/' .. defs[I] .. '.lua')
end


-- Loading entity types
logAction('Loading entity types ...')
local types = {
	'hostile', 'peaceful', 'npc',
}

for I in pairs(types) do
	dofile(antum.entities.modpath .. '/types/' .. types[I] .. '.lua')
end
