# more_chests
Originally a fork of 0gb.us's chests_0gb_us (https://forum.minetest.net/viewtopic.php?f=11&t=4366).  
Megaf's more_chests fixes several bugs, uses new textures and adds compatibility with [VanessaE's Pipeworks] (https://github.com/VanessaE/pipeworks) mod.  
nxet's rework introduces a new backend which allows for easier extension of the available models, including two new models showcasing the feature.


### Available models
> NOTE: descriptions of the original models come from 0gb.us initial effort

#### Cobble Chest
This locked chest looks like cobblestone, and has no info text. Great for hiding things in. However, unlike real cobblestone, this chest is breakable by hand. If you suspect there is one hiding, hold the left mouse button and run your hand along the walls. When cracks appear, you've found the chest.
1 | 2 | 3
---|---|---
default:wood | default:cobble | default:wood
default:cobble | default:steel_ingot | default:cobble
default:wood | default:cobble | default:wood


#### Drop Box
Anyone can put things in, but only the chest's placer can remove items.
1 | 2 | 3
---|---|---
default:wood | _empty_ | default:wood
default:wood | default:steel_ingot | default:wood
default:wood | default:wood | default:wood


#### Secret Chest
As long as you remember to click "close" before you leave the chest, no one can see what the chest contains. Only the chest's owner can click "open" and "close" on the chest's formspec, revealing and hiding the chest's contents.
1 | 2 | 3
---|---|---
default:wood | default:cobble | default:wood
default:wood | default:steel_ingot | default:wood
default:wood | default:wood | default:wood


#### Shared Chest
Exactly what it sounds like. The chest's placer can add people to the chest's shared list using the chest's formspec. Warning: anyone you add may empty the chest. When the chest is empty, it can be mined by anyone, just like a regular locked chest.
1 | 2 | 3
---|---|---
default:wood | default:leaves | default:wood
default:wood | default:steel_ingot | default:wood
default:wood | default:wood | default:wood


#### Wifi Chest
A wacky chest that doesn't store it's items in the usual way, but instead, stores them remotely. For that reason, all wifi chests appear to have the same inventory. Due to not actually having an inventory, wifi chests can also be mined, even when they appear to have stuff in them. Lastly, as everyone gets their own wifi account, the items you see in the wifi chest are not the same items anyone else sees. This chest's properties make it nice for keeping secrets, as well as essentially almost doubling your inventory space, if you choose to carry one with you.
1 | 2 | 3
---|---|---
default:wood | default:mese | default:wood
default:wood | default:steel_ingot | default:wood
default:wood | default:wood | default:wood


#### Fridge
A new model which comes in two forms, 1- and 2-block tall, which indeed have different sizes inventories. No fancy functionality here, I just wanted to know at a glance which one is the chest I'm storing food into.

###### Fridge Recipe
1 | 2 | 3
---|---|---
_empty_ | default:steel_ingot | _empty_
default:steel_ingot | default:ice | default:steel_ingot
_empty_ | default:steel_ingot | _empty_

###### Big Fridge Recipe
1 | 2 | 3
---|---|---
default:steel_ingot | default:steel_ingot | default:steel_ingot
default:steel_ingot | default:ice | default:steel_ingot
default:steel_ingot | default:steel_ingot | default:steel_ingot


#### Toolbox
This model has no particular functionality to offer other than giving your tools' chest a new look. As a bonus you can also craft the chest with different types of wood, which will give you different results. For the fanciest garage workshop you ever built on Minetest.
1 | 2 | 3
---|---|---
default:wood | default:wood | default:wood
default:wood | default:pickaxe | default:wood
default:wood | default:wood | default:wood
> Note: crafting also accepts Aspen, Acacia, Junglewood, Pine and Steel instead of wood
