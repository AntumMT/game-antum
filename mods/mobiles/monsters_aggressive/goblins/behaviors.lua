
local debug_goblins_attack = minetest.settings:get_bool("debug_goblins_attack") or false
local debug_goblins_find = minetest.settings:get_bool("debug_goblins_find") or false
local debug_goblins_replace = minetest.settings:get_bool("debug_goblins_replace") or false
local debug_goblins_replace2 = minetest.settings:get_bool("debug_goblins_replace2") or false
local debug_goblins_search = minetest.settings:get_bool("debug_goblins_search") or false
local debug_goblins_tunneling = minetest.settings:get_bool("debug_goblins_tunneling") or false
local debug_goblins_trade = minetest.settings:get_bool("debug_goblins_trade") or false

--@trade_shrewdness increases trade difficulty
local goblins_trade_shrewdness = tonumber(minetest.settings:get("goblins_trade_shrewdness")) or 20

--@aggro_on_wield will goblins attack when a weapon is wielded?
local goblins_aggro_on_wield = minetest.settings:get_bool("goblins_aggro_on_wield") ~= false
--@goblins_defend_groups will goblins and gobdogs defend other mobs?
local goblins_defend_groups = minetest.settings:get_bool("goblins_defend_groups") ~= false

local mobs_griefing = minetest.settings:get_bool("mobs_griefing") ~= false
local goblins_node_protect_strict = minetest.settings:get_bool("goblins_node_protect_strict") ~= false
local peaceful_only = minetest.settings:get_bool("only_peaceful_mobs")

local S = minetest.get_translator("goblins")

local gob_name_parts = goblins.gob_name_parts

local function strip_escapes(input)
  goblins.strip_escapes(input)
end

local function print_s(input)
  print(goblins.strip_escapes(input))
end

function goblins.mixitup(pos)
  pos.y = pos.y + math.random()
  pos.x = pos.x + math.random()
  pos.x = pos.x - math.random()
  pos.z = pos.z + math.random()
  pos.z = pos.z - math.random()
  return pos
end

local function match_item_list(item, list)
  for k,v in pairs(list) do
    local found = string.find(item, v)
    return found
  end
end

local function match_only_list(item, list)
  for k,v in pairs(list) do
    if item == v then
      return v
    end
  end
end

