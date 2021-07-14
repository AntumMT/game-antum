
local diamond = "default:diamond"
local diamond_old = "gems_encrustable:diamond"

if core.registered_items[diamond] and core.registered_items[diamond_old] then
	cleaner.register_item_replacement(diamond_old, diamond)

	-- Note: need to update cleaner to replace items in parallel with nodes
	cleaner.register_item_replacement("gems_encrustable:mineral_diamond", "default:stone")
	cleaner.register_node_replacement("gems_encrustable:mineral_diamond", "default:stone")

	local shapes = {
		"cube",
		"doublepanel",
		"halfstair",
		"micropanel",
		"microslab",
		"nanoslab",
		"panel",
		"thinstair",
	}

	for _, shape in ipairs(shapes) do
		local old_node = "gems_encrustable:mineral_diamond_" .. shape
		local new_node = "gems_encrustable:mineral_aquamarine_" .. shape

		cleaner.register_item_replacement(old_node, new_node)
		cleaner.register_node_replacement(old_node, new_node)
	end

	-- Note: gems_encrustable uses core.register_on_generated instead of registering an ore

	local mod_minerals = {
		["default"] = {"steel"},
		["moreores"] = {"gold", "mithril"},
	}

	for _, tool in ipairs({"axe", "pick", "shovel", "sword"}) do
		for modname, minerals in pairs(mod_minerals) do
			for _, mineral in ipairs(minerals) do
				local diamond_tool = "gems_encrustable:" .. tool .. "_" .. mineral .. "_diamond"
				local src_tool = modname .. ":" .. tool .. "_" .. mineral

				if core.registered_items[diamond_tool] then
					antum.overrideCraftOutput({
						type = "shapeless",
						output = diamond_tool,
						recipe = {src_tool, diamond},
					})
				else
					antum.log("warning", "not overriding craft recipe for " .. diamond_tool)
				end
			end
		end
	end
end
