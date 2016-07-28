--function
local function add_leaves(pos, leave)
	local p = {x=pos.x, y=pos.y+1, z=pos.z}
	local n = minetest.env:get_node(p)
	if (n.name=="air") then
	  minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z}, {name="trees:tree_mangrove"})
	  minetest.env:add_node(p, {name="trees:leaves_mangrove"})
	end
	for x = 1, -1, -1 do
		for z = 1, -1, -1 do
			local p = {x=pos.x+x, y=pos.y, z=pos.z+z}
			local n = minetest.env:get_node(p)
			if (n.name=="air") then
				minetest.env:add_node(p, {name=leave})
			end
		end
	end
end

abstract_trees.grow_mangrovetree = function(pos)
  local size = 5+math.random(11)  
  local trunk_node = "trees:tree_mangrove"
  local leaves_node = "trees:leaves_mangrove"
  
  local top = {x=pos.x, y=pos.y+size, z=pos.z}
  
  add_leaves({x=top.x+math.ceil(math.random(3))-2, y=top.y, z=top.z+math.ceil(math.random(3))-2},leaves_node)
    add_leaves({x=top.x+math.ceil(math.random(3))-2, y=top.y, z=top.z+math.ceil(math.random(3))-2},leaves_node)
  
  for i=1, size, 1 do
    if math.ceil(math.random(2)) == 1 then
      local dir = {
        x=math.ceil(math.random(3))-2,
        y=math.ceil(math.random(3))-2,
        z=math.ceil(math.random(3))-2,
      }
      if i < size/2 then
        add_leaves({x=pos.x+dir.x, y=top.y-i, z=pos.z+dir.z},leaves_node)
      end
    end
    minetest.env:add_node({x=top.x, y=top.y-i, z=top.z}, {name=trunk_node})
  end
  minetest.env:add_node({x=pos.x-1, y=pos.y, z=pos.z}, {name=trunk_node})
  minetest.env:add_node({x=pos.x+1, y=pos.y, z=pos.z}, {name=trunk_node})
  minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z+1}, {name=trunk_node})
  minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z-1}, {name=trunk_node})
end
--nodes
name = "mangrove"
minetest.register_node("trees:leaves_"..name, {
  description = name.. " Leaves",
  drawtype = "allfaces_optional",
  tiles = {"trees_leaves_"..name..".png"},
  paramtype = "light",
  groups = {snappy=3, leafdecay=3, flammable=2},
  drop = {
	  max_items = 1,
	  items = {
		  {items = {'trees:sapling_'..name},rarity = 20},
	  }
  },
  sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("trees:tree_"..name, {
  description = name.. " Tree",
  tiles = {"trees_tree_top_"..name..".png", "trees_tree_top_"..name..".png", "trees_tree_"..name..".png"},
  groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
  sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'trees:wood_mangrove 4',
	recipe = {
		{'trees:tree_mangrove'},
	}
})

minetest.register_node("trees:sapling_mangrove", {
  description = "Mangrove Sapling",
  drawtype = "plantlike",
  visual_scale = 1.0,
  tiles = {"trees_jungletree_sapling.png"},
  inventory_image = "trees_jungletree_sapling.png",
  wield_image = "trees_jungletree_sapling.png",
  paramtype = "light",
  walkable = false,
  groups = {snappy=2,dig_immediate=3,flammable=2},
})
--abm
minetest.register_abm({
  nodenames = {"trees:sapling_mangrove"},
  interval = 300,
  chance = 20,
  action = function(pos, node)
    abstract_trees.grow_jungletree(pos)
  end,
})

minetest.register_abm({
  nodenames = "trees:sapling_mangrove",
  interval = 1000,
  chance = 4,
  action = function(pos, node, _, _)
    if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
      abstract_trees.grow_mangrovetree({x = pos.x, y = pos.y, z = pos.z})
      end
    end
})

--spawning
biome_lib:register_generate_plant({
    surface = "default:dirt",
    max_count = 30,
    near_nodes = {"default:water_source"},
    near_nodes_size = 1,
    near_nodes_vertical = 3,
    near_nodes_count = 6,
    avoid_nodes = {"group:tree", "default:sand"},
    avoid_radius = 3,
    rarity = 50,
    seed_diff = 666,
    min_elevation = -3,
    max_elevation = 2,
    plantlife_limit = -0.5,
    check_air = false,
    humidity_max = -1,
    humidity_min = 0.5,
    temp_max = -0.8,
    temp_min = 0,
  },
  "abstract_trees.grow_mangrovetree"
)

--abstract_trees.grow_mangrovetree(pointed_thing.above, height)
