
--- Spawn rate frequency.
--
--
--  @setting kitten.spawn_interval
--  @settype int
--  @default 60
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
mobs_kitten.spawn_interval = tonumber(core.settings:get("kitten.spawn_interval")) or 60

--- Chance of spawn at interval.
--
--  @setting kitten.spawn_chance
--  @settype int
--  @default 10000
--  @see [ABM definition](http://minetest.gitlab.io/minetest/definition-tables.html#abm-activeblockmodifier-definition)
mobs_kitten.spawn_chance = tonumber(core.settings:get("kitten.spawn_chance")) or 10000 -- 22000
