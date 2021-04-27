
server_shop = {}
server_shop.name = core.get_current_modname()

local node_name = "server_shop:shop"

local shops = {}

--- Registers a shop list to be accessed via a shop node.
--
--  @function server_shop.register_shop
--  @param name Human readable name to be displayed.
--  @param id String ID associated with shop list.
--  @param def Shop definition (e.g. items & prices)
function server_shop.register_shop(name, id, def)
	-- FIXME: check if shop is alreay registered
	local shop = {}
	shop.name = name
	shop.id = id
	shop.def = def
	table.insert(shops, shop)

	core.log("action", "[" .. server_shop.name .. "] Registered shop: " .. shop.id)
end

local function get_shop(id)
	for _, s in pairs(shops) do
		if s.id == id then
			return s
		end
	end
end

local function get_shop_name(id)
	local shop = get_shop(id)
	if shop then
		return shop.name
	end
end


local fs_width = 14
local fs_height = 11
local btn_w = 1.75
local btn_y = 4.6

local function get_product_list(id)
	local products = ""
	local shop = get_shop(id)

	if shop and shop.def then
		for _, p in ipairs(shop.def) do
			local item = core.registered_items[p[1]]

			if not item then
				core.log("warning", "Unknown item \"" .. p[1] .. "\" for shop ID \"" .. id .. "\"")
				goto continue
			end

			local item_name = item.short_description
			if not item_name then
				item_name = item.description
				if not item_name then
					item_name = p[1]
				end
			end

			local item_price = p[2]
			if not item_price then
				core.log("warning", "Price not set for item \"" .. p[1] .. "\" for shop ID \"" .. id .. "\"")
				goto continue
			end

			if products == "" then
				products = item_name .. " : " .. tostring(item_price) .. " MG"
			else
				products = products .. "," .. item_name .. " : " .. tostring(item_price) .. " MG"
			end

			::continue::
		end
	end

	return products
end

--- Checks if a player has admin rights to for managing shop.
--
--  @local
--  @function is_shop_admin
--  @param pos Position of shop.
--  @param player Player requesting permissions.
local function is_shop_admin(pos, player)
	if not player then
		return false
	end

	local meta = core.get_meta(pos)
	return core.check_player_privs(player, "server")
		--or player:get_player_name() == meta:get_string("owner")
end

local function is_shop_owner(pos, player)
	if not player then
		return false
	end

	local meta = core.get_meta(pos)
	return player:get_player_name() == meta:get_string("owner")
end

local function get_formspec(pos, player)
		local meta = core.get_meta(pos)
		local id = meta:get_string("id")
		local deposited = meta:get_int("deposited")

		local formspec = "formspec_version[4]size[" .. tostring(fs_width) .. "," .. tostring(fs_height) .."]"

		local shop_name = meta:get_string("name"):trim()
		if shop_name ~= "" then
			formspec = formspec .. "label[0.2,0.4;Shop: " .. shop_name .. "]"
		end

		if is_shop_admin(pos, player) then
			formspec = formspec
				.. "button[" .. tostring(fs_width-6.2) .. ",0.2;" .. tostring(btn_w) .. ",0.75;btn_id;Set ID]"
				.. "field[" .. tostring(fs_width-4.3) .. ",0.2;4.1,0.75;input_id;;" .. id .. "]"
				.. "field_close_on_enter[input_id;false]"
		end

		-- ensure selected value in meta data
		if meta:get_int("selected") < 1 then
			meta:set_int("selected", meta:get_int("default_selected"))
		end

		formspec = formspec
			.. "label[0.2,1;Deposited: " .. tostring(deposited) .. " MG]"
			.. "list[context;deposit;0.2,1.5;1,1;0]"
			.. "textlist[2.15,1.5;9.75,3;products;" .. get_product_list(id) .. ";"
				.. tostring(meta:get_int("selected")) .. ";false]"
			.. "button[0.2," .. tostring(btn_y) .. ";" .. tostring(btn_w) .. ",0.75;btn_refund;Refund]"
			.. "button[" .. tostring(fs_width-(btn_w+0.2)) .. "," .. tostring(btn_y) .. ";" .. tostring(btn_w) .. ",0.75;btn_buy;Buy]"
			.. "list[current_player;main;2.15,5.5;8,4;0]"

		local formname = "server_shop"
		if id and id ~= "" then
			formname = formname .. "_" .. id
		end

		return formspec .. formname
end


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

--- Calculates the price of item being purchased.
--
--  @function calculate_price
--  @local
--  @param shop_id String identifier of shop.
--  @param item_id String identifier of item (e.g. default:dirt).
--  @param quantity Number of item being purchased.
--  @return Total value of purchase.
local function calculate_price(shop_id, item_id, quantity)
	local shop = get_shop(shop_id)
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

--- Retrieves item name/id from shop list.
--
--  @function get_shop_index
--  @local
--  @param shop_id String identifier of shop.
--  @param idx Index of the item to retrieve.
--  @return String item identifier or `nil` if shop does not contain item.
local function get_shop_index(shop_id, idx)
	local shop = get_shop(shop_id)
	if shop then
		local product = shop.def[idx]
		if product then
			return product[1]
		end
	end
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

--- Sets the amount of money deposited into machine.
--
--  @local
--  @function set_deposit_balance
--  @param pos Position of shop.
--  @param amount Integer amount to be set.
--[[ UNUSED:
local function set_deposit_balance(pos, amount)
	local meta = core.get_meta(pos)
	meta:set_int("deposited", amount)
end
]]

--- Retrieves amound of money currently deposited into shop.
--
--  @local
--  @function get_deposit_balance
--  @param pos Position of shop.
local function get_deposit_balance(pos)
	return core.get_meta(pos):get_int("deposited")
end

core.register_node(node_name, {
	description = "Shop",
	drawtype = "nodebox",
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
		meta:set_string("formspec", get_formspec(pos))
	end,
	after_place_node = function(pos, placer)
		local meta = core.get_meta(pos)
		set_owner(pos, placer:get_player_name())
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local meta = core.get_meta(pos)
		meta:set_string("formspec", get_formspec(pos, player))
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

		return is_shop_owner(pos, player) or is_shop_admin(pos, player)
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
			-- reset selected to default when closed
			meta:set_int("selected", meta:get_int("default_selected"))
		elseif fields.btn_id and is_shop_admin(pos, sender) then
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
					meta:set_string("infotext", "Shop: " .. shop_name)
					meta:set_string("name", shop_name)
				else
					meta:set_string("infotext", nil)
					meta:set_string("name", nil)
				end
			end
		elseif fields.products then
			-- set selected index in meta data to be retrieved when "buy" button is pressed
			meta:set_int("selected", fields.products:sub(5))
		elseif fields.btn_refund then
			local refund = calculate_refund(meta:get_int("deposited"))
			for _, istack in ipairs(refund) do
				give_product(sender, istack)
			end

			-- reset deposited amount after refund
			meta:set_int("deposited", 0)
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
		meta:set_string("formspec", get_formspec(pos, sender))
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local deposited = calculate_value(stack)
		if deposited > 0 then
			local meta = core.get_meta(pos)
			meta:set_int("deposited", meta:get_int("deposited") + deposited)

			-- refresh formspec dialog
			meta:set_string("formspec", get_formspec(pos, player))

			return -1
		end

		return 0
	end
})


-- load configured shops from world directory
local shops_file = core.get_worldpath() .. "/server_shops.lua"
local fopen = io.open(shops_file, "r")
if fopen ~= nil then
	io.close(fopen)
	dofile(shops_file)
end