---Goblins will become aggro at range due to
-- wielded weapon, player aggression, defending defined mob groups
-- some attack code reused from Mobs Redo by TenPlus1
function goblins.attack(self, target, type)
  if self.state == "runaway"
    or self.state == "attack"
    or self:day_docile()
    or peaceful_only == true
  then
    --print_s(S("player not considered"))
    return
  end

  local pos = vector.round(self.object:get_pos())
  if pos then
    local s = self.object:get_pos()
    local objs = minetest.get_objects_inside_radius(s, self.view_range)
    local aggro_wielded = {}
    if goblins_aggro_on_wield then
      aggro_wielded = self.aggro_wielded
    end
    local defend_groups = goblins_defend_groups
    --print_s(S(dump(aggro_wielded)))
    -- remove entities we aren't interested in
    for n = 1, #objs do
      local ent = objs[n]:get_luaentity()
      -- are we a player?
      if objs[n]:is_player() then
        local pname = objs[n]:get_player_name()
        local relations_self = {}
        local relations = {}
        local relations_adj = 0
        --do we know this player?
        local relations_self = goblins.relations(self, pname)
        if not relations_self.trade then goblins.relations(self, pname,{trade = 0}) end
        if not relations_self.aggro then goblins.relations(self, pname,{aggro = 0}) end

        --tally the territorial scores
        relations.aggro = goblins.relations_territory(self, pname, "aggro")
        relations.trade = goblins.relations_territory(self, pname, "trade")
        if debug_goblins_attack then
          print_s(S("@1 of @2: ", self.secret_name, self.secret_territory.name))
          print_s(S("mob relations = @1",dump(goblins.relations(self, pname))))
          print_s(S("comparing territory trade @1 and aggro @2",dump(relations.trade),dump(relations.aggro)))
        end

        if relations.trade >= relations.aggro then
          relations_adj = relations.trade - relations.aggro
        end
        if debug_goblins_attack then print_s(S("relations = @1",dump(relations))) end
        if mobs.invis[pname]
          or self.owner == pname then
          local name = ""
        else
          local player = objs[n]
          local name = "player"
        end
        -- if player invisible or mob not setup to attack then remove from list
        local wielded = objs[n]:get_wielded_item():to_string()
        --print(self.secret_name.." is loyal to " ..self.owner)
        if debug_goblins_attack then print_s( S("player has @1 in hand",dump(objs[n]:get_wielded_item():to_string())))end
        if self.attack_players == false
          or relations_adj >= 100
          or not self.owner == pname
          --or not self.tamed
          or mobs.invis[pname]
          or self.specific_attack == "player" then
          if debug_goblins_attack then print_s(S("found exempt player with score of @1 holding @2",relations_adj,dump(objs[n]:get_wielded_item():to_string()))) end
          objs[n] = nil
          --print("- pla", n)
        else
          if debug_goblins_attack then print_s(S("attackable player, @1 holding @2",pname,wielded)) end
          --lets check if our friends in a fight with the player!
          for n = 1, #objs do
            local ent_other = objs[n]:get_luaentity()
            if defend_groups and ent_other and ent_other.groups and self.groups_defend then
              for k,v in pairs(self.groups_defend) do
                if match_only_list(v, ent_other.groups) and
                    ent_other.state == "attack" and
                    ent_other.attack:is_player() and
                    ent_other.attack:get_player_name() == pname then
                      local xname = ent_other.attack:get_player_name()
                      if debug_goblins_attack then print_s( S("      ****Defending @1 from @2!",v,xname)) end
                      minetest.sound_play("goblins_goblin_war_cry", {
                        pos = pos,
                        gain = 1.0,
                        max_hear_distance = self.sounds.distance or 10
                      })
                      self:set_animation("run")
                      self:set_velocity(self.run_velocity)
                      self.state = "attack"
                      self.attack = ent_other.attack
                end
              end
            end
          end
          if aggro_wielded and match_item_list(wielded, aggro_wielded)
          then
            if debug_goblins_attack then print_s(S("*** aggro triggered by @1 at @2 !!  ***",wielded,minetest.pos_to_string(pos))) end
            minetest.sound_play("goblins_goblin_war_cry", {
              pos = pos,
              gain = 1.0,
              max_hear_distance = self.sounds.distance or 10
            })
            self:set_animation("run")
            self:set_velocity(self.run_velocity)
            self.state = "attack"
            self.attack = (objs[n])
          end
        end
      end --end of player eval
      --what else do we care about?
      --group_attack mobs nearby
    end
  end
end

