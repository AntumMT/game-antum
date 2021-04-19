
--[[ DEFAULTS: --
spawn_on                   = {"group:soil", "group:stone"},
spawn_near                 = {"air"},
spawn_min_light            = 0,
spawn_max_light            = 15,
spawn_interval             = 30,
spawn_chance               = 5000,
spawn_active_object_count  = 1,
spawn_min_height           = -31000,
spawn_max_height           = 31000,
]]

local config = {}

config.spawn_enabled_ostrich = true
config.spawn_on_ostrich = {"default:desert_sand", "default:desert_stone"}
config.spawn_max_light_ostrich = 20
config.spawn_min_light_ostrich = 10
config.spawn_chance_ostrich = 1500
config.spawn_active_object_count_ostrich = 1
config.spawn_max_height_ostrich = 31000

global_desert_life = config
