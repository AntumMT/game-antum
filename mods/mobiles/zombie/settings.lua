
--- Entity lifespan.
--
--  @setting zombie.lifetime
--  @settype int
--  @default 300 (5 minutes)
cmer_zombie.lifetime = tonumber(core.settings:get("zombie.lifetime")) or 300

--- Spawn rate frequency.
--
--
--  @setting zombie.spawn_interval
--  @settype int
--  @default 36
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_zombie.spawn_interval = tonumber(core.settings:get("zombie.spawn_interval")) or 36

--- Chance of spawn at interval.
--
--  @setting zombie.spawn_chance
--  @settype int
--  @default 7600
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_zombie.spawn_chance = tonumber(core.settings:get("zombie.spawn_chance")) or 7600
