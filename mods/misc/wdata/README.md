## World Data Manager library for Minetest

### Description:

A [Minetest][] library for managing data files in the world directory.

It takes a little work to read from & write to data in the world directory. `wdata` aims to make that easier by utilizing just two simple methods.

### Licensing:

- [MIT](LICENSE.txt)

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

- [Forum](https://forum.minetest.net/viewtopic.php?t=26804)
- [Git repo](https://github.com/AntumMT/mod-wdata)
- [API](https://antummt.github.io/mod-wdata/docs/api.html)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)


[Minetest]: http://minetest.net/
