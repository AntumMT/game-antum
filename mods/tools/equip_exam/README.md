## Equipment Examiner

### Description:

Tool to examine item stats in [Minetest](https://www.minetest.net/).

![screenshot](screenshot.png)

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: [CC0](textures//sources.txt)

### Dependencies:

- Required:
  - none
- Optional:
  - [default](https://github.com/minetest/minetest_game/tree/master/mods/default) *(required for craft recipe)*
  - [basic_materials](https://forum.minetest.net/viewtopic.php?t=21000)

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

- [Minetest forum](https://forum.minetest.net/viewtopic.php?t=26618)
- [GitHub repo](https://github.com/AntumMT/mod-equip_exam)
- [Changelog](CHANGES.txt)
- [TODO](TODO.txt)
