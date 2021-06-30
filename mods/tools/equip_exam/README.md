## Equipment Examiner

### Description:

A [Minetest](https://www.minetest.net/) mod that adds a node that can be used to examine equipment & item specs.

![screenshot](screenshot.png)

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: [CC0](textures//sources.txt)

### Requirements:

- Depends: none
- Optional depends:
	- [![default](https://img.shields.io/static/v1?label=GitHub&message=default&color=%23375a7f&logo=github)](https://github.com/minetest/minetest_game/tree/master/mods/default) *(required for craft recipe)*
	- [![basic_materials](https://img.shields.io/static/v1?label=ContentDB&message=basic_materials&color=%23375a7f&logo=minetest)](https://content.minetest.net/packages/VanessaE/basic_materials/)

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
