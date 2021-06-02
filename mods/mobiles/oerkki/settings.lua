
--- Entity lifespan.
--
--  @setting oerkki.lifetime
--  @settype int
--  @default 540 (9 minutes)
cmer_oerkki.lifetime = tonumber(core.settings:get("oerkki.lifetime")) or 9 * 60

--- Spawn rate frequency.
--
--
--  @setting oerkki.spawn_interval
--  @settype int
--  @default 55
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_oerkki.spawn_interval = tonumber(core.settings:get("oerkki.spawn_interval")) or 55

--- Chance of spawn at interval.
--
--  @setting oerkki.spawn_chance
--  @settype int
--  @default 7800
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_oerkki.spawn_chance = tonumber(core.settings:get("oerkki.spawn_chance")) or 7800
