## Ownit: Set/Unset Node Owner

### Description:

![wand](textures/ownit_wand.png)

A tool for setting or removing "ownership" of a node. Not to be confused with an area protection mod. Ownership is determined by the "owner" attribute in the node's meta data. In order for this to actually be effective, other mods must respect that attribute. Otherwise, setting the owner does nothing.

- Player can own a node if the node is unowned & in an area protected/owned by the player. A protection mod is required as vanilla `minetest.is_protected` method always returns `false`.
- Player can unown a node if they are the current owner.

Unsetting ownership can be useful for mods that set ownership automatically when a node is placed (some doors for instance).

This mod has been tested to be working with the following protection mods:
- [simple_protection](https://forum.minetest.net/viewtopic.php?t=9035)

### Usage:

- *left-click (use):* Sets/Unsets user as owner.
- *right-click (place):* Checks owner status & outputs to chat log.

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures:
  - ownit_wand.png: CC0 (by [rcorre](https://opengameart.org/node/40598))

### Links:

- [Git repo](https://github.com/AntumMT/mod-ownit)
- [Forum](https://forum.minetest.net/viewtopic.php?t=26740)
- [Changelog](CHANGES.txt)
- [TODO](TODO.txt)
