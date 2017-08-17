# Slingshot API


---
## -- Functions --

### ***slingshot.log(message)***
- Info log message
  - Logs 'info' message if 'log_message' setting set to 'true'.
- **param:** *message*
  - Message to be logged
  - **type:** *string*

### ***slingshot.logDebug(message)***
- Debug log message
  - Logs 'info' message if 'debug_log_level' setting set to 'verbose'.
- **param:** *message*
  - Message to be logged
  - **type:** *string*

### ***slingshot.on_use(itemstack, user, veloc)***
- Action to take when slingshot is used
- **param:** *itemstack*
- **param:** *user*
- **param:** *veloc*

### ***slingshot.register(name, def)***
- Registers a new slingshot
  - **param:** *name*
    - Name/Type of new slingshot (e.g., 'wood')
    - **type:** *string*
  - **param:** *def*
    - Tool definition
    - **type:** *table*
      - Required attributes
        - *description*
          - Tool description
          - **type:** *string*
        - *damage_groups*
          - Damage dealt to entities
          - **type:** *table*
        - *velocity*
          - Speed/Distance of thrown object
          - **type:** int
