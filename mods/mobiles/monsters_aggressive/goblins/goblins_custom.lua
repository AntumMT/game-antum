
local S = minetest.get_translator("goblins")

-- Create new goblins here (or override existing ones).
-- This example just overrides the existing Cobble, feel to remove it
--[[
  goblins.gob_types.cobble = {
    description = S("Cobblemoss Goblin"),
    lore = S("Cobbler crumbles walls infusing them with moss to collect moisture for a fetid, mushroom friendly habitat."),
    damage = 1,
    hp_min = 5,
    hp_max = 10,
    sounds = {
      random = {"goblins_goblin_breathing",gain = 0.5},
      war_cry = "goblins_goblin_war_cry",
      attack = "goblins_goblin_attack",
      damage = "goblins_goblin_damage",
      death = "goblins_goblin_death",
      replace = "default_place_node",gain = 0.8,
      distance = 15
    },
    textures = {
      {"goblins_goblin_cobble1.png"},
      {"goblins_goblin_cobble2.png"},
    },
    runaway_from = "player",

    do_custom = function(self)
      if math.random() < .2 then
        goblins.search_replace(
          self,
          50, --search_rate
          20, --search_rate_above
          20, --search_rate_below
          1, --search_offset
          2, --search_offset_above
          1, --search_offset_below
          20, --replace_rate
          "default:mossycobble", --replace_what
          "goblins:moss", --replace_with
          nil, --replace_rate_secondary
          nil, --replace_with_secondary
          nil, --decorate
          {3}, -- primary and secondary tool index
          nil --debug messages
          
        )
      else
        goblins.search_replace(
          self,
          50, --search_rate
          20, --search_rate_above
          20, --search_rate_below
          1, --search_offset
          2, --search_offset_above
          1, --search_offset_below
          20, --replace_rate
          { "group:stone",
            "group:torch"}, --replace_what
          "default:mossycobble", --replace_with
          90, --replace_rate_secondary
          "goblins:mossycobble_trap", --replace_with_secondary
          nil, --decorate
          {1,2}, -- primary and secondary tool index
          nil --debug messages
          


        )
      end
    end,
    additional_properties = {
      goblin_tools = {
                       "default:mossycobble",
                       "default:axe_stone",
                       "goblins:moss",
                       "default:sword_stone"
                     }
    },
    after_activate = function (self)
      goblins.tool_attach(self,self.goblin_tools)
    end,
    spawning = goblins.spawning.cobble
--]]
--[[
goblins.gob_types.foo = {
  description = S("foo Goblin"),
  lore = S("foo bar baz"),
  --you can leave as much as you want undefined as it will be added by the default template in goblins.lua
}
--]]

--[[
goblins.gobdog_types.zoo = {
  description = S("zoo Gobdog"),
  lore = S("zoo bar foo"),
  --you can leave as much as you want undefined as it will be added by the default template in animals.lua
}
--]]