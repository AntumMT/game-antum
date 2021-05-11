
local ss = server_shop


local node_name = "server_shop:shop"

local currencies = {
	{"currency:minegeld", 1,},
	{"currency:minegeld_5", 5,},
	{"currency:minegeld_10", 10,},
	{"currency:minegeld_50", 50,},
	{"currency:minegeld_100", 100,},
}

--- Calculates how much money is being deposited.
local function calculate_value(stack)
	local value = 0
	for _, c in ipairs(currencies) do
		if stack:get_name() == c[1] then
			value = stack:get_count() * c[2]
			break
		end
	end

	return value
end

local function get_shop_name(id)
	local shop = ss.get_shop(id)
	if shop then
		return shop.name
	end
end

--- Retrieves item name/id from shop list.
--
--  @function get_shop_index
--  @local
--  @param shop_id String identifier of shop.
--  @param idx Index of the item to retrieve.
--  @return String item identifier or `nil` if shop does not contain item.
local function get_shop_index(shop_id, idx)
	local shop = ss.get_shop(shop_id)
	if shop then
		local product = shop.def[idx]
		if product then
			return product[1]
		end
	end
end

--- Sets the owner of the shop & gives admin privileges.
--
--  @local
--  @function set_owner
--  @param pos Position of shop.
--  @param pname String name of new owner.
local function set_owner(pos, pname)
	local meta = core.get_meta(pos)
	meta:set_string("owner", pname)
end

--- Calculates the price of item being purchased.
--
--  @function calculate_price
--  @local
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

--- Calculates money to be returned to player.
--
--  FIXME: not very intuitive
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
	for _, c in ipairs(currencies) do
		local iname = c[1]
		local ivalue = c[2]
		local icount = 0

		if ivalue == 1 then
			icount = one
		elseif ivalue == 5 then
			icount = fiv
		elseif ivalue == 10 then
			icount = ten
		elseif ivalue == 50 then
			icount = fif
		elseif ivalue == 100 then
			icount = hun
		end

		if icount > 0 then
			local stack = ItemStack(iname)
			stack:set_count(icount)
			table.insert(refund, stack)
		end
	end

	return refund
end

--- Add item(s) to player inventory or drops on ground.
--
--  @function player The player who is receiving the item.
--  @local
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

local function give_refund(meta, player)
	local refund = calculate_refund(meta:get_int("deposited"))
	for _, istack in ipairs(refund) do
		give_product(player, istack)
	end

	-- reset deposited amount after refund
	meta:set_int("deposited", 0)
end


core.register_node(node_name, {
	description = "Shop",
	--drawtype = "nodebox",
	drawtype = "normal",
	tiles = {
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_side.png",
		"server_shop_front.png",
		"server_shop_side.png",
	},
	--[[
	drawtype = "mesh",
	mesh = "server_shop.obj",
	tiles = {"server_shop_mesh.png",},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.45, 0.5},
	},
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	]]
	groups = {oddly_breakable_by_hand=1,},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = core.get_meta(pos)
		-- set which item should be selected when formspec is opened
		meta:set_int("default_selected", 1)
		meta:set_string("formspec", ss.get_formspec(pos))
	end,
	after_place_node = function(pos, placer)
		local meta = core.get_meta(pos)
		set_owner(pos, placer:get_player_name())
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", ss.get_formspec(pos, player))
		local inv = meta:get_inventory()
		inv:set_size("deposit", 1)
	end,
	can_dig = function(pos, player)
		local meta = core.get_meta(pos)
		local deposited = meta:get_int("deposited")

		if deposited > 0 then
			core.log(player:get_player_name() .. " attempted to dig " .. node_name
				.. " containing " .. tostring(deposited) .. " MG at ("
				.. pos.x .. "," .. pos.y .. "," .. pos.z .. ")")
			return false
		end

		return ss.is_shop_owner(pos, player) or ss.is_shop_admin(pos, player)
	end,
	on_dig = function(pos, node, digger)
		local deposited = core.get_meta(pos):get_int("deposited")
		core.node_dig(pos, node, digger)

		if deposited < 0 then
			core.log("warning", digger:get_player_name() .. " dug " .. node_name
				.. " containing negative deposit balance")
		end
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = core.get_meta(pos)
		local pname = sender:get_player_name()

		if fields.quit then
			-- refund any money still deposited
			give_refund(meta, sender)
			-- reset selected to default when closed
			meta:set_int("selected", meta:get_int("default_selected"))
		elseif fields.btn_id and ss.is_shop_admin(pos, sender) then
			local new_id = fields.input_id:trim()
			-- FIXME: allow to be set to "" in order to remove shop
			if new_id ~= "" then
				core.log("action", pname .. " sets " .. node_name .. " ID to \"" .. new_id
					.. "\" at (" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")")
				meta:set_string("id", new_id)
				fields.input_id = new_id

				-- set or remove displayed text when pointed at
				local shop_name = get_shop_name(new_id)
				if shop_name then
					meta:set_string("infotext", shop_name)
					meta:set_string("name", shop_name)
				else
					meta:set_string("infotext", nil)
					meta:set_string("name", nil)
				end

				-- make sure selected index is set back to default value
				meta:set_int("selected", meta:get_int("default_selected"))
			end
		elseif fields.products then
			-- set selected index in meta data to be retrieved when "buy" button is pressed
			meta:set_int("selected", fields.products:sub(5))
		elseif fields.btn_refund then
			give_refund(meta, sender)
		elseif fields.btn_buy then
			-- get selected index
			local selected = meta:get_int("selected")
			local shop_id = meta:get_string("id")
			local product = get_shop_index(shop_id, selected)

			if not product then
				core.log("warning", "Trying to buy undefined item from shop \""
					.. tostring(shop_id) .. "\"")
				return
			end

			-- FIXME: allow purchasing multiples
			local product_count = 1
			local total = calculate_price(shop_id, product, product_count)

			local deposited = meta:get_int("deposited")
			if total > deposited then
				core.chat_send_player(pname, "You haven't deposited enough money.")
				return
			end

			product = ItemStack(product)
			product:set_count(product_count)

			-- subtract total from deposited money
			meta:set_int("deposited", deposited - total)
			-- execute transaction
			core.chat_send_player(pname, "You purchased " .. tostring(product:get_count())
				.. " " .. product:get_description() .. " for " .. tostring(total) .. " MG.")
			give_product(sender, product)
		end

		-- refresh formspec dialog
		meta:set_string("formspec", ss.get_formspec(pos, sender))
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local deposited = calculate_value(stack)
		if deposited > 0 then
			local meta = core.get_meta(pos)
			meta:set_int("deposited", meta:get_int("deposited") + deposited)

			-- refresh formspec dialog
			meta:set_string("formspec", ss.get_formspec(pos, player))

			return -1
		end

		return 0
	end
})
