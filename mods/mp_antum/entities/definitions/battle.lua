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


-- Battle defines hp, knockback level, ....
antum.def.battle = {}


-- HP defines how durable the entity is when attacked
antum.def.battle.sturdy = {
	hp = 40,
	knockback = 0,
}

antum.def.battle.strong = {
	hp = 40,
	knockback = 1,
}

antum.def.battle.average = {
	hp = 20,
	knockback = 2,
}

antum.def.battle.weak = {
	hp = 10,
	knockback = 4,
}

-- TESTING
antum.def.battle.creeper = {
	hp = 20,
	physical = true,
	knockback = 2,
}
