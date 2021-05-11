
local ss = server_shop


local fs_width = 14
local fs_height = 11
local btn_w = 1.75
local btn_y = 4.6

--- Retrieves shop product list by ID.
--
--  @function get_product_list
--  @local
--  @param id String identifier of shop.
--  @return String of shop contents.
function get_product_list(id)
	local products = ""
	local shop = ss.get_shop(id)

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


function server_shop.get_formspec(pos, player)
		local meta = core.get_meta(pos)
		local id = meta:get_string("id")
		local deposited = meta:get_int("deposited")

		local formspec = "formspec_version[4]size[" .. tostring(fs_width) .. "," .. tostring(fs_height) .."]"

		local shop_name = meta:get_string("name"):trim()
		if shop_name ~= "" then
			formspec = formspec .. "label[0.2,0.4;" .. shop_name .. "]"
		end

		if ss.is_shop_admin(pos, player) then
			formspec = formspec
				.. "button[" .. tostring(fs_width-6.2) .. ",0.2;" .. tostring(btn_w) .. ",0.75;btn_id;Set ID]"
				.. "field[" .. tostring(fs_width-4.3) .. ",0.2;4.1,0.75;input_id;;" .. id .. "]"
				.. "field_close_on_enter[input_id;false]"
		end

		-- ensure selected value in meta data
		if meta:get_int("selected") < 1 then
			meta:set_int("selected", meta:get_int("default_selected"))
		end

		-- get item name for displaying image
		local selected_item = nil
		local shop = ss.get_shop(id)

		if shop then
			-- make sure we're not out of range of the shop list
			local s_idx = meta:get_int("selected")
			if s_idx > #shop.def then
				s_idx = 1
			end

			selected_item = shop.def[meta:get_int("selected")]
			if selected_item then
				selected_item = selected_item[1]
			end
		end

		local margin_r = fs_width-(btn_w+0.2)

		formspec = formspec
			.. "label[0.2,1;Deposited: " .. tostring(deposited) .. " MG]"
			.. "list[context;deposit;0.2,1.5;1,1;0]"
			.. "textlist[2.15,1.5;9.75,3;products;" .. get_product_list(id) .. ";"
				.. tostring(meta:get_int("selected")) .. ";false]"

		if selected_item and selected_item ~= "" then
			formspec = formspec
				.. "item_image[" .. tostring(fs_width-1.2) .. ",1.5;1,1;" .. selected_item .. "]"
		end

		formspec = formspec
			.. "button[0.2," .. tostring(btn_y) .. ";" .. tostring(btn_w) .. ",0.75;btn_refund;Refund]"
			.. "button[" .. tostring(margin_r) .. "," .. tostring(btn_y) .. ";" .. tostring(btn_w) .. ",0.75;btn_buy;Buy]"
			.. "list[current_player;main;2.15,5.5;8,4;0]"
			.. "button_exit[" .. tostring(margin_r) .. ",10;" .. tostring(btn_w) .. ",0.75;btn_close;Close]"
		local formname = "server_shop"
		if id and id ~= "" then
			formname = formname .. "_" .. id
		end

		return formspec .. formname
end
