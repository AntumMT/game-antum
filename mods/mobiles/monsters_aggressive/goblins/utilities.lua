local debug_goblins_announce_spawning = minetest.settings:get_bool("debug_goblins_announce_spawning") or false
local debug_goblins_relations = minetest.settings:get_bool("debug_goblins_relations") or false
local debug_goblins_secret = minetest.settings:get_bool("debug_goblins_secret") or false
local debug_goblins_territories = minetest.settings:get_bool("debug_goblins_territories") or false
local debug_goblins_territory_relations = minetest.settings:get_bool("debug_goblins_territory_relations") or false
local debug_goblins_trade_relations = minetest.settings:get_bool("debug_goblins_trade_relations") or false

local announce_spawning = debug_goblins_announce_spawning

local S = minetest.get_translator("goblins")

local function print_s(input)
  print(goblins.strip_escapes(input))
end

function goblins.timer(target,timer_name,timeout)
  local start = os.time()
  local t_name = timer_name
  if not t_name then t_name = default end
  if target and minetest.is_player(target) then
    local player = target
    local meta = player:get_meta()
    local timer = "timer_"..t_name
      if not meta:get_int(timer) then
        meta:set_int(timer,start)
      elseif meta:get_int(timer) and
        os.time() > (meta:get_int(timer) + timeout) then
          meta:set_int(timer,0)
      return timeout
    end
  end
end

goblins.gob_name_parts = {
  list_a = "Ach Adz Ak Ark Az Balg Bilg Blid Blig Blok Blot Bolg Boor Bot Bug Burk Chu Dokh Drik Driz Drub Duf Flug Gaw Gad Gag Gah Gak Gar Gat Gaz Ghag Ghak Ghor Git Glag Glak Glat Glig Gliz Glok Gnat Gog Grak Grat Guk Hig Irk Kak Kav Khad Krig Lag Lak Lig Likk Loz Luk Lun Mak Maz Miz Mog Mub Mur Nad Nag Naz Nilg Nikk Nogg Nok Nukk Nur Pog Rag Rak Rat Rok Ronk Rot Shrig Shuk Skrag Skug Slai Slig Slog Sna Snag Snark Snat Snig Snik Snit Sog Spik Stogg Tog Unk Urf Vark Vog Yad Yagg Yak Yark Yarp Yig Yip Zat Zib Zit Ziz Zob Zord",
  list_b = "ach adz ak ark awg az balg bilg blid blig blok blot bolg bot bug burk bus dokh drik driz duf ffy flug g ga gad gag gah gak gar gat gaz ghag ghak git glag glak glat glig gliz glok gnat gog grak grat gub guk hig irk kak khad krig lag lak lig likk loz luk mak maz miz mub murch nad nag naz nilg nikk nogg nok nukk og plus rag rak rat rkus rok shrig shuk skrag skug slai slig slog sna snag snark snat snig snik snit sog spik stogg thus tog un urf us vark yad yagg yak yark yarp yig yip zat zib zit ziz",
  list_opt = "ah ay e ee gah ghy y ya"
}
--need to find more goblinly-sounding words than these..
goblins.words_desc = {
  tool_adj = S("bent broken crusty dirty dull favorite gnarly grubbly happy moldy pointy ragged rusty sick sharp slimy trusty"),
  motiv_adj = S("quickly quietly slowly stealthily"),
  verbs = S("eats drinks hears moves feels smells sees")
}
local gob_name_parts = goblins.gob_name_parts

