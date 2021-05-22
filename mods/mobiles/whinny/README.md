## Horses for Minetest

### Description:

A continuation of the [whinny][forum] mod for [Minetest], that adds tameable & rideable horses.

![screenshot](screenshot.png)

### Licensing:

- Code: [MIT](LICENSE.txt)
- Models & textures by sparky: CC0
- Sounds: see [sounds/sources.txt](sounds/sources.txt)

### Usage:

Wild horses can be tamed by feeding them items that they like, such as apples, carrots, wheat, & oats. Once the horse's appetite has been satisfied it becomes "tamed" & the player feeding it becomes the owner. Tamed/Owned horses can only be ridden, picked up, & killed by the owner. Currently, the `mobs:lasso` item is supported for picking up (plans to add more items).

To ride tamed horsed, right-click (place action) the entity to mount it. Use the W/S keys for forward/reverse. There are two modes for steering:

- mouse (follows player facing direction) (default)
- A/D keys

Controls can be changed by setting `whinny.enable_mouse_ctrl` in the configuration.

Right-click again to dismount. Tamed horses do not wander.

### Dependencies:

Required: [default](https://github.com/minetest/minetest_game/tree/master/mods/default)

Optional:
- [mobs_redo](https://content.minetest.net/packages/TenPlus1/mobs/) (meat drops)
- [farming](https://github.com/minetest/minetest_game/tree/master/mods/farming) or [farming_redo](https://content.minetest.net/packages/TenPlus1/farming/)
- [player_api](https://github.com/minetest/minetest_game/tree/master/mods/player_api)

### Links:

- [Forum][forum]
- [Git repo](https://github.com/AntumMT/mod-whinny)
- [Changelog](CHANGES.txt)
- [TODO](TODO.txt)


[Minetest]: http://minetest.net/
[forum]: https://forum.minetest.net/viewtopic.php?t=17170
