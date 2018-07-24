# PvP Areas

Sets an area for PvP control.

Use safemode to make areas be safe zones; otherwise they are killzones by default.

## Config
in minetest.conf

* `pvp_areas.safemode`
	* safemode = true --> PvP Control areas are safe zones
	* default is `false`, making PvP Control areas kill zones

* `pvp_areas.label`
	* if ShadowNinja's `areas` mod is also present with HUD registration feature, this label will be displayed anywhere
		a PvP Control area has been set.

## Commands

* `/pvp_areas`
	* without arguments lists areas, if any.
* `/pvp_areas pos1`
	* selects the players current position as the area minimum.
* `/pvp_areas pos2`
	* selects the players current position as the area maximum.
* `/pvp_areas set`
	* adds an entry using pos1 and pos2 values.
* `/pvp_areas remove n`
	* removes an area entry.
