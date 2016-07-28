function add_section(pos,size)
  local leave = "trees:leaves_conifer"
  minetest.env:add_node(pos, {name="trees:tree_conifer"})
  for y = size , 0, -1 do
    if y <= 0 then return end
    for x = y, -y, -1 do
      for z = y, -y, -1  do
        if math.abs(x)+math.abs(z) <= size then 
          local p = {x=pos.x+x, y=pos.y+size-1-y, z=pos.z+z}
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

abstract_trees.grow_conifertree = function(pos)
  minetest.after(5, function()
  local size = 5+math.random(10)
  local inter = size/7
  local walk = 2
  minetest.env:add_node({x=pos.x, y=pos.y+size, z=pos.z}, {name="trees:leaves_conifer"})
  for i=1,size,1 do
    if walk < inter then 
      minetest.env:add_node({x=pos.x, y=pos.y+size-i, z=pos.z}, {name="trees:tree_conifer"})
      walk = walk + 1
    else
      
      if i > size*0.9 then
        minetest.env:add_node({x=pos.x, y=pos.y+size-i, z=pos.z}, {name="trees:tree_conifer"})
      else
        add_section({x=pos.x, y=pos.y+size-i, z=pos.z},math.ceil(inter))
      end
      walk = 1
      inter = inter + (i/size)*3
    end
  end
  end)
end


-- abm
minetest.register_abm({
  nodenames = "trees:sapling_conifer",
  interval = 1000,
  chance = 4,
  action = function(pos, node, _, _)
    if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
      abstract_trees.grow_conifertree({x = pos.x, y = pos.y, z = pos.z})
      end
    end
})
--spawn
biome_lib:register_generate_plant({
    surface = {"default:dirt", "default:dirt_with_grass", "snow:dirt_with_snow"},
    max_count = 10,
    avoid_nodes = {"group:tree"},
    avoid_radius = 2,
    rarity = 50,
    seed_diff = 777,
    min_elevation = 10,
    max_elevation = 200,
    plantlife_limit = -0.9,
    humidity_max = -0.7,
    humidity_min = 0.4,
    temp_max = -0.2,
    temp_min = 0.4,
  },
  "abstract_trees.grow_conifertree"
)
