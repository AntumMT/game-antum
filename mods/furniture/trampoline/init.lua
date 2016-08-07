
local modname = "trampoline"

core.log("action", "[MOD] Loading '" .. modname .. "' ...")


logMessage = function(message)
	core.log("action", "[" .. modname .. "] " .. message)
end


local trampolinebox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.2, -0.5,  0.5,    0,  0.5},

		{-0.5, -0.5, -0.5, -0.4, -0.2, -0.4},
		{ 0.4, -0.5, -0.5,  0.5, -0.2, -0.4},
		{ 0.4, -0.5,  0.4,  0.5, -0.2,  0.5},
		{-0.5, -0.5,  0.4, -0.4, -0.2,  0.5},
		}
}


local default_bounce = 20

addColoredTrampNode = function(color, bounce)
	local bounce = default_bounce * bounce
	
	minetest.register_node("trampoline:trampoline_" .. color, {
		description = color:gsub("^%l", string.upper) .. " trampoline",
		drawtype = "nodebox",
		node_box = trampolinebox,
		selection_box = trampolinebox,
		paramtype = "light",
		on_punch = trampoline_punch,
		tiles = {
			"jumping_trampoline_top.png",
			"jumping_trampoline_bottom.png",
			"jumping_trampoline_sides.png^trampoline_sides_overlay_" .. color .. ".png"
		},
		groups = {dig_immediate=2, bouncy=bounce, fall_damage_add_percent=-70},
	})
end

addColoredTrampCraft = function(color)
	minetest.register_craft({
		output = "trampoline:trampoline_" .. color,
		recipe = {
			{"default:leaves", "default:leaves", "default:leaves"},
			{"my_door_wood:wood_" .. color, "my_door_wood:wood_" .. color, "my_door_wood:wood_" .. color},
			{"default:stick", "default:stick", "default:stick"}
		}
	})
end



minetest.register_node("trampoline:trampoline", {
	description = "Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	on_punch = trampoline_punch,
	tiles = {
		"jumping_trampoline_top.png",
		"jumping_trampoline_bottom.png",
		"jumping_trampoline_sides.png^jumping_trampoline_sides_overlay.png"
	},
	groups = {dig_immediate=2, bouncy=20+20, fall_damage_add_percent=-70},
})

minetest.register_craft({
	output = "trampoline:trampoline",
	recipe = {
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:wood", "default:wood", "default:wood"},
		{"default:stick", "default:stick", "default:stick"}
	}
})


-- *** Colored Trampolines ***

if minetest.get_modpath("my_door_wood") ~= nil then
	local color_count = 0
	local mydoor_colors = {"red", "brown"}
	
	-- Get the number of tramp colors available
	for _ in pairs(mydoor_colors) do
		color_count = color_count + 1
	end
	
	-- Add all available trampoline colors
	for i = 1, color_count do
		addColoredTrampNode(mydoor_colors[i], i+1)
		
		addColoredTrampCraft(mydoor_colors[i])
		
		logMessage("Registered '" .. mydoor_colors[i]:gsub("^%l", string.upper) .. " trampoline'")
	end
end


core.log("action", "[MOD] '" .. modname .. "' loaded")
