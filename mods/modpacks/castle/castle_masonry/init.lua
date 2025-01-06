castle_masonry = {}

castle_masonry.sounds = {}

if minetest.get_modpath("default") then
	castle_masonry.sounds = default
end

if minetest.get_modpath("mcl_sounds") then
	castle_masonry.sounds = mcl_sounds
end

local MP = minetest.get_modpath(minetest.get_current_modname())

dofile(MP.."/pillars.lua")
dofile(MP.."/arrow_slits.lua")
dofile(MP.."/murder_holes.lua")
dofile(MP.."/stone_wall.lua")
dofile(MP.."/paving.lua")


local S = minetest.get_translator("castle_masonry")

local read_setting = function(name, default)
	local setting = minetest.settings:get_bool(name)
	if not setting then return default end
	return setting
end

-- Material definition:
-- {
--	name=, -- the name that will be part of the resulting node names
--	desc=, -- Player-facing name of the material
--	tile=, -- Optional - the texture tile to use for the resulting blocks (can be a single texture or a table, as a normal node definition's tile def). If not set this will be taken from the material it's made out of.
--	craft_material=, -- What source block is used to craft these blocks.
--	composition_material=, -- Optional, this will override the properties of the product with a specific material. Useful if you want to use a group for the craft material (eg, "group:wood")
--}

castle_masonry.materials = {}

local function register_material(def, setting_default)
	if read_setting("castle_masonry_" .. def.name, setting_default) then
		table.insert(castle_masonry.materials, def)
	end
end

-- castle masonry materials
register_material({name="stonewall", desc=S("Stonewall"), tile="castle_stonewall.png", craft_material="castle_masonry:stonewall"}, true)

-- MTG materials
if minetest.get_modpath("default") then
	register_material({name="cobble", desc=S("Cobble"), tile="default_cobble.png", craft_material="default:cobble"}, true)
	register_material({name="stonebrick", desc=S("Stonebrick"), tile="default_stone_brick.png", craft_material="default:stonebrick"}, true)
	register_material({name="stone", desc=S("Stone"), tile="default_stone.png", craft_material="default:stone"}, true)
	register_material({name="wood", desc=S("Wood"), tile="default_wood.png", craft_material="group:wood", composition_material="default:wood"})
	register_material({name="ice", desc=S("Ice"), tile="default_ice.png", craft_material="default:ice"})
	register_material({name="snow", desc=S("Snow"), tile="default_snow.png", craft_material="default:snow"})
	register_material({name="sandstone", desc=S("Sandstone"), tile="default_sandstone.png", craft_material="default:sandstone"}, true)
	register_material({name="sandstonebrick", desc=S("Sandstone Brick"), tile="default_sandstone_brick.png", craft_material="default:sandstonebrick"}, true)
	register_material({name="desertstonebrick", desc=S("Desert Stone Brick"), tile="default_desert_stone_brick.png", craft_material="default:desert_stonebrick"}, true)
	register_material({name="desertsandstonebrick", desc=S("Desert Sandstone Brick"), tile="default_desert_sandstone_brick.png", craft_material="default:desert_sandstone_brick"}, true)
	register_material({name="silversandstonebrick", desc=S("Silver Sandstone Brick"), tile="default_silver_sandstone_brick.png", craft_material="default:silver_sandstone_brick"}, true)
	register_material({name="desertstone", desc=S("Desert Stone"), tile="default_desert_stone.png", craft_material="default:desert_stone"}, true)
	register_material({name="desertsandstone", desc=S("Desert Sandstone"), tile="default_desert_sandstone.png", craft_material="default:desert_sandstone"}, true)
	register_material({name="silversandstone", desc=S("Silver Sandstone"), tile="default_silver_sandstone.png", craft_material="default:silver_sandstone"}, true)
	register_material({name="obsidianbrick", desc=S("Obsidian Brick"), tile="default_obsidian_brick.png", craft_material="default:obsidianbrick"})
end

-- MCL materials
if minetest.get_modpath("mcl_core") then
	register_material({name="cobble", desc=S("Cobble"), craft_material="group:cobble", composition_material="mcl_core:cobble"}, true)
	register_material({name="stonebrick", desc=S("Stonebrick"), craft_material="mcl_core:stonebrick"}, true)
	register_material({name="stone", desc=S("Stone"), craft_material="group:stone", composition_material="mcl_core:stone"}, true)
	register_material({name="ice", desc=S("Ice"), craft_material="mcl_core:packed_ice"})
	register_material({name="snow", desc=S("Snow"), craft_material="mcl_core:snowblock"})
	register_material({name="sandstone", desc=S("Sandstone"), craft_material="mcl_core:sandstone"}, true)
	register_material({name="redsandstone", desc=S("Red Sandstone"), craft_material="mcl_core:redsandstone"}, true)
end
-- wood ids are different in MineClonia and Mineclone2, mcl_trees is part of MineClonia
if minetest.get_modpath("mcl_trees") then
	register_material({name="wood", desc=S("Wood"), craft_material="group:wood", composition_material="mcl_trees:wood_oak"})
elseif minetest.get_modpath("mcl_core") then
	register_material({name="wood", desc=S("Wood"), craft_material="group:wood", composition_material="mcl_core:wood"})
end
if minetest.get_modpath("mcl_nether") then
	register_material({name="quartz", desc=S("Quartz"), craft_material="mcl_nether:quartz_block"}, true)
end
if minetest.get_modpath("mcl_blackstone") then
	register_material({name="blackstone", desc=S("Blackstone"), craft_material="mcl_blackstone:blackstone_brick_polished"}, true)
end
if minetest.get_modpath("mcl_deepslate") then
	register_material({name="deepslate_bricks", desc=S("Deepslate Bricks"), craft_material="mcl_deepslate:deepslate_bricks"}, true)
	register_material({name="deepslate_tiles", desc=S("Deepslate Tiles"), craft_material="mcl_deepslate:deepslate_tiles"}, true)
end


castle_masonry.get_material_properties = function(material)
	local composition_def
	local burn_time
	if material.composition_material ~= nil then
		composition_def = minetest.registered_nodes[material.composition_material]
		burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack(material.composition_material)}}).time
	else
		composition_def = minetest.registered_nodes[material.craft_material]
		burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack(material.craft_material)}}).time
	end

	local tiles = material.tile
	if tiles == nil then
		tiles = composition_def.tiles
	elseif type(tiles) == "string" then
		tiles = {tiles}
	end

	local desc = material.desc
	if desc == nil then
		desc = composition_def.description
	end

	return composition_def, burn_time, tiles, desc
