## Alternode: Node Meta Manipulation

### Description:

A [Minetest](http://minetest.net/) mod that allows administrators with *server* privilege to examine & alter node meta data. Additionally, a pencil & key tools are provided with limited use for players to alter *infotext* & *owner* meta value.

### Usage:

#### Chat commands:

- */getmeta &lt;x&gt; &lt;y&gt; &lt;z&gt; &lt;key&gt;*
  - prints the value of `key` in meta data of node at `x,y,z`.
- */setmeta &lt;x&gt; &lt;y&gt; &lt;z&gt; &lt;key&gt; &lt;new_value&gt;*
  - Sets the value of `key` in meta data of node at `x,y,z`.
- */unsetmeta &lt;x&gt; &lt;y&gt; &lt;z&gt; &lt;key&gt;*
  - Unsets the value of `key` in meta data of node at `x,y,z`.

#### Tools:

**Wand:**

Use the `alternode:wand` on a node to receive node coordinates, name, & some select meta info. Only players with the `server` privilege can use this item

- *left-click (use):* Opens formspec to retrieve & set/unset meta attributes.
- *right-click (place):* Print node coordinates, name, & some select meta info.

**Pencil:**

The `alternode:pencil` is a tool for players to set/unset the `infotext` meta value of nodes within protected/owned areas.

- *left-click (use):* Opens formspec to set/unset infotext meta attribute.

**Key:**

The `alternode:key` is a tool that will set/unset the player wielding it as owner of a node (e.g. `owner` meta attribute will be set to player's name or cleared). Only nodes within an area owned/protected by the player can owned. Any node can be unowned.

- *left-click (use):* Sets/Unsets user as owner.
- *right-click (place):* Prints owner status to chat log.

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: CC0
	- alternode_pencil.png:` by AntumDeluge
	- [`alternode_key.png`](https://opengameart.org/node/120374)
	- [`alternode_wand.png`](https://opengameart.org/node/40598) by rcorre

### Links:

- [Forum](https://forum.minetest.net/viewtopic.php?t=26667)
- [Git repo](http://github.com/AntumMT/mod-alternode)
- [API](https://antummt.github.io/mod-alternode/docs/api.html)
- [Changelog](CHANGES.txt)
- [TODO](TODO.txt)
