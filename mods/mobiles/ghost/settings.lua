
--- Entity lifespan.
--
--  @setting ghost.lifetime
--  @settype int
--  @default 300
cmer_ghost.lifetime = tonumber(core.settings:get("ghost.lifetime")) or 300

--- Spawn rate frequency.
--
--
--  @setting ghost.spawn_interval
--  @settype int
--  @default 40
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_ghost.spawn_interval = tonumber(core.settings:get("ghost.spawn_interval")) or 40

--- Chance of spawn at interval.
--
--  @setting ghost.spawn_chance
--  @settype int
--  @default 7300
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
cmer_ghost.spawn_chance = tonumber(core.settings:get("ghost.spawn_chance")) or 7300
