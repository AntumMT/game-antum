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


-- Nyan cat blocks
antum.registerCraft({
	output = "default:nyancat_rainbow",
	recipe = {
		{'', 'dye:red', '',},
		{'dye:violet', 'group:wood', 'dye:yellow',},
		{'', 'dye:blue', '',},
	}
})


-- Walking light items
antum.registerCraft({
	output = 'walking_light:helmet_gold',
	recipe = {
		{'default:torch'},
		{'3d_armor:helmet_gold'},
	}
})


local glowlight = {
	cube = "homedecor:glowlight_small_cube_14",
	quarter = "homedecor:glowlight_quarter_14",
	half = "homedecor:glowlight_half_14",
	glass = "moreblocks:super_glow_glass",
}

if core.registered_items[glowlight.glass] then
	if core.registered_items[glowlight.cube] then
		core.register_craft({
			type = "shapeless",
			output = glowlight.cube .. " 4",
			recipe = {glowlight.glass},
		})
	end

	if core.registered_items[glowlight.quarter] then
		core.register_craft({
			output = glowlight.quarter,
			recipe = {
				{glowlight.glass, glowlight.glass},
			},
		})
	end

	if core.registered_items[glowlight.half] then
		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.glass, glowlight.glass},
				{glowlight.glass, glowlight.glass},
			},
		})

		core.register_craft({
			output = glowlight.half,
			recipe = {
				{glowlight.quarter},
				{glowlight.quarter},
			},
		})
	end
end
