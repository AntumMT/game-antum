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


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists("intllib") then
	dofile(core.get_modpath("intllib").."/intllib.lua")
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair("mobs")
	else
		S = intllib.Getter("mobs")
	end
else
	S = function ( s ) return s end
end


-- OVERRIDING CRAFT ITEMS


-- Fur group

core.register_craftitem(":mobs:leather", {
	description = S("Leather"),
	inventory_image = "mobs_leather.png",
	groups = {fur = 1},
})


-- Shears
if antum.dependsSatisfied({'mob_sheep', 'mobs',}) or antum.dependsSatisfied({'sheep', 'mobs',}) then
	override.overrideItems(':creatures:shears', {
		overrides = {'creatures:shears', 'mobs:shears'},
		description = 'Shears',
		inventory_image = 'mobs_shears.png',
		stack_max = 1,
	})
	core.clear_craft({
		output = 'mobs:shears',
	})
	
	-- FIXME: Not being registered in overrideItems
	core.register_alias('mobs:shears', 'creatures:shears')
end
