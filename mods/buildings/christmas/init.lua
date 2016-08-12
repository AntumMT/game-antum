-- Crafting
minetest.register_craft({
	output = '"christmas:ligs" 5',
	recipe = {
		{"christmas:slig"},
		{"christmas:slig"},
		{"christmas:slig"},
	}
})
minetest.register_craft({
	output = '"christmas:stoc" 5',
	recipe = {
		{"christmas:orn"},
		{"christmas:slig"},
		{"christmas:slig"},
	}
})
minetest.register_craft({
	output = '"christmas:gar" 5',
	recipe = {
		{"default:leaves"},
		{"default:leaves"},
		}
})
minetest.register_craft({
	output = '"christmas:slig" 4',
	recipe = {
		{"default:coal_lump"},
		{"default:leaves"},
	}
})
minetest.register_craft({
	output = '"christmas:orn" 10',
	recipe = {
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:glass", "default:cactus", "default:glass"},
	        {"default:glass", "default:glass", "default:glass"},
        }

})
minetest.register_craft({
	output = '"christmas:tee" 4',
	recipe = {
		{"default:mese"},
		{"wool:white"},
	}
})
minetest.register_craft({
	output = '"christmas:rwool" 4',
	recipe = {
		{"default:leaves"},
		{"wool:white"},
	}
})

minetest.register_craft({
	output = '"christmas:bwool" 4',
	recipe = {
		{"default:cactus"},
		{"wool:white"},
	}
})
minetest.register_craft({
	output = '"christmas:t" 4',
	recipe = {
		{"christmas:orn"},
		{"default:leaves"},
	}
})
minetest.register_craft({
	output = '"christmas:star" 1',
	recipe = {
		{"default:mese", "default:mese", "default:mese"},
		{"default:mese", "default:mese", "default:mese"},
		{"default:mese", "default:mese", "default:mese"},
	}
})
minetest.register_craft({
	output = '"christmas:fire" 1',
	recipe = {
		{"default:gravel", "default:leaves", "default:gravel"},
		}
})
-- Blocks

minetest.register_node("christmas:wool", {
	tiles = {"christmas_wo.png"},
	inventory_image = minetest.inventorycube("christmas_wo.png"),
	is_ground_content = true,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:rwool", {
	tiles = {"christmas_rwool.png"},
	inventory_image = minetest.inventorycube("christmas_rwool.png"),
	is_ground_content = true,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:bwool", {
	tiles = {"christmas_bwool.png"},
	inventory_image = minetest.inventorycube("christmas_bwool.png"),
	is_ground_content = true,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:t", {
	tiles = {"christmas_t.png"},
	inventory_image = minetest.inventorycube("christmas_t.png"),
	is_ground_content = true,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:tee", {
	tiles = {"christmas_tee.png"},
	inventory_image = minetest.inventorycube("christmas_tee.png"),
	is_ground_content = true,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:ligs", {
	drawtype = "signlike",
	tiles = {"christmas_lig.png"},
	inventory_image = "christmas_lig.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 20,
        is_ground_content = true,
	walkable = false,
	climbable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:stoc", {
	drawtype = "signlike",
	tiles = {"christmas_stoc.png"},
	inventory_image = "christmas_stoc.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 0,
        is_ground_content = true,
	walkable = false,
	climbable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:gar", {
	drawtype = "signlike",
	tiles = {"christmas_garr.png"},
	inventory_image = "christmas_garr.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 0,
        is_ground_content = true,
	walkable = false,
	climbable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
})

minetest.register_node("christmas:slig", {
	drawtype = "torchlike",
	tiles = {"christmas_slig.png", "christmas_slig.png", "christmas_slig.png"},
	inventory_image = "christmas_slig.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 10,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
	furnace_burntime = 4,
})

minetest.register_node("christmas:star", {
	drawtype = "torchlike",
	tiles = {"christmas_star.png", "christmas_star.png", "christmas_star.png"},
	inventory_image = "christmas_star.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 40,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
	furnace_burntime = 4,
})

minetest.register_node("christmas:fire", {
	drawtype = "torchlike",
	tiles = {"christmas_fire.png", "christmas_fire.png", "christmas_fire.png"},
	inventory_image = "christmas_fire.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	paramtype2 = "wallmounted",
	light_source = 30,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=2},
	furnace_burntime = 4,
})

minetest.register_node("christmas:orn", {
	drawtype = "torchlike",
	tiles = {"christmas_orn.png", "christmas_orn.png", "christmas_orn.png"},
	inventory_image = "christmas_orn.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 0,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	legacy_wallmounted = true,
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
	end,
	groups = {choppy=2,dig_immediate=2},
	furnace_burntime = 4,
})
--		end
--		return false
--	end,
--
