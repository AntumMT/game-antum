fort_spikes = {
  wood_durability_index = 0.4,
  iron_durability_index = 0.9
}

-- add damage to any object.
fort_spikes.do_damage = function(obj, durability_index)
  if obj == nil then return end

  if obj:is_player() or (obj:get_luaentity() ~= nil and obj:get_luaentity().name ~= "__builtin:item") then
    obj:punch(obj, 1.0, {full_punch_interval = 1.0, damage_groups = {fleshy=5}}, nil)
    if durability_index ~= nil and fort_spikes.is_broken(durability_index) then
      return 1
    end
  end
  return 0
end

-- check nodes below/above to forbid construct spikes in two vertical rows.
fort_spikes.is_allowed_position = function(pos)
  local node = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
  if minetest.get_node_group(node.name, "spikes") > 0 then
    return false
  end
  node = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z})
  if minetest.get_node_group(node.name, "spikes") > 0 then
    return false
  end
  return true
end

-- ramdomly decide if spike is broken.
fort_spikes.is_broken = function(durability_index)
  if (durability_index < math.random()) then
    return true
  end
  return false
end

minetest.register_node("fort_spikes:wood_spikes", {
  description = "Wood spikes",
  drawtype = "plantlike",
  visual_scale = 1,
  tiles = {"fort_spikes_wood_spikes.png"},
  inventory_image = ("fort_spikes_wood_spikes.png"),
  paramtype = "light",
  walkable = false,
  drop = "default:stick 3",
  sunlight_propagates = true,
  groups = {spikes=1, flammable=2, choppy = 2, oddly_breakable_by_hand = 1},
  on_punch = function(pos, node, puncher, pointed_thing)
    fort_spikes.do_damage(puncher, nil)
  end,
  on_construct = function(pos)
    if fort_spikes.is_allowed_position(pos) == false then
      minetest.dig_node(pos)
    end
  end,
})

minetest.register_node("fort_spikes:broken_wood_spikes", {
  description = "Broken wood spikes",
  drawtype = "plantlike",
  visual_scale = 1,
  tiles = {"fort_spikes_broken_wood_spikes.png"},
  inventory_image = ("fort_spikes_broken_wood_spikes.png"),
  paramtype = "light",
  walkable = false,
  sunlight_propagates = true,
  drop = "default:stick 3",
  groups = {spikes=1, flammable=2, choppy = 2, oddly_breakable_by_hand = 1},
})

minetest.register_craft({
  output = 'fort_spikes:wood_spikes 3',
  recipe = {
    {'default:stick', '', 'default:stick'},
    {'', 'default:stick', ''},
    {'default:stick', '', 'default:stick'},
  },
  on_place = function(itemstack, placer, pointed_thing, param2)
    if (fort_spikes.is_spikes_below(pointed_thing)) then
      return
    end
  end,
})

minetest.register_node("fort_spikes:iron_spikes", {
  description = "Iron spikes",
  drawtype = "plantlike",
  visual_scale = 1,
  tiles = {"fort_spikes_iron_spikes.png"},
  inventory_image = ("fort_spikes_iron_spikes.png"),
  paramtype = "light",
  walkable = false,
  sunlight_propagates = true,
  drop = "default:steel_ingot 2",
  groups = {cracky=2, spikes=1},
  on_punch = function(pos, node, puncher, pointed_thing)
    fort_spikes.do_damage(puncher, nil)
  end,
  on_construct = function(pos)
    if fort_spikes.is_allowed_position(pos) == false then
      minetest.dig_node(pos)
    end
  end,
})

minetest.register_node("fort_spikes:broken_iron_spikes", {
  description = "Broken  spikes",
  drawtype = "plantlike",
  visual_scale = 1,
  tiles = {"fort_spikes_broken_iron_spikes.png"},
  inventory_image = ("fort_spikes_broken_iron_spikes.png"),
  paramtype = "light",
  walkable = false,
  sunlight_propagates = true,
  drop = "default:steel_ingot 2",
  groups = {cracky=2, spikes=1},
})

minetest.register_craft({
  output = 'fort_spikes:iron_spikes 3',
  recipe = {
    {'default:steel_ingot', '', 'default:steel_ingot'},
    {'', 'default:steel_ingot', ''},
    {'default:steel_ingot', '', 'default:steel_ingot'},
  },
  on_place = function(itemstack, placer, pointed_thing, param2)
    if (fort_spikes.is_spikes_below(pointed_thing)) then
      return
    end
  end,
})

minetest.register_abm(
  {nodenames = {"fort_spikes:wood_spikes"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
      local times_broken = 0
      local objs = minetest.get_objects_inside_radius(pos, 1)
      for k, obj in pairs(objs) do
        times_broken = times_broken + fort_spikes.do_damage(obj, fort_spikes.wood_durability_index)
      end
      if times_broken > 0 then
        minetest.remove_node(pos)
        minetest.place_node(pos, {name="fort_spikes:broken_wood_spikes"})
      end
    end,
  }
)

minetest.register_abm(
  {nodenames = {"fort_spikes:iron_spikes"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
      local times_broken = 0
      local objs = minetest.get_objects_inside_radius(pos, 1)
      for k, obj in pairs(objs) do
        times_broken = times_broken + fort_spikes.do_damage(obj, fort_spikes.iron_durability_index)
      end
      if times_broken > 0 then
        minetest.remove_node(pos)
        minetest.place_node(pos, {name="fort_spikes:broken_iron_spikes"})
      end
    end,
  }
)
