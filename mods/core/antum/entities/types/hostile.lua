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


function antum.createHostileEntity(def)
	-- def must have name, visual, movement, battle,
	local name = def.name
	local vi = def.visual
	local mo = def.movement
	local ba = def.battle
	local tex = def.textures
	
	local def = {
		-- Visuals
		collisionbox = vi.collisionbox,
		visual = vi.visual,
		animation = vi.animation,
		animation_speed = vi.animation_speed,
		textures = tex,
		
		-- Movement
		makes_footstep_sound = mo.footsteps,
		walk_speed = mo.speed,
		jump_height = mo.jump,
		
		-- Battle definitions
		hp_max = ba.hp,
		physical = ba.physical,
		knockback_level = ba.knockback,
	}
	
	core.register_entity(name, def)
end

-- TESTING
--[[
local creeper = {
	name = ':antum:creeper',
	visual = antum.def.visual.creeper,
	movement = antum.def.movement.creeper,
	battle = antum.def.battle.creeper,
	textures = {'creeper.png'},
}

antum.createHostileEntity(creeper)--]]
