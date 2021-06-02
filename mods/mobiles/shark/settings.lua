
--- Interval in seconds that specifies how often shark spawns.
--
--  @setting shark.interval
cmer_shark.interval = tonumber(core.settings:get("shark.interval")) or 60

--- Chance for each node of spawning shark at each interval.
--
--  The value is inverted. So a chance of value of 5000 equals 1/5000.
--
--  @setting shark.chance
cmer_shark.chance = tonumber(core.settings:get("shark.chance")) or 5000

--- Minimum node light required for spawning.
--
--  "0" is darkest & "14" is lightest (daylight).
--  See: [Node definition] light_source
--
--  @setting shark.min_light
cmer_shark.min_light = tonumber(core.settings:get("shark.min_light")) or 4

--- Maximum node light required for spawning.
--
--  "0" is darkest & "14" is lightest (daylight).
--  See: [Node definition] light_source
--
--  @setting shark.max_light
cmer_shark.max_light = tonumber(core.settings:get("shark.max_light")) or core.LIGHT_MAX

--- Minimum height at which shark can spawn.
--
--  @setting shark.min_height
cmer_shark.min_height = tonumber(core.settings:get("shark.min_height")) or -500

--- Maximum height at which shark can spawn.
--
--  @setting shark.max_height
cmer_shark.max_height = tonumber(core.settings:get("shark.max_height")) or 500

--- Times that shark can spawn.
--
--  Modes supported:
--  - day:   spawns during day
--  - night: spawns during night
--  - any:   spawns anytime (default)
--
--  @setting shark.spawn_time
local spawn_time = core.settings:get("shark.spawn_time") or "any"

cmer_shark.min_time = 0
cmer_shark.max_time = 23999
if spawn_time == "day" then
	cmer_shark.min_time = 6000
	cmer_shark.max_time = 19000
elseif spawn_time == "night" then
	cmer_shark.min_time = 19500
	cmer_shark.max_time = 4500
end
