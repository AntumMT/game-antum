-- optional ambience api mod: https://notabug.org/TenPlus1/ambience

if minetest.get_modpath("ambience") then

  print("Ambience Lite mod detected, looking for API..")
  if ambience then
  print("Ambience mod API loaded")
    if ambience.get_set("cave") then 
      ambience.del_set("cave")
    end
    ambience.add_set("underground", {
    frequency = 1000,
    sounds = {
      {name = "goblins_ambient_underground", length = 25}
    },
    sound_check = function(def)
        		--[[ local c = (def.totals["default:mossycobble"] or 0)
                         + (def.totals["default:stone"] or 0) 
        if c > 5  then--]]
      if  def.pos.y < -15 then
        return "underground"
      end
    end,
    })
    
  --Does not seem to be working as expected, but maybe someday:
    ambience.add_set("mossycobble", {
      frequency = 100,
      sounds = {
        {name = "goblins_ambient_drip", length = 11.4}
      },
      sound_check = function(def)
        local c = (def.totals["default:mossycobble"] or 0)
     
        if c > 10 and def.pos.y < -15 then
  
          return "mossycobble"
        end
      end,
    })
  else 
    print(dump( minetest.get_modpath("ambience") ))
    print("Ambience Lite  mod API not found")
    print("Please check latest version of Ambience Lite at")
    print("https://notabug.org/TenPlus1/ambience")
  end
end