--- This can build all the mobs in our mod.
-- @gob_types is a table with the key used to build the subtype with values that are unique to that subtype
-- @goblin_template is the table with all params that a mob type would have defined
function goblins.generate(gob_types,goblin_template)
  for k, v in pairs(gob_types) do
    -- we need to get a fresh template to modify for every type or we get some carryover values:-P
    local g_template = table.copy(goblin_template)
    -- g_type should be different every time so no need to freshen
    local g_type = v
    for x, y in pairs(g_type) do
      -- print_s("found template modifiers " ..dump(x).." = "..dump(y))
      g_template[x] = g_type[x]
    end
    print_s("Assembling the "..g_template.description..":")
    if g_template.lore then print_s("  "..g_template.lore) end
    if g_template.additional_properties and g_template.additional_properties.goblin_tools then
      --print("found in template:"..g_template.goblin_tool)
      goblins.tool_gen(g_template.additional_properties.goblin_tools)
    end
    --print_s("resulting template: " ..dump(g_template))
    mobs:register_mob("goblins:goblin_"..k, g_template)
    mobs:register_egg("goblins:goblin_"..k, S("@1  Egg",g_template.description),"default_mossycobble.png", 1)
    g_template.spawning.name = "goblins:goblin_"..k --spawn in the name of the key!
    mobs:spawn(g_template.spawning)
    if g_template.additional_properties then
      for x,y in pairs(g_template.additional_properties) do
        minetest.registered_entities["goblins:goblin_"..k][x] = y
      end
    end
    --print(dump(minetest.registered_entities["goblins:goblin_"..k]))
    g_template = {}
  end
end

