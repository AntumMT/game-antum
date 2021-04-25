local S = minetest.get_translator("folks")

minetest.register_tool("folks:npc_creator", {
  description = S("Use this to create a new NPC  at your position"),
  inventory_image = "npc_creator.png",
  groups = {oddly_breakable_by_hand = "2"},
  on_place = function() end,
  on_drop = function() end,

  on_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player:get_player_name(), { folks_admin=true }) then return end

    local npc_id = folks.backend.get_unique_id()
    local new_npc = minetest.add_entity(player:get_pos(), "folks:npc", minetest.serialize({_npc_id = npc_id}))
    if new_npc then
      local entity = new_npc:get_luaentity()
      if entity then
        entity._npc_id = npc_id
        folks.backend.add_npc(new_npc)
      end
    end
    return
  end
})

minetest.register_tool("folks:npc_editor", {
  description = S("Use this to edit the NPC you click"),
  inventory_image = "npc_editor.png",
  groups = {oddly_breakable_by_hand = "2"},
  on_place = function() end,
  on_drop = function() end,

  on_use = function(itemstack, player, pointed_thing)
    if pointed_thing.type == "nothing" or pointed_thing.type == "node" then return end
    if not minetest.check_player_privs(player:get_player_name(), { folks_admin=true }) then return end

    local entity = pointed_thing.ref:get_luaentity()
    if entity._isfolk then
      if mobkit.is_alive(entity) and not entity._isremoved then
        -- TODO: show formspec to edit clicked npc
        local meta = player:get_meta()
        meta:set_string("folks_editing_npc", entity._npc_id)
        -- minetest.log(dump(entity._npc_object))
        minetest.chat_send_player(player:get_player_name(), minetest.colorize("#00ff00", S("You are now editing NPC: @1", entity._npc_id)))
        -- minetest.log(entity._npc_id or "none")
        -- formspec
        minetest.show_formspec(player:get_player_name(), "folks:edit_npc_formspec", folks.get_edit_formspec(entity._npc_id))
        -- end formspec
      end
    end
    return
  end
})

minetest.register_tool("folks:npc_remover", {
  description = S("Use this to remove the NPC you click"),
  inventory_image = "npc_remover.png",
  groups = {oddly_breakable_by_hand = "2"},
  on_place = function() end,
  on_drop = function() end,

  on_use = function(itemstack, player, pointed_thing)
    if pointed_thing.type == "nothing" or pointed_thing.type == "node" then return end
    if not minetest.check_player_privs(player:get_player_name(), { folks_admin=true }) then return end

    local entity = pointed_thing.ref:get_luaentity()
    if entity._isfolk and not entity._isremoved then
      if folks.backend.get_npc(entity._npc_id) then
        for _, npc_obj in pairs(folks.backend.get_npcs_obj(entity._npc_id)) do
          npc_obj:remove()
        end
        folks.backend.remove_npc(entity._npc_id)
      end
      return
    else
      return
    end
  end
})

minetest.register_tool("folks:npc_spawner", {
  description = S("Use this to spawn an NPC that you had already created"),
  inventory_image = "npc_spawner.png",
  groups = {oddly_breakable_by_hand = "2"},
  on_place = function() end,
  on_drop = function() end,

  on_use = function(itemstack, player, pointed_thing)
    if not minetest.check_player_privs(player:get_player_name(), { folks_admin=true }) then return end

    minetest.show_formspec(player:get_player_name(), "folks:spawn_npc_formspec", folks.get_spawn_formspec())

    return
  end
})

minetest.register_tool("folks:npc_despawner", {
  description = S("Use this to despawn without deleting the NPC you click"),
  inventory_image = "npc_despawner.png",
  groups = {oddly_breakable_by_hand = "2"},
  on_place = function() end,
  on_drop = function() end,

  on_use = function(itemstack, player, pointed_thing)
    if pointed_thing.type == "nothing" or pointed_thing.type == "node" then return end
    if not minetest.check_player_privs(player:get_player_name(), { folks_admin=true }) then return end

    pointed_thing.ref:remove()

    return
  end
})
