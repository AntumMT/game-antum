
local ss = server_shop
local transaction = dofile(ss.modpath .. "/transaction.lua")


--- Calculates the value of an item stack.
--
--  @local
--  @function server_shop.calculate_value
--  @tparam ItemStack stack Item stack.
local function calculate_value(stack)
	local value = 0

	for c, v in pairs(ss.registered_currencies) do
		if stack:get_name() == c then
			value = stack:get_count() * v
			break
		end
	end

	return value
end


local callbacks = {
	allow_put = function(inv, listname, index, stack, player)
		-- TODO: move this to `on_put`

		local pmeta = player:get_meta()

		local to_deposit = calculate_value(stack)
		if to_deposit <= 0 then return 0 end

		local id = pmeta:get_string(ss.modname .. ":id")
		if id:trim() == "" then return 0 end

		local pos = core.deserialize(pmeta:get_string(ss.modname .. ":pos"))
		if not pos then return 0 end

		transaction.set_deposit(id, player, transaction.get_deposit(id, player) + to_deposit)

		-- refresh formspec dialog
		ss.show_formspec(pos, player)

		return -1
	end,
}

local inv = core.create_detached_inventory(ss.modname, callbacks)
inv:set_size("deposit", 1)
