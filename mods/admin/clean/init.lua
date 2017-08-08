-- LICENSE: WTFPL
-- Copyright: PilzAdam

local old_nodes = {}
local old_entities = {
	-- Broken
	'animal_chicken:chicken',
	'animal_sheep:sheep',
	'animal_sheep:sheep_naked',
	'animal_dm:dm',
	'sneeker:sneeker',
	-- Replaced
	'spidermob:spider',
	'mob_oerkki:oerkki',  -- animals_modpack
	'creatures:oerrki',  -- mob-engine
}

-- Old/Missing nodes that should be replaced with something currently in game
local replace_nodes = {
	-- Craft guides
	{'craft_guide:sign_wall', 'craftguide:sign'},
	-- Old homedecor nodes
	{'homedecor:glowlight_small_cube_white', 'homedecor:glowlight_small_cube'},
	-- Discontinued
	{'kpgmobs:horse', 'mob_horse:horse'},
	{'kpgmobs:horse2', 'mob_horse:horse'},
	{'kpgmobs:horse3', 'mob_horse:horse'},
	{'kpgmobs:horsearah1', 'mob_horse:horse'},
	{'kpgmobs:horseh1', 'mob_horse:horse'},
	{'kpgmobs:horsepegh1', 'mob_horse:horse'},
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
        minetest.remove_node(pos)
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