--- Our mobs, territories, etc can have randomly generated names.
-- @name_parts is the name parts table: {list_a = "foo bar baz"}
-- @rules are the list table key names in order of how they will be chosen
-- "-" and "\'" are rules that can be used to add a hyphen or apostrophe respectively
function goblins.generate_name(name_parts, rules)
  -- print_s("generating name")
  local name_arrays = {}
  local r_parts = {}
  local generated_name = {}
  for k,v in pairs(name_parts) do
    --  name_arrays.k = mysplit(v)
    name_arrays.k = string.split(v," ")
    -- print_s(dump(name_arrays.k))
    r_parts[k] = k
    r_parts[k] = name_arrays.k[math.random(1,#name_arrays.k)]
  end
  --local r_parts.k = name_arrays.k[math.random(1,#name_arrays.k)] did not work
  --print_s(name_a)
  if r_parts.list_opt and math.random() <= 0.5 then r_parts.list_opt = "" end
  --print_s(r_parts.list_a..r_parts.list_b..r_parts.list_opt)
  if rules then
    --print_s(dump(rules))
    local gen_name = ""
    for i, v in ipairs(rules) do
      if v == "-" then
        gen_name = gen_name.."-"
      elseif v == "\'" then
        gen_name = gen_name.."\'"
      else
        gen_name = gen_name..r_parts[v]
      end
    end
    generated_name = gen_name
    --print_s(dump(generated_name))
    return generated_name
  else
    generated_name = r_parts.list_a..r_parts.list_b..r_parts.list_opt
    return generated_name
  end
end

local function territory_list_update(player_name, territory_name)
  local known_territories = {}
  local recorded = false
  local player = minetest.get_player_by_name(player_name)
  local meta = player:get_meta()
  known_territories = minetest.deserialize(meta:get_string("territory_list"))
  if type(known_territories) == table then
    for k,v in known_territories do
      if territory_name == v then
        recorded = true
      end
    end
  else
    known_territories = {}
    --known_territories[1] = territory_name
  end
  if not recorded then
    table.insert(known_territories,territory_name)
    meta:set_string("territory_list", minetest.serialize(known_territories))
  end
  goblins.update_hud(player)
end

--- This will store the name of a player that learns the mobs territory in the mobs table.
function goblins.secret_territory(self, player_name, tell)
  local pname = player_name
  --self.nametag = self.secret_name.." of "..self.secret_territory.name
  if not self.secret_territory_told then
    self.secret_territory_told = {ix = os.time()}
  end
  if self.secret_territory_told[pname] then return self.secret_territory end
  if not self.secret_territory_told[pname] and tell then
    minetest.chat_send_player(pname,
      S("   You have learned the secret territory name of @1!!",dump(self.secret_territory.name)))
    self.secret_territory_told[pname] = os.time()
    ---self.nametag = self.secret_name.." of "..self.secret_territory.name
    ---player could also receive some kind of functional token for this territory
    territory_list_update(pname, self.secret_territory.name)
    return self.secret_territory
  end
  if debug_goblins_secret then
    for k,v in pairs(self.secret_territory_told)  do
      print_s(self.secret_name.." revealed secret territories to: "..k.." "..v)
    end
  end
end

--- This will store the name of a player that learns the mobs name in the mobs table.
function goblins.secret_name(self, player_name,tell)
  -- self.nametag = self.secret_name
  local pname = player_name
  if not self.secret_name_told then
    self.secret_name_told = {[self.secret_name] = os.time()}
  end
  if self.secret_name_told[pname] then return self.secret_name end
  if not self.secret_name_told[pname] and tell then
    --The goblin is willing to share something special!
    minetest.chat_send_player(pname,
      S("   You have learned the secret name of @1!!",self.secret_name))
    self.secret_name_told[pname] = os.time()
    --self.nametag = self.secret_name
    return self.secret_name
  end
  if debug_goblins_secret then
    for k,v in pairs(self.secret_name_told)  do
      print_s(self.secret_name.." revealed secret name to: "..k.." "..v)
    end
  end
end

------------
-- Announce Spawn ...summon it with care, for the floods shall come!
-----------
-- Purely for debugging or curiosity it can be enabled at the top of this page
function goblins.announce_spawn(self)
  if announce_spawning == true then
    local pos = vector.round(self.object:get_pos())
    if not pos then return end
    if self.secret_name then
      print_s( self.name:split(":")[2].. ", "..self.secret_name.." spawned at: " .. minetest.pos_to_string(pos))
    else
      print_s( self.name:split(":")[2].. " spawned at: " .. minetest.pos_to_string(pos))
    end
    --goblins.territory(pos)
    if self.secret_territory then
      if self.secret_name then
        print_s(self.secret_name.. " dwells in "..self.secret_territory["name"].." at " ..self.secret_territory["vol"].."!\n" )
      else
        print_s("A nameless creature inhabits"..self.secret_territory["name"].." at " ..self.secret_territory["vol"].."!\n" )
      end
    else
      local territory = {goblins.territory(pos)}
      if self.secret_name then
        print_s(territory[1].." at "..territory[2].." festers with the lurking form of "..self.secret_name.."\n")
      else
        print_s(territory[1].." at "..territory[2].." becomses the domain of a nameless one\n")
      end
    end
  end
end


-----
-- CREATE TERRITORIES
-----
-- Get the Minimum of a Chunk https://forum.minetest.net/viewtopic.php?p=351592#p351592
-- by duane » Sun Jul 14, 2019 00:20 and
-- by TalkLounge » Sun Jul 14, 2019 11:39

local function mapgen_min_max(pos)
  local pos = vector.round(pos)
  local chunksize = tonumber(type(minetest.settings) ~= "nil" and minetest.settings:get("chunksize") or minetest.setting_get("chunksize")) or 5
  local chunk_offset = math.floor(chunksize / 2) * 16
  local csize = {x = chunksize * 16, y = chunksize * 16, z = chunksize * 16}
  local chunk = vector.floor(vector.divide(vector.add(pos, chunk_offset), csize))
  local minp = vector.add(vector.multiply(chunk, 80), -chunk_offset)
  local maxp = vector.add(minp, (chunksize * 16) - 1)
  return minp, maxp
end

-- refer to https://rubenwardy.com/minetest_modding_book/en/map/storage.html
local goblins_db_fields = goblins_db:to_table()["fields"]

local function goblins_db_deser(table)
  local data = minetest.deserialize(goblins_db_fields[table])
  return data
end

local function goblins_db_read(table)
  local data = minetest.deserialize(goblins_db:to_table()["fields"][table])
  return data
end

local function goblins_db_write(key, table)
  local data = minetest.serialize(table)

  goblins_db:set_string(key, data)
  return key, data
end

function goblins.territory_test(pos,territories)

  local db_test = minetest.serialize({fieldtest = "initialized"})
  print_s("\nBEGIN EXISTING LIST--------\n"..dump(goblins_db_read("territories")).."\n ------END LIST\n")
end --test

-- Provides a way to take a chunks position and use it a base for storing information in a mod.
-- it is dependant on the mapgen_min_max function above as well the goblins_db functions for storage.
-- @opt_data is just for adding information to this territories storage it expects a table
function goblins.territory(pos, opt_data)
  -- this should be called on spawn but before a goblin gets its secret name
  -- a handy chunk name key generator, should create a unique name for every chunk
  local function cat_pos(chunk)
    return "Xa"..chunk[1].x.."_Ya"..chunk[1].y.."_Za"..chunk[1].z.."_x_Xb"..chunk[2].x.."_Yb"..chunk[2].y.."_Zb"..chunk[2].z
  end
  -- get list of known territories and thier chunks or
  local existing_territories = {}
  existing_territories = goblins_db_read("territories")
  local minp_maxp = {mapgen_min_max(pos)}
  local this_territory = {}
  local volume_cat_pos = cat_pos(minp_maxp)
  --print_s(dump(volume_cat_pos).." cat paws!")
  if debug_goblins_territories then
    print_s("\n----Known territories")
    for k,v in pairs(existing_territories) do
      print_s(dump(k).." is known as "..dump(existing_territories[k].name))
    end
    print_s("----End Known territories\n")
  end
  local territories_table = table.copy(existing_territories)
  -- print_s(dump(territories_table).."copied territories")
  -- print_s("\nTERRITORY TEST TABLE READ:\n" ..dump(goblins_db_read("territories")).."\n")
  if territories_table[volume_cat_pos]  then
    local t_vol = volume_cat_pos
    local t_name = territories_table[volume_cat_pos]["name"]
    if opt_data then  --insert a table
      for k,v in pairs(opt_data) do
        --if not territories_table[volume_cat_pos][k] -- this is tricky...
        territories_table[volume_cat_pos][k] = v
        local territories_table_ser = minetest.serialize(territories_table)
        goblins_db:set_string("territories", territories_table_ser )
        if debug_goblins_territories then
          print_s(k.." added to "..territories_table[volume_cat_pos]["name"])
        end
        --end
    end
    return t_name, t_vol
    end
    if debug_goblins_territories then
      print_s(dump(t_name).." at "..dump(t_vol).." is already known!")
    end
    -- print_s(dump(territories_table[volume_cat_pos]).. "\n ---end details \n")
    return t_name, t_vol
  else
    -- generate a name for this territory
    local name_rules = {"list_a","list_opt","-","list_b"}
    local territory_name = goblins.generate_name(gob_name_parts,name_rules)
    -- print_s(dump(territory_name).." is a name whispered among those who dwell here")
    -- set concatenated minp_maxp as the key for this territory and populate data
    -- print_s(dump(volume_cat_pos)))
    this_territory[(volume_cat_pos)] = {
      ["name"] = territory_name,
      ["flag"] = pos,
    }
    if debug_goblins_territories then
      print_s("The territory of "..dump(this_territory[volume_cat_pos]["name"]).. " at "..volume_cat_pos.." will be recorded.")
    end
    territories_table[volume_cat_pos] = this_territory[volume_cat_pos]
    -- print_s(dump(territories_table).. " is the new table \n")
    -- print_s("\nTERRITORY TESTING SERIALIZED WRITE:\n"..dump(this_territory_ser).."\n")
    -- prepare the territories_table for storage, unless we have something else to say..
    if opt_data then  --insert a table
      for k,v in pairs(opt_data) do
        --if not territories_table[volume_cat_pos][k] -- this is tricky...
        territories_table[volume_cat_pos][k] = v
        local territories_table_ser = minetest.serialize(territories_table)
        goblins_db:set_string("territories", territories_table_ser )
        if debug_goblins_territories then
          print_s(k.." added to "..territories_table[volume_cat_pos]["name"])
        end
        --end
    end
    local t_name = territory_name
    local t_vol = volume_cat_pos
    return t_name, t_vol
    end
    local territories_table_ser = minetest.serialize(territories_table)
    goblins_db:set_string("territories", territories_table_ser )
    local t_name = territory_name
    local t_vol = volume_cat_pos
    return t_name, t_vol
  end
  --print_s("\nTERRITORY TEST:\n"..dump(this_territory.name).."\n")
end

-- Express and optionally store the relationship between a mob and a player or another mob.
-- Will return all known relationships if nothing is defined.
-- @self will return only relations know to that mob
-- @target_name will return the table of the self.relations (mobs) relations to the target if
-- optional target_table is not defined.
-- @target_table will set the value of a mobs relation to the target.
-- THIS SCRIPT IS DEPENDANT on secret_name and secret_territory!
function goblins.relations(self, target_name, target_table)
  local existing_relations = {}
  if not goblins_db_read("relations") then
    print_s("relations DB not initialized from init.lua!!")
    return
  end
  -- let's get all the facts, this query may have to get more specific if its too big...
  local existing_relations = goblins_db_read("relations")
  -- do we want to know something in particular?

  if self then
    local name = self.secret_name
    --have we started keeping track of who we know?
    if not self["relations"] then
      self.relations = {ix = os.time()}
      if debug_goblins_relations then print_s("self table: "..dump(self)) end
      -- create an entry for ourselves with our territory as the value
      if self.secret_name and self.secret_territory then
        self.relations[name] = self.secret_territory.name
        existing_relations[name] = self.relations
        if debug_goblins_relations then print_s("self table updated: "..dump(self.relations).."\n") end
        if debug_goblins_relations then print_s("adding mob to relations table: "..dump(existing_relations[self]).."\n")end
        goblins_db_write("relations",existing_relations)
      end
    end
    -- do we just want to know how we feel about the target?
    if target_name and not target_table then
      -- do we even know the target? If not, initialize relationship root for target
      if not self.relations[target_name] then
        self.relations[target_name] = {ix = os.time()}
        existing_relations[name] = self.relations
        goblins_db_write("relations",existing_relations)
      end
      return self.relations[target_name]
    end
    -- we have something to say about the target!
    if target_name and target_table then
      -- mob adds it to their entity..
      for k,v in pairs(target_table) do
        self.relations[target_name][k] = v
      end

      existing_relations[name] = self.relations
      -- we add or modify this relationship in the mod storage "relations"

      --existing_relations[name][target_name] = target_value
      --print_s(dump(existing_relations))
      goblins_db_write("relations",existing_relations)
      if debug_goblins_relations then print_s("updated self table: "..dump(self.relations).."\n") end
      return existing_relations[target_name]
    end
  end
  -- we dont have a target just dump everything known about everone
  if debug_goblins_relations then print_s("all relations"..dump(existing_relations).."\n") end
  return existing_relations
end

--- Returns the status of a players relation throughout a territory
-- will initialize any new relation if required
-- at some point to support an array of relations to return
function goblins.relations_territory(self, player_name, rel_name)
  local pname = player_name
  local relations = goblins.relations(self)
  local t_relation = 0
  -- initialize tables if necessary
  if not self["relations"] then self.relations = {ix = os.time()} end
  if not self.relations[pname] then goblins.relations(self, pname) end
  if not self.relations[pname][rel_name] then self.relations[pname][rel_name] = 0 end
  --be sure that relations have been started with player before using this!
  if debug_goblins_trade_relations then print_s(S("Individual mob trade relations: ")) end
  for m_name,prop in pairs(relations) do
    if self.secret_territory.name == relations[m_name][m_name] and
      relations[m_name][pname] and relations[m_name][pname][rel_name] then
      --add up the trade relations between the player and all goblins in this goblins territory
      t_relation = t_relation + relations[m_name][pname][rel_name]
      if debug_goblins_trade_relations then print_s(S("@1 = @2",m_name,relations[m_name][pname][rel_name]))end
    end
  end
  if debug_goblins_territory_relations then
    print_s("this mob's relation are "..dump(relations[self.secret_name]))
    print_s(S("@1 territory @2 relation score = @3",self.secret_territory.name,rel_name,t_relation))
  end
  return t_relation
end

function goblins.player_relations_territory(player,territory)
end

