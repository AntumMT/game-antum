
trampoline = {}
trampoline.modname = minetest.get_current_modname()
trampoline.modpath = minetest.get_modpath(trampoline.modname)
trampoline.bounce = 20

-- Bounce multipliers
trampoline.multi = 5
trampoline.multi_brown = 6
trampoline.multi_colors = 7


minetest.log('action', '[MOD] Loading \'' .. trampoline.modname .. '\' ...')


--- Percent of damage absorbed when falling on tramp.
--
-- min 0 (full damage)
-- max 100 (no damage)
trampoline.damage_absorb = core.settings:get('trampoline.damage_absorb')
if trampoline.damage_absorb == nil then
	-- Defaults to no damage
	trampoline.damage_absorb = 100
else
	trampoline.damage_absorb = tonumber(trampoline.damage_absorb)
end


trampoline.box = {
	type = 'fixed',
	fixed = {
		{-0.5, -0.2, -0.5,  0.5,    0,  0.5},

		{-0.5, -0.5, -0.5, -0.4, -0.2, -0.4},
		{ 0.4, -0.5, -0.5,  0.5, -0.2, -0.4},
		{ 0.4, -0.5,  0.4,  0.5, -0.2,  0.5},
		{-0.5, -0.5,  0.4, -0.4, -0.2,  0.5},
		}
}


local scripts = {
	'functions',
	'nodes',
	'crafting',
	'aliases',
}

for I in pairs(scripts) do
	dofile(trampoline.modpath .. '/' .. scripts[I] .. '.lua')
end

-- Register other colored trampolines
if minetest.global_exists('coloredwood') then
	dofile(trampoline.modpath .. '/colored.lua')
end


minetest.log('action', '[MOD] \'' .. trampoline.modname .. '\' loaded')
