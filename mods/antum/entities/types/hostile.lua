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


function antum.createHostileEntity(name, def)
	-- def must have visual, battle,
	local visual_def = def.visual
	local movement_def = def.movement
	local battle_def = def.battle
	
	local def = {
		--physical = , -- FIXME
		collisionbox = visual_def.collisionbox,
		visual = visual_def.type,
		makes_footstep_sound = behavior_def.footsteps,
		animation = visual_def.anim,
		animation_speed = visual_def.anim_speed,
		walk_speed = behavior_def.speed,
		jump_height = behavior_def.jump,
		
		-- Battle definitions
		hp_max = battle_def.hp,
		knockback_level = battle_def.knockback,
		
		--local function on_activate = ,
	}
end

-- Creates an entity using mesh visuals
function antum.createHostileEntityMesh(name, def)
	
end
