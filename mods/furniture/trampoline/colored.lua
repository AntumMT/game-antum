-- Colored trampolines (requires 'coloredwood' mod)


local color_count = 0
local tramp_colors = {"blue", "green", "red", "violet", "yellow"}

-- Get the number of tramp colors available
for _ in pairs(tramp_colors) do
	color_count = color_count + 1
end

-- Add all available trampoline colors
for i = 1, color_count do
	trampoline.addColoredTrampNode(tramp_colors[i], i+1)
	
	trampoline.addColoredTrampCraft(tramp_colors[i])
	
	trampoline.log("Registered '" .. tramp_colors[i]:gsub("^%l", string.upper) .. " trampoline'")
end
