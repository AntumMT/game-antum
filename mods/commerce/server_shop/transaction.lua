
local ss = server_shop
local S = core.get_translator(ss.modname)


--- Formats a string from deposit identification.
--
--  @local
--  @function format_deposit_id
--  @tparam string id Shop identifier.
--  @tparam bool buyer Denotes whether shop type is seller or buyer (default: false).
--  @treturn string String formatted as "<modname>:<buy/sell>:<id>:deposited".
local function format_deposit_id(id, buyer)
	local deposit_id = ss.modname .. ":sell:"
	if buyer then
		deposit_id = ss.modname .. ":buy:"
	end
	return deposit_id .. id .. ":deposited"
end

--- Sets deposited amount for shop.
--
--  @local
--  @function set_deposit
--  @tparam string id Shop id.
--  @param player Player for whom deposit is being set.
--  @tparam int amount The amount deposit should be set to.
--  @tparam bool buyer Denotes whether shop is a seller or buyer
local function set_deposit(id, player, amount, buyer)
	local pmeta = player:get_meta()
	local deposit_id = format_deposit_id(id, buyer)

	pmeta:set_int(deposit_id, amount)
end

--- Retrieves amount player has deposited at shop.
--
--  @local
--  @function get_deposit
--  @tparam string id Shop id.
--  @param player Player to check.
--  @treturn int Total amount currently deposited.
local function get_deposit(id, player, buyer)
	return player:get_meta():get_int(format_deposit_id(id, buyer))
end

--- Add item(s) to player inventory or drops on ground.
--
--  @local
--  @function player The player who is receiving the item.
--  @param product String identifier of the item.
--  @param quantity Amount to give.
local function give_product(player, product, quantity)
	local istack = ItemStack(product)
	if quantity then
		istack:set_count(quantity)
	end

	-- add to player inventory or drop on ground
	local pinv = player:get_inventory()
	if not pinv:room_for_item("main", istack) then
		core.chat_send_player(player:get_player_name(),
			S("WARNING: @1 @2 was dropped on the ground.",
				istack:get_count(), istack:get_description()))
		core.item_drop(istack, player, player:get_pos())
	else
		pinv:add_item("main", istack)
	end
end

--- Calculates money to be returned to player.
--
--  @local
--  @function calculate_refund
--  @param total
--  @return ItemStack list & remainder
local function calculate_refund(total)
	local currencies = ss.get_currencies()
	local keys = {}

	-- sort currencies by value
	for k in pairs(currencies) do
		table.insert(keys, k)
	end
	table.sort(keys, function(kL, kR) return currencies[kL] > currencies[kR] end)

	local refund = {}
	local remain = total

	for _, k in ipairs(keys) do
		local v = currencies[k]
		local count = math.floor(remain / v)

		if count > 0 then
			local stack = ItemStack(k)
			stack:set_count(count)
			table.insert(refund, stack)

			remain = remain - (count * v)
		end
	end

	return refund, remain
end

--- Returns remaining deposited money to player.
--
--  @local
--  @function give_refund
--  @tparam string id Shop id.
--  @param player Player to whom refund is given.
local function give_refund(id, player, buyer)
	if not ss.currency_is_registered() then
		ss.log("error", "no currencies registered, cannot give refund")
		return
	end

	local pmeta = player:get_meta()
	local deposit_id = format_deposit_id(id, buyer)

	local refund, remain = calculate_refund(pmeta:get_int(deposit_id))
	for _, istack in ipairs(refund) do
		give_product(player, istack)
	end

	if remain > 0 then
		ss.log("warning", "refund left remaining balance: Shop ID: " .. id
			.. ", Player: " .. player:get_player_name() .. ", Balance: " .. remain)
		pmeta:set_int(deposit_id, remain)
		return
	end

	if remain < 0 then
		ss.log("warning", "refunded extra money: Shop ID: " .. id
			.. ", Player: " .. player:get_player_name() .. ", Discrepancy: " .. remain)
	end

	-- reset deposited amount after refund
	pmeta:set_string(deposit_id, nil)
end

--- Calculates the price of item being purchased.
--
--  @local
--  @function calculate_price
--  @param shop_id String identifier of shop.
--  @param item_id String identifier of item (e.g. default:dirt).
--  @param quantity Number of item being purchased.
--  @return Total value of purchase.
local function calculate_price(shop_id, item_id, quantity)
	local shop = ss.get_shop(shop_id)
	if not shop then
		return 0
	end

	local price_per = 0
	for _, i in ipairs(shop.products) do
		if i[1] == item_id then
			price_per = i[2]
			break
		end
	end

	return price_per * quantity
end

--- Calculates value of an item stack against registered currencies.
--
--  @local
--  @function calculate_currency_value
--  @tparam ItemStack stack Item stack.
--  @treturn int Total value of item stack.
local function calculate_currency_value(stack)
	local value = 0

	for c, v in pairs(ss.get_currencies()) do
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
	for _, product in ipairs(shop.products) do
		if item_name == product[1] then
			value_per = product[2]
			break
		end
	end

	return value_per * stack:get_count()
end


return {
	set_deposit = set_deposit,
	get_deposit = get_deposit,
	give_product = give_product,
	calculate_refund = calculate_refund,
	give_refund = give_refund,
	calculate_price = calculate_price,
	calculate_currency_value = calculate_currency_value,
	calculate_product_value = calculate_product_value,
}
