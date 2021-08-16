
--- Server Shops Formspec
--
--  @topic formspec


local ss = server_shop
local S = core.get_translator(ss.modname)


local fs_width = 14
local fs_height = 11
local btn_w = 1.75
local btn_y = 4.6

local transaction = dofile(ss.modpath .. "/transaction.lua")


--- Retrieves shop name by ID.
--
--  @local
--  @function get_shop_name
--  @tparam string id String identifier of shop.
--  @tparam bool buyer
--  @treturn string Shop's name representation.
local get_shop_name = function(id, buyer)
	if buyer ~= nil then
		ss.log("warning", "get_shop_name: \"buyer\" parameter is deprecated")
	end

	local shop = ss.get_shop(id)
	if shop then
		return shop.name
	end
end

--- Retrieves item name/id from shop list.
--
--  @local
--  @function get_shop_index
--  @param shop_id String identifier of shop.
--  @param idx Index of the item to retrieve.
--  @tparam bool buyer
--  @return String item identifier or `nil` if shop does not contain item.
local get_shop_index = function(shop_id, idx, buyer)
	if buyer ~= nil then
		ss.log("warning", "get_shop_index: \"buyer\" parameter is deprecated")
	end

	local shop = ss.get_shop(shop_id)
	if shop then
		local product = shop.products[idx]
		if product then
			return product[1]
		end
	end
end

--- Retrieves shop product list by ID.
--
--  @local
--  @function get_product_list
--  @param id String identifier of shop.
--  @tparam bool buyer
--  @return String of shop contents.
local get_product_list = function(id, buyer)
	if buyer ~= nil then
		ss.log("warning", "get_product_list: \"buyer\" parameter is deprecated")
	end

	local products = ""
	local shop = ss.get_shop(id)

	if shop and shop.products then
		for _, p in ipairs(shop.products) do
			local item = core.registered_items[p[1]]

			if not item then
				ss.log("warning", "Unknown item \"" .. p[1] .. "\" for shop ID \"" .. id .. "\"")
			else
				local item_name = item.short_description
				if not item_name then
					item_name = item.description
					if not item_name then
						item_name = p[1]
					end
				end

				local item_price = p[2]
				if not item_price then
					ss.log("warning", "Price not set for item \"" .. p[1] .. "\" for shop ID \"" .. id .. "\"")
				elseif products == "" then
					products = item_name .. " : " .. tostring(item_price)
				else
					products = products .. "," .. item_name .. " : " .. tostring(item_price)
				end

				if ss.currency_suffix then
					products = products .. " " .. ss.currency_suffix
				end
			end
		end
	end

	return products
end

--- Gets string formatted for use with form names.
--
--  @local
--  @function format_formname
--  @tparam bool buyer Denotes buyer or seller (can be `true`, `false`, or `nil`).
local format_formname = function(buyer)
	local t = {
		["buyer"] = true,
		["seller"] = false,
	}

	if type(buyer) == "string" then
		buyer = t[buyer]
	end

	if buyer == nil then
		return ss.modname..":unregistered"
	end

	if buyer then
		return ss.modname..":buy"
	end

	return ss.modname..":sell"
end


local quantities = {
	1,
	5,
	10,
	25,
	50,
	99,
}
quantities.get_idx = function(self, value)
	local idx = 1
	for _, v in ipairs(self) do
		if value == self[idx] then return idx end
		idx = idx + 1
	end

	return 1
end

