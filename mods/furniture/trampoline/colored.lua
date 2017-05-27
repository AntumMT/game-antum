-- Colored trampolines (requires 'coloredwood' mod)


local tramp_colors = {'blue', 'green', 'red', 'violet', 'yellow'}

-- Add all available trampoline colors
for I in pairs(tramp_colors) do
	-- These colored tramps bounce higher than brown tramp
	trampoline.addColoredTrampNode(tramp_colors[I], trampoline.bounce * trampoline.multi_colors)
	trampoline.addColoredTrampCraft(tramp_colors[I])
	trampoline.log('Registered \'' .. tramp_colors[I]:gsub('^%l', string.upper) .. ' trampoline\'')
end
