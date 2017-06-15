## A list of changes to make for Antum game


---

### Bugs

---

### Nodes

#### Nodes that are too common in game

#### Sleeping
* beds
    * add option to allow night skip for single player in bed

#### Nodes that should emit light, but don't
* homedecor:candle???

#### Damage
* trampoline
    * player should not receive damage from falling on tramp

#### Glass nodes to make connected

---

### Broken nodes

#### Doors
* my_future_doors:door\*a

#### Misc
* jukebox:box

---

### Entities

#### Duplicate mobiles types
* mobs:sheep

#### Overspawning
* sneeker:sneeker

#### Convert to 'mobs_redo' engine
* sneeker:sneeker
* spidermob
* cme:sheep

#### Misc
* cme:sheep
    * make only drop wool when shorn (or killed)

---

### Crafting

#### Recipes to override / change
* craftguide:sign
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

#### Items to make work with 'walking_light'
* ethereal:candle
* moreblocks:glow_glass
* moreblocks:super_glow_glass

#### Items that need new aliases
* my_future_doors
	* my_future_doors:door2a
	* my_future_doors:door3a
	* my_future_doors:door4a
	* my_future_doors:door6a
	* my_future_doors:door7a
* my_misc_doors
	* my_misc_doors:door2a

#### Items that need new descriptions

#### Items that need new inventory textures

#### Duplicates or items with similar function
* mobs:magic_lasso
    * lasso???

---

### Broken items

---

### Tools / Weapons / Equipment

#### Add optional setting to disable wear/break
* all weapons
* all armor

---

### Alternate / Additional mods

#### Mods to create/look for
* adamantine
	* ore & tools
* colored_glass
    * use node coloring
