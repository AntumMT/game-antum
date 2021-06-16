## World Data Manager library for Minetest

### Description:

A [Minetest][] library for managing data files in the world directory.

It takes a little work to read from & write to data in the world directory. `wdata` aims to make that easier by utilizing just two simple methods.

This mod is essentially an alternative to Minetest's built-in [StorageRef][] & was created before I realized the implementation existed. Some may still find wdata useful as it does allow for customizing sub-directories & filenames.

<img src="screenshot.png" alt="icon" width="100px" />

### Licensing:

- Code: [MIT](LICENSE.txt)
- Icon: [CC0](https://openclipart.org/detail/270878)

### Usage:

There are two methods:

```
- wdata.read(fname)
  - reads json data from file in world directory & converts to a table.
  - fname:  File basename without suffix (e.g. "my_config" or "my_mod/my_config").
- wdata.write(fname, data[, styled])
  - converts table to json data & writes to file in world directory.
  - fname:  File basename without suffix (e.g. "my_config" or "my_mod/my_config").
  - data:   Table containing data to be exported.
  - styled: Outputs in a human-readable format if this is set (default: true).
```

### Requirements:

```
Depends:          none
Optional depends: none
```

### Links

- [![ContentDB](https://content.minetest.net/packages/AntumDeluge/wdata/shields/title/)](https://content.minetest.net/packages/AntumDeluge/wdata/)
- [Forum](https://forum.minetest.net/viewtopic.php?t=26804)
- [Git repo](https://github.com/AntumMT/mod-wdata)
- [API](https://antummt.github.io/mod-wdata/docs/api.html)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)


[Minetest]: http://minetest.net/
[StorageRef]: https://github.com/minetest/minetest/blob/c9144ae/doc/lua_api.txt#L6883
