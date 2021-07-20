## Lighted Helmets

### Description:

Light-emitting helmets.

Supports helmets from the following mods:
- [3d_armor](https://content.minetest.net/packages/stu/3d_armor/)
- [technic_armor](https://github.com/stujones11/technic_armor)
- [xtraarmor](https://forum.minetest.net/viewtopic.php?t=16645)
- [amber](https://forum.minetest.net/viewtopic.php?t=18186)
- [rainbow_ore](https://forum.minetest.net/viewtopic.php?id=13519)

![icon](screenshot.png)

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: CC0
- Screenshot/Icon: [CC0](https://openclipart.org/detail/201890)

### Usage:

#### Crafting:

<details><summary>Spoiler</summary>

```
╔══════════════════════╗
║    default:torch     ║
╠══════════════════════╣
║ default:mese_crystal ║
╠══════════════════════╣
║       helmet         ║
╚══════════════════════╝
```

</details>

### Requirements:

```
Minimum Minetest verserion: 0.4

Depends:
- 3d_armor
- 3d_armor_light

Optional depends:
- default
- technic_armor
- xtraarmor
- amber
- rainbow_ore

Settings:
- lighted_helmets.exclude
  - List of mods or helmets to exclude.
  - Example: lighted_helmets.exclude = xtraarmor,amber:helmet
```

### Links:

- [Forum](https://forum.minetest.net/viewtopic.php?t=27035)
- [Git repo](https://github.com/AntumMT/mod-lighted_helmets)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)
