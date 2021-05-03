-- atm interface

function atm.getform (player)
	atm.ensure_init(player:get_player_name())
	local formspec =
		"size[12,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[0.5,0;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
		"label[0.5,0.35;Deposit:]" ..
		"list[context;deposit;0.5,1.25;1,1;0]" ..
		"label[6.5,0.35;Withdraw:]" ..
		"label[6.5,0.75;1s]" ..
		"label[7.5,0.75;5s]" ..
		"label[8.5,0.75;10s]" ..
		"label[9.5,0.75;50s]" ..
		"label[10.5,0.75;100s]" ..
		"item_image_button[6.5,1.25;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "x1" .."]" ..
		"item_image_button[7.5,1.25;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "x1" .."]" ..
		"item_image_button[8.5,1.25;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "x1" .."]" ..
		"item_image_button[9.5,1.25;1,1;".. "currency:minegeld_50" ..";i-50;\n\n\b\b\b\b\b" .. "x1" .."]" ..
		"item_image_button[10.5,1.25;1,1;".. "currency:minegeld_100" ..";i-100;\n\n\b\b\b\b\b" .. "x1" .."]" ..
		"item_image_button[6.5,2.25;1,1;".. "currency:minegeld" ..";t-10;\n\n\b\b\b\b" .. "x10" .."]" ..
		"item_image_button[7.5,2.25;1,1;".. "currency:minegeld_5" ..";t-50;\n\n\b\b\b\b" .. "x10" .."]" ..
		"item_image_button[8.5,2.25;1,1;".. "currency:minegeld_10" ..";t-100;\n\n\b\b\b\b" .. "x10" .."]" ..
		"item_image_button[9.5,2.25;1,1;".. "currency:minegeld_50" ..";t-500;\n\n\b\b\b\b" .. "x10" .."]" ..
		"item_image_button[10.5,2.25;1,1;".. "currency:minegeld_100" ..";t-1000;\n\n\b\b\b\b" .. "x10" .."]" ..
		"item_image_button[6.5,3.25;1,1;".. "currency:minegeld" ..";c-100;\n\n\b\b\b" .. "x100" .."]" ..
		"item_image_button[7.5,3.25;1,1;".. "currency:minegeld_5" ..";c-500;\n\n\b\b\b" .. "x100" .."]" ..
		"item_image_button[8.5,3.25;1,1;".. "currency:minegeld_10" ..";c-1000;\n\n\b\b\b" .. "x100" .."]" ..
		"item_image_button[9.5,3.25;1,1;".. "currency:minegeld_50" ..";c-5000;\n\n\b\b\b" .. "x100" .."]" ..
		"item_image_button[10.5,3.25;1,1;".. "currency:minegeld_100" ..";c-10000;\n\n\b\b\b" .. "x100" .."]" ..
		"button_exit[5.5,3;1,2;Quit;Quit]" ..
		"list[current_player;main;2,4.5;8,1;]"..
		"list[current_player;main;2,5.75;8,3;8]"..
		"listring[]"..
		default.get_hotbar_bg(2, 4.5)

	return formspec, "atm.form"
end



-- wire transfer interface

function atm.getform_wt (player)
	atm.ensure_init(player:get_player_name())
	local formspec =
		"size[8,6]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"button[5.75,0;2,1;transactions;Transactions >]" ..
		"label[2.5,0;Wire Transfer Terminal]" ..
		"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
		"field[0.5,1.5;5,1;dstn;Recepient:;]"..
		"field[6,1.5;2,1;amnt;Amount:;]"..
		"field[0.5,3;7.5,1;desc;Description:;]"..
		"button_exit[0.2,5;1,1;Quit;Quit]" ..
		"button[4.7,5;3,1;pay;Complete the payment]"

	return formspec, "atm.form.wt"
end

function atm.getform_wtconf (player, dstn, amnt, desc)
	atm.ensure_init(player:get_player_name())
	local formspec =
		"size[8,6]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"label[2.5,0;Wire Transfer Terminal]" ..
		"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
		"label[2.5,1;TRANSACTION SUMMARY:]"..
		"label[0.5,1.5;Recepient: " .. dstn .. "]"..
		"label[0.5,2;Amount: " .. amnt .. "]"..
		"label[0.5,2.5;Description: " .. desc .. "]"..
		"button_exit[0.2,5;1,1;Quit;Quit]" ..
		"button[4.7,5;3,1;cnfrm;Confirm transfer]"

	return formspec, "atm.form.wtc"
end

function atm.getform_wtlist (player, tlist)
	atm.ensure_init(player:get_player_name())

	local textlist = ''

	if not tlist then
		textlist = "no transactions registered\n"
	else
		for _, entry in ipairs(tlist) do
			textlist = textlist .. entry.date .. " $" .. entry.sum .. " from " .. entry.from .. ": " .. entry.desc .. "\n"
		end
	end

	local formspec =
		"size[8,6]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"button[5.75,0;2,1;transfer;< Transfer money]" ..
		"label[2.5,0;Wire Transfer Terminal]" ..
		"label[2,0.5;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
		"textarea[0.5,1.25;7.5,4;hst;Transaction list;" .. textlist .. "]" ..
		"button_exit[0.2,5;1,1;Quit;Quit]" ..
		"button[4.7,5;3,1;clr;Clear transactions]"

	return formspec, "atm.form.wtl"
end
