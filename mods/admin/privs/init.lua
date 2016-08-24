-- License: CC0

local priv = {}

priv.bookmarks = "bookmarks"

minetest.register_privilege(priv.bookmarks, {
	description = "Can set & use bookmarks",
	}
)
