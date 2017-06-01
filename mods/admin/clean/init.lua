-- LICENSE: WTFPL
-- Copyright: PilzAdam

local old_nodes = {'mod:a', 'mod:b'}
local old_entities = {
	'creeper:creeper',
	'kpgmobs:bee',
	'kpgmobs:cow',
	'kpgmobs:horse',
	'kpgmobs:horse2',
	'kpgmobs:medved',
	'kpgmobs:sheep',
	'mobs_animal:sheep_black',
	'mobs_animal:sheep_blue',
	'mobs_animal:sheep_brown',
	'mobs_animal:sheep_cyan',
	'mobs_animal:sheep_dark_green',
	'mobs_animal:sheep_dark_grey',
	'mobs_animal:sheep_green',
	'mobs_animal:sheep_grey',
	'mobs_animal:sheep_magenta',
	'mobs_animal:sheep_orange',
	'mobs_animal:sheep_pink',
	'mobs_animal:sheep_red',
	'mobs_animal:sheep_violet',
	'mobs_animal:sheep_white',
	'mobs_animal:sheep_yellow',
	'mobs_mc:skeleton',
	'mobs_mc:creeper',
	}

-- Old/Missing nodes that should be replaced with something currently in game
local replace_nodes = {
	{'creeper:spawnegg', 'sneeker:spawnegg'},
    {'homedecor:bed_regular', 'homedecor:bed_white_regular'},
    {'homedecor:bed_extended', 'homedecor:bed_white_extended'},
    {'homedecor:bed_kingsize', 'homedecor:bed_white_kingsize'},
    {'homedecor:book_open', 'homedecor:book_open_brown'},
    {'homedecor:glowlight_half', 'homedecor:glowlight_half_white'},
    {'homedecor:glowlight_quarter', 'homedecor:glowlight_quarter_white'},
    {'homedecor:kitchen_chair_wood', 'homedecor:chair'},
    {'homedecor:shutter', 'homedecor:shutter_oak'},
    {'kpgmobs:meat', 'mobs:meat'},
    {'kpgmobs:meat_raw', 'mobs:meat_raw'},
    {'lrfurn:armchair', 'lrfurn:armchair_white'},
    {'craft_guide:sign_wall', 'craftguide:sign'},
    {'stairsplus:panel_cobble_vertical', 'moreblocks:panel_cobble'},
    {'torches:floor', 'default:torch'},
}


-- "Replaces" an old/non-existent node
local function replace_node(old_node, new_node)
    minetest.register_alias(old_node, new_node)
end


for _,node_name in ipairs(old_nodes) do
    minetest.register_node(':'..node_name, {
        groups = {old=1},
    })
end

minetest.register_abm({
    nodenames = {'group:old'},
    interval = 1,
    chance = 1,
    action = function(pos, node)
        minetest.env:remove_node(pos)
    end,
})

for _,entity_name in ipairs(old_entities) do
    minetest.register_entity(':'..entity_name, {
        on_activate = function(self, staticdata)
            self.object:remove()
        end,
    })
end

-- Replace old nodes
for _, node_group in pairs(replace_nodes) do
    replace_node(node_group[1], node_group[2])
end
