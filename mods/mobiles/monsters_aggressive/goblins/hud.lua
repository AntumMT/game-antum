local saved_huds = {}

local ght = tonumber(minetest.settings:get("goblins_hud_timer")) or 0

local function clear_hud(params)

  local player = minetest.get_player_by_name(params[1])
  local meta = player:get_meta()
  --print ("testing"..dump(params))
  if os.time() >= (meta:get_int("hud_time_start") + ght) then
   player:hud_remove(params[2])
   meta:set_int("hud_cleared",1)
   --print ("removing"..dump(params))
  end
end
function goblins.update_hud(player)
  if ght > 0 then
  --for _,player in ipairs(minetest.get_connected_players()) do
    local player_name = player:get_player_name()
    --print(player_name)
    local meta = player:get_meta()
      local goblin_current = meta:get_string("goblin_current")
      local territory_current = meta:get_string("territory_current")
      local known_territories = minetest.deserialize(meta:get_string("territory_list"))
      local territory = "unknown"
      if known_territories then
        for k,v in pairs(known_territories) do
          if territory_current == v then
            territory = v
          end
        end
      end
      local text_goblin_current = goblin_current
      local text_territory_current   = "of " ..territory
      local territory_score_table = minetest.deserialize(meta:get_string(territory_current))
      local text_territory_scores = {}
      if not territory_score_table then return end
      for k,v in pairs(territory_score_table) do
        text_territory_scores[k] = k..": "..v
      end

      local ids = saved_huds[player_name]

      if not ids then
        ids = {}
        ids.territory_scores = {}
        saved_huds[player_name] = ids
        -- create HUD elements and set ids into `ids`
        --[[
          player:hud_add({
            hud_elem_type = "text",
            position  = {x = 1, y = 0.5},
            offset    = {x = -120, y = -25},
            text      = "Goblin HUD",
            alignment = -0,
            scale     = { x = 100, y = 30},
            number    = 0xFFFFFF,
          })
          --]]
          ids.goblin_current = player:hud_add({
            hud_elem_type = "text",
            position  = {x = 1, y = 0.5},
            offset    = {x = -120, y = -25},
            text      = text_goblin_current,
            alignment = -1,
            scale     = { x = 50, y = 10},
            number    = 0xFFFFFF,
          })
          local params = {player_name,ids.goblin_current}
          minetest.after((ght+5),clear_hud, params)
          ids.territory_current = player:hud_add({
            hud_elem_type = "text",
            position  = {x = 1, y = 0.5},
            offset    = {x = -120, y = 0},
            text      = text_territory_current,
            alignment = -1,
            scale     = { x = 50, y = 10},
            number    = 0xFFFFFF,
          })
          local params = {player_name,ids.territory_current}
          minetest.after((ght+5),clear_hud, params)
          local tst_yo = 0
          for k,v in pairs(territory_score_table) do
            tst_yo = tst_yo + 20
            ids.territory_scores[k] = player:hud_add({
              hud_elem_type = "text",
              position  = {x = 1, y = 0.5},
              offset    = {x = -120, y = tst_yo},
              text      = text_territory_scores[k],
              alignment = -1,
              scale     = { x = 50, y = 10},
              number    = 0xFFFFFF,
            })
            local params = {player_name,ids.territory_scores[k]}
            minetest.after(ght+5,clear_hud, params)
          end

          --minetest.after(ght,clear_hud, params)
      else
        if meta:get_int("hud_cleared") == 1 then
          --hud_params_title()
          ids.goblin_current = player:hud_add({
            hud_elem_type = "text",
            position  = {x = 1, y = 0.5},
            offset    = {x = -120, y = -25},
            text      = text_goblin_current,
            alignment = -1,
            scale     = { x = 50, y = 10},
            number    = 0xFFFFFF,
          })
          local params = {player_name,ids.goblin_current}
          minetest.after(ght,clear_hud, params)
          ids.territory_current = player:hud_add({
            hud_elem_type = "text",
            position  = {x = 1, y = 0.5},
            offset    = {x = -120, y = 0},
            text      = text_territory_current,
            alignment = -1,
            scale     = { x = 50, y = 10},
            number    = 0xFFFFFF,
          })
          local params = {player_name,ids.territory_current}
          minetest.after(ght,clear_hud, params)
          local tst_yo = 0
          for k,v in pairs(territory_score_table) do
            tst_yo = tst_yo + 20
            ids.territory_scores[k] = player:hud_add({
              hud_elem_type = "text",
              position  = {x = 1, y = 0.5},
              offset    = {x = -120, y = tst_yo},
              text      = text_territory_scores[k],
              alignment = -1,
              scale     = { x = 50, y = 10},
              number    = 0xFFFFFF,
            })
            local params = {player_name,ids.territory_scores[k]}
            minetest.after(ght,clear_hud, params)
          end
        else
          local params = {player_name,ids.goblin_current}
          player:hud_change(ids["goblin_current"], "text", text_goblin_current)
          minetest.after(ght,clear_hud, params)
          local params = {player_name,ids.territory_current}
          player:hud_change(ids["territory_current"], "text", text_territory_current)
          minetest.after(ght,clear_hud, params)
          for k,v in pairs(territory_score_table) do
            local params = {player_name,ids.territory_scores[k]}
            minetest.after(ght,clear_hud, params)
            player:hud_change(ids.territory_scores[k],"text", text_territory_scores[k])
          end
          --player:hud_change(ids["bar_foreground"],
          --"scale", { x = percent, y = 1 })
        end
      end
      meta:set_int("hud_cleared",0)
      meta:set_int("hud_time_start",os.time())
       --minetest.after(ght, print,"ONE" )
       -- minetest.after(ght-1, print,"TWO" )
       -- minetest.after(ght-2, print,"THREE")

  end
end



minetest.register_on_joinplayer(goblins.update_hud)
minetest.register_on_leaveplayer(function(player)
  saved_huds[player:get_player_name()] = nil
end)