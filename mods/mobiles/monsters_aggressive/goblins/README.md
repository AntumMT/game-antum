# [goblins] Goblins (Mobs Redo addon) [mod] for Minetest 

* forum: https://forum.minetest.net/viewtopic.php?f=9&t=13004
* code :https://github.com/FreeLikeGNU/goblins
* Minetest Content DB: https://content.minetest.net/packages/FreeLikeGNU/goblins/

This mod adds several Goblins (and Goblin Dogs) to Minetest that should spawn near ore deposits or lairs underground.

* Goblins dig caves, destroy torches, create lairs, set traps, cultivate mushrooms and some are aggressive.
* Gobdogs will roam caves, bury bones and other items in soft terrain, eat meats. Some Gobdogs are aggressive!
* Basic trading with Goblins - the more you trade with a goblin, the more likely you will get things in return! 
* Goblins have a territorial framework for location based interactions, if you trade with more Goblins of a territory
  your trades will be easier! 
* Harming goblins will negatively affect your trade with all gobins in a territory!  
* If you brandish weapons (including axes) around a goblin it may decide to attack!
* Goblins and Gobdogs will defend each other.  You can have them defend other mobs by simply
adding to: 
`on_spawn = function(self)`
the following:
`self.groups = {"goblin_friend", "gobdog_friend"}`
in your own mobs definition!
* There are many settings now accessible from the minetest menu -> "settings" tab -> "all settings" -> "mods" -> "goblins" list!
these can also be defined in the settingtypes.txt
* Goblin and Gobdog spawning is now configured from goblins_spawning.lua (at least until there is a way to easily change these with the setting menu :P )
* A basic and optional (enabled in minetest setting menu) HUD is available
* tested with Minetest 5.2 and 5.30(dev)

## Required Mods:
* Mobs Redo by TenPlus1 API as of version 20200516: to run
    * https://forum.minetest.net/viewtopic.php?f=9&t=9917
    * Mobs Redo git repository  https://notabug.org/TenPlus1/mobs_redo
	
## Optional Mods:
* Ambience Lite by TenPlus1 API
    * https://notabug.org/TenPlus1/ambience	
    
* Hunger NG by Linuxdirk
    * https://forum.minetest.net/viewtopic.php?t=19664
    * https://gitlab.com/4w/hunger_ng

* Bonemeal by TenPlus1
    * https://forum.minetest.net/viewtopic.php?t=16446
    * https://notabug.org/TenPlus1/bonemeal
    
## Licenses of Source Media Files:
* goblins_goblin.b3d and goblins_goblin.blend 
    * Copyright 2015 by Francisco "FreeLikeGNU" Athens Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
    * http://creativecommons.org/licenses/by-sa/3.0/

* above meshes based on character from minetest_game
    * by MirceaKitsune (WTFPL)
    * https://github.com/minetest/minetest_game/blob/master/mods/default/README.txt#L71

* goblins_goblins*.png files and goblins_goblin.xcf files
    * Copyright 2015,2020 by Francisco "FreeLikeGNU" Athens  Creative Commons  Attribution-ShareAlike 3.0 Unported 		(CC BY-SA 3.0) 
    * http://creativecommons.org/licenses/by-sa/3.0/

* goblins_goblin_dog.b3d and goblins_goblin_dog*.blend 
    * Copyright 2016,2020 by Francisco "FreeLikeGNU" Athens Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
    * http://creativecommons.org/licenses/by-sa/3.0/

* goblins_goblin_dog*.png files and goblins_goblin_dog*_.xcf files
    * Copyright 2015 by Francisco "FreeLikeGNU" Athens  Creative Commons  Attribution-ShareAlike 3.0 Unported         (CC BY-SA 3.0) 
    * http://creativecommons.org/licenses/by-sa/3.0/
    
## Additional source and content credits:
* goblin mushrooms from "flowers" mod source code:
    * Originally by Ironzorg (MIT) and VanessaE (MIT)
    * Various Minetest developers and contributors (MIT)

* mushrooms.xcf Copyright Francisco Athens (CC BY-SA 3.0) 2020
* goblins_mushroom_brown.png, goblins_mushroom_brown2.png goblins_mushroom_brown3.png goblins_mushroom_brown4.png Copyright Francisco Athens (CC BY-SA 3.0) 2020

## Sound files by:
 * artisticdude http://opengameart.org/content/goblins-sound-pack (CC0-license)
 * Ogrebane http://opengameart.org/content/monster-sound-pack-volume-1 (CC0-license)
 * goblins_ambient_underground: 232685__julius-galla__atmosphere-cave-loop (CC-BY-SA)
    * https://freesound.org/people/julius_galla/sounds/232685/
 * goblins_goblin_trap: LittleRobotSoundFactory  (CC-BY-SA)
    * https://freesound.org/people/LittleRobotSoundFactory/
 * goblins_goblin_breathing: spookymodem 
    * https://freesound.org/people/spookymodem/ (CC-0)
 * goblins_goblin_dog_ sounds:
    * delphidebrain Jazz the Dog Howl & Bark (CC-BY-SA)
        * https://freesound.org/people/delphidebrain/sounds/236027/
   * Glitchedtones Dog Shih Tzu Growling 06.wav (CC-BY-SA)
        * https://freesound.org/people/Glitchedtones/sounds/372533/

* Super thanks to duane-r for his work on nasty traps and tunneling  https://github.com/duane-r 

* Thanks to Napiophelios for the goblin king skin
    * https://forum.minetest.net/viewtopic.php?f=9&t=13004#p186921
    * goblins_goblin_king.png
    * License: Creative Commons (CC-BY-SA-3.0 SummerFeilds TP
  
  Thanks to orbea for adding Hunger NG and Bonemeal mod support and bugfixes!
    * https://github.com/orbea
  Thanks to TenPlus1 for keeping the Mobs_Redo going!
  Thanks to rubenwardy for awesome help and the Minetest ContentDB
  Thanks to everyone in the Minetest forums and IRC for just being great!
GET MINETEST: https://www.minetest.net/
