# Slingshot Mod for Minetest

### Description:

Adds a slingshot that can throw inventory items as ammunition.

The original code was extracted from [hook][] mod by [AiTechEye][].

![Screenshot](screenshot.png)

Depends:
- default

Optional depends (soft):
- technic


### Licensing:

- Code
  - Original code by AiTechEye: [CC0][lic.cc0]
  - Code by Jordan Irwin (AntumDeluge): [MIT][lic.mit]

- Textures:
  - slingshots: [CC0][lic.cc0]
  - rubber band: [CC0][lic.cc0]


### Functions:

- *Right-click*: Changes ammo slot between left & right of slingshot
- *Left-click*: Throws items from selected ammo slot


### Crafting:

* `SI` = default:steel_ingot
* `ST` = default:stick
* `RB` = slingshot:rubber_band
* `TR` = technic:rubber
* `TL` = technic:raw_latex

##### Craft recipes:

slingshot:

    ╔════╦════╦════╗
    ║ SI ║    ║ SI ║
    ╠════╬════╬════╣
    ║    ║ SI ║    ║
    ╠════╬════╬════╣
    ║    ║ SI ║    ║
    ╚════╩════╩════╝

slingshot (with technic):

    ╔════╦════╦════╗
    ║ SI ║    ║ SI ║
    ╠════╬════╬════╣
    ║    ║ SI ║    ║
    ╠════╬════╬════╣
    ║    ║ SI ║    ║
    ╚════╩════╩════╝

wood slingshot:

    ╔════╦════╦════╗
    ║ ST ║ RB ║ ST ║
    ╠════╬════╬════╣
    ║    ║ ST ║    ║
    ╠════╬════╬════╣
    ║    ║ ST ║    ║
    ╚════╩════╩════╝

wood slingshot (with technic):

    ╔════╦════╦════╗
    ║ ST ║ RB ║ ST ║
    ╠════╬════╬════╣
    ║    ║ ST ║    ║
    ╠════╬════╬════╣
    ║    ║ ST ║    ║
    ╚════╩════╩════╝

rubber band:

    ╔════╦════╦════╗
    ║ TL ║ TL ║    ║
    ╠════╬════╬════╣
    ║ TL ║    ║ TL ║
    ╠════╬════╬════╣
    ║    ║ TL ║ TL ║
    ╚════╩════╩════╝

rubber band (shapeless):

    ╔════╗
    ║ TR ║
    ╚════╝



[AiTechEye]: https://forum.minetest.net/memberlist.php?mode=viewprofile&u=16172

[hook]: https://forum.minetest.net/viewtopic.php?t=13634

[lic.cc0]: LICENSE-cc0.txt
[lic.mit]: LICENSE.txt
