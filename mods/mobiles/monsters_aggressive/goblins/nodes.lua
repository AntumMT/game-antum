
minetest.register_node(":default:mossycobble", {
  description = "Mossy Cobblestone",
  tiles = {"default_mossycobble.png"},
  is_ground_content = false,
  groups = {cracky = 3, stone = 1},
  sounds = default.node_sound_stone_defaults({
    footstep = {name = "goblins_mossycobble_footstep", gain = 0.4},
  }),
  paramtype = "light",
  light_source = 0,
})

minetest.register_node("goblins:moss", {
  description = "Moss",
  inventory_image = "default_moss.png",
  tiles = {
		"default_moss.png^[colorize:#222222:150",
	},
  paramtype = "light",
  
	drawtype = "normal",
  walkable = true,
  buildable_to = true,
  is_ground_content = false,
  groups = {crumbly = 3,slippery = 2, falling_node = 1, },
  sounds = default.node_sound_dirt_defaults({
    footstep = {name = "goblins_mossycobble_footstep", gain = 0.4},
  }),
  
  light_source = 4,
  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    --print("node meta:"..dump(meta))
  end
})

minetest.register_node("goblins:mossx", {
  description = "Moss",
  inventory_image = "default_moss.png",
  tiles = {
		"default_moss.png^[colorize:#222222:150",
		"default_moss.png^[colorize:#222222:150",
		"default_moss.png^[colorize:#222222:150",
		"default_moss.png^[colorize:#222222:150",
		"default_moss.png^[colorize:#222222:150",
		"default_moss.png^[colorize:#222222:150",
	},
	paramtype2="wallmounted",
  paramtype = "light",
  
	drawtype = "nodebox",
	node_box = {
    type = "wallmounted",
    wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.45, 0.5}, -- bottom
    wall_top = {-0.5, 0.45, -0.5, 0.5, 0.5, 0.5}, -- top
    wall_side = {-0.45, -0.5, -0.5, -0.5, 0.5, 0.5} -- side

	},
  walkable = false,
  buildable_to = true,
  is_ground_content = false,
  groups = {crumbly = 3,slippery = 2, falling_node = 1, attached_node = 1},
  sounds = default.node_sound_dirt_defaults({
    footstep = {name = "goblins_mossycobble_footstep", gain = 0.4},
  }),
  
  light_source = 2,
  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    --print("node meta:"..dump(meta))
  end
})

minetest.register_node("goblins:mushroom_goblin", {
  description = "gobble mushroom",
  tiles = {"goblins_mushroom_brown.png^(default_grass_1.png^[opacity:150)"},
  inventory_image = "goblins_mushroom_brown.png",
  wield_image = "goblins_mushroom_brown.png",
  drawtype = "firelike",
  paramtype = "light",
  paramtype2="wallmounted",
  light_source = 2,
  sunlight_propagates = true,
  walkable = false,
  buildable_to = true,
  climbable = true,
  floodable = true,
  groups = {float = 1, mushroom = 1, food_mushroom = 1, snappy = 3, attached_node = 1, flammable = 1},
  sounds = default.node_sound_leaves_defaults(),
  on_use = minetest.item_eat(2),
  selection_box = {
    type = "fixed",
    fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
  }
})

minetest.register_node("goblins:mushroom_goblin2", {
  description = "gobble mushroom",
  tiles = {"goblins_mushroom_brown2.png^(default_grass_1.png^[opacity:150)"},
  inventory_image = "goblins_mushroom_brown2.png",
  wield_image = "goblins_mushroom_brown.png",
  drawtype = "firelike",
  paramtype = "light",
  paramtype2="wallmounted",
  light_source = 2,
  sunlight_propagates = true,
  walkable = false,
  buildable_to = true,
  climbable = true,
  floodable = true,
  groups = {float = 1, mushroom = 1, food_mushroom = 2, snappy = 3, attached_node = 1, flammable = 1},
  sounds = default.node_sound_leaves_defaults(),
  on_use = minetest.item_eat(2),
  selection_box = {
    type = "fixed",
    fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
  }
})

minetest.register_node("goblins:mushroom_goblin3", {
  description = "gobble mushroom",
  tiles = {"goblins_mushroom_brown3.png^(default_grass_1.png^[opacity:150)"},
  inventory_image = "goblins_mushroom_brown3.png",
  wield_image = "goblins_mushroom_brown.png",
  drawtype = "firelike",
  paramtype = "light",
  paramtype2="wallmounted",
  light_source = 2,
  sunlight_propagates = true,
  walkable = false,
  buildable_to = true,
  climbable = true,
  floodable = true,
  groups = {float = 1, mushroom = 1, food_mushroom = 3, snappy = 3, attached_node = 1, flammable = 1},
  sounds = default.node_sound_leaves_defaults(),
  on_use = minetest.item_eat(2),
  selection_box = {
    type = "fixed",
    fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
  }
})
minetest.register_node("goblins:mushroom_goblin4", {
  description = "gobble mushroom",
  tiles = {"goblins_mushroom_brown4.png^(default_grass_1.png^[opacity:150)"},
  inventory_image = "goblins_mushroom_brown4.png",
  wield_image = "goblins_mushroom_brown.png",
  drawtype = "firelike",
  paramtype = "light",
  paramtype2="wallmounted",
  light_source = 2,
  sunlight_propagates = true,
  walkable = false,
  buildable_to = true,
  climbable = true,
  floodable = true,
  groups = {float = 1, mushroom = 1, food_mushroom = 4, snappy = 3, attached_node = 1, flammable = 1},
  sounds = default.node_sound_leaves_defaults(),
  on_use = minetest.item_eat(2),
  selection_box = {
    type = "fixed",
    fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
  }
})

