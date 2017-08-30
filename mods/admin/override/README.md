## Override Mod for [Minetest][]


---
### **Description:**

A mod to simplify overriding craft items. Overriding other types of objects may be supported in the future.

Overrides can be adding using a file named ***overrides.txt*** in the world path directory. The formatting is as follows:

Each new line represents an override:
```
alias1,alias2,...;target
```

In the example above, each existing item (alias1, alias2, etc) will be unregistered & re-added as an alias of ***target***.


---
### **Licensing:**

- [MIT](LICENSE.txt)


---
### **Requirements:**

- Depends: none


---
### **Documentation:**

- [API Documentation](https://antummt.github.io/mod-override/)


[Minetest]: http://www.minetest.net/