--- Retrieves formspec layout.
--
--  @function server_shop.get_formspec
--  @tparam vector pos Shop node coordinates.
--  @tparam player ObjectRef Player to whom the formspec is shown.
--  @tparam[opt] bool buyer `true` if the shop in question is a buyer shop (default: false).
--  @treturn string Formspec formatted string.
ss.get_formspec = function(id, player, buyer)
		if buyer ~= nil then
			ss.log("warning", "get_formspec: \"buyer\" parameter is deprecated")
		end

		local pmeta = player:get_meta()
		local shop = ss.get_shop(id)

		local buyer, deposited
		if shop then
			buyer = shop.buyer == true
			deposited = transaction.get_deposit(id, player)

			-- store ID in player meta for retrieval during transactions
			pmeta:set_string(ss.modname .. ":id", id)
		end

		local margin_r = fs_width-(btn_w+0.2)
		local btn_refund = "button[0.2," .. tostring(btn_y) .. ";"
			.. tostring(btn_w) .. ",0.75;btn_refund;" .. S("Refund") .. "]"
		local btn_buy = "button[" .. tostring(margin_r) .. ","
			.. tostring(btn_y) .. ";" .. tostring(btn_w)
			.. ",0.75;btn_buy;" .. S("Buy") .. "]"
		local btn_sell = "button[" .. tostring(margin_r) .. ","
			.. tostring(btn_y) .. ";" .. tostring(btn_w)
			.. ",0.75;btn_sell;" .. S("Sell") .. "]"
		local btn_close = "button_exit[" .. tostring(margin_r) .. ",10;" .. tostring(btn_w)
			.. ",0.75;btn_close;" .. S("Close") .. "]"

		local formspec = "formspec_version[4]"
			.. "size[" .. tostring(fs_width) .. "," .. tostring(fs_height) .."]"

		if not ss.currency_is_registered() then
			return formspec.."label[0.2,1;"
				..S("Cannot use shops because there are no registered currencies.").."]"
					..btn_close
		end

		if shop and shop.name and shop.name ~= "" then
			formspec = formspec .. "label[0.2,0.4;" .. shop.name .. "]"
		end

		if ss.is_shop_admin(player) then
			formspec = formspec
				.. "button[" .. tostring(fs_width-6.2) .. ",0.2;" .. tostring(btn_w)
				.. ",0.75;btn_id;" .. S("Set ID") .. "]"
				.. "field[" .. tostring(fs_width-4.3) .. ",0.2;4.1,0.75;input_id;;" .. id .. "]"
				.. "field_close_on_enter[input_id;false]"
		end

		local selected_idx = 1
		local quant_idx = 1
		if player then
			selected_idx = pmeta:get_int(ss.modname .. ":selected")
			quant_idx = quantities:get_idx(pmeta:get_int(ss.modname .. ":quant"))
		end
		if selected_idx < 1 then
			selected_idx = 1
		end

		-- get item name for displaying image
		local selected_item = nil
		if shop then
			-- make sure we're not out of range of the shop list
			if selected_idx > #shop.products then
				selected_idx = #shop.products
			end

			selected_item = shop.products[selected_idx]
			if selected_item then
				selected_item = selected_item[1]
			end
		end

		if not buyer then
			formspec = formspec .. "label[0.2,1;"
			if ss.currency_suffix and ss.currency_suffix ~= "" then
				formspec = formspec .. S("Deposited: @1 @2", tostring(deposited), ss.currency_suffix)
			else
				formspec = formspec .. S("Deposited: @1", tostring(deposited))
			end
			formspec = formspec .. "]"
		end

		if shop then -- don't allow deposits to unregistered stores
			local inv_type = format_formname(buyer)

			formspec = formspec .. "list[detached:" .. inv_type .. ";deposit;0.2,1.5;1,1;0]"
		end

		formspec = formspec .. "textlist[2.15,1.5;9.75,3;products;"
			.. get_product_list(id) .. ";"
			.. tostring(selected_idx) .. ";false]"

		if selected_item and selected_item ~= "" then
			formspec = formspec
				.. "item_image[" .. tostring(fs_width-1.2) .. ",1.5;1,1;" .. selected_item .. "]"
		end

		if shop then
			if not buyer then
				formspec = formspec .. btn_refund
					.. "dropdown[" .. tostring(margin_r) .. ",3.77;" .. tostring(btn_w) .. ",0.75;quant;"
					.. table.concat(quantities, ",") .. ";" .. tostring(quant_idx) .. "]"
					.. btn_buy
			else
				formspec = formspec .. btn_sell
			end
		end

		return formspec	.. "list[current_player;main;2.15,5.5;8,4;0]" .. btn_close
end

--- Displays formspec to player.
--
--  @function server_shop.show_formspec
--  @tparam vector pos Shop node coordinates.
--  @tparam player ObjectRef Player to whom the formspec is shown.
--  @tparam[opt] bool buyer (deprecated)
ss.show_formspec = function(pos, player, buyer)
	if buyer ~= nil then
		ss.log("warning", "show_formspec: \"buyer\" parameter is deprecated")
	end

	local id = core.get_meta(pos):get_string("id")

	core.show_formspec(player:get_player_name(), format_formname(ss.shop_type(id)),
		ss.get_formspec(id, player))
end


