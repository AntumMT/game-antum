
local ss = server_shop
local transaction = dofile(ss.modpath .. "/transaction.lua")


--- Calculates value of an item stack against registered currencies.
--
--  @local
--  @function calculate_currency_value
--  @tparam ItemStack stack Item stack.
--  @treturn int Total value of item stack.
local function calculate_currency_value(stack)
	local value = 0

	for c, v in pairs(ss.registered_currencies) do
		if stack:get_name() == c then
			value = stack:get_count() * v
			break
		end
	end

	return value
end

--- Calculates value of an item stack against a registered shop's product list.
--
--  @local
--  @function calculate_product_value
--  @tparam ItemStack stack Item stack.
--  @tparam string id Shop id.
--  @tparam bool buyer Determines whether to parse buyer shops or seller shops.
--  @treturn int Total value of item stack.
local function calculate_product_value(stack, id, buyer)
	local shop = ss.get_shop(id, buyer)
	if not shop then return 0 end

	local item_name = stack:get_name()
	local value_per = 0
	for _, product in ipairs(shop.def) do
		if item_name == product[1] then
			value_per = product[2]
			break
		end
	end

	return value_per * stack:get_count()
end


local seller_callbacks = {
	allow_put = function(inv, listname, index, stack, player)
		local pmeta = player:get_meta()
		local id = pmeta:get_string(ss.modname .. ":id")
		if id:trim() == "" then return 0 end

		local to_deposit = calculate_currency_value(stack)
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

		local to_deposit = calculate_product_value(stack, id, true)
		if to_deposit <= 0 then return 0 end

		local pos = core.deserialize(pmeta:get_string(ss.modname .. ":pos"))
		if not pos then return 0 end

		transaction.set_deposit(id, player, transaction.get_deposit(id, player, true) + to_deposit, true)

		-- refresh formspec dialog
		ss.show_formspec(pos, player, true)

		return -1
	end,
}

local sinv = core.create_detached_inventory(ss.modname .. ":sell", seller_callbacks)
sinv:set_size("deposit", 1)

local binv = core.create_detached_inventory(ss.modname .. ":buy", buyer_callbacks)
binv:set_size("deposit", 1)
