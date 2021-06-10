## Whiter List (*whitelist*) mod for Minetest

### Description:

A [Minetest][] mod that adds a simple player whitelist. Any player names not found in the whitelist are denied access to the server.

Forked from ShadowNinja's original [White List][].

![icon](icon.png)

### Usage:

Whitelist can be updated by editing *whitelist.txt* in the world directory or by issuing the following in-game commands. The *ban* privilege is required for issuing chat commands.

Commands:
- ***/whitelist [&lt;command&gt; &lt;name&gt;]***
	- Manages the whitelist.
	- Without parameters: displays all whitelisted names
	- commands:
		- *query:* checks if a name is whitelisted
		- *add:* adds a name to whitelist
		- *remove:* removes a names from whitelist
	- *name:* name of player

Settings:
- ***whitelist.enable***
	- Enables/Disables denying access to users not on the whitelist.
	- Enabled by default.
- ***whitelist.message***
	- Changes the default message *"This server is whitelisted and you are not on the whitelist."*

The *whitelist.txt* file is reloaded whenever a player attempts to log on. So it can be edited without the need to restart the server.

### Licensing:

- Code: [MIT](LICENSE.txt)

### Requirements:

- Minimum Minetest version: 5.0.0
- Depends: none
- Optional depends: none

### Links:

- [![ContentDB](https://content.minetest.net/packages/AntumDeluge/whitelist/shields/title/)](https://content.minetest.net/packages/AntumDeluge/whitelist/)
- [Forum](https://forum.minetest.net/viewtopic.php?t=18325)
- [Git repo](https://github.com/AntumMT/mod-whitelist)
- [Changelog](changelog.txt)
- [TODO](TODO.txt)


[Minetest]: http://www.minetest.net/
[White List]: https://forum.minetest.net/viewtopic.php?t=8434
