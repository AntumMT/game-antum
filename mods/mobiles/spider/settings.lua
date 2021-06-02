
--- Entity lifespan.
--
--  @setting spider.lifetime
--  @settype int
--  @default 600 (10 minutes)
cmer_spider.lifetime = tonumber(core.settings:get("spider.lifetime")) or 10 * 60

--- Spawn rate frequency.
--
--
--  @setting spider.spawn_interval
--  @settype int
--  @default 60 (1 minute)
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_spider.spawn_interval = tonumber(core.settings:get("spider.spawn_interval")) or 60

--- Chance of spawn at interval.
--
--  @setting spider.spawn_chance
--  @settype int
--  @default 7500
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_spider.spawn_chance = tonumber(core.settings:get("spider.spawn_chance")) or 7500