end


if read_setting("castle_masonry_pillar", true) then
	for _, material in pairs(castle_masonry.materials) do
		castle_masonry.register_pillar(material)
	end
end

if read_setting("castle_masonry_arrowslit", true) then
	for _, material in pairs(castle_masonry.materials) do
		castle_masonry.register_arrowslit(material)
	end
end

if read_setting("castle_masonry_murderhole", true) then
	for _, material in pairs(castle_masonry.materials) do
		castle_masonry.register_murderhole(material)
	end
end

minetest.register_alias("castle:pillars_bottom", "castle_masonry:pillars_stonewall_bottom")
minetest.register_alias("castle:pillars_top", "castle_masonry:pillars_stonewall_top")
minetest.register_alias("castle:pillars_middle", "castle_masonry:pillars_stonewall_middle")
minetest.register_alias("castle:arrowslit", "castle_masonry:arrowslit_stonewall")
minetest.register_alias("castle:arrowslit_hole", "castle_masonry:arrowslit_stonewall_hole")
minetest.register_alias("castle:arrowslit_cross", "castle_masonry:arrowslit_stonewall_cross")

for _, material in pairs(castle_masonry.materials) do
	castle_masonry.register_murderhole_alias("castle", material.name, "castle_masonry", material.name)
	castle_masonry.register_pillar_alias("castle", material.name, "castle_masonry", material.name)

	-- Arrowslit upgrade has special handling because the castle mod arrow slit is reversed relative to current build-from-inside standard
	local lbm_def = {
		name = "castle_masonry:arrowslit_flip_front_to_back"..material.name,
		run_at_every_load = false,
		nodenames = {
			"castle:arrowslit_"..material.name,
			"castle:arrowslit_"..material.name.."_cross",
			"castle:arrowslit_"..material.name.."_hole",
		},
		action = function(pos, node)
			local flip_front_to_back = {[0]=2, 3, 0, 1, 6, 7, 4, 5, 10, 7, 8, 9, 14, 15, 12, 13, 18, 19, 16, 17, 22, 23, 20, 21}
			node.param2 = flip_front_to_back[node.param2]
			node.name = "castle_masonry" .. string.sub(node.name, 7, -1)
			minetest.swap_node(pos, node)
		end
	}
	minetest.register_lbm(lbm_def)
end
