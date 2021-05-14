
local ss = server_shop


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
	local istack = product
	if type(istack) == "string" then
		-- create the ItemStack
		istack = ItemStack(product)
		-- make sure we give at leaset 1
		if not quantity then quantity = 1 end
		istack:set_count(quantity)
	elseif quantity and istack:get_count() ~= quantity then
		istack:set_count(quantity)
	end

	-- add to player inventory or drop on ground
	local pinv = player:get_inventory()
	if not pinv:room_for_item("main", istack) then
		core.chat_send_player(player:get_player_name(), "WARNING: "
			.. tostring(istack:get_count()) .. " " .. istack:get_description()
			.. " was dropped on the ground.")
		core.item_drop(istack, player, player:get_pos())
	else
		pinv:add_item("main", istack)
	end
end

--- Calculates money to be returned to player.
--
--  FIXME:
--    - not very intuitive
--    - doesn't allow currency values other than 1, 5, 10, 50, & 100
--
--  @local
--  @function calculate_refund
--  @param total
local function calculate_refund(total)
	local refund = 0

	local hun = math.floor(total / 100)
	total = total - (hun * 100)

	local fif = math.floor(total / 50)
	total = total - (fif * 50)

	local ten = math.floor(total / 10)
	total = total - (ten * 10)

	local fiv = math.floor(total / 5)
	total = total - (fiv * 5)

	-- at this point, 'total' should always be divisible by whole number
	local one = total / 1
	total = total - one

	if total ~= 0 then
		core.log("warning", "Refund did not result in 0 deposited balance")
	end

	local refund = {}
	for c, v in pairs(ss.registered_currencies) do
		local icount = 0

		if v == 1 then
			icount = one
		elseif v == 5 then
			icount = fiv
		elseif v == 10 then
			icount = ten
		elseif v == 50 then
			icount = fif
		elseif v == 100 then
			icount = hun
		end

		if icount > 0 then
			local stack = ItemStack(c)
			stack:set_count(icount)
			table.insert(refund, stack)
		end
	end

	return refund
end

--- Returns remaining deposited money to player.
--
--  @local
--  @function give_refund
--  @tparam string id Shop id.
--  @param player Player to whom refund is given.
local function give_refund(id, player, buyer)
	local pmeta = player:get_meta()
	local deposit_id = format_deposit_id(id, buyer)

	local refund = calculate_refund(pmeta:get_int(deposit_id))
	for _, istack in ipairs(refund) do
		give_product(player, istack)
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
	for _, i in ipairs(shop.def) do
		if i[1] == item_id then
			price_per = i[2]
			break
		end
	end

	return price_per * quantity
end


return {
	set_deposit = set_deposit,
	get_deposit = get_deposit,
	give_product = give_product,
	give_refund = give_refund,
	calculate_price = calculate_price,
}
