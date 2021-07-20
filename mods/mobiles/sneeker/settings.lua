
--- Settings for sneeker mod.
--
--  @module settings.lua


local time_min = 60

--- How long (in seconds) sneeker remains in world after spawn.
--
--  @setting sneeker.lifespan
--  @settype int
--  @default 900 (15 minutes)
sneeker.lifetime = tonumber(core.settings:get("sneeker.lifetime") or time_min * 15)

--- Loudness of explosion.
--
--  @setting sneeker.boom_gain
--  @settype float
--  @default 1.5
sneeker.boom_gain = tonumber(core.settings:get("sneeker.boom_gain") or 1.5)

--- Determines whether or not a player must be close for spawn to occur.
--
--  @setting sneeker.spawn_require_player_nearby
--  @settype bool
--  @default true
sneeker.spawn_require_player_nearby = core.settings:get_bool("sneeker.spawn_require_player_nearby", true)

--- Distance in nodes a player must be for spawn to occur.
--
--  Only used if `sneeker.spawn_require_player_nearby` enabled.
--
--  @setting sneeker.spawn_player_radius
--  @settype int
--  @default 100
sneeker.spawn_player_radius = tonumber(core.settings:get("sneeker.spawn_player_radius") or 100)

--- If enabled, mobs not near any players will despawn.
--
--  @setting sneeker.despawn_player_far
--  @settype bool
--  @default true
sneeker.despawn_player_far = core.settings:get_bool("sneeker.despawn_player_far", true)

--- Distance determining if a player is near enough to prevent despawn.
--
--  Only used if `sneeker.despawn_player_far` enabled.
--
--  @setting sneeker.despawn_player_radius
--  @settype int
--  @default 500
sneeker.despawn_player_radius = tonumber(core.settings:get("sneeker.despawn_player_radius") or 500)

--- Sets possibility for spawn.
--
--  Inverted value (e.g. 10000 = 1/10000).
--
--  @setting sneeker.spawn_chance
--  @settype int
--  @default 10000
sneeker.spawn_chance = tonumber(core.settings:get("sneeker.spawn_chance") or 10000)

--- Sets frequency of spawn chance.
--
--  @setting sneeker.spawn_interval
--  @settype int
--  @default 240 (4 minutes)
sneeker.spawn_interval = tonumber(core.settings:get("sneeker.spawn_interval") or time_min * 4)

--- Sets the minimum light that a node must have for spawn to occur.
--
--  Value can be set between 0 (no light) & 15 (max light).
--
--  @setting sneeker.spawn_minlight
--  @settype int
--  @default 0
sneeker.spawn_minlight = tonumber(core.settings:get("sneeker.spawn_minlight") or 0)

--- Sets the maximum light that a node can have for spawn to occur.
--
--  Value can be set between 0 (no light) & 15 (max light).
--
--  @setting sneeker.spawn_maxlight
--  @settype int
--  @default 4
sneeker.spawn_maxlight = tonumber(core.settings:get("sneeker.spawn_maxlight") or 4)

--- Sets the lowest position at which sneeker can spawn.
--
--  @setting sneeker.spawn_minheight
--  @settype int
--  @default -31000
sneeker.spawn_minheight = tonumber(core.settings:get("sneeker.spawn_minheight") or -31000)

--- Sets the highest position at which sneeker can spawn.
--
--  @setting sneeker.spawn_maxheight
--  @settype int
--  @default 31000
sneeker.spawn_maxheight = tonumber(core.settings:get("sneeker.spawn_maxheight") or 31000)

--- Limits the number of entities that can spawn per mapblock (16x16x16).
--
--  @setting sneeker.spawn_mapblock_limit
--  @settype int
--  @default 1
sneeker.spawn_mapblock_limit = tonumber(core.settings:get("sneeker.spawn_mapblock_limit") or 1)

--- Comma-separated list of nodes on which sneeker can spawn.
--
--  @setting sneeker.spawn_nodes
--  @settype string
--  @default default:dirt_with_dry_grass,default:dry_dirt,default:dry_dirt_with_dry_grass,default:desert_sand,nether:rack
sneeker.spawn_nodes = core.settings:get("sneeker.spawn_nodes") or "default:dirt_with_dry_grass,default:dry_dirt,default:dry_dirt_with_dry_grass,default:desert_sand,nether:rack"
sneeker.spawn_nodes = sneeker.spawn_nodes:trim()
