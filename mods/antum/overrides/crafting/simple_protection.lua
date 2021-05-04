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

--[[
local depends_satisfied = true

local depends = {
	'gems_encrustable',
	'gems_tools',
}

for I in pairs(depends) do
	if not core.get_modpath(depends[I]) then
		depends_satisfied = false
	end
end
]]

local function itemsAreRegistered(items)
	for _, iname in pairs(items) do
		if not core.registered_items[iname] then
			return false, iname
		end
	end

	return true
end

local i = {
	topaz = "gems_encrustable:topaz",
	emerald = "gems_tools:emerald_gem",
}

if itemsAreRegistered(i) then
	antum.overrideCraftOutput({
		output = "simple_protection:claim",
		recipe = {
			{"", "", i.topaz},
			{"", i.emerald, ""},
			{i.emerald, "", ""},
		},
	})
end
