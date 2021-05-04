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


local function replace_item(old, new)
	if core.registered_items[old] and core.registered_items[new] then
		core.log("action", "Replacing " .. old .. " with " .. new)
		core.unregister_item(old)
		core.register_alias(old, new)
	end
end

replace_item("creatures:flesh", "mobs:meat_raw")
replace_item("creatures:meat", "mobs:meat")
replace_item("creatures:chicken_flesh", "mobs:chicken_raw")
replace_item("creatures:chicken_meat", "mobs:chicken_cooked")
replace_item("creatures:egg", "mobs:egg")
replace_item("creatures:fried_egg", "mobs:chicken_egg_fried")
replace_item("creatures:shears", "mobs:shears")
