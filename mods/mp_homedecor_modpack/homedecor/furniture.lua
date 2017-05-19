local S = homedecor.gettext

local table_colors = {
	{ "",           S("Table"),           homedecor.plain_wood },
	{ "_mahogany",  S("Mahogany Table"),  homedecor.mahogany_wood },
	{ "_white",     S("White Table"),     homedecor.white_wood }
}

for _, t in ipairs(table_colors) do
	local suffix, desc, texture = unpack(t)

	homedecor.register("table"..suffix, {
		description = desc,
		tiles = { texture },
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3,  0.4, -0.3 },
				{  0.3, -0.5, -0.4,  0.4,  0.4, -0.3 },
				{ -0.4, -0.5,  0.3, -0.3,  0.4,  0.4 },
				{  0.3, -0.5,  0.3,  0.4,  0.4,  0.4 },
				{ -0.5,  0.4, -0.5,  0.5,  0.5,  0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1,  0.3 },
				{  0.3, -0.2, -0.4,  0.4, -0.1,  0.3 },
				{ -0.3, -0.2, -0.4,  0.4, -0.1, -0.3 },
				{ -0.3, -0.2,  0.3,  0.3, -0.1,  0.4 },
			},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
	})
end

local chaircolors = {
	{ "",           S("plain") },
	{ "black",      S("black") },
	{ "red",        S("red") },
	{ "pink",       S("pink") },
	{ "violet",     S("violet") },
	{ "blue",       S("blue") },
	{ "dark_green", S("dark green") },
}

local kc_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125 },
}

local ac_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5 },
		{-0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	}
}

for _, t in ipairs(chaircolors) do

	local woolcolor, colordesc = unpack(t)
	local color = woolcolor
	local chairtiles

	if woolcolor == "" then
		chairtiles = {
			homedecor.plain_wood,
			homedecor.plain_wood
		}
	else
		color = "_"..woolcolor
		chairtiles = {
			homedecor.plain_wood,
			"wool"..color..".png",
		}
	end

	homedecor.register("chair"..color, {
		description = S("Kitchen chair (@1)", colordesc),
		mesh = "homedecor_kitchen_chair.obj",
		tiles = chairtiles,
		selection_box = kc_cbox,
		collision_box = kc_cbox,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			pos.y = pos.y+0 -- where do I put my ass ?
			homedecor.sit(pos, node, clicker)
			return itemstack
		end
	})

	if color ~= "" then
		homedecor.register("armchair"..color, {
			description = S("Armchair (@1)", colordesc),
			mesh = "forniture_armchair.obj",
			tiles = {
				"wool"..color..".png",
				"wool_dark_grey.png",
				"default_wood.png"
			},
			groups = {snappy=3},
			sounds = default.node_sound_wood_defaults(),
			node_box = ac_cbox
		})

		minetest.register_craft({
			output = "homedecor:armchair"..color.." 2",
			recipe = {
			{ "wool:"..woolcolor,""},
			{ "group:wood","group:wood" },
			{ "wool:"..woolcolor,"wool:"..woolcolor },
			},
		})
	end
end

local ob_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
}

minetest.register_node(":homedecor:openframe_bookshelf", {
	description = S("Bookshelf (open-frame)"),
	drawtype = "mesh",
	mesh = "homedecor_openframe_bookshelf.obj",
	tiles = {
		"homedecor_openframe_bookshelf_books.png",
		"default_wood.png"
	},
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = ob_cbox,
	collision_box = ob_cbox,
})

homedecor.register("wall_shelf", {
	description = S("Wall Shelf"),
	tiles = {
		"homedecor_wood_table_large_edges.png",
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4, 0.47, 0.5, 0.47, 0.5},
			{-0.5, 0.47, -0.1875, 0.5, 0.5, 0.5}
		}
	}
})

-- Aliases for 3dforniture mod.

minetest.register_alias("3dforniture:table", "homedecor:table")
minetest.register_alias("3dforniture:chair", "homedecor:chair")
minetest.register_alias("3dforniture:armchair", "homedecor:armchair_black")
minetest.register_alias("homedecor:armchair", "homedecor:armchair_black")

minetest.register_alias('table', 'homedecor:table')
minetest.register_alias('chair', 'homedecor:chair')
minetest.register_alias('armchair', 'homedecor:armchair')
