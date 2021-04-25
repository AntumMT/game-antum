local S = minetest.get_translator("folks")

folks.default_npc = {
  initial_properties = {
    hp_max = 9999,
    physical = true,
    collide_with_objects = false,
    collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
    visual_size = {x = 1, y = 1},
    visual = "mesh",
    mesh = "npc.b3d",
    textures = {
      folks.default_npc_texture,
    },
    pushable = false,
    nametag = "Folk",
    nametag_color = "#ffffff",
  },

  -- mobkit properties
  timeout = 0,
  max_hp = 9999,
  buoyancy = -1,
  lung_capacity = 200,
  on_step = mobkit.stepfunc,
  -- on_activate = mobkit.actfunc,
  on_activate = function(self, staticdata, dtime_s)
    mobkit.actfunc(self, staticdata, dtime_s)

    self._npc_object = self.object
    -- minetest.log("ACtivated")
    -- minetest.log(dump(self._npc_object))
    -- minetest.log(dump(mobkit.recall(self, "_npc_id")))
    if staticdata ~= nil then
      staticdata = minetest.deserialize(staticdata)
      if mobkit.recall(self, "_npc_id") == nil then  -- saves _npc_id to memory so I can get it every time the entity is activated
        mobkit.remember(self, "_npc_id", staticdata._npc_id)
        -- minetest.log(dump(mobkit.recall(self, "_npc_id")))
      -- else
      --   self.memory = folks.util.deepcopy(staticdata.memory)
      end
      local npc_id = mobkit.recall(self, "_npc_id")
      local npc_data = folks.backend.get_npc(npc_id)
      if npc_data then  -- Here I set all the customizable properties
        self.object:set_properties({
          nametag = npc_data._npc_name,
          nametag_color = npc_data._npc_name_color,
          textures = npc_data._npc_textures,
        })
        self._npc_id = npc_id
        folks.backend.set_npc_obj(npc_id, self.object)
      end
    end
  end,
  get_staticdata = mobkit.statfunc,
  view_range = 24,
  max_speed = 10,
  jump_height = 10,
  logic = function(self)
    mobkit.vitals(self)
    local prty = mobkit.get_queue_priority(self)

    local pos = self.object:get_pos()

    if prty < 10 then
      local plyr = mobkit.get_nearby_player(self)
      if plyr and vector.distance(pos,plyr:get_pos()) < 8 then
        mobkit.lq_turn2pos(self, plyr:get_pos())
        return
      end
    end
  end,


  on_rightclick = function(self, player)
    local msg_index = folks.backend.get_next_message_index(self._npc_id, player:get_player_name())
    local msg = folks.get_npc_message(self._npc_id, msg_index)
    if msg then
      local npc_name = folks.backend.get_npc(self._npc_id)._npc_name
      minetest.chat_send_player(player:get_player_name(), minetest.colorize("#00ff00", npc_name .. ": " .. S(msg)))
    end
  end,

  on_punch = function(self, puncher, t_from_last, tool_cap, dir, dmg)
    -- minetest.log("action", minetest.serialize(tool_cap))
  end,

  -- custom properties
  _isfolk = true,
  _isremoved = false,
  _npc_object = nil,
  _bound_player = nil,  -- nil or player name
  _npc_messages = {"Hey, I'm a Folk!"} -- contains all npc's messages
}



minetest.register_entity("folks:npc", folks.default_npc)
