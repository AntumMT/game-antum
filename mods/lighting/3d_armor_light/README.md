## Wielded Light for 3d_armor

### Description:

A library for [3d_armor](https://content.minetest.net/packages/stu/3d_armor/) that adds [wielded_light](https://content.minetest.net/packages/bell07/wielded_light/) support.

### Licensing:

- Code: [MIT](LICENSE.txt)

### Usage:

Methods:
```
armor_light.register(item, lvalue)
- Register an item to emit light when equipped in the armor inventory.
- params:
	- item:   Item name or ItemStack.
	- lvalue:	Light value (optional) (default: 10).

armor_light.is_lighted(item)
- Checks if an item is registered as light-emitting from armor inventory.
- params:
	- item:   Item name or ItemStack.
- returns:  `true` if the item is registered.
```

### Links:

- [Forum](https://forum.minetest.net/viewtopic.php?t=27034)
- [Git repo](https://github.com/AntumMT/mod-3d_armor_light)
- [Changelog](changelog.txt)