core.register_on_player_receive_fields(function(player, formname, fields)
	if string.find(formname, ss.modname..":") == 1 then
		local buyer = formname == format_formname(true)

		local pmeta = player:get_meta()
		local pos = core.deserialize(pmeta:get_string(ss.modname .. ":pos"))
		if not pos then
			ss.log("error", "cannot retrieve shop position from player meta data")
			return false
		end

		local smeta = core.get_meta(pos)
		local id = smeta:get_string("id")

		local product_quant = 1
		if fields.quant then
			product_quant = tonumber(fields.quant)
		end

		if fields.quit then
			if server_shop.refund_on_close then
				if buyer then
					local inv = core.get_inventory({type="detached", name=ss.modname .. ":buy"})
					if not inv then return false end

					if not inv:is_empty("deposit") then
						local product = inv:get_stack("deposit", 1)
						transaction.give_product(player, product)
						inv:remove_item("deposit", product)
					end
				else
					-- return money to player if formspec closed
					transaction.give_refund(id, player, buyer)
				end
			end

			if not buyer then
				-- reset selected amount
				pmeta:set_string(ss.modname .. ":quant", nil)
			end

			return false
		elseif fields.btn_id or (fields.key_enter and fields.key_enter_field == "input_id") then
			-- safety check that only server admin can set ID
			if not ss.is_shop_admin(player) then
				ss.log("warning", "non-admin player " .. player.get_player_name()
					.. " attempted to change shop ID at ("
					.. tostring(pos.x) .. "," .. tostring(pos.y) .. "," .. tostring(pos.z)
					.. ")")
				return false
			end

			-- should not happen
			if not fields.input_id then
				ss.log("error", "Cannot retrieve ID input")
				return false
			end

			fields.input_id = ss.format_id(fields.input_id)
			smeta:set_string("id", fields.input_id)

			-- set or remove displayed text when pointed at
			local shop_name = get_shop_name(fields.input_id)
			if shop_name then
				smeta:set_string("infotext", shop_name)
				smeta:set_string("name", shop_name)
			else
				smeta:set_string("infotext", nil)
				smeta:set_string("name", nil)
			end

			ss.log("action", "admin " .. player:get_player_name()
				.. " set shop ID at ("
				.. tostring(pos.x) .. "," .. tostring(pos.y) .. "," .. tostring(pos.z)
				.. ") to \"" .. id .. "\"")
		elseif fields.products then
			local idx = tonumber(fields.products:sub(5))
			if type(idx) == "number" then
				pmeta:set_int(ss.modname .. ":selected", idx)
			end
		elseif fields.btn_refund then
			transaction.give_refund(id, player, buyer)
		elseif fields.btn_buy then
			local idx = pmeta:get_int(ss.modname .. ":selected")
			local product = get_shop_index(id, idx)

			if not product then
				ss.log("warning", "Trying to buy undefined item from shop \""
					.. tostring(id) .. "\"")
				return false
			end

			local total = transaction.calculate_price(id, product, product_quant)

			local deposited = transaction.get_deposit(id, player)
			if total > deposited then
				core.chat_send_player(player:get_player_name(), S("You haven't deposited enough money."))
				return false
			end

			product = ItemStack(product)
			product:set_count(product_quant)

			-- subtract total from deposited money
			transaction.set_deposit(id, player, deposited - total, buyer)

			-- execute transaction
			core.chat_send_player(player:get_player_name(),
				S("You purchased @1 @2 for @3 @4.", product:get_count(),
					product:get_description(), total, ss.currency_suffix))

			transaction.give_product(player, product, product_quant)
		elseif fields.btn_sell then
			local inv = core.get_inventory({type="detached", name=ss.modname .. ":buy",})
			if not inv then
				ss.log("error", "could not retrieve detached inventory: " .. ss.modname .. ":buy")
				return false
			end

			if inv:is_empty("deposit") then return false end

			local product = inv:get_stack("deposit", 1)
			local total = transaction.calculate_product_value(product, id, true)
			if total <= 0 then return false end

			local refund, remain = transaction.calculate_refund(total)
			for _, istack in ipairs(refund) do
				transaction.give_product(player, istack)
			end

			core.chat_send_player(player:get_player_name(),
				S("You sold @1 @2 for @3 @4.", product:get_count(),
					product:get_description(), total, ss.currency_suffix))

			inv:remove_item("deposit", product)

			if remain > 0 then
				ss.log("warning", "buyer shop \"" .. id .. "\" failed to refund "
					.. remain .. " to player " .. player:get_player_name())
			elseif remain < 0 then
				ss.log("warning", "buyer shop \"" .. id .. "\" gave "
					.. remain .. " extra to player " .. player:get_player_name())
			end
		end

		-- refresh formspec view
		pmeta:set_int(ss.modname .. ":quant", product_quant)
		ss.show_formspec(pos, player)

		return false
	end
end)
