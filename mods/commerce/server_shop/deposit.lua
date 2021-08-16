
local ss = server_shop
local transaction = dofile(ss.modpath .. "/transaction.lua")


local seller_callbacks = {
	allow_put = function(inv, listname, index, stack, player)
		local pmeta = player:get_meta()
		local id = pmeta:get_string(ss.modname .. ":id")
		if id:trim() == "" then return 0 end

		local to_deposit = transaction.calculate_currency_value(stack)
		if to_deposit <= 0 then return 0 end

		local pos = core.deserialize(pmeta:get_string(ss.modname .. ":pos"))
		if not pos then return 0 end

		transaction.set_deposit(id, player, transaction.get_deposit(id, player) + to_deposit)

		-- refresh formspec dialog
		ss.show_formspec(pos, player)

		return -1
	end,
}

local buyer_callbacks = {
	allow_put = function(inv, listname, index, stack, player)
		local pmeta = player:get_meta()
		local id = pmeta:get_string(ss.modname .. ":id")
		if id:trim() == "" then return 0 end

		local to_deposit = transaction.calculate_product_value(stack, id, true)
		if to_deposit <= 0 then return 0 end

		local pos = core.deserialize(pmeta:get_string(ss.modname .. ":pos"))
		if not pos then return 0 end

		return stack:get_count()
	end,
}

core.create_detached_inventory(ss.modname .. ":sell", seller_callbacks):set_size("deposit", 1)
core.create_detached_inventory(ss.modname .. ":buy", buyer_callbacks):set_size("deposit", 1)
