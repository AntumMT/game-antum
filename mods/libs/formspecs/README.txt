ActiveFormspecs Mod v2.6
By Leslie E. Krause

ActiveFormspecs is a self-contained API that provides secure session tracking, session-
based state tables, and localized event handling of formspecs for individual mods as well
as entire games. It evolved out of a recurring need for secure "node formspecs" on my
server, while avoiding the burden of "reinventing the wheel" with every new project.

ActiveFormspecs is intended to be compatible with all versions of Minetest 0.4.15+.

https://forum.minetest.net/viewtopic.php?f=9&t=19303

Revision History
----------------------

Version 1.0a (15-Dec-2016)
  - initial version within default mod

Version 1.1b (16-Dec-2016)
  - added better comments

Version 1.2b (18-Dec-2016)
  - renamed public methods

Version 1.3b (04-Jan-2017)
  - fixed logic of quit event to require valid session

Version 1.4b (26-Jul-2017)
  - added method to update formspec and maintain session

Version 2.0 (24-Dec-2017)
  - separated all routines into new mod for public release

Version 2.1 (08-Jan-2018)
  - various code refactoring and better comments
  - introduced password hashing of form names
  - improved sanity checks during form submission
  - fully reworked parsing of hidden elements
  - ensured hidden elements are always stripped
  - gave hidden elements default-state behavior
  - localized old node registration functions
  - included player object within form table
  - added signal handling on formspec termination
  - added support for callbacks in node overrides

Version 2.2 (19-Jan-2018)
  - introduced player-name arguments for all API calls
  - added signal for programmatic formspec closure
  - ensured callbacks are notified of session resets
  - renamed some local variables to improve clarity

Version 2.3 (28-Jan-2018)
  - corrected erroneous value of formspec exit signal
  - removed two experimental form session methods
  - included timestamp and origin within form table
  - added form session validation on destroy and update
  - introduced form timers with start and stop methods
  - created routine to notify callbacks of timeout
  - added support for internal statistical tracking
  - added chat command to view form session summary

Version 2.4 (12-Feb-2018)
  - various code refactoring and better comments
  - full rewrite of timer queue for higher precision

Version 2.5 (01-Feb-2019)
  - made callback function optional with default no-op
  - added non-trappable form session termination signal
  - properly reset timestamp for lifetime calculation

Version 2.6 (02-Feb-2020)
  - added callback to preset state of node formspecs
  - removed experimental property from node definition
  - implemented reverse-lookups for dropdown fields
  - extended dropdown element with optional parameter
  - added signal to suspend and restore form sessions
  - combined element parsers into dedicated function
  - added functions for escaping formspec strings
  - revamped element parsers to ignore malformed tags
  - added conditional pattern matching helper function
  - compatability bumped to Minetest 0.4.15+

Compatability
----------------------

Minetest 0.4.15+ required

Installation
----------------------

  1) Unzip the archive into the mods directory of your game.
  2) Rename the formspecs-master directory to "formspecs".
  3) Add "formspecs" as a dependency to any mods using the API.

Source Code License
----------------------

The MIT License (MIT)

Copyright (c) 2016-2020, Leslie E. Krause (leslie@searstower.org)

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
