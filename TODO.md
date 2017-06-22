## A list of changes to make for Antum game


---

### Game data
* Add custom game header image

---

### Nodes

#### Duplicates or similar function
* homedecor:bed_*
	* beds:bed_*

#### Too common in game

#### Function changes
* trampoline
    * player should not receive damage from falling on tramp

#### Should emit light, but don't
* homedecor:candle???

#### Glass nodes to make connected

#### Broken
* Doors
	* my_future_doors:door\*a
* Misc
	* jukebox:box

#### Fix unknown


---

### Entities

#### Spawn/Death
* Use max spawn instead of timeout
* Reduce spawn rate
	* creatures:sheep
	* sneeker:sneeker

#### Duplicates
* mobs:sheep

#### Engine changes
* Convert to 'mobs' (mobs_redo)
	* creature:sheep???
	* sneeker:sneeker
* Unify mobiles/engines


---

### Crafting

#### Recipes to override / change
* default:book
    * 3 paper, 3 ???

#### Undefined ingredients:
* dye
	* dye:black
	* dye:cyan
	* dye:dark_green
	* dye:dark_grey
	* dye:green
	* dye:grey
	* dye:magenta
	* dye:pink

#### Unusable due to redefinition or override:
* my_future_doors (sliding doors all use same recipe)
	* my_future_doors:door2a (Steel Sliding Door)
	* my_future_doors:door3a (Squared Sliding Door)
	* my_future_doors:door4a (Dark Sliding Door)
	* my_future_doors:door6a (Points Sliding Door)
	* my_future_doors:door7a (Snow Flake Sliding Door)
* my_misc_doors (sliding doors all use same recipe)
	* my_misc_doors:door2a (Sliding Door)

#### Duplicate recipes:

#### Aliases that do not register:


---

### Items

#### To make work with 'walking_light'
* ethereal:candle
* moreblocks:glow_glass
* moreblocks:super_glow_glass

#### Need new/more aliases
* my_future_doors
	* my_future_doors:door2a
	* my_future_doors:door3a
	* my_future_doors:door4a
	* my_future_doors:door6a
	* my_future_doors:door7a
* my_misc_doors
	* my_misc_doors:door2a

#### Need new descriptions

#### Need new inventory textures

#### Duplicates or items with similar function

#### Fix unknown

#### Broken


---

### Tools / Weapons / Equipment

#### Add optional setting to disable wear/break
* all weapons
* all armor
* creatures:shears
* mobs:shears
* technic:treetap

#### Change/Add/Understand function
* compassgps
	* How to reset


---

### Alternate / Additional mods

#### Mods to create/look for
* adamantine
	* ore & tools
* colored_glass
    * use node coloring


---

### World

#### Weather
* Make snow only in cold biomes

#### Misc
* Look at 'remove far entities' option


---

### UI

#### Inventory
* Switch to 'sfinv'
* Convert to use 'sfinv'
	* bags
