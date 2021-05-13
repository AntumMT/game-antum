# List Items (***listitems***) chat command for [Minetest][]


---
### **Description:**

#### Chat Commands:
- ***list:*** Lists registered items or entities available in the game.
  - Invocation: ```/list type [options] [string1] [string2] ...```
    - ***type:*** List type (e.g. "items", "entities", etc.).
    - ***options:*** Switches to control output behavior.
      - ***-v:*** Display description (if available) after object name.
    - ***string[1,2] ...:*** String parameter(s) to filter output.
    - Without any string parameters, all objects registered in game are listed.
    - With string parameters, only objects matching any of the strings will be listed.

![Screenshot](screenshot.png)


---
### **Licensing:**

- [MIT](LICENSE.txt)


---
### **Requirements:**

- **Dependencies:**
  - Required: ***none***
  - Optional:
    - ***[mobs_redo][]*** *(optionally adds "list mobs" chat command)*
- **Privileges:** none


---
### **Documentation:**

- [API Documentation](https://antummt.github.io/mod-listitems/api.html)


---
### **TODO:**

- Add ***-d*** option to search within descriptions.


[Minetest]: http://www.minetest.net/
[intllib]: https://forum.minetest.net/viewtopic.php?t=4929
[mobs_redo]: https://forum.minetest.net/viewtopic.php?t=9917
