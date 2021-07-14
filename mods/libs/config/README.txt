Configuration Panel Mod v1.1
By Leslie Krause

Configuration Panel is an API extension for Minetest that allows seamless loading of mod 
configuration at runtime. It provides much greater flexibility than Minetest's builtin 
'Settings' interface, since the mod configuration itself is read as a native Lua script. 
Hence it's possible to include simple data structures without the need for serialization,
in addition to temporary variables, mathematical expressions, and conditional branching.

While some might be opposed to using Lua for configuration purposes, arguing that it is
anti-pattern, that's not actually true. In fact, Lua itself was originally intended to
double as a configuration language, like JSON, so it is very befitting of its purpose.

   "Lua started off as a configuration language. This has some nice quirks in that it's 
   great for creating and configuring things - which is what you want to do in a game."
   from Lua Users Wiki: Lua versus Python (http://lua-users.org/wiki/LuaVersusPython)

   "An important use of Lua is as a configuration language...."
   from Programming in Lua: Extending your Application (https://www.lua.org/pil/25.html)

There is only one function call necessary to load your mod's configuration:

   minetest.load_config( base_config, options )
   Automatically loads the mod configuration at server-startup according to the options
   and returns a table of key-value pairs.

    * 'base_config' is the default mod configuration (optional)
    * 'options' are additional options that effect loading behavior (optional)

   Example:
   > local config = minetest.load_config( {
   >         spawn_pos = { x = 0, y = 0, z = 0 },
   >         filename = "player_spawns.txt",
   > } )

By default, the configuration is first loaded from the 'config.lua' script within the mod
directory. If not found, it will instead be loaded from a script residing within the 
'config' subdirectory of the current world. That script must be named the same as the mod
but with a '.lua' extension, of course.

This would be the typical order of loading on Linux distros of Minetest:

   /usr/local/share/minetest/games/minetest_game/mods/sample_mod/config.lua
   /home/minetest/.minetest/worlds/sample_world/config/sample_mod.lua

By specifying the option 'can_override = true', both scripts will be loaded, allowing for
the world configuration to override the game configuration. If, for example, you want to
change some game-specific settings for your mod, "sample_mod", as well as world-specific
settings for the world, "my_world", then you would save scripts in two locations:

   /usr/local/share/minetest/games/minetest_game/mods/sample_mod/config.lua

   > allow_fly = false
   > allow_walk = false
   > allow_swim = false

   /home/minetest/.minetest/worlds/my_world/config/sample_mod.lua

   > allow_swim = true

Hence, 'allow_fly' and 'allow_walk' will be false, whereas 'allow_swim' will be true. By
default, however, all three would remain false since the world configuration is ignored
whenever the game configuration is found. 

For security reasons, configuration scripts are executed within a restricted environment.
However, the following builtin functions are made available for convenience:

   * core.print
   * core.debug (alias for minetest.log)
   * core.is_yes (alias for minetest.is_yes)
   * core.has_feature (alias for minetest.has_feature)
   * core.string_to_pos (alias for minetest.string_to_pos)
   * core.pos_to_string (alias for minetest.pos_to_string)
   * core.colorize (alias for minetest.colorize)
   * core.tonumber
   * core.tostring
   * core.sprintf (alias for string.format)
   * core.tolower (alias for string.lower)
   * core.toupper (alias for string.upper)
   * core.concat (alias for table.concat)
   * core.random (alias for math.random)
   * core.max (alias for math.max)
   * core.min (alias for math.min)
   * core.next
   * core.pairs
   * core.ipairs
   * core.date (alias for os.date)
   * core.time (alias for os.time)
   * core.assert
   * core.error

The 'core' table also contains the properties 'MOD_NAME', 'MOD_PATH', and 'WORLD_PATH'
which designate the name and the path of the currently loading mod as well as the path 
of the selected world respectively.

A chat command is also available for editing the configuration directly in-game. Simply
type '/config' followed by the mod name to configure (requires the "server" privilege).

Special Note: Before using the chat command you must add "config" to the list of trusted 
mods in minetest.conf and you must install the ActiveFormspecs mod, otherwise the editing 
functionality will be disabled.

Repository
----------------------

Browse source code:
  https://bitbucket.org/sorcerykid/config

Download archive:
  https://bitbucket.org/sorcerykid/config/get/master.zip
  https://bitbucket.org/sorcerykid/config/get/master.tar.gz

Dependencies
----------------------

Default Mod (required)
  https://github.com/minetest-game-mods/default

ActiveFormspecs Mod (optional)
  https://bitbucket.org/sorcerykid/formspecs

Installation
----------------------

  1) Unzip the archive into the mods directory of your game.
  2) Rename the config-master directory to "config".
  3) Add "config" as a dependency to any mods using the API.

Source Code License
----------------------

The MIT License (MIT)

Copyright (c) 2020, Leslie Krause (leslie@searstower.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

For more details:
https://opensource.org/licenses/MIT
