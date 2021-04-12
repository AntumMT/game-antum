-- optional hunger api mod: https://gitlab.com/4w/hunger_ng

if minetest.get_modpath("hunger_ng") then
  print("Hunger NG mod detected, looking for API..")
  if hunger_ng and hunger_ng.add_hunger_data then
    print("Hunger NG mod API loaded")
    local add = hunger_ng.add_hunger_data
    add("goblins:mushroom_goblin",  { satiates = 1.5 })
    add("goblins:mushroom_goblin2", { satiates = 2.0 })
    add("goblins:mushroom_goblin3", { satiates = 2.2 })
    add("goblins:mushroom_goblin4", { satiates = 2.5 })
  else
    print(dump( minetest.get_modpath("hunger_ng") ))
    print("Hunger NG mod API not found")
    print("Please check latest version of Hunger NG at")
    print("https://gitlab.com/4w/hunger_ng")
  end
end
