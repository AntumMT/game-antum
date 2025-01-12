
-- common settings

whinny.creative = core.settings:get_bool("creative_mode", false)

whinny.enable_damage = core.settings:get_bool("enable_damage", true)

whinny.turn_player_look = core.settings:get_bool("mount_turn_player_look", true)


-- mobs_redo settings

whinny.display_spawn = core.settings:get_bool("display_mob_spawn", false) -- deprecated?


-- unique settings

whinny.peaceful_only = core.settings:get_bool("whinny.peaceful_only", true)

whinny.spawn_chance = tonumber(core.settings:get("whinny.spawn_chance") or 50000)

whinny.spawn_height_min = tonumber(core.settings:get("whinny.spawn_height_min") or -500)

whinny.spawn_height_max = tonumber(core.settings:get("whinny.spawn_height_max") or 500)

--- Comma-separated list of nodes on which horses can spawn.
--
--  @setting whinny.spawn_nodes
--  @settype string
--  @default default:dirt_with_grass,default:dirt_with_dry_grass
whinny.spawn_nodes = {}

local spawn_nodes = core.settings:get("whinny.spawn_nodes") or "default:dirt_with_grass,default:dirt_with_dry_grass"
if not spawn_nodes:find(",") then
	table.insert(whinny.spawn_nodes, spawn_nodes)
else
	for _, node_name in ipairs(spawn_nodes:split(",")) do
		table.insert(whinny.spawn_nodes, node_name:trim())
	end
end


--- Comma-separated list of key=value pairs of items used to tame horses.
--
-- - key: item name
-- - value: filling value (higher means less required to tame)
--
-- @setting whinny.fill_values
-- @settype string
-- @default default:apple=2,farming:wheat=1,farming:barley=3,farming:oat=5,farming:carrot=4,farming:carrot_gold=5,farming:cucumber=2
whinny.fill_values = {}

local function parse_fill_item(item)
	if not item:find("=") then
		whinny.log("warning", "invalid key=value pair in setting 'whinny.fill_values': " .. item)
		return
	end
	local def = item:split("=")
	local key = def[1]:trim()
	local value = tonumber(def[2])
	if value == nil then
		whinny.log("warning", "value must be a number setting 'whinny.fill_values': " .. item)
		return
	end
	whinny.fill_values[key] = value
end

local fill_values = core.settings:get("whinny.fill_values") or "default:apple=2,farming:wheat=1,farming:barley=3,farming:oat=5,farming:carrot=4,farming:carrot_gold=5,farming:cucumber=2"
if not fill_values:find(",") then
	if fill_values ~= "" then
		parse_fill_item(fill_values)
	end
else
	for _, item in ipairs(fill_values:split(",")) do
		parse_fill_item(item)
	end
end


--- Value required to tame horse with food.
--
-- Must be 1 or more.
--
-- @setting whinny.appetite
-- @settype int
-- @default 40
whinny.appetite = tonumber(core.settings:get("whinny.appetite")) or 40
if whinny.appetite < 1 then
	whinny.appetite = 40
end


--- Name of item that player can wield to place horse in inventory.
--
--  @setting whinny.pickup_with
--  @settype string
--  @default mobs:lasso
whinny.pickup_with = core.settings:get("whinny.pickup_with") or "mobs:lasso"
