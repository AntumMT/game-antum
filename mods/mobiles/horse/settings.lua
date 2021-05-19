
--- Entity lifespan.
--
--  @setting horse.lifetime
--  @settype int
--  @default 300
cmer_horse.lifetime = tonumber(core.settings:get("horse.lifetime")) or 300

--- Spawn rate frequency.
--
--
--  @setting horse.spawn_interval
--  @settype int
--  @default 600 (10 minutes)
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_horse.spawn_interval = tonumber(core.settings:get("horse.spawn_interval")) or 10 * 60

--- Chance of spawn at interval.
--
--  @setting horse.spawn_chance
--  @settype int
--  @default 9000
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_horse.spawn_chance = tonumber(core.settings:get("horse.spawn_chance")) or 9000
