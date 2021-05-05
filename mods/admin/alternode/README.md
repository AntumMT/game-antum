## Alternode: Node Meta Manipulation

### Description:

A [Minetest](http://minetest.net/) mod that allows administrators with *server* privilege to examine & alter node meta data.

### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: CC0

### Usage:

Invoke `/giveme alternode:infostick`. Use the infostick on a node to receive coordinate & other information.

**Chat commands:**

- */getmeta <x> <y> <z> <key>*
  - prints the value of `key` in the node's meta data at `x,y,z`.
- */setmeta <x> <y> <z> string|int|float <key> <new_value>*
  - Sets the value of `key` in the meta data of node at `x,y,z`.

### Links:

- [Forum](https://forum.minetest.net/viewtopic.php?t=26667)
- [Git repo](http://github.com/AntumMT/mod-alternode)
- [TODO](TODO.txt)
