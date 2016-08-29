# Antum
A custom game for Minetest/Freeminer
Requires a current development release of Minetest: 0.4.14-dev-281e9f3 or above

The game includes the mods from the default [minetest_game](https://github.com/minetest/minetest_game/tree/master/mods)

The following mods are also included:
* admin/
    * [clean][] (WTFPL)
    * [invisible][] ([LGPL / CC BY-SA](mods/admin/invisible/readme.txt))
    * [privs][] ([CC0](mods/admin/privs/init.lua))
    * [spectator_mode][] ([WTFPL][spectator_mode lic]) version: [3459db4][spectator_mode version]
* [adv_spawning][] ([???](mods/adv_spawning/README.txt))
* [animalmaterials (modpack)][animalmaterials] (CC-BY-SA / CC0)
* antum/
    * [antum][] ([MIT][antum lic])
	* overrides ([MIT][antum lic])
* [awards][] ([LGPL](mods/awards/LICENSE.txt))
* buildings/
    * barn ([mobf_core modpack][mobf]) ([CC-BY-SA](doc/modpacks/mobf_core/License.txt))
    * building_blocks ([homedecor_modpack][homedecor]) ([LGPL/WTFPL/CC-BY-SA](doc/modpacks/homedecor/LICENSE))
    * chains ([homedecor_modpack][homedecor])
    * [christmas][] ([MIT](mods/buildings/christmas/LICENSE.txt))
    * computer ([homedecor_modpack][homedecor])
    * [elevator][] ([WTFPL](mods/buildings/elevator/readme.txt))
    * fake_fire ([homedecor_modpack][homedecor])
    * [fort_spikes][] ([MIT/CC0](mods/buildings/fort_spikes/LICENSE))
    * homedecor([homedecor_modpack][homedecor])
    * homedecor_3d_extras ([homedecor_modpack][homedecor])
    * inbox ([homedecor_modpack][homedecor])
    * itemframes ([homedecor_modpack][homedecor])
    * lavalamp ([homedecor_modpack][homedecor])
    * lrfurn ([homedecor_modpack][homedecor])
    * [moreblocks][] ([zlib](mods/buildings/moreblocks/LICENSE.md))
    * mdoors ([mydoors modpack][mydoors]) ([CC-BY / CC-BY-SA / WTFPL](mods/buildings/mdoors/README.txt) / [DWYWFPL](doc/modpacks/mydoors/licence.txt))
    * my_*_doors ([mydoors modpack][mydoors])
    * my_garage_door ([mydoors modpack][mydoors])
    * plasmascreen ([homedecor_modpack][homedecor])
    * [stairsplus][] ([zlib](mods/buildings/stairsplus/LICENSE.txt))
    * [windmill][] ([WTFPL](mods/buildings/windmill/README.md))
* [campfire][] ([GPL / CC BY-SA / WTFPL](mods/campfire/README.md))
* chat/
    * [away][] ([GPL](mods/chat/away/COPYING))
    * [chatlog][] ([CC0](mods/chat/chatlog/Readme.txt))
* [coloredwood][] ([LGPL](mods/coloredwood/LICENSE)) Version: Git [7b177f3][coloredwood version]
* crafting/
    * [craft_guide][] ([BSD 3-Clause](mods/crafting/craft_guide/LICENSE))
    * [craftguide][] ([GPL / WTFPL](mods/crafting/craftguide/LICENSE)) Installed version: [51a00b9][craftguide version] (Git)
* [currency][] ([WTFPL](https://forum.minetest.net/viewtopic.php?t=7002)) [Git d2ea7c3](https://github.com/minetest-mods/currency/tree/d2ea7c352ada7646e019f55a365a506d132f301a)
* display/
    * [bags][] ([BSD 3-Clause](mods/display/bags/LICENSE))
    * [home_gui][] ([BSD 3-Clause](mods/display/home_gui/README.md))
    * [inventory_plus][] ([BSD 3-Clause](mods/display/inventory_plus/LICENSE))
* farming/
	* [farming_plus][] ([WTFPL](mods/farming/farming_plus/README.txt))
* furniture/
    * [trampoline][] ([GPL](mods/furniture/trampoline/LICENSE.txt))
    * [trash_can][] ([MIT](mods/furniture/trash_can/LICENSE.txt))
* [intllib][] (WTFPL)
* lib/
    * [biome_lib][] ([WTFPL](mods/lib/biome_lib/README.md))
	* [signs_lib][] ([BSD/WTFPL](mods/lib/signs_lib/copyright.txt))
* materials/
	* [moreores][] ([zlib/CC-BY-SA](mods/materials/moreores/README.md))
	* [quartz][] ([MIT](mods/materials/quartz/LICENSE.txt))
	* [unifieddyes][] ([GPL](mods/materials/unifieddyes/LICENSE))
* [mesecons (modpack)][mesecons] ([LGPL/CC-BY-SA](mods/mesecons/COPYING.txt))
* mobs/
    * [creatures (Creatures MOB-Engine)][cme] ([zlib/CC-BY-SA](doc/modpacks/cme/README.txt))
    * [kpgmobs][] ([MIT](mods/mobs/kpgmobs/README.txt))
    * mobf ([mobf_core modpack][mobf]) ([CC-BY-SA](doc/modpacks/mobf_core/License.txt))
    * mobf_settings ([mobf_core modpack][mobf]) ([CC-BY-SA](doc/modpacks/mobf_core/License.txt))
    * [mobs_redo][] ([MIT](mods/mobs/mobs_redo/license.txt))
* mobs_aggressive/
    * [creeper][] ([WTFPL](mods/mobs_aggressive/creeper/LICENSE.md))
    * ghost ([Creatures MOB-Engine][cme])
    * mob_archer ([animals_modpack][]) ([CC-BY-SA / CC0](mods/mobs_aggressive/mob_archer/License.txt))
    * mob_bear ([animals_modpack][]) ([CC-BY-SA / CC0](mods/mobs_aggressive/mob_bear/License.txt))
    * mob_guard ([animals_modpack][]) ([CC-BY-SA / CC0](mods/mobs_aggressive/mob_guard/License.txt))
    * mob_shark ([animals_modpack][]) ([CC-BY-SA](mods/mobs_aggressive/mob_shark/License.txt))
    * mob_slime ([animals_modpack][]) ([CC-BY / CC-BY-SA / CC0](mods/mobs_aggressive/mob_slime/License.txt))
    * [mobs_goblins][] ([CC-BY-SA / CC-BY / CC0](mods/mobs_aggressive/mobs_goblins/README.md))
    * oerrki ([Creatures MOB-Engine][cme])
    * [spidermob][] ([CC-BY-SA / WTFPL / CC0](mods/mobs_aggressive/spidermob/LICENSE))
    * zombie ([Creatures MOB-Engine][cme])
* mobs_passive/
    * animal_clownfish ([animals_modpack][]) ([CC-BY-SA](mods/mobs_passive/animal_clownfish/License.txt))
    * animal_fish_blue_white ([animals_modpack][]) ([CC-BY-SA](mods/mobs_passive/animal_fish_blue_white/License.txt))
    * animal_gull ([animals_modpack][]) ([CC-BY-SA](mods/mobs_passive/animal_gull/License.txt))
    * animal_rat ([animals_modpack][]) ([CC-BY-SA / CC0](mods/mobs_passive/animal_rat/License.txt))
    * chicken ([Creatures MOB-Engine][cme])
    * sheep ([Creatures MOB-Engine][cme])
* [moremesecons][] ([GPL](mods/moremesecons/LICENSE.txt))
* npc/
    * [peaceful_npc][] (WTFPL)
* [painting][] (???)
* [pipeworks][] ([WTFPL](mods/pipeworks/LICENSE))
* plantlife/
* player/
    * 3d_armor ([3d_armor modpack][3d_armor]) ([LGPL/WTFPL/CC-BY-SA](doc/modpacks/3d_armor/LICENSE.md))
    * 3d_armor_stand ([3d_armor modpack][3d_armor])
    * [character_creator][] ([WTFPL/CC-BY-SA](mods/player/character_creator/LICENSE.md))
    * hazmat_suit ([3d_armor modpack][3d_armor])
    * [playeranim][] ([WFTLPL](mods/player/playeranim/LICENSE.txt) / [BSD](mods/player/playeranim/LICENSE-original.txt)) - version [f1c542e][playeranim version]
    * shields ([3d_armor modpack][3d_armor])
    * technic_armor ([3d_armor modpack][3d_armor])
    * [throwing][] (WTFPL)
    * [unified_inventory][] ([LGPL/WTFPL](mods/player/unified_inventory/README.md))
    * [walking_light][] ([WTFPL / CC-BY-SA](mods/player/walking_light/README.md))
    * [wardrobe][] ([WTFPL](mods/player/wardrobe/README.txt))
    * wieldview ([3d_armor modpack][3d_armor])
* [technic (modpack)][technic] ([LGPL](mods/technic/README.md))
* [tnt][] ([WTFPL](mods/tnt/README.txt)) (Git [d6a0b7d][tnt version])
* tools/
	* [compassgps][] ([WTFPL / CC0 / CC BY-SA](mods/tools/compassgps/README.md))
    * [torches][] ([LGPL / CC-BY-SA](mods/tools/torches/README.txt))
    * [workbench][] ([GPL / WTFPL](mods/tools/workbench/LICENSE))
    * [tools_obsidian][] ([LGPL / CC BY-SA](mods/tools/tools_obsidian/README.md)) -- version: [f77fd79][tools_obsidian version]
* transport/
    * [carts][] ([WTFPL/CC0](mods/transport/carts/README.txt))
    * [hovercraft][] ([LGPL / CC BY-SA / CC0](mods/transport/hovercraft/LICENSE.txt))
* ui/
    * [bookmarks_gui][] ([BSD 3-Clause](mods/ui/bookmarks_gui/LICENSE))
    * [home_gui][] ([BSD 3-Clause](mods/ui/home_gui/LICENSE)) Installed version: [f6b5001][home_gui version] (Git)
    * [hud][] ([LGPL / CC BY-SA / WTFPL](mods/ui/hud/README.txt))
    * [hudmap][] ([LGPL / WTFPL](mods/ui/hudmap/README.txt))
    * [markers][] (GPL / WTFPL) -- version [52d1b90][markers version]
* [vector_extras][] ([WTFPL](mods/vector_extras/LICENSE.txt))
* weather/
    * [lightning][] ([LGPL/CC-BY-SA](mods/weather/lightning/README.md))
* world/
    * [ambience][ambience_ultralite] (WTFPL / [CC-BY / CC-BY-SA / CC-BY-NC-SA / CC0](mods/world/ambience/sounds/SoundLicenses.txt))
    * [areas][] ([LGPL](mods/world/areas/LICENSE.txt))
    * [ethereal][] ([WTFPL](mods/world/ethereal/license.txt))
    * [glow][] (GPL)
    * [nether][] ([WTFPL / CC BY-SA](mods/world/nether/README.md))
    * [worldedge][] ([DWYWPL](mods/world/worldedge/licence.txt))



[3d_armor]: https://forum.minetest.net/viewtopic.php?t=4654
[adv_spawning]: https://github.com/sapier/adv_spawning
[ambience_ultralite]: https://forum.minetest.net/viewtopic.php?p=151166#p151166
[animalmaterials]: https://github.com/sapier/animalmaterials
[animals_modpack]: https://forum.minetest.net/viewtopic.php?t=629
[antum]: mods/antum/antum
[antum lic]: mods/antum/LICENSE.txt
[areas]: https://forum.minetest.net/viewtopic.php?t=7239
[awards]: https://forum.minetest.net/viewtopic.php?t=4870
[away]: https://forum.minetest.net/viewtopic.php?t=1211
[bags]: http://cornernote.github.io/minetest-bags/
[biome_lib]: https://forum.minetest.net/viewtopic.php?f=11&t=12999
[bookmarks_gui]: http://cornernote.github.io/minetest-bookmarks_gui/
[campfire]: https://forum.minetest.net/viewtopic.php?t=10569
[carts]: https://forum.minetest.net/viewtopic.php?t=2451
[character_creator]: https://forum.minetest.net/viewtopic.php?f=9&t=13138
[chatlog]: https://forum.minetest.net/viewtopic.php?id=6220
[christmas]: https://forum.minetest.net/viewtopic.php?t=3950
[clean]: https://forum.minetest.net/viewtopic.php?t=2777
[cme]: https://forum.minetest.net/viewtopic.php?t=8638
[coloredwood]: https://forum.minetest.net/viewtopic.php?t=2411
[coloredwood version]: https://github.com/minetest-mods/coloredwood/tree/7b177f3082da84faf14fef38274358e3768a99b1
[compass]: https://forum.minetest.net/viewtopic.php?t=3785
[compassgps]: https://forum.minetest.net/viewtopic.php?t=9373
[craft_guide]: https://cornernote.github.io/minetest-craft_guide/
[craftguide]: https://forum.minetest.net/viewtopic.php?t=14088
[craftguide version]: https://github.com/minetest-mods/craftguide/tree/51a00b957e81428aa5af1b0b5eddbfdd57729d77
[creeper]: https://forum.minetest.net/viewtopic.php?t=11891
[currency]: https://github.com/minetest-mods/currency
[elevator]: https://forum.minetest.net/viewtopic.php?t=12944
[ethereal]: https://forum.minetest.net/viewtopic.php?t=14638
[farming_plus]: https://forum.minetest.net/viewtopic.php?t=2787
[fort_spikes]: https://forum.minetest.net/viewtopic.php?t=14574
[glow]: https://forum.minetest.net/viewtopic.php?t=6300
[helicopter]: https://forum.minetest.net/viewtopic.php?t=6183
[home_gui]: http://cornernote.github.io/minetest-home_gui/
[home_gui version]: https://github.com/cornernote/minetest-home_gui/tree/f6b500164f95a85c4f2fab9a150983887bad143f
[homedecor]: https://forum.minetest.net/viewtopic.php?t=2041
[hovercraft]: https://forum.minetest.net/viewtopic.php?t=6722
[hud]: https://github.com/BlockMen/hud
[hudmap]: https://github.com/stujones11/hudmap
[intllib]: https://forum.minetest.net/viewtopic.php?t=4929
[invisible]: https://forum.minetest.net/viewtopic.php?t=14399
[inventory_plus]: https://forum.minetest.net/viewtopic.php?t=3100
[jumping]: https://forum.minetest.net/viewtopic.php?t=2957
[kpgmobs]: https://forum.minetest.net/viewtopic.php?t=8798
[lightning]: https://forum.minetest.net/viewtopic.php?t=13886
[markers]: https://forum.minetest.net/viewtopic.php?id=8175
[markers version]: https://github.com/Sokomine/markers/tree/52d1b90b8906b28d4b5ba93cd271b3865b316d00
[mesecons]: https://forum.minetest.net/viewtopic.php?t=628
[mobf]: https://github.com/sapier/mobf_core
[mobs_goblins]: https://forum.minetest.net/viewtopic.php?t=13004
[mobs_redo]: https://forum.minetest.net/viewtopic.php?t=9917
[moreblocks]: https://forum.minetest.net/viewtopic.php?t=509
[moremesecons]: https://forum.minetest.net/viewtopic.php?t=13150
[moreores]: https://forum.minetest.net/viewtopic.php?t=549
[moretrees]: https://forum.minetest.net/viewtopic.php?t=4394
[mydoors]: https://forum.minetest.net/viewtopic.php?t=10626
[nether]: https://forum.minetest.net/viewtopic.php?t=5790
[painting]: https://github.com/minetest-mods/painting
[peaceful_npc]: https://forum.minetest.net/viewtopic.php?t=4167
[pipeworks]: https://forum.minetest.net/viewtopic.php?t=2155
[plantlife_modpack]: https://forum.minetest.net/viewtopic.php?f=11&t=3898
[playeranim]: https://forum.minetest.net/viewtopic.php?t=12189
[playeranim version]: https://github.com/minetest-mods/playeranim/tree/f1c542e5284711ab0867bbe28316cfd27bbe610c
[privs]: mods/admin/privs
[quartz]: https://forum.minetest.net/viewtopic.php?t=5682
[signs_lib]: https://forum.minetest.net/viewtopic.php?f=11&t=13762
[spectator_mode]: https://forum.minetest.net/viewtopic.php?t=13718
[spectator_mode lic]: mods/admin/spectator_mode/LICENSE
[spectator_mode version]: https://github.com/minetest-mods/spectator_mode/tree/3459db48e1b507388ee5d24ba1531ea494e64dea
[spidermob]: https://forum.minetest.net/viewtopic.php?t=10045
[stairsplus]: https://forum.minetest.net/viewtopic.php?id=6140
[technic]: https://forum.minetest.net/viewtopic.php?t=2538
[throwing]: https://forum.minetest.net/viewtopic.php?t=687
[tnt]: https://forum.minetest.net/viewtopic.php?id=2902
[tnt version]: https://github.com/PilzAdam/TNT/tree/d6a0b7dfec33c647414ed4c2dadf32b9347b7508
[torches]: https://forum.minetest.net/viewtopic.php?t=6099
[tools_obsidian]: https://forum.minetest.net/viewtopic.php?t=14236
[tools_obsidian version]: https://github.com/Dragonop/tools_obsidian/tree/f77fd79d76a85c07e08ca965708a75f500be32d6
[trampoline]: mods/furniture/trampoline
[trash_can]: https://forum.minetest.net/viewtopic.php?t=6315
[trees]: https://forum.minetest.net/viewtopic.php?f=11&t=5713
[unified_inventory]: https://forum.minetest.net/viewtopic.php?id=3933
[unifieddyes]: https://forum.minetest.net/viewtopic.php?t=2178
[vector_extras]: https://forum.minetest.net/viewtopic.php?t=8533
[vines]: https://forum.minetest.net/viewtopic.php?f=11&t=2344
[walking_light]: https://github.com/petermaloney/walking_light
[wardrobe]: https://forum.minetest.net/viewtopic.php?id=9680
[weather]: https://forum.minetest.net/viewtopic.php?t=5245
[windmill]: https://forum.minetest.net/viewtopic.php?id=7440
[workbench]: https://forum.minetest.net/viewtopic.php?t=14085
[worldedge]: https://forum.minetest.net/viewtopic.php?t=10753
