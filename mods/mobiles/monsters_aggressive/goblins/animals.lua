local function variance(min,max)
  local target = math.random(min,max) / 100
  --print(target)
  return target
 end

local gob_name_parts = goblins.gob_name_parts
local goblins_spawning = goblins.spawning
goblins.gobdog_types = {
  gobdog = {
    owner_loyal = true,
    attack_npcs = false,
    attack_monsters = false,
    group_attack = true,
    attack_players = true,
  },
  gobdog_aggro = {
    description ="Dire Gobdog",
    lore = "Dire Gobdogs are sensitive to light and are very territorial",
    type = "monster",
    group_attack = true,
    owner_loyal = true,
    attack_npcs = false,
    attack_monsters = false,
    attack_players = true,

    spawning = goblins_spawning.gobdog_aggro
  },
}
-------------
-- Gobdog Template
------------
goblins.gobdog_template = {
  description ="Gobdog",
  lore = "Gobdogs are not canids but goblins that have mutated somehow, fortunately they do not share the hunger and size of the mythical werewolf.",
  type = "npc",
  attack_type = "dogfight",
  group_attack = true,
  reach = 2,
  damage = 1,
  hp_min = 2,
  hp_max = 5,
  armor = 100,
  stepheight = 1.2,
  walk_velocity = 2,
  run_velocity = 4,
  jump = true,
  jump_height = 6,
  pushable = true,
  knock_back = true,
  view_range = 15,
  water_damage = 0,
  lava_damage = 5,
  light_damage = 0,
  fear_height = 4,
  floats = 1,
  --glow = 1,
  pathfinding = 1,
  stay_near = {
    "group:water", 20,
    "group:sand", 20,
    "group:soil", 20,
    "default:mossycobble", 10,
    "group:meat" ,2,
    "goblins:goblins_goblin_bone_meaty"},
  collisionbox = {-0.45, -0.01, -0.45, 0.45, 0.85, 0.45},
  visual = "mesh",
  mesh = "goblins_goblin_dog.b3d",
  textures = {
    {"goblins_goblin_dog.png"},
  },
  makes_footstep_sound = true,
  sounds = {
    random = "goblins_goblin_dog_ambient_cave",
    war_cry = "goblins_goblin_dog_war_cry_cave",
    attack = "goblins_goblin_dog_attack_cave",
    damage = "goblins_goblin_dog_damage_cave",
    death = "goblins_goblin_dog_death_cave",
    replace = "goblins_goblin_dog_replace_cave",gain = 0.8,
  },
  follow = {
    "goblins:goblins_goblin_bone","goblins:goblins_goblin_bone_meaty","group:meat"
  },
  drops = {
    {name = "goblins:goblins_goblin_bone", chance = 1, min = 1, max = 3},
  },
  animation = {
    speed_normal = 60,
    stand_start = 0,
    stand_end = 60,
    walk_start = 70,
    walk_end = 90,
    run_start = 130,
    run_end = 140,
    run_speed =30,
    jump_start = 160,
    jump_end = 190,
    jump_loop = true,
    jump_speed = 30,
    punch_start = 130,
    punch_end = 140,
    punch_speed = 30,
    die_start = 140,
    die_stop = 145,
    die_speed = 30,
    die_loop = false,
  },

  on_spawn = function(self)
    minetest.sound_play("goblins_goblin_dog_war_cry_cave", {
      object = self.object,
      gain = .5,
      max_hear_distance =30
    })
    self.groups = {"gobdog", "goblin"}
    self.groups_defend = {"goblin","gobdog","gobdog_friend"}
    if not self.secret_name then
      local name_rules = {"list_a", "list_opt"}
      self.secret_name = goblins.generate_name(gob_name_parts, name_rules)
    end
    --print (dump(self.secret_name))
    local pos = vector.round(self.object:get_pos())
    if not pos then return end
    if not self.secret_territory then
      local territory = {goblins.territory(pos)}
      self.secret_territory = {name = territory[1], vol = territory[2]}
      --print(dump(self.secret_territory.name).." secret_territory assigned")
    else
    --print(dump(self.secret_territory.name).." secret_territory already assigned")
    end
    local color_var = "#"..math.random(10,50)..math.random(10,50)..math.random(10,50)
    --print("COLOR_VAR: "..color_var)
    self.object:set_texture_mod("^[colorize:"..color_var..":80")

    if not self.size then
      local s_mod = variance(1,20)
      self.size = {x = (variance(90,100) - s_mod), y = (variance(80,110) - s_mod), z = (variance(90,100) - s_mod)}
    end

    local self_properties = self.object:get_properties()
    self_properties.visual_size = self.size
    self.object:set_properties(self_properties)
    goblins.announce_spawn(self)
  end,

  on_rightclick = function(self, clicker)
    if mobs:feed_tame(self, clicker, 4, true, true) then return end
    if mobs:protect(self, clicker) then return end
    if mobs:capture_mob(self, clicker, 0, 5, 50, false, nil) then return end
  end,
  ---dog behaviors or not...
  do_custom = function(self)
    goblins.goblin_dog_behaviors(self)
  end,

  do_punch = function(self,hitter)
    local pname = hitter:get_player_name()
    local relations = goblins.relations(self, pname)
    if not relations.aggro then
       goblins.relations(self, pname, {aggro = 0})
       relations = goblins.relations(self, pname)
    end
    --print(self.secret_name.." relations on click:\n"..dump(self.relations).."\n")
    if self.relations[pname].aggro  then
       local adj = (self.relations[pname].aggro + 1) * 1.5
       self.relations[pname].aggro = math.floor(adj)
       goblins.relations(self, pname, {aggro = self.relations[pname].aggro} )
    end
  end,

  spawning = goblins_spawning.gobdog
}

mobs:alias_mob("goblins:goblins_goblin_dog", "goblins:goblin_gobdog")
mobs:alias_mob("goblins:goblin_goblin_dog", "goblins:goblin_gobdog")

mobs:alias_mob("goblins:goblins_goblin_dog_aggro", "goblins:goblin_gobdog_aggro")
mobs:alias_mob("goblins:goblin_goblin_dog_aggro", "goblins:goblin_gobdog_aggro")