--- Drops a special personlized item
function goblins.special_gifts(self, pname, drop_chance, max_drops)
  if pname then
    if self.drops then
      if not drop_chance then drop_chance = 1000 end
      if not max_drops then max_drops = 1 end
      local rares = {}
      for k,v in pairs(self.drops) do
        --print_s(dump(v.name).." and "..dump(v.chance))
        if v.chance >= drop_chance then
          table.insert(rares,v.name)
        end
      end
      if #rares > 0 then
        --print_s("rares = "..dump(rares))
        local pos = self.object:get_pos()
        if pos then
          pos.y = pos.y + 0.5
          goblins.mixitup(pos)
          if #rares > max_drops then
            rares = rares[math.random(max_drops, #rares)]
            if type(rares) ~= table then rares = {rares} end --
          end
          for k,v in pairs(rares) do
            minetest.sound_play("goblins_goblin_cackle", {
              pos = pos,
              gain = 1.0,
              max_hear_distance = self.sounds.distance or 10
            })
            local item_wear = math.random(5000,10000)
            local stack = ItemStack({name = v, wear = item_wear })
            local org_desc = minetest.registered_items[v].description
            local meta = stack:get_meta()
            local tool_adj = goblins.generate_name(goblins.words_desc, {"tool_adj"})
            -- special thanks here to rubenwardy for showing me how translation works!
            meta:set_string(
              "description", S("@1's @2 @3", self.secret_name, tool_adj, org_desc)
            )
            local obj = minetest.add_item(pos, stack)
            minetest.chat_send_player(
              pname,S("@1 drops @2",self.secret_name, meta:get_string("description"))
            )
          end
        end
      end
    end
  end
end

---grab the score for a territory
--@rel_names are a table of relations to reference
function goblins.get_scores(self,player_name,rel_names)
  local t_scores = {}
local player = minetest.get_player_by_name(player_name)
  if not player then return end
  local meta = player:get_meta()
  local pdata = {}
    --local pdata[self.secret_territory] = {}
  for k,v in pairs(rel_names) do
    t_scores[v] = goblins.relations_territory(self, player_name, v)
    pdata[k] = v
  end
  --print_s(S("t_scores = @1",dump(t_scores)))
  --write player data
  meta:set_string(self.secret_territory.name, minetest.serialize(t_scores))
  --print("***    player meta = "..meta:get_string(self.secret_territory.name))
  meta:set_string("territory_current", self.secret_territory.name)
  if self.secret_name_told and self.secret_name_told[player_name] then
    meta:set_string("goblin_current", self.secret_name)
    print("***    player meta = "..meta:get_string("goblin_current"))
  else
    meta:set_string("goblin_current", "unknown goblin")
  end

  goblins.update_hud(player)
  return t_scores
end

--calculate tables of scores and get results
local function score_calc(add, sub)
  local adds = 0
  local subs = 0
  local score = 0
  if add then
    for k,v in pairs(add) do
      adds = v + adds
    end
  end
  if sub then
    for k,v in pairs(sub) do
      subs = v + subs
    end
  end
  if adds >= subs then
    score = adds - subs
    return score
  else score = 0
  end
  return score
end
-- prepare trade score for giving a gift
local function trade_score(self, player_name)
  local add = {}
  local sub = {}
  local rel_names = {"trade", "aggro"}
  local rel_scores = goblins.get_scores(self,player_name,rel_names)
  add[1] = rel_scores.trade
  sub[1] = rel_scores.aggro
  local result = score_calc(add, sub)
  --print_s(S("calculated score = @1",dump(result)))
  return result
end
--- You can give a gift, they *may* give something(s) in return, thats Goblin trading
function goblins.give_gift(self,clicker)
  --if mobs:feed_tame(self, clicker, 14, false, false) then
  local item = clicker:get_wielded_item()
  local pname = clicker:get_player_name()
  local gift_accepted = nil
  local gift_declined = nil
  
  local name_told = goblins.secret_name(self, pname)
  local territory_told = goblins.secret_territory(self, pname)
  local trade_shrewdness = goblins_trade_shrewdness
  --establish trade if its not set
  if not self.relations[pname] then
    goblins.relations(self, pname, {trade = 0})
  end
  if debug_goblins_trade then print_s(dump(goblins.relations(self, pname))) end
  local srp_trade = self.relations[pname].trade
  local gift = item:get_name()
  local gift_description = item:get_definition().description
  if debug_goblins_trade then print_s("you offer: " ..dump(gift)) end
  for k,v in pairs(self.follow) do
    if v == gift then
      local gift_value = k or 5  --higher number is less wanted gift, otherwise 10
      gift_accepted = true
      if debug_goblins_trade then print_s(S("@1 accepts @2 (@3)",self.name,dump(gift),k)) end
      --increase trade rating on gifting - first item in follow list is worth more
      srp_trade = srp_trade + math.ceil(5/k)
      if gift == self.follow[1] then
        srp_trade =  srp_trade + 4
        minetest.chat_send_player(pname,"Yessss! " .. gift_description.."!")
      end
      goblins.relations(self, pname,{trade = srp_trade})
      if debug_goblins_trade then print_s("this goblins trade rating is now = " ..dump(srp_trade)) end
      local gr_trade = trade_score(self, pname)
      if debug_goblins_trade then print_s("Goblin adjusted (trade - aggro) relations for territory is = "..dump(gr_trade)) end
      if not minetest.settings:get_bool("creative_mode") then
        item:take_item()
        clicker:set_wielded_item(item)
      end
    ---appease an attacking goblin
      if self.state == "attack" and self.attack == clicker then
        if (self.relations[pname].aggro * 2) < self.relations[pname].trade then
          self.state = "stand"
          self:set_velocity(0)
          self:set_animation("stand")
          self.attack = nil
          self.v_start = false
          self.timer = 0
          self.blinktimer = 0
          self.path.way = nil
        end
      end
      --print_s(dump(self.object:get_luaentity()).. " at " ..dump(self.object:get_pos()).. " takes: " ..dump(item:get_name()))
      if self.drops then
        if debug_goblins_trade then
          print_s("you may get some of "..dump(#self.drops).. " things such as: ")
          for _,v in pairs(self.drops) do
            print_s(dump(v.name).. " with a base drop chance of 1 in " ..dump(v.chance))
          end
        end
        -- we can make some mobs extra stingy despite trade relations
        if not self.shrewdness then self.shrewdness = 1 end
        local pos = self.object:get_pos()
        if pos then
          pos.y = pos.y + 0.5
          for _,v in pairs(self.drops) do
            --@d_chance takes all the factors of trade into account for each item in drop list
            local d_chance = 0
            d_chance = ((gift_value + v.chance) * (self.shrewdness + trade_shrewdness)) / (gr_trade + 1)
            --print(v.name.." d_chance = " ..d_chance)
            --more likely to get something really rare , less likely to get something common
            if gift == self.follow[1] then d_chance = self.shrewdness + trade_shrewdness end
            d_chance = math.ceil(d_chance)
            if math.random(d_chance) == 1 then
              if debug_goblins_trade == true then
                print_s(S("\n @1 dropped by @2 at an adjusted chance of 1 in @3", dump(v.name),dump(self.name),dump(d_chance)))
              end
              minetest.sound_play("goblins_goblin_cackle", {
                pos = pos,
                gain = 0.2,
                max_hear_distance = self.sounds.distance or 10
              })
              --let it go already!
              goblins.mixitup(pos)
              minetest.add_item(pos, {
                name = v.name
              })
            end
          end
        end
      end
      gift_accepted = true
      if name_told and territory_told then
        minetest.chat_send_player(pname,S("@1 of @2 takes your @3!",self.secret_name,self.secret_territory.name,gift_description))
      elseif name_told then
        minetest.chat_send_player(pname,S("@1 takes your @2!",self.secret_name,gift_description))
      else
        minetest.chat_send_player(pname,S("Goblin takes your @1!", gift_description))
      end
      return gift_accepted --acception of gift complete
    else
      if debug_goblins_trade == true then print_s("You did not offer " .. dump(string.split(v,":")[2]) ) end
    end
  end
  local pos = self.object:get_pos()
  if pos then
    minetest.sound_play("goblins_goblin_damage", {
      pos = pos,
      gain = 0.2,
      max_hear_distance = self.sounds.distance or 10
    })
  end
  if name_told and territory_told then
    minetest.chat_send_player(
      pname,S("@1 of @2  does not want your @3",
        self.secret_name,self.secret_territory.name,gift_description))
  elseif name_told then
    minetest.chat_send_player(pname,S("@1 does not want your @2",self.secret_name,gift_description))
  else
    minetest.chat_send_player(pname,S("Goblin does not want your @1",gift_description))
  end
  gift_declined = true
end

--- Replaces nodes with many params.
function goblins.search_replace(
  self,
  search_rate,
  search_rate_above,
  search_rate_below,
  search_offset,
  search_offset_above,
  search_offset_below,
  replace_rate,
  replace_what,
  replace_with,
  replace_rate_secondary,
  replace_with_secondary,
  decorate, --this is for placing attached nodes like goblin mushrooms and torches
  debug_me,
  tools) -- {primary, secondary} based on index# of self.goblin_tools
  local pos  = self.object:get_pos()
  if pos and mobs_griefing and not minetest.is_protected(pos, "") and math.random(1, search_rate) == 1 then
    -- look for nodes
    local pos  = self.object:get_pos() 
    local pos1 = self.object:get_pos()
    local pos2 = self.object:get_pos()

    --local pos  = vector.round(self.object:get_pos())  --will have to investigate these further
    --local pos1 = vector.round(self.object:get_pos())
    --local pos2 = vector.round(self.object:get_pos())
    local tool_set = {}
    if tools then 
     tool_set = tools
    end
    
    -- if we are looking, will we look below and by how much?
    if pos1 and math.random(1, search_rate_below) == 1 then
      pos1.y = pos1.y - search_offset_below
    end

    -- if we are looking, will we look above and by how much?
    if pos2 and math.random(1, search_rate_above) == 1 then
      pos2.y = pos2.y + search_offset_above
    end

    pos1.x = pos1.x - search_offset
    pos1.z = pos1.z - search_offset
    pos2.x = pos2.x + search_offset
    pos2.z = pos2.z + search_offset

    if debug_goblins_search and debug_me then
      print (self.name:split(":")[2] .. " at\n "
        .. minetest.pos_to_string(pos) .. " is searching between\n "
        .. minetest.pos_to_string(pos1) .. " and\n "
        .. minetest.pos_to_string(pos2))
    end

    local nodelist = minetest.find_nodes_in_area(pos1, pos2, replace_what)
    if #nodelist > 0 then
      if debug_goblins_find and debug_me then
        print_s(#nodelist.." nodes found by " .. self.name:split(":")[2]..":")
        for k,v in pairs(nodelist) do print_s(minetest.get_node(v).name:split(":")[2].. " found.") end
      end
      for key,value in pairs(nodelist) do
        value = vector.round(value)
        -- ok we see some nodes around us, are we going to replace them?
        if minetest.is_protected(value, "") and goblins_node_protect_strict then break end
        if math.random(1, replace_rate) == 1 then
          local air_value = nil
          if replace_rate_secondary and
            math.random(1, replace_rate_secondary) == 1 then
            if decorate then
              value = minetest.find_node_near(value, 1, "air")
            end
            if value ~= nil then
              -- print("decorating with "..replace_with_secondary..minetest.pos_to_string(value))
              if tools and self.goblin_tools and type(self.goblin_tools) == "table" then
                local replace = tools[2]
                goblins.tool_attach(self,self.goblin_tools[replace])
                --print("changing tool: "..self.goblin_tools[replace])
              end
              self:set_velocity(0)
              self:set_animation("punch")
              if decorate then
                minetest.set_node(value, {name = replace_with_secondary})
              else
                minetest.set_node(value, {name = replace_with_secondary})
              end
            end
            if debug_goblins_replace2 and debug_me then
              print_s(replace_with_secondary.." secondary node placed by " .. self.name:split(":")[2])
            end
          else
            if decorate then
              value = minetest.find_node_near(value, 1, "air")
            end
            if value ~= nil  then
              if tools and self.goblin_tools and type(self.goblin_tools) == "table" then
                local replace = tools[1]
                goblins.tool_attach(self,self.goblin_tools[replace])
                --print("changing tool: "..self.goblin_tools[replace])
              end
              -- print("decorating with "..replace_with..minetest.pos_to_string(value))
              self:set_velocity(0)
              self:set_animation("punch")
              if decorate then
                minetest.set_node(value, {name = replace_with})
              else
                minetest.set_node(value, {name = replace_with})
              end
            end
            if debug_goblins_replace and debug_me then
              print_s(replace_with.." placed by " .. self.name:split(":")[2])
            end
          end
          minetest.sound_play(self.sounds.replace, {
            object = self.object, gain = self.sounds.gain,
            max_hear_distance = self.sounds.distance
          })
        end
      end
    end
  end
end

--[[
"He destroys everything diggable in his path. It's too much trouble
to fudge around with particulars. Besides, I don't want them to
mine for me."
      --From the tome __Of Goblinkind__ by duane-r

 "The domain of stone is the Goblins home,
  by metals might one thwart them from invasion."
      --Epithet from __The Luanacy of Goblins__ by Persont Bachslachdi
--]]

--the following is built from duane-r's goblin tunnel digging:
local diggable_nodes = {"group:stone", "group:sand", "group:soil", "group:cracky", "group:crumbly"}
-- This translates yaw into vectors.
local cardinals = {{x=0,y=0,z=0.75}, {x=-0.75,y=0,z=0}, {x=0,y=0,z=-0.75}, {x=0.75,y=0,z=0}}
----------
-- Goblins Tunneling.
---------
-- @type are available for fine-tuning.
function goblins.tunneling(self, type)
  --
  if type == nil then
    type = "digger"
  end

  local pos = self.object:get_pos()
  if pos and mobs_griefing and not minetest.is_protected(pos, "") then
    if self.state == "tunnel" then
      self:set_animation("walk")
      self:set_velocity(self.walk_velocity)
      -- Yaw is stored as one of the four cardinal directions.
      if not self.digging_dir then
        self.digging_dir = math.random(0,3)
      end

      -- Turn him roughly in the right direction.
      -- self.object:setyaw(self.digging_dir * math.pi * 0.5 + math.random() * 0.5 - 0.25)
      self.object:setyaw(self.digging_dir * math.pi * 0.5)

      -- Get a pair of coordinates that should cover what's in front of him.
      local p = vector.add(pos, cardinals[self.digging_dir+1])
      -- p.y = p.y - 1  -- What's this about?
      local p1 = vector.add(p, .1)
      local p2 = vector.add(p, 1.5)

      -- Get any diggable nodes in that area.
      local np_list = minetest.find_nodes_in_area(p1, p2, diggable_nodes)
      if #np_list > 0 then
        -- Dig it.
        --print("  NP_LIST: ".. dump(np_list))
        for _, np in pairs(np_list) do
          if minetest.is_protected(np, "")  and goblins_node_protect_strict then break end
          local np_info = minetest.get_node(np)
          --print("     np_name: "..np_info.name)
          if np_info.name ~= "default:mossycobble" and np_info.name ~= "default:chest" then
            self:set_animation("punch")
            minetest.remove_node(np)
            minetest.sound_play(self.sounds.replace, {
              object = self.object, gain = self.sounds.gain,
              max_hear_distance = self.sounds.distance
            })
          end
        end
      end

      if math.random() < 0.2 then
        local d = {-1,1}
        self.digging_dir = (self.digging_dir + d[math.random(2)]) % 4
      end
      self.state = "walk"
      self:set_animation("walk")
      self:set_velocity(self.walk_velocity)

    elseif self.state == "room" then  -- Dig a room.
      --[[first make sure player is not near by! (not quite ready yet)
          goblins.must_hide = function()
          end --]]
      if not self.room_radius then
        self.room_radius = 1
    end

    self:set_velocity(0)
    self.state = "stand"
    self:set_animation("stand")

    -- Work from the inside, out.
    for r = 1,self.room_radius do
      -- Get a pair of coordinates that form a room.
      local p1 = vector.add(pos, -r)
      local p2 = vector.add(pos, r)
      -- But not below him.
      p1.y = pos.y

      local np_list = minetest.find_nodes_in_area(p1, p2, diggable_nodes)

      --FLG prefers a smaller room with a rougher look for goblin warrens.  Maybe this should be a setting for users preference?
      if r >= self.room_radius and #np_list == 0 then
        --self.room_radius = math.random(1,2) + math.random(0,1)
        self.room_radius = math.random(1,1.5) + math.random(0,0.5)
        --        self.state = "stand"
        --        self:set_velocity(0)
        --        self:set_animation("stand")
        break
      end

      if #np_list > 0 then -- dig it
        if goblins_node_protect_strict then break end
        self:set_animation("punch")
        minetest.remove_node(np_list[math.random(#np_list)])
        minetest.sound_play(self.sounds.replace, {
          object = self.object, gain = self.sounds.gain,
          max_hear_distance = self.sounds.distance
        })
        break
      end
      self.state = "walk"
      self:set_animation("walk")
      self:set_velocity(self.walk_velocity)
    end
    end
    ---the following values should be vars for settings...
    --if we are standing, maybe make a tunnel or
    --if we are tunneling, maybe make a room or
    --if we are tunneling stand or maybe just end this function
    --
    if self.state == "stand" and math.random() < 0.1 then
      self.state = "tunnel"
      if debug_goblins_tunneling then print_s("goblineer is now tunneling") end
    elseif self.state == "tunnel" and math.random() < 0.1 then
      self.state = "room"
      if debug_goblins_tunneling then print_s("goblineer is now making a room") end
    elseif self.state == "tunnel" and math.random() < 0.1 then
      self.state = "stand"
      if debug_goblins_tunneling then print_s(dump(vector.round(self.object:get_pos())).. "goblineer is thinking...") end
    end
  end
end

function goblins.danger_dig(self,freq,depth)
  local gpos = self.object:get_pos()
  if gpos then
    local pos = vector.round(gpos)
    local lol = minetest.get_node_light(pos) or 0
    local freq = freq or 0.1
    local depth = depth or 1
    local target = table.copy(pos)
    target.y = target.y - depth

    if self.light_damage_min and 
      lol >= self.light_damage_min and
      mobs_griefing and
      not minetest.is_protected(target, "") and
      math.random() <= freq and 
      minetest.get_node(target).name ~="air" then
        local target_node = minetest.get_node(target)
            
        if self.state ~= "stand" then self.state = "stand" end

        --find a pick among goblin tools if we can
        if self.goblin_tools and type(self.goblin_tools) == "table" then
          local tool = match_item_list("pick",self.goblin_tools)
          if tool then
            goblins.tool_attach(self,self.goblin_tools[tool])
            --print("changing tool: "..self.goblin_tools[replace])
          end
        end

        self:set_velocity(0)
        self:set_animation("punch")
        minetest.remove_node(target)
        local node_above = vector.round(self.object:get_pos())
        node_above.y = node_above.y + 2
        local nb_node1 = vector.round(self.object:get_pos())
        local nb_node2 = vector.round(self.object:get_pos())
        nb_node1.y = node_above.y
        nb_node2.y = node_above.y
        nb_node1.x = nb_node1.x - 1
        nb_node1.z = nb_node1.z - 1
        nb_node2.x = nb_node1.x + 1
        nb_node2.z = nb_node1.z + 1
        local air_nodes = minetest.find_nodes_in_area(nb_node1,nb_node2, "air")
        --print(#nodes)
        if #air_nodes == 1 then
          minetest.set_node(node_above, {name = target_node.name})
        end
    end
  end
  

end

function goblins.goblin_dog_behaviors(self)
  local pos = self.object:get_pos()
  if pos then
    if math.random() < 0.1 then
      goblins.attack(self)
      --print("looking for a reason to fight")
    end
    if mobs_griefing and not minetest.is_protected(pos, "") then
      if math.random() < 0.5 then
        --consume meaty bones"
        goblins.search_replace(
          self,
          100, --search_rate
          100000, --search_rate_above
          100000, --search_rate_below
          1, --search_offset
          1, --search_offset_above
          1, --search_offset_below
          5, --replace_rate
          {"group:meat","group:food_meat","group:food_meat_raw"}, --replace_what
          "goblins:goblins_goblin_bone", --replace_with
          10, --replace_rate_secondary
          "air", --replace_with_secondary --very hungry
          nil, --decorate
          false --debug_me if debugging also enabled in behaviors.lua
        )
      elseif math.random() < 0.5 then
        --consume dry bones"
        goblins.search_replace(
          self,
          100, --search_rate
          100000, --search_rate_above
          100000, --search_rate_below
          1, --search_offset
          1, --search_offset_above
          1, --search_offset_below
          5, --replace_rate
          "goblins:goblins_goblin_bone", --replace_what
          "air", --replace_with
          nil, --replace_rate_secondary
          nil, --replace_with_secondary
          nil, --decorate
          false--debug_me if debugging also enabled in behaviors.lua
        )
      elseif math.random() < 0.8 then
        --dig and maybe bury bones if theres suitable terrain around
        goblins.search_replace(
          self,
          100, --search_rate
          100000, --search_rate_above
          100, --search_rate_below
          1, --search_offset
          1, --search_offset_above
          2, --search_offset_below
          10, --replace_rate
          {"group:soil",
            "group:sand",
            "default:gravel"}, --replace_what
          "goblins:dirt_with_bone",
          2, --replace_rate_secondary
          "default:dirt", --replace_with_secondary
          nil, --decorate
          false --debug_me if debugging also enabled in behaviors.lua
        )
      else
        --or maybe bury something more useful
        goblins.search_replace(
          self,
          100, --search_rate
          100000, --search_rate_above
          100, --search_rate_below
          1, --search_offset
          1, --search_offset_above
          2, --search_offset_below
          10, --replace_rate
          {"group:soil",
            "group:sand",
            "default:gravel"}, --replace_what
          "goblins:dirt_with_stuff",
          2, --replace_rate_secondary
          "default:dirt", --replace_with_secondary
          nil, --decorate
          false --debug_me if debugging also enabled in behaviors.lua
        )
      end
    end
    --[[not quite ready yet...
    if math.random() < 0.01 then
      goblins.do_taunt_at(self)
      print_s("are " ..dump(self.name).. " barking?" )
    end
  --]]
  end
end


