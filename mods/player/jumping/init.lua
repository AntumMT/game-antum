
local modname = "jumping"

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

local cushionbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5,  0.5, -0.3,  0.5},
		}
}

local trampoline_punch = function(pos, node)
--	local id = string.sub(node.name, #node.name)
--	id = id + 1
--	if id == 7 then id = 1 end
	minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)})
end



local default_bounce = 20

addColoredTrampNode = function(color, bounce)
	local bounce = default_bounce * bounce
	
	minetest.register_node("jumping:trampoline_" .. color, {
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
		output = "jumping:trampoline_" .. color,
		recipe = {
			{"default:leaves", "default:leaves", "default:leaves"},
			{"my_door_wood:wood_" .. color, "my_door_wood:wood_" .. color, "my_door_wood:wood_" .. color},
			{"default:stick", "default:stick", "default:stick"}
		}
	})
end



minetest.register_node("jumping:trampoline", {
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
	output = "jumping:trampoline",
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

--[[

for i = 1, 6 do
	minetest.register_node("jumping:trampoline_"..trampoline_colors[i], {
		description = "Trampoline",
		drawtype = "nodebox",
		node_box = trampolinebox,
		selection_box = trampolinebox,
		paramtype = "light",
		on_punch = trampoline_punch,
		tiles = {
			"jumping_trampoline_top.png",
			"jumping_trampoline_bottom.png",
			"jumping_trampoline_sides.png^jumping_trampoline_sides_overlay"..i..".png"
		},
		groups = {dig_immediate=2, bouncy=20+i*20, fall_damage_add_percent=-70},
	})
end
--]]

--[[
for i = 1, 6 do
	tcolor = trampoline_colors[i]
	twood = "my_door_wood:wood_" .. tcolor
	minetest.register_craft({
		output = "jumping:trampoline_" .. tcolor,
		recipe = {
			{twood, twood, twood},
			{"default:leaves", "default:leaves", "default:leaves"},
			{"default:stick", "default:stick", "default:stick"}
		}
	})
end
tcolor = nil
twood = nil
--]]

minetest.register_node("jumping:cushion", {
	description = "Cushion",
	drawtype = "nodebox",
	node_box = cushionbox,
	selection_box = cushionbox,
	paramtype = "light",
	tiles = {
		"jumping_cushion_tb.png",
		"jumping_cushion_tb.png",
		"jumping_cushion_sides.png"
	},
	groups = {dig_immediate=2, disable_jump=1, fall_damage_add_percent=-100},
})

minetest.register_craft({
	output = "jumping:cushion",
	recipe = {
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:leaves", "default:leaves", "default:leaves"},
		{"default:stick", "default:stick", "default:stick"}
	}
})


core.log("action", "[MOD] 'jumping' loaded")
