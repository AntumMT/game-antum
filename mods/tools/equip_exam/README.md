## Equipment Examiner

### Description:

A [Minetest](https://www.minetest.net/) mod that adds a node that can be used to examine equipment & item specs.

![screenshot](screenshot.png)

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: [CC0](textures//sources.txt)

### Usage:

Right-click the equipment examiner node & place an item into its inventory slot to populate the specs list.

### Requirements:

- Minetest minimum version: 5.0
- Depends: none
- Optional depends:
	- [![default](https://img.shields.io/static/v1?label=GitHub&message=default&color=%23375a7f&logo=github)](https://github.com/minetest/minetest_game/tree/master/mods/default) *(required for craft recipe)*
	- [![basic_materials](https://img.shields.io/static/v1?label=ContentDB&message=basic_materials&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/VanessaE/basic_materials/)
	- [![wielded_light](https://img.shields.io/static/v1?label=ContentDB&message=wielded_light&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/bell07/wielded_light/)
	- [![workbench](https://img.shields.io/static/v1?label=GitHub&message=workbench&color=%23375a7f&logo=minetest)](https://github.com/AntumMT/mod-workbench)
	- [![xdecor](https://img.shields.io/static/v1?label=ContentDB&message=xdecor&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/jp/xdecor/)
	- [![3d_armor_light](https://img.shields.io/static/v1?label=ContentDB&message=3d_armor_light&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/AntumDeluge/3d_armor_light/)

#### Other Mod Support:

- [![3d_armor](https://img.shields.io/static/v1?label=ContentDB&message=3d_armor&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/stu/3d_armor/)

### Crafting:

<details>
<summary>Spoiler:</summary>

Key:
- d:s = default:steel_ingot (wrought iron ingot)
- d:b = default:bronze_ingot (bronze ingot)
- d:o = default:obsidianbrick (obsidian brick)
- b:i = basic_materials:ic (simple integrated circuit)

<blockquote>

Without `basic_materials`:
```
┌─────┬─────┬─────┐
│ d:s │ d:b │ d:s │
├─────┼─────┼─────┤
│ d:b │ d:o │ d:b │
├─────┼─────┼─────┤
│ d:s │ d:b │ d:s │
└─────┴─────┴─────┘
```

With `basic_materials`:
```
┌─────┬─────┬─────┐
│ d:s │ d:b │ d:s │
├─────┼─────┼─────┤
│ d:b │ b:i │ d:b │
├─────┼─────┼─────┤
│ d:s │ d:b │ d:s │
└─────┴─────┴─────┘
```

</blockquote>
</details>

### Links:

- [![ContentDB](https://img.shields.io/static/v1?label=ContentDB&message=equip_exam&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/AntumDeluge/equip_exam/)
- [Forum](https://forum.minetest.net/viewtopic.php?t=26618)
- [Git repo](https://github.com/AntumMT/mod-equip_exam)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)
