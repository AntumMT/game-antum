-- Functions for trampoline mod


trampoline.bounce = 20
-- Bounce multipliers
trampoline.multi = 5
trampoline.multi_high = 6
trampoline.multi_higher = 7

-- trampoline shape
local box = {
	type = "fixed",
	fixed = {
		{-0.5, -0.2, -0.5,  0.5,    0,  0.5},

		{-0.5, -0.5, -0.5, -0.4, -0.2, -0.4},
		{ 0.4, -0.5, -0.5,  0.5, -0.2, -0.4},
		{ 0.4, -0.5,  0.4,  0.5, -0.2,  0.5},
		{-0.5, -0.5,  0.4, -0.4, -0.2,  0.5},
	}
}


--- Register a new trampoline.
--
--  Definition attributes:
--  - `description`: Text description
--  - `overlay`: Image to overlay on the sides of tramp
--  - `bounce_rate`: How "bouncy" the tramp is
--
--  @function trampoline.register_tramp
--  @param name
--  @param def
function trampoline.register_tramp(name, def)
	local new_def = {
		description = def.description,
		drawtype = "nodebox",
		node_box = box,
		selection_box = box,
		paramtype = "light",
		tiles = {
			"top.png",
			"bottom.png",
			"sides.png^" .. def.overlay,
		},
		groups = {
			dig_immediate = 2,
			bouncy = def.bounce_rate,
			fall_damage_add_percent = -trampoline.damage_absorb,
		},
		sounds = {
			footstep = "trampoline_boing",
		},
	}

	if core.global_exists("unifieddyes") then
		new_def.paramtype2 = "color"
		new_def.palette = "unifieddyes_palette_extended.png"
		new_def.groups.ud_param2_colorable = 1
		new_def.on_dig = unifieddyes.on_dig
	end

	core.register_node("trampoline:" .. name, new_def)
end
