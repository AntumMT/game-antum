--more things to craft soon...
local craft_ingreds = {
  mossycobble = "default:mossycobble",
}

for name, mat in pairs(craft_ingreds) do
  minetest.register_craft({
    output = "goblins:pick_".. name,
    recipe = {
      {mat, mat, mat},
      {"", "group:stick", ""},
      {"", "group:stick", ""}
    }
  })
end
minetest.register_tool("goblins:pick_mossycobble", {
  description = "Mossycobble Pickaxe",
  inventory_image = "default_tool_stonepick.png",
  tool_capabilities = {
    full_punch_interval = 1.2,
    max_drop_level=0,
    groupcaps={
      cracky = {times={[2]=1.8, [3]=0.90}, uses=25, maxlevel=1},
    },
    damage_groups = {fleshy=3},
  },
  sound = {breaks = "default_tool_breaks"},
  groups = {pickaxe = 1}
})

local goblin_tool = {}
goblin_tool = {
  initial_properties = {
      --physical = true,
      pointable = false,
      collisionbox = {0,0,0,0,0,0},
      visual = "wielditem",
      visual_size = {x = 0.15, y = 0.15},
      wield_item = "default:stick",
  },
  message = "Default message",
  on_step = function(self)
    if not self.owner or not self.owner:get_luaentity() then
      self.object:remove()
    else
      if self.owner:get_luaentity().current_tool ~= self.tool_name then
        --print("removing old tool: "..self.tool_name.." for "..self.owner:get_luaentity().current_tool)
        self.object:set_detach()
        self.object:remove()
      end
    end
  end
}

local function tool_check(tool)
  if not minetest.registered_entities[tool] and
     not minetest.registered_tools[tool] and
     not minetest.registered_items[tool] and
     not minetest.registered_craftitems[tool] and
     not minetest.registered_nodes[tool] then
      return
  else
    return true
  end
end

local function tool_gen_engine(tool)
  local tool_table = string.split(tool,":")
  local tool_string = tool_table[1].."_"..tool_table[2]
  --print("tool string 1: "..tool_string)
  local gen_tool = table.copy(goblin_tool)
  gen_tool.initial_properties.wield_item = tool
  --print("goblin tool "..dump(goblin_tool))
  --tool_string = "default_stick"
  local ent_name = "goblins:goblin_tool_"..tool_string
  --print("trying "..ent_name )
  if not minetest.registered_entities[ent_name] then
    minetest.register_entity(ent_name,gen_tool)
  --  print("registered "..ent_name )
  else
  --  print("***   goblin tool: "..ent_name.." already registered!   ***")
  end
  --return tool_string
end

function goblins.tool_gen(tool)
  -- if not tool_check(tool) then
  --   tool = "default:stick"
  -- end
  if type(tool) == "table" then
    for k,v in pairs(tool) do
     tool_gen_engine(v)
    end
  else
    tool_gen_engine(tool)
  end
end

local function tool_attach_engine(self,tool)
  local tool_table = string.split(tool,":")
  local tool_string = tool_table[1].."_"..tool_table[2]
  --print("tool string 2: "..tool_string)
  --print("testing attach: "..dump(tool_gen(tool)))
  local tool_name = "goblins:goblin_tool_"..tool_string
  --..tool_gen(tool)
  --print("tool name:"..tool_name)
  local item = minetest.add_entity(self.object:get_pos(), tool_name)
  item:set_attach(self.object, "Arm_Right", {x=0.15, y=2.0, z=1.75}, {x=-90, y=180, z=90})
  --print(dump(self.goblin_tools))
  item:get_luaentity().owner = self.object
  self.current_tool = tool
  item:get_luaentity().tool_name = tool
end

local function wrandom(wtable)
  local chance = #wtable
  for _,__ in pairs(wtable) do
    local test = chance * math.random(chance)
    if chance == math.random(test) then
      return wtable[chance]
    else chance = chance - 1
    end
  end
end


function goblins.tool_attach(self,tool)
  --print(dump(tool))
  -- if not tool_check(tool) then
  --   tool = "default:stick"
  -- end
  if type(tool) == "table" then
    local rnd_tool = wrandom(tool)
   -- print("attaching "..rnd_tool)
    -- local rnd_tool = tool[math.random(1,#tool)]
    tool_attach_engine(self,rnd_tool)
    --print("attaching "..rnd_tool)
  else
    tool_attach_engine(self,tool)
  end
end
