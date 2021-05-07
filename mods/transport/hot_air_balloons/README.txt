This mod adds craftable and ridable hot air balloons to minetest.
Controls:
	right click with fuel item: increase heat and buoyancy (*)
	right click without coal: enter or leave balloon
	left, right, up, down (default WASD): accelerate the balloon
	sneak (default shift): decrease heat, lowering buoyancy
	jump (default space): turn the balloon towards where the player is looking



optional dependencies:
	default, bucket (enable crafting recipe 1 if installed together)
	mcl_core, mcl_mobitems, mcl_buckets (enable crafting recipe 2 if installed together)


Crafting recipe 1 (Minetest Game and most derivatives):
[P] := paper
[W] := wood
[L] := lava bucket
[ ] := nothing

[P][P][P]
[P][L][P]
[ ][W][ ]

Crafting recipe 2 (MineClone 2):
[L] := leather
[W] := wood
[V] := lava bucket
[S] := string

[L][L][L]
[L][V][L]
[S][W][S]

See license.txt for proper license information.

Author of code
----------------------------------------
NetherEran (LGPL v2.1)

Authors of media (models, textures)
----------------------------------------
Textures
--------
NetherEran (CC BY-SA 3.0):
	hot_air_balloons_balloon.png
	hot_air_balloons_balloon_flame.png
	hot_air_balloons_balloon_model.png --Contains default_wood.png (by BlockMen) and default_aspen_wood.png (by sofar) (derived from default_pine_wood by paramat)

Models
--------
NetherEran (CC BY-SA 3.0):
	ballon.blend (= hot_air_balloons_balloon.obj)
