
local S = minetest.get_translator("castle_masonry")

-------------------------------------------------------------------------------------

castle_masonry.register_murderhole = function(material)
	local composition_def, burn_time, tile, desc = castle_masonry.get_material_properties(material)
	local mod_name = minetest.get_current_modname()
	
	-- Node Definition
	minetest.register_node(mod_name..":hole_"..material.name, {
		drawtype = "nodebox",
		description = S("@1 Murder Hole", desc),
		tiles = tile,
		groups = composition_def.groups,
		_mcl_hardness = composition_def._mcl_hardness or 0.8,
		_mcl_blast_resistance = composition_def._mcl_blast_resistance or 1,
		_mcl_stonecutter_recipes = {material.composition_material or material.craft_material},
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-8/16,-8/16,-8/16,-4/16,8/16,8/16},
				{4/16,-8/16,-8/16,8/16,8/16,8/16},
				{-4/16,-8/16,-8/16,4/16,8/16,-4/16},
				{-4/16,-8/16,8/16,4/16,8/16,4/16},
			},
		},
	})
	
	minetest.register_node(mod_name..":machicolation_"..material.name, {
		drawtype = "nodebox",
		description = S("@1 Machicolation", desc),
		tiles = tile,
		groups = composition_def.groups,
		_mcl_hardness = composition_def._mcl_hardness or 0.8,
		_mcl_blast_resistance = composition_def._mcl_blast_resistance or 1,
		_mcl_stonecutter_recipes = {material.composition_material or material.craft_material},
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0},
				{-0.5, -0.5, 0, -0.25, 0.5, 0.5},
				{0.25, -0.5, 0, 0.5, 0.5, 0.5},
			},
		},
	})

	minetest.register_craft({
		output = mod_name..":hole_"..material.name.." 4",
		recipe = {
			{"",material.craft_material, "" },
			{material.craft_material,"", material.craft_material},
			{"",material.craft_material, ""}
		},
	})

	minetest.register_craft({
		output = mod_name..":machicolation_"..material.name,
		type="shapeless",
		recipe = {mod_name..":hole_"..material.name},
	})
	minetest.register_craft({
		output = mod_name..":hole_"..material.name,
		type="shapeless",
		recipe = {mod_name..":machicolation_"..material.name},
	})
	
	if burn_time > 0 then
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":hole_"..material.name,
			burntime = burn_time,
		})
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":machicolation_"..material.name,
			burntime = burn_time,
		})	
	end
end

castle_masonry.register_murderhole_alias = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias(old_mod_name..":hole_"..old_material_name,			new_mod_name..":hole_"..new_material_name)
	minetest.register_alias(old_mod_name..":machicolation_"..old_material_name,	new_mod_name..":machicolation_"..new_material_name)
end

castle_masonry.register_murderhole_alias_force = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias_force(old_mod_name..":hole_"..old_material_name,			new_mod_name..":hole_"..new_material_name)
	minetest.register_alias_force(old_mod_name..":machicolation_"..old_material_name,	new_mod_name..":machicolation_"..new_material_name)
end
