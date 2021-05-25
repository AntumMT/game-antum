--
--

--- Creatures Revived Settings
--
--  @module settings.lua


--- Enables particles when swimming.
--
--  @setting creatures_enable_particles
--  @settype bool
--  @default false
cmer.enable_particles = core.settings:get_bool("creatures_enable_particles", false)

--- Disables attacking players.
--
--  @setting only_peaceful_mobs
--  @settype bool
--  @default false
cmer.allow_hostile = core.settings:get_bool("only_peaceful_mobs") ~= true

--- Enables damage.
--
--  Global setting.
--
--  @setting enable_damage
--  @settype bool
--  @default false
cmer.enable_damage = core.settings:get_bool("enable_damage", false)

--- Enables creative mode.
--
--  Global setting.
--
--  @setting creative_mode
--  @settype bool
--  @default false
cmer.creative = core.settings:get_bool("creative_mode", false)

--- Displays nametags above mobs.
--
--  @setting mobs_nametags
--  @settype bool
--  @default false
cmer.nametags = core.settings:get_bool("mobs_nametags", false)

--- Determines if owned entities can be killed by non-owners.
--
--  @setting mobs_griefing
--  @settype bool
--  @default false
cmer.griefing = core.settings:get_bool("mobs_griefing", false)
