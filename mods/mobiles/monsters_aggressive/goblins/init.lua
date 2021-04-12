local path = minetest.get_modpath("goblins")
goblins_db = minetest.get_mod_storage()
goblins_db:set_string("goblins mod start time", os.date() )
--set namespace for goblins functions
goblins = {}

goblins.version = "20210421"

-- Strips any kind of escape codes (translation, colors) from a string
-- https://github.com/minetest/minetest/blob/53dd7819277c53954d1298dfffa5287c306db8d0/src/util/string.cpp#L777
function goblins.strip_escapes(input)
  local s = function(idx) return input:sub(idx, idx) end
  local out = ""
  local i = 1
  while i <= #input do
    if s(i) == "\027" then -- escape sequence
      i = i + 1
      if s(i) == "(" then -- enclosed
        i = i + 1
        while i <= #input and s(i) ~= ")" do
          if s(i) == "\\" then
            i = i + 2
          else
            i = i + 1
          end
        end
      end
    else
      out = out .. s(i)
    end
    i = i + 1
  end
  --print(("%q -> %q"):format(input, out))
  return out
end

local function print_s(input)
  print(goblins.strip_escapes(input))
end

local S = minetest.get_translator("goblins")

local goblins_version = goblins.version
-- create the table if it does not exist!
local goblins_db_fields = goblins_db:to_table()["fields"]
local function goblins_db_write(key, table)
  local data = minetest.serialize(table)
  goblins_db:set_string(key, data)
  return key, data
end
if not goblins_db_fields["territories"] then
  print("-------------\nWe must Initialize!\n-------------")
  goblins_db_write("territories", {test = {version = goblins_version, encode = minetest.encode_base64(os.date()), created = os.date() }})
end
if not goblins_db_fields["relations"] then
  print("-------------\nWe must Initialize!\n-------------")
  goblins_db_write("relations", {test = {version = goblins_version, encode = minetest.encode_base64(os.date()), created = os.date() }})
end
--compatability with minimal game
if not default.LIGHT_MAX then
  default.LIGHT_MAX = 14
  LIGHT_MAX = default.LIGHT_MAX
end

minetest.log("action", "[MOD] goblins " ..goblins.version.. " is lowdings....")
print_s(S("Please report issues at https://github.com/FreeLikeGNU/goblins/issues "))

if mobs.version then
  if tonumber(mobs.version) >= tonumber(20200516) then
    print_s(S("Mobs Redo 20200516 or greater found!"))
  else
    print_s(S("You should find a more recent version of Mobs Redo!"))
    print_s(S("https://notabug.org/TenPlus1/mobs_redo"))
  end
else
  print_s(S("This mod requires Mobs Redo version 2020516 or greater!"))
  print_s(S("https://notabug.org/TenPlus1/mobs_redo"))
end

dofile(path .. "/utilities.lua")
dofile(path .. "/traps.lua")
dofile(path .. "/nodes.lua")
dofile(path .. "/items.lua")
dofile(path .. "/soundsets.lua")
dofile(path .. "/behaviors.lua")
dofile(path .. "/goblins_spawning.lua")
dofile(path .. "/animals.lua")
dofile(path .. "/goblins.lua")
dofile(path .. "/hunger.lua")
dofile(path .. "/goblins_custom.lua") --allow for additional/replacement goblins created by user
dofile(path .. "/hud.lua")
-------------
--ASSEMBLE THE GOBLIN HORDES!!!!
-------------

local gob_types = goblins.gob_types
local gobdog_types = goblins.gobdog_types
local goblin_template = goblins.goblin_template
local gobdog_template = goblins.gobdog_template
local gob_name_parts = goblins.gob_name_parts
local gob_words = goblins.words_desc

goblins.generate(gob_types,goblin_template)
goblins.generate(gobdog_types,gobdog_template)

local function ggn(gob_name_parts,rules)
  return goblins.generate_name(gob_name_parts,rules)
end

print_s(S("This diversion is dedicated to the memory of @1 the @2, @3 the @4, and @5 the @6... May their hordes be mine!",
  ggn(gob_name_parts),ggn(gob_words, {"tool_adj"}),ggn(gob_name_parts),ggn(gob_words, {"tool_adj"}),ggn(gob_name_parts),ggn(gob_words, {"tool_adj"})))
print_s(S("   --@1 of the @2 clan.",ggn(gob_name_parts),ggn(gob_name_parts,{"list_a","list_opt","-","list_b"})))

