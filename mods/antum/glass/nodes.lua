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


local function registerGroupAliases(group)
	for I in pairs(group) do
		local source = group[I][1]
		local alias = group[I][2]
		-- DEBUG
		antum.logAction('Registering alias: ' .. alias .. ' -> ' .. source)
		core.register_alias(alias, source)
	end
end


local group_glass = {} -- Local glass is already in this group
local group_panes = {}

local function appendGroupGlass(source, suffix)
	local suffix = 'glass:' .. suffix
	table.insert(group_glass, -1, {source, suffix})
end

local function appendGroupPanes(source, suffix)
	local suffix = 'glass_panes:' .. suffix
	table.insert(group_panes, -1, {source, suffix})
end


for I in pairs(antum.glass.colors) do
	local color = antum.glass.colors[I]
	
	core.register_node(':glass:' .. color, {
		description = color:gsub('^%l', string.upper) .. ' Glass',
		drawtype = 'glasslike_framed_optional',
		tiles = {'glass_' .. color .. '.png', 'glass_' .. color .. '_detail.png'},
		paramtype = 'light',
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {cracky = 3, oddly_breakable_by_hand = 3},
		sounds = default.node_sound_glass_defaults(),
	})
end

-- Local glass is already part of 'glass' group
for I in pairs(antum.glass.colors) do
	--table.insert(group_panes, -1, {'glass:' .. antum.glass.colors[I], 'glass_panes:' .. antum.glass.colors[I]})
	local source = 'glass:' .. antum.glass.colors[I]
	local suffix = antum.glass.colors[I]
	appendGroupPanes(source, suffix)
end

if core.get_modpath('default') then
	local source = 'default:glass'
	local suffix = 'glass'
	appendGroupGlass(source, suffix)
	appendGroupPanes(source, suffix)
end

if core.get_modpath('moreblocks') then
	local panes = {
		'clean', 'coal', 'glow', 'iron', 'super_glow',
		'trap', 'trap_glow', 'trap_super_glow',
	}
	
	for I in pairs(panes) do
		local source = 'moreblocks:' .. panes[I] .. '_glass'
		local suffix = panes[I]
		
		appendGroupGlass(source, suffix)
		appendGroupPanes(source, suffix)
	end
	
--[[	-- Clean glass
	local source = 'moreblocks:clean_glass
	table.insert(group_glass, -1, {'moreblocks:clean_glass', 'glass:clean'})
	table.insert(group_panes, -1, {'moreblocks:clean_glass', 'glass_panes:clean'})
	
	-- Coal glass
	table.insert(group_glass, -1, {'moreblocks:coal_glass', 'glass:coal'})
	table.insert(group_panes, -1, {'moreblocks:coal_glass', 'glass_panes:coal'})
	
	-- Glow glass
	table.insert(group_glass, -1, {'moreblocks:glow_glass', 'glass:glow'})
	table.insert(group_panes, -1, {'moreblocks:glow_glass', 'glass_panes:glow'})
	
	-- Iron glass
	table.insert(group_glass, -1, {'moreblocks:iron_glass', 'glass:iron'})
	table.insert(group_panes, -1, {'moreblocks:iron_glass', 'glass_panes:iron'})
	
	-- Super glow glass
	table.insert(group_glass, -1, {'moreblocks:super_glow_glass', 'glass:super_glow'})
	table.insert(group_panes, -1, {'moreblocks:super_glow_glass', 'glass_panes:super_glow'})
	
	-- Trap glass
	table.insert(group_glass, -1, {'moreblocks:trap_glass', 'glass:trap'})
	table.insert(group_panes, -1, {'moreblocks:trap_glass', 'glass_panes:trap'})
	
	-- Trap glow glass
	table.insert(group_glass, -1, {'moreblocks:trap_glow_glass', 'glass:trap_glow'})
	table.insert(group_panes, -1, {'moreblocks:trap_glow_glass', 'glass_panes:trap_glow'})
	
	-- Trap super glow glass
	table.insert(group_glass, -1, {'moreblocks:trap_super_glow_glass', 'glass:trap_super_glow'})
	table.insert(group_panes, -1, {'moreblocks:trap_super_glow_glass', 'glass_panes:trap_super_glow'})
	--]]
end

registerGroupAliases(group_glass)
registerGroupAliases(group_panes)
