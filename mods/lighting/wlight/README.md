## Walking Light

### Description:

A mod for [Minetest](http://minetest.net/) that illuminates the area around a player when wielding a light-emitting item. Also supports equipped armor with [3d_armor](https://content.minetest.net/packages/stu/3d_armor/).

![screenshot](screenshot.png)

#### History:

- forked from [v0.6][forum.echo] of Echo's *walking_light*
- forked from [Git commit 766ef0f](https://github.com/petermaloney/walking_light/tree/766ef0f) of petermaloney's *walking_light*

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: [CC0](https://creativecommons.org/publicdomain/zero/1.0/legalcode)

### Requirements:

```
- Minetest minimum version: 5.0.0
- Depends: none
- Optional depends: default (for torch & megatorch)
- Privileges: server (for using chat commands)
```

### Usage:

Main methods:

```
wlight.register_item(iname, radius)
- Registers an item to emit light when wielded.
- `iname`: Item technical name.
- `radius`: Distance light will reach (max: 10).

wlight.register_armor(iname, radius, litem)
- Registers an item to emit light when equipped in armor inventory.
- `iname`: Item technical name.
- `radius`: Distance light will reach (max: 10).
- `litem`: Whether or not this item should also be registered with `wlight.register_item` (default: true).
```

Settings:

```
wlight.enable_megatorch
- Enables wlight:megatorch item.
- default: true
```

### Links:

- [![ContentDB](https://content.minetest.net/packages/AntumDeluge/wlight/shields/title/)](https://content.minetest.net/packages/AntumDeluge/wlight/)
- [Forum](https://forum.minetest.net/viewtopic.php?t=26938)
- [Git repo](https://github.com/AntumMT/mod-wlight)
- [API](https://antummt.github.io/mod-wlight/docs/api.html)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)
- Echo's *walking_light*:
	- [Forum][forum.echo]
	- [v0.6 release](https://github.com/AntumMT/mod-wlight/releases/tag/v0.6)
- petermaloney's *walking_light*:
	- [Git repo](https://github.com/petermaloney/walking_light)

**Alternative Mods:**

- [![wielded_light](https://content.minetest.net/packages/bell07/wielded_light/shields/title/)](https://content.minetest.net/packages/bell07/wielded_light/)


[forum.echo]: https://forum.minetest.net/viewtopic.php?t=2621
