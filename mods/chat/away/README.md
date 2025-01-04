
# Away Command

## About

A simple [Luanti (Minetest)](https://luanti.org/) mod that adds an `/away` command. Inspired by jordan4ibanez's extra commands mod, but works slightly differently than its `/afk` command.

## Usage

- `/away [reason]`: If you are not marked as away or a reason parameter is given, marks you as away (or changes the away reason). If you are marked as away and no reason parameter is given, sets you as not away and possibly notifies other players (if they tried to talk to you while you were away).
- `/away? [name]`: Checks the away status of the player with the specified name, or yourself if no name parameter is given. Possible statuses are: present, away (<reason>), disconnected.

`/away <reason>` marks you as being away. The reason is optional. When you're back, simply type `/away` again. Writing a chat message (except commands) clears your away status too. You can check your away status with the command `/away?`, and that of other people with `/away? <name>`.

Other players don't immediately see when you set yourself as away, unless they constantly watch you with `/away? yourname`. However, when somebody mentions your name in chat, they receive an away notice. If that happens, they're also notified as soon as you come back. The intent of this delayed notice system is to reduce away message spam.

## Notes

- No dependencies. Should be compatible with almost all other mods, if an incompatibility is found I'll list it here.
- If the name of an away player is mentioned multiple times in succession, only one notice is printed per minute.
- Players without the shout privilege can not set a reason in `/away`.
- Away statuses are not persistent, as that would make no sense. They're cleared when the server quits or the player disconnects (but see "Bugs" below).

## Bugs

- Moving around or interacting with things should probably reset the away status. Ideally this should be configurable.
- Away statuses are not immediately reset when a player disconnects. If the player was marked away and reconnects within 1-2 minutes after disconnecting, he may still be marked away. (Problem: there's no register_on_disconnect callback.)
