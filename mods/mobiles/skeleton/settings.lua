
--- Entity lifespan.
--
--  @setting skeleton.lifetime
--  @settype int
--  @default 900 (15 minutes)
cmer_skeleton.lifetime = tonumber(core.settings:get("skeleton.lifetime")) or 900

--- Spawn rate frequency.
--
--
--  @setting skeleton.spawn_interval
--  @settype int
--  @default 120 (2 minutes)
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_skeleton.spawn_interval = tonumber(core.settings:get("skeleton.spawn_interval")) or 120

--- Chance of spawn at interval.
--
--  @setting skeleton.spawn_chance
--  @settype int
--  @default 7000
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_skeleton.spawn_chance = tonumber(core.settings:get("skeleton.spawn_chance")) or 7000
