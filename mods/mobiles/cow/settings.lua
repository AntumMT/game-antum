
--- Spawn rate frequency.
--
--
--  @setting cow.spawn_interval
--  @settype int
--  @default 60
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
mobs_cow.spawn_interval = tonumber(core.settings:get("cow.spawn_interval")) or 60

--- Chance of spawn at interval.
--
--  @setting cow.spawn_chance
--  @settype int
--  @default 8000
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
mobs_cow.spawn_chance = tonumber(core.settings:get("cow.spawn_chance")) or 8000
