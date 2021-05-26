
-- Place spawners in dungeons

local function place_spawner(tab)
	local pos = tab[math.random(1, (#tab or 4))]
	pos.y = pos.y - 1
	local n = core.get_node_or_nil(pos)
	if n and n.name ~= "air" then
		pos.y = pos.y + 1
		core.set_node(pos, {name="creatures:zombie_spawner"})
	end
end

core.set_gen_notify("dungeon")

core.register_on_generated(function(minp, maxp, blockseed)
	local ntf = core.get_mapgen_object("gennotify")
	if ntf and ntf.dungeon and #ntf.dungeon > 3 then
		core.after(3, place_spawner, table.copy(ntf.dungeon))
	end
end)
