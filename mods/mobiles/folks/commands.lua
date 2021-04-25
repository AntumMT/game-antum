local S = minetest.get_translator("folks")

ChatCmdBuilder.new("folks", function(cmd)
  -- command for editing selected npc name
  cmd:sub("edit name :name:text", function(pname, new_name)
    local player = minetest.get_player_by_name(pname)
    if player then
      local meta = player:get_meta()
      if meta then
        local editing_npc = meta:get_string("folks_editing_npc")
        if editing_npc == "" then
          minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("You are not editing an NPC. Click the NPC you want to edit with the NPC editor item.")))
          return
        end
        local npc = folks.backend.get_npc(editing_npc)
        if npc then
          folks.edit_npc_name(editing_npc, new_name)
          meta:set_string("folks_editing_npc", "")
          minetest.chat_send_player(pname, minetest.colorize("#00ff00", S("Edited NPC: @1", editing_npc)))
        end
      end
    end
  end)


  -- command for editing selected npc name color
  cmd:sub("edit name_color :color:text", function(pname, new_color)
    local player = minetest.get_player_by_name(pname)
    if player then
      local meta = player:get_meta()
      if meta then
        local editing_npc = meta:get_string("folks_editing_npc")
        if editing_npc == "" then
          minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("You are not editing an NPC. Click the NPC you want to edit with the NPC editor item.")))
          return
        end
        local npc = folks.backend.get_npc(editing_npc)
        if npc then
          folks.edit_npc_name_color(editing_npc, new_color)
          meta:set_string("folks_editing_npc", "")
          minetest.chat_send_player(pname, minetest.colorize("#00ff00", S("Edited NPC: @1", editing_npc)))
        end
      end
    end
  end)


  -- command for editing selected npc texture
  cmd:sub("edit texture :name:text", function(pname, new_texture)
    local player = minetest.get_player_by_name(pname)
    if player then
      local meta = player:get_meta()
      if meta then
        local editing_npc = meta:get_string("folks_editing_npc")
        if editing_npc == "" then
          minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("You are not editing an NPC. Click the NPC you want to edit with the NPC editor item.")))
          return
        end
        local npc = folks.backend.get_npc(editing_npc)
        if npc then
          folks.edit_npc_texture(editing_npc, new_texture)
          meta:set_string("folks_editing_npc", "")
          minetest.chat_send_player(pname, minetest.colorize("#00ff00", S("Edited NPC: @1", editing_npc)))
        end
      end
    end
  end)



  -- command to bind name and texture of npc to a player, needs skins_collectible
  cmd:sub("bind :name:text", function(pname, bind_to)
    if folks.skins_c then
      local player = minetest.get_player_by_name(pname)
      if player then
        local meta = player:get_meta()
        if meta then
          local editing_npc = meta:get_string("folks_editing_npc")
          if editing_npc == "" then
            minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("You are not editing an NPC. Click the NPC you want to edit with the NPC editor item.")))
            return
          end
          local npc = folks.backend.get_npc(editing_npc)
          if npc then
            if folks.bind_npc_to_player(editing_npc, bind_to) then
              minetest.chat_send_player(pname, minetest.colorize("#00ff00", S("Edited NPC: @1", editing_npc)))
            else
              minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("Couldn't retrieve player texture (is it online?)")))
            end
            meta:set_string("folks_editing_npc", "")
          end
        end
      end
    else
      minetest.chat_send_player(pname, minetest.colorize("#ff0000", S("You need skins_collectible to use this feature")))
    end
  end)


end, {
  description = S("Manage folks npcs"),
  privs = {
    folks_admin = true
  }
})