function goblins.moss_spread(pos, node)
  if minetest.get_node_light(pos, 0.5) > 6 then
    if minetest.get_node_light(pos, nil) == 15 then
      minetest.remove_node(pos)
    end
    return
  end
  --print("moss spread abm"..minetest.pos_to_string(pos))
  if math.random() < 0.1 then

    minetest.set_node(pos,{name = "goblins:mushroom_goblin"})
  else
    local positions = minetest.find_nodes_in_area_under_air(
      {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
      {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
      {"default:mossycobble","group:choppy"})
    
    if #positions == 0 or pos.y > -10 then
      return
    end
    local pos2 = positions[math.random(#positions)]
    pos2.y = pos2.y + 1
    if minetest.get_node_light(pos2, 0.5) <= 5 then
      minetest.set_node(pos2, {name = node.name})
    end
  end
end

function goblins.mushroom_spread(pos, node)
  if minetest.get_node_light(pos, 0.5) > 6 then
    if minetest.get_node_light(pos, nil) == 15 then
      minetest.remove_node(pos)
    end
    return
  end
  --print("mushroom spread abm"..minetest.pos_to_string(pos))
  local positions = minetest.find_nodes_in_area_under_air(
    {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
    {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
    {"default:mossycobble"})
  if #positions == 0 or pos.y > -10 then
    return
  end
  local pos2 = positions[math.random(#positions)]
  pos2.y = pos2.y + 1
  if minetest.get_node_light(pos2, 0.5) <= 5 then
    minetest.set_node(pos2, {name = node.name})
  end
end

minetest.register_abm({
  label = "Moss spread",
  nodenames = {"goblins:moss"},
  interval = 50,
  chance = 50,
  action = function(...)
    goblins.moss_spread(...)
  end,
})

minetest.register_abm({
  label = "Mushroom spread",
  nodenames = {"goblins:mushroom_goblin","goblins:mushroom_goblin2","goblins:mushroom_goblin3","goblins:mushroom_goblin4"},
  interval = 100,
  chance = 100,
  action = function(...)
    goblins.mushroom_spread(...)
  end,
})


minetest.register_node("goblins:goblins_goblin_bone", {
  description = "gnawed bone",
  tiles = {"goblins_goblin_bone.png"},
  inventory_image  = "goblins_goblin_bone.png",
  visual_scale = 0.7,
  drawtype = "plantlike",
  wield_image = "goblins_goblin_bone.png",
  paramtype = "light",
  walkable = false,
  is_ground_content = true,
  sunlight_propagates = true,
  selection_box = {
    type = "fixed",
    fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
  },
  groups = {bone = 1, meat = 1, snappy = 2, fleshy =1, dig_immediate = 3},
  after_place_node = function(pos, placer, itemstack)
    if placer:is_player() then
      minetest.set_node(pos, {name = "goblins:goblins_goblin_bone", param2 = 1})
    end
  end,
})

minetest.register_node("goblins:goblins_goblin_bone_meaty", {
  description = "meaty bone",
  tiles = {"goblins_goblin_bone_meaty.png"},
  inventory_image  = "goblins_goblin_bone_meaty.png",
  visual_scale = 0.7,
  drawtype = "plantlike",
  wield_image = "goblins_goblin_bone_meaty.png",
  paramtype = "light",
  walkable = false,
  is_ground_content = true,
  sunlight_propagates = true,
  selection_box = {
    type = "fixed",
    fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
  },
  groups = {meat = 1, snappy = 2, fleshy =3, dig_immediate = 3},
  after_place_node = function(pos, placer, itemstack)
    if placer:is_player() then
      minetest.set_node(pos, {name = "goblins:goblins_goblin_bone_meaty", param2 = 1})
    end
  end,
})
---from minetest default mod: nodes
minetest.register_node("goblins:dirt_with_bone", {
  description = "Dirt with something buried",
  tiles = {"default_dirt.png^default_stones.png",
    {name = "default_dirt.png^goblins_goblin_bone.png",
      tileable_vertical = false}},
  groups = {crumbly = 3, soil = 1,
  --not_in_creative_inventory = 1
  },
  drop = {
    max_items = 1, -- Only one set of item will be dropped.
    items = {
      {
        items = {"default:flint 1", "goblins:goblins_goblin_bone 2","default:stick"},
        rarity = 2, -- has 1 chance over 2 to be picked
      },
      {items = {"goblins:goblins_goblin_bone"}}
    }
  },
  sounds = default.node_sound_dirt_defaults({
    footstep = {name = "default_grass_footstep", gain = 0.25},
  }),
})

minetest.register_node("goblins:dirt_with_stuff", {
  description = "Dirt with something shiny buried",
  tiles = {"default_dirt.png^default_mineral_tin.png^default_stones.png",
    {name = "default_dirt.png^default_mineral_tin.png^goblins_goblin_bone.png",
      tileable_vertical = false}},
  groups = {crumbly = 3, soil = 1,
  --not_in_creative_inventory = 1
  },
  drop = {
    max_items = 2, -- Only one set of item will be dropped.
    items = {
      {
        items = {"default:pick_steel", "default:meselamp"},
        rarity = 16, -- has 1 chance over 16 to be picked
      },
      {items = {"goblins:goblins_goblin_bone","default:shovel_steel"}}
    }
  },
  sounds = default.node_sound_dirt_defaults({
    footstep = {name = "default_grass_footstep", gain = 0.25},
  }),
})
