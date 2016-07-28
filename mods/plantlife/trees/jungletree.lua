local function add_tree_branch(pos)
  local leaves = {"green","yellow","red"}
  local leave = "trees:leaves_"..leaves[math.random(1,3)]
  minetest.env:add_node(pos, {name="default:jungletree"})
  --height
  
  local height = 2 + math.random(3)
  
  for y = height , 0, -1 do
    if y <= 0 then return end
    for x = y, -y, -1 do
      for z = y, -y, -1  do
        if math.abs(x)+math.abs(z) <= 4 then 
          local p = {x=pos.x+x, y=pos.y+height-1-y, z=pos.z+z}
          local n = minetest.env:get_node(p)
          if (n.name=="air") then
            minetest.env:add_node(p, {name=leave})
          elseif (n.name=="ignore") then
            minetest.after(20, function()
              minetest.env:add_node(p, {name=leave})
            end)
          end
        end
      end
    end
  end
end

abstract_trees.grow_jungletree = function(pos)
  minetest.after(5, function()
  local size =  5+math.random(15)
  if size < 10 then
    for i = size, -2, -1 do
      local p = {x=pos.x, y=pos.y+i, z=pos.z}
      minetest.env:add_node(p, {name="default:jungletree"})
      if i == size then
        add_tree_branch({x=pos.x, y=pos.y+size+math.random(0, 1), z=pos.z})
        add_tree_branch({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
        add_tree_branch({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
        add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
        add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
      end
      if i < 0 then
        minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="default:jungletree"})
      end
      if (math.sin(i/size*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
        branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
        add_tree_branch(branch_pos)
      end
    end
  else
    for i = size, -1, -1 do
      if (math.sin(i/size*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
        branch_pos = {x=pos.x-1+math.random(0,2), y=pos.y+i, z=pos.z-1-math.random(0,2)}
        add_tree_branch(branch_pos)
      end
      if i < math.random(2) then
        add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+1})
        add_tree_branch({x=pos.x+2, y=pos.y+i, z=pos.z-1})
        add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-2})
        add_tree_branch({x=pos.x-1, y=pos.y+i, z=pos.z})
      end
      if i == size then
        add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+1})
        add_tree_branch({x=pos.x+2, y=pos.y+i, z=pos.z-1})
        add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-2})
        add_tree_branch({x=pos.x-1, y=pos.y+i, z=pos.z})
        add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+2})
        add_tree_branch({x=pos.x+3, y=pos.y+i, z=pos.z-1})
        add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-3})
        add_tree_branch({x=pos.x-2, y=pos.y+i, z=pos.z})
        add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z})
        add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z-1})
        add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-1})
        add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z})
      else
        minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="default:jungletree"})
        minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="default:jungletree"})
      end
    end
  end
  end)
end

--nodes
local leaves = {"green","yellow","red"}
for color = 1, 3 do
  local leave_name = "trees:leaves_"..leaves[color]
  minetest.register_node(leave_name, {
    description = "Jungle Tree Leaves",
    drawtype = "allfaces_optional",
    tiles = {"trees_leaves_"..leaves[color]..".png"},
    paramtype = "light",
    groups = {snappy=3, leafdecay=3, flammable=2},
    drop = {
      max_items = 1,
      items = {
        {items = {'trees:jungletree_sapling'},rarity = 20},
      }
    },
    sounds = default.node_sound_leaves_defaults(),
  })
end

minetest.register_node("trees:jungletree_sapling", {
  description = "Jungle Tree Sapling",
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
  nodenames = {"trees:jungletree_sapling"},
  interval = 300,
  chance = 20,
  action = function(pos, node)
    abstract_trees.grow_jungletree(pos)
  end,
})

--spawn
biome_lib:register_generate_plant({
    surface = "default:dirt_with_grass",
    max_count = 30,
    avoid_nodes = {"group:tree"},
    avoid_radius = 2,
    rarity = 40,
    seed_diff = 112,
    min_elevation = -1,
    max_elevation = 40,
    plantlife_limit = -0.6,
    humidity_max = -0.9,
    humidity_min = 0.4,
    temp_max = -0.9,
    temp_min = -0.3,
  },
  "abstract_trees.grow_jungletree"
)
