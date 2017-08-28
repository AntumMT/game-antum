
"Slimes Redo" - Mod for Minetest (http://www.minetest.net/)

Introduction
===========================================================================
This mod adds two type of mobs in the world of Minetest: green slimes and lava slimes. They are hostile and will attack the players as soon as they see them. If they are defeated, the slimes maybe will reward the player with useful resources.

Green slimes live in the tall grass of the jungles and in the ancient ruins of lost temples. And lava slimes live deep underground near the lava pools.

Hope you like it!

Special thanks:
@TenPlus1, for all your help and amazing work to integrate Slimes with Mobs Redo.
@Jeija, for the original slimes mod (viewtopic.php?f=11&t=2979).

Details
===========================================================================
- This mod adds two new hostile mobs: green slimes and lava slimes.
- They attack players and hurt them on touch.
- The biger ones split in a random amout of smaller versions when defeated: big > medium > small.
- They use custom textures and sounds. (more work needs to be done here ;P)
- Thanks to the use of Mobs Redo API, the slimes have all the benefits of the other mobs included in the original:
> IA to search and attack players
> Enviromental damage
> Easy configuration
  ... and more.

Green slimes:
  > spawn in jungle grass or in temples mossy cobble (default:mossycobble).
  > on die, they drop a randomish amount of glue (from mesecon mod)
  > Lava hurts them.

Lava slimes:
  > spawn in lava pools deep under ground.
  > on die, they drop a randomish amount of gunpowder (from default tnt mod).
  > water hurts them.
  > when they jump they can leave behind a footprint of fire. ^^

Install
===========================================================================
Unzip the archive an place it in minetest-base-directory/mods/slimes/
If you have a windows client or a linux run-in-place client.
If you have a linux system-wide instalation place it in ~/.minetest/mods/slimes/.
If you want to install this mod only in one world create the folder worldmods/ in your world directory.
For further information or help see: http://wiki.minetest.com/wiki/Installing_Mods

How to use the mod:
===========================================================================
1. Install Mobs Redo >= 1.10
2. Install Slimes Redo.
3. Enjoy

Mod Information
===========================================================================
Version: 0.2.1
Required Minetest Version: >=0.4.12
Dependencies: default, tnt, mobs redo >=1.10 (https://forum.minetest.net/viewtopic.php?f=9&t=9917)
Soft Dependencies: (none)
Highly Recommended: mesecon_materials (https://forum.minetest.net/viewtopic.php?f=11&t=628)
Craft Recipies: (none)
Git Repo: https://github.com/TomasJLuis/mt-slimes-redone
Minetest.net Forum:  https://forum.minetest.net/viewtopic.php?f=9&t=11743

Modders/Developers
===========================================================================
If you are a modder, you should know that I've never used LUA before. this is my first mod for Mintetest, and I've used this mod to learn how to mod on Minetest. So may be you will find a code full of mistakes and bad practices... ;P
If you spot someting that can/must be improved/changed/removed and want to help me to improve this mode and my knowledge, please report to me on GitHub or on Minetest forum.
Thank you!

Version history
===========================================================================
0.2.1 - Updated to Mob Redo API 1.10
0.2 - Now using Mob Redo API (Thank you TenPlus1). Changed mod name to Slimes Redo to reflect better this.
0.1 - Initial release

Copyright and Licensing
===========================================================================

- Authors:  Tomas J. Luis (textures, code)
            TenPlus1 (migration to Mobs Redo API)

- Original sound for slime damage by RandomationPictures under licence CC0 1.0.
http://www.freesound.org/people/RandomationPictures/sounds/138481/

- Original sounds for slime jump, land and death by Dr. Minky under licence CC BY 3.0.
http://www.freesound.org/people/DrMinky/sounds/

- Source code and images by TomasJLuis under WTFPL.

          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004 

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net> 

 Everyone is permitted to copy and distribute verbatim or modified 
 copies of this license document, and changing it is allowed as long 
 as the name is changed. 

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE 
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 

  0. You just DO WHAT THE FUCK YOU WANT TO.
