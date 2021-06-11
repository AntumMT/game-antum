
--- Settings for server_shop.
--
--  @module settings.lua


--- If currency mod is installed, automatically set up values for minegeld notes.
--
--  @setting server_shop.use_currency_defaults
--  @settype bool
--  @default true
server_shop.use_currency_defaults = core.settings:get_bool("server_shop.use_currency_defaults", true)

--- Refunds deposited money when formspec is closed.
--
--  @setting server_shop.refund_on_close
--  @settype bool
--  @default true
server_shop.refund_on_close = core.settings:get_bool("server_shop.refund_on_close", true)
