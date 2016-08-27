print("Obsidian tools")

dofile(minetest.get_modpath("tools_obsidian").."/sword.lua")

minetest.register_alias("sword_obsidian", "tools_obsidian:sword_obsidian")
minetest.register_alias("longsword_obsidian", "tools_obsidian:longsword_obsidian")
minetest.register_alias("dagger_obsidian", "tools_obsidian:dagger_obsidian")