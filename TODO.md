## A list of changes to make for Antum game


#### Bugs to fix
* ethereal
    * setting bonemeal causes server to crash

#### Recipes with undefined ingredients:
* dye
	* dye:black
	* dye:cyan
	* dye:dark_green
	* dye:dark_grey
	* dye:green
	* dye:grey
	* dye:magenta
	* dye:pink

#### Recipes that are unusable due to redefinition or override:
* my_future_doors (sliding doors all use same recipe)
	* my_future_doors:door2a (Steel Sliding Door)
	* my_future_doors:door3a (Squared Sliding Door)
	* my_future_doors:door4a (Dark Sliding Door)
	* my_future_doors:door6a (Points Sliding Door)
	* my_future_doors:door7a (Snow Flake Sliding Door)
* my_misc_doors (sliding doors all use same recipe)
	* my_misc_doors:door2a (Sliding Door)

#### Duplicate recipes:

#### Craft recipes to override:
* bags:
	* small
		* Use leather & thread
	* medium
		* Use 9 small bags
	* large
		* Use 9 mediaum bags
* default:
	* book
		* 3 paper, 3 ???
	* furnace
		* Add coal or something similar to recipe

#### Aliases that do not register:
* farming_plus:
	* farming:cotton -> farming:cotton_3
* moreblocks:
	* stairs:stair_stone -> moreblocks:stair_stone
	* stairs:slab_stone -> moreblocks:slab_stone
	* stairs:stair_cobble -> moreblocks:stair_cobble

#### Craft items that need new aliases
* my_future_doors
	* my_future_doors:door2a
	* my_future_doors:door3a
	* my_future_doors:door4a
	* my_future_doors:door6a
	* my_future_doors:door7a
* my_misc_doors
	* my_misc_doors:door2a

#### Craft items that need new descriptions

#### Craft items that need new inventory textures

#### Items that do not function correctly
* moreblocks:glow_glass & moreblocks:super_glow_glass
	* Make work with connected glass setting

#### Items to make work with walking_light
* ethereal:candle

#### Nodes that are too common in game

#### Nodes that do not work right
* my_future_doors:
	* door*a
* jukebox:
	* box

#### Glass nodes to make connected

#### Mods to create/look for
* adamantine:
	* ore & tools

#### Remove old mods replaced by 'minetest' game modpack
* dye
* screwdriver
* sethome
* stairs
* tnt
* vessels
* walls
* wool
* xpanes
