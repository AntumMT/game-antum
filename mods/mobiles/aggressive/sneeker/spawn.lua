-- Original code by Rui: WTFPL


local time_min = 60
local time_hr = time_min * 60
local time_day = time_hr * 24

local spawn_cap = tonumber(minetest.settings:get('sneeker.spawn_cap')) or 10 -- Maximum number of spawns active at one time
local spawn_chance = tonumber(minetest.settings:get('sneeker.spawn_chance')) or 1000 -- 1/1000 chance of spawn
local spawn_interval = tonumber(minetest.settings:get('sneeker.spawn_interval')) or time_min * 4 -- Default interval is 4 minutes
local spawn_maxlight = tonumber(minetest.settings:get('sneeker.spawn_maxlight')) or 5 -- Maximum light of node for spawn

-- Display spawn chance as percentage in log
local spawn_chance_percent = math.floor(1 / spawn_chance * 100)
if spawn_chance_percent < 1 then
	spawn_chance_percent = 'Less than 1%'
else
	spawn_chance_percent = tostring(spawn_chance_percent) .. '%'
end

sneeker.log('Spawn cap: ' .. tostring(spawn_cap))
sneeker.log('Spawn chance: ' .. spawn_chance_percent)
sneeker.log('Spawn interval: ' .. tostring(spawn_interval) .. ' (' .. tostring(spawn_interval/60) .. ' minute(s))')
sneeker.log('Maximum light value for spawn: ' .. tostring(spawn_maxlight))

minetest.register_abm({
	nodenames = {'default:dirt_with_grass', 'default:stone'},
	neighbors = {'air'},
	interval = spawn_interval,
	chance = spawn_chance,
	action = function(pos, node, _, active_object_count_wider)
		if active_object_count_wider > 5 then
			return
		end
		
		-- Check light value of node
		pos.y = pos.y+1
		local node_light = minetest.get_node_light(pos)
		
		-- Debugging spawning
		sneeker.log_debug('Node light level at ' .. sneeker.get_pos_string(pos) .. ': ' .. tostring(node_light))
		
		if not node_light or node_light > spawn_maxlight or node_light < -1 then
			sneeker.log_debug('Node not dark enough for spawn')
			return
		end
		
		-- Spawn range
		if pos.y > 31000 then
			return
		end
		
		-- Node must be touching air
		if minetest.get_node(pos).name ~= 'air' then
			return
		end
		pos.y = pos.y+1
		if minetest.get_node(pos).name ~= 'air' then
			return
		end
		
		-- Get total count of sneekers in world
		local count = 0
		for I in pairs(minetest.luaentities) do
		    if minetest.luaentities[I].name == sneeker.mob_name then
		        count = count + 1
		    end
		end
		
		sneeker.log_debug('Current active spawns: ' .. tostring(count) .. '/' .. tostring(spawn_cap))
		
		if count >= spawn_cap then
			sneeker.log_debug('Max spawns reached')
			return
		end
		
		sneeker.spawn(pos)
	end
})
