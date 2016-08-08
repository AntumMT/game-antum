Elevator mod by orwell

This mod adds elevators (or lifts in american english) to minetest. Since a [lifts] mod already exists, I called the mod elevator.

Elevators consist of a shaft with special rails, a motor and some elevator "doors" (called entries, better suggestion for translation welcome). They can move up and down between doors, just like real elevators do, with one limitation:
If it is obvious that the elevator has been or will become inactive during the ride to the player because it is leaving an active area (it is too far away from a player), the elevator will teleport itself to the target entry. It will never do this with a player riding it.

Constructing elevators:
-----------------------
1. dig a shaft of 3*3 nodes diameter. No nodes are allowed inside the shaft except elevator rails, entries, torches(from minetest_game) and air.
2. place rails at the shaft walls, so that the shaft looks like:
-----
|   |
|- -|  where - are elevator rails
|   |
-----
(rails behave like torches - they need a node behind them to back them up)
3. place an elevator motor between the uppermost rail pair:
-----
|   |
|-M-|  where - are elevator rails and M is a motor
|   |
-----
4. place elevator entries into the shaft in the following way:
-----
|   |
|- -|  where - are elevator rails and E is an entry
| E |
-- --  <- there should be air, since this is the position the player is getting off to
or
-- --
| E |
|- -|
|   |
-----
(or even:
-- --
| E |
|- -|
| E |
-- --)
That entry has to be placed one layer below the actual entry layer, so that you can walk on it:
 |      | = rails
 | ____ <-floor
 |E     <-entry node
The entries will ask for a name, this is the name of the button appearing inside the elevator.

The motor must be placed first. To destruct an elevator, dig the motor and the entries are digged and added to your inventory too (of course there has to be space :) ).

Using elevators
---------------
To call an elevator, right-click the elevator entry node.
The elevator will either be called (if it is loaded and in range) or spawned (if it has been unloaded or was too far away)
Then, right-click the elevator. You are attached to the elevator and a formspec will open. Select your target door. The elevator will drive to it and you will exit automatically.
If the shaft is blocked in any way, the elevator will stop. Right-click it again and select an entry you can drive to, or dig the blocking node and select your initial target again.

Try it, it's simple and comfortable.
There is no height limit. (you just need the rails...)
Placing rails on the floor or the ceiling will work, but this looks ugly.

Differences to the old WIP version 1.0
--------------------------------------
- The mod does not depend on forceload-lib anymore.
- Elevators teleport instead of forceloading the areas around them.
- When constructing, you place the motor before placing entries!
- Old elevators will probably not work anymore, re-construct the motor and the entries.
- If minetest crashes when opening a world including an elevator from the old version, load the old mod, remove all elevators, all entries and all motors and then load the new mod again.

License:
-------
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.

-------