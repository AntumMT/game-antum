
if core.registered_nodes["moretrees:rubber_tree_leaves"] then
	core.override_item("moretrees:rubber_tree_leaves", {
		drawtype = "plantlike",
		visual_scale = 1.4,
		walkable = core.settings:get_bool("ethereal.leafwalk", false),
	})
end
