## Server Shop

---
### Description:

Shops intended to be set up by [Minetest](https://www.minetest.net/) server administrators.

No craft recipe is given as this for administrators, currently a machine can only be set up with `/giveme server_shop:shop` command.

***WARNING:** this mod is in early development, see [TODO](TODO.txt) list*

![screenshot](screenshot.png)

---
### Usage:

#### Registering Shops & Currencies:

Shop lists are registered with the `server_shop.register_shop(id, name, def)` function. `id` is a string identifier associated with the shop list. `name` is a human-readable string that will be displayed as the shop's title. `def` is the shop list definition. Shop lists are defined in a table of tuples in `{itemname, price}` format.

Registration example:
```lua
server_shop.register_shop("basic", "Basic Shop", {
	{
		{"default:wood", 2},
		{"default:obsidian", 7},
	}
})
```

Shops can optionally be configured in `<world_path>/server_shops.json` file. To register a seller shop (buyers currently not supported), set `type` to "sell". `id` is a string identifier for the shop. `name` is the string displayed in the formspec & when a player points at the node. `products` is a list of products sold at the shop in format "name:value".

Example:
```json
[
  {
    "type":"sell",
    "id":"frank",
    "name":"Frank's Shop",
    "products":{"default:wood":1}
  },
  {
    "type":"sell",
    "id":"julie",
    "name":"Julie's Shop",
    "products":
    {
      "default:iron_lump":5,
      "default:copper_lump":5,
    }
  },
]
```

Currencies can be registered with `server_shop.register_currency`:
```lua
server_shop.register_currency("currency:minegeld", 1)
server_shop.register_currency("currency:minegeld_5", 5)
```

When registering a new currency in `server_shops.json`, set `type` to "currency". `name` is the item to be used as currency & `value` is the item's worth:
```json
	{
		"type":"currency",
		"name":"currency:minegeld",
		"value":1,
	},
	{
		"type":"currency",
		"name":"currency:minegeld_5",
		"value":5,
	},
```

You can also register a currency suffix to be displayed in the formspec. Simply set the value of `server_shop.currency_suffix`:
```lua
server_shop.currency_suffix = "MG"
```

In `server_shops.json`, set `type` to "suffix" & `value` to the string to be displayed:
```json
	{
		"type":"suffix",
		"value":"MG",
	},
```

#### Setting up Shops in Game:

Server admins use the chat command `/giveme server_shop:shop` to receive a shop node. After placing the node, the ID can be set with the "Set ID" button & text input field (only players with the "server" privilege can set ID). Set the ID to the shop ID you want associated with this shop node ("basic" for the example above) & the list will be populated with the registered products & prices.

To make purchases, players deposit currency items into the deposit slot. Select an item to purchase & press the "Buy" button. If there is adequate money deposited, player will receive the item & the price will be deducted from the deposited amount. Press the "Refund" button to retrieve any money not spent.

***SECURITY WARNING:*** As stated, this mod is in early development. Currently, it is possible to interfere in another player's transactions. So this mod is *not* recommended for use with public servers at this time.

---
### Licensing:

- Code: [MIT](LICENSE.txt)
- Textures: CC0

---
### Dependencies:

- Required:
  - none
- Optional:
  - [currency][mod.currency]

Compatible with:

---
### Links:

- [GitHub repo](https://github.com/AntumMT/mod-server_shop)
- [Minetest forum](https://forum.minetest.net/viewtopic.php?t=26645)
- [API](https://antummt.github.io/mod-server_shop/docs/api.html)
- [Changelog](CHANGES.txt)
- [TODO](TODO.txt)


[mod.currency]: https://forum.minetest.net/viewtopic.php?t=21339
