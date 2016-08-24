
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

-- Define function to add a colored trampoline
addColoredTrampNode = function(color, bounce)
	local bounce = default_bounce * bounce
	
	minetest.register_node("trampoline:trampoline_" .. color, {
		description = color:gsub("^%l", string.upper) .. " Trampoline",
		drawtype = "nodebox",
		node_box = trampolinebox,
		selection_box = trampolinebox,
		paramtype = "light",
		tiles = {
			"top.png",
			"bottom.png",
			"sides.png^sides_overlay_" .. color .. ".png"
		},
		groups = {dig_immediate=2, bouncy=bounce, fall_damage_add_percent=-70},
	})
	
	minetest.register_alias(color .. "_trampoline", "trampoline:trampoline_" .. color)
end

-- Define function to add a colored trampoline craft recipe
addColoredTrampCraft = function(color)
	minetest.register_craft({
		output = "trampoline:trampoline_" .. color,
		recipe = {
			{"technic:rubber", "technic:rubber", "technic:rubber"},
			{"coloredwood:wood_" .. color, "coloredwood:wood_" .. color, "coloredwood:wood_" .. color},
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
	tiles = {
		"top.png",
		"bottom.png",
		"sides.png^sides_overlay.png"
	},
	groups = {dig_immediate=2, bouncy=20+20, fall_damage_add_percent=-70},
})

minetest.register_alias("trampoline", "trampoline:trampoline")

minetest.register_craft({
	output = "trampoline:trampoline",
	recipe = {
		{"technic:rubber", "technic:rubber", "technic:rubber"},
		{"default:wood", "default:wood", "default:wood"},
		{"default:stick", "default:stick", "default:stick"}
	}
})


-- *** Colored Trampolines ***

-- BROWN TRAMP

minetest.register_node("trampoline:trampoline_brown", {
	description = "Brown Trampoline",
	drawtype = "nodebox",
	node_box = trampolinebox,
	selection_box = trampolinebox,
	paramtype = "light",
	tiles = {
		"top.png",
		"bottom.png",
		"sides.png^sides_overlay_brown.png"
	},
	groups = {dig_immediate=2, bouncy=20+20, fall_damage_add_percent=-70},
})

minetest.register_alias("brown_trampoline", "trampoline:trampoline_brown")

minetest.register_craft({
	output = "trampoline:trampoline_brown",
	recipe = {
		{"technic:rubber", "technic:rubber", "technic:rubber"},
		{"default:junglewood", "default:junglewood", "default:junglewood"},
		{"default:stick", "default:stick", "default:stick"}
	}
})


if minetest.get_modpath("coloredwood") ~= nil then
	local color_count = 0
	local tramp_colors = {"blue", "green", "red", "violet", "yellow"}
	
	-- Get the number of tramp colors available
	for _ in pairs(tramp_colors) do
		color_count = color_count + 1
	end
	
	-- Add all available trampoline colors
	for i = 1, color_count do
		addColoredTrampNode(tramp_colors[i], i+1)
		
		addColoredTrampCraft(tramp_colors[i])
		
		logMessage("Registered '" .. tramp_colors[i]:gsub("^%l", string.upper) .. " trampoline'")
	end
end


core.log("action", "[MOD] '" .. modname .. "' loaded")
