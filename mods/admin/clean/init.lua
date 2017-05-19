-- LICENSE: WTFPL
-- Copyright: PilzAdam

local old_nodes = {'mod:a', 'mod:b'}
local old_entities = {'mobs_mc:skeleton', 'mobs_mc:creeper', 'kpgmobs:sheep'}

-- Old/Missing nodes that should be replaced with something currently in game
local replace_nodes = {
    {'homedecor:bed_regular', 'homedecor:bed_white_regular'},
    {'homedecor:bed_extended', 'homedecor:bed_white_extended'},
    {'homedecor:bed_kingsize', 'homedecor:bed_white_kingsize'},
    {'lrfurn:armchair', 'lrfurn:armchair_white'},
    {'craft_guide:sign_wall', 'craftguide:sign'},
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
