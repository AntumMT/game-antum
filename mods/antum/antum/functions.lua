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


-- Displays a message in the log
function antum.log_action(mod, message)
	minetest.log('action', '[' .. mod .. '] ' .. message)
end


-- Checks if a file exists
function antum.file_exists(file_path)
	local fexists = io.open(file_path, 'r')
	
	if fexists == nil then
		minetest.log('error', '[' .. antum.modname .. '] Could not load script: ' .. file_path)
		return false
	end
	
	return true
end


-- Loads a mod sub-script
function antum.load_script(mod_path, script_name)
	local script = mod_path .. '/' .. script_name .. '.lua'
	
	if antum.file_exists(script) then
		dofile(script)
	end
end
