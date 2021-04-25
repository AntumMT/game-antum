-- atm interface

function atm.showform (player)
    atm.ensure_init(player:get_player_name())
    local formspec =
    "size[12,8.5]"..
    default.gui_bg..
    default.gui_bg_img..
    default.gui_slots..
    "label[0.5,0.15;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
    "label[0.5,0.5;Deposit: 1s           5s             10s            50s           100s]" ..
    "label[6.5,0.5;Withdraw: 1s        5s            10s            50s            100s]" ..
    "item_image_button[0.5,1;1,1;".. "currency:minegeld" ..";i1;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[1.5,1;1,1;".. "currency:minegeld_5" ..";i5;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[2.5,1;1,1;".. "currency:minegeld_10" ..";i10;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[3.5,1;1,1;".. "currency:minegeld_50" ..";i50;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[4.5,1;1,1;".. "currency:minegeld_100" ..";i100;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[6.5,1;1,1;".. "currency:minegeld" ..";i-1;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[7.5,1;1,1;".. "currency:minegeld_5" ..";i-5;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[8.5,1;1,1;".. "currency:minegeld_10" ..";i-10;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[9.5,1;1,1;".. "currency:minegeld_50" ..";i-50;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[10.5,1;1,1;".. "currency:minegeld_100" ..";i-100;\n\n\b\b\b\b\b" .. "x1" .."]" ..
    "item_image_button[0.5,2;1,1;".. "currency:minegeld" ..";t10;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[1.5,2;1,1;".. "currency:minegeld_5" ..";t50;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[2.5,2;1,1;".. "currency:minegeld_10" ..";t100;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[3.5,2;1,1;".. "currency:minegeld_50" ..";t500;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[4.5,2;1,1;".. "currency:minegeld_100" ..";t1000;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[6.5,2;1,1;".. "currency:minegeld" ..";t-10;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[7.5,2;1,1;".. "currency:minegeld_5" ..";t-50;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[8.5,2;1,1;".. "currency:minegeld_10" ..";t-100;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[9.5,2;1,1;".. "currency:minegeld_50" ..";t-500;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[10.5,2;1,1;".. "currency:minegeld_100" ..";t-1000;\n\n\b\b\b\b" .. "x10" .."]" ..
    "item_image_button[0.5,3;1,1;".. "currency:minegeld" ..";c100;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[1.5,3;1,1;".. "currency:minegeld_5" ..";c500;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[2.5,3;1,1;".. "currency:minegeld_10" ..";c1000;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[3.5,3;1,1;".. "currency:minegeld_50" ..";c5000;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[4.5,3;1,1;".. "currency:minegeld_100" ..";c10000;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[6.5,3;1,1;".. "currency:minegeld" ..";c-100;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[7.5,3;1,1;".. "currency:minegeld_5" ..";c-500;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[8.5,3;1,1;".. "currency:minegeld_10" ..";c-1000;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[9.5,3;1,1;".. "currency:minegeld_50" ..";c-5000;\n\n\b\b\b" .. "x100" .."]" ..
    "item_image_button[10.5,3;1,1;".. "currency:minegeld_100" ..";c-10000;\n\n\b\b\b" .. "x100" .."]" ..
    "button_exit[5.5,2.75;1,2;Quit;Quit]" ..
    "list[current_player;main;2,4.25;8,1;]"..
    "list[current_player;main;2,5.5;8,3;8]"..
    "listring[]"..
    default.get_hotbar_bg(2, 4.25)
    minetest.after((0.1), function(gui)
            return minetest.show_formspec(player:get_player_name(), "atm.form", gui)
        end, formspec)
end



-- wire transfer interface

function atm.showform_wt (player)
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
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wt", gui)
		end, formspec)
end

function atm.showform_wtconf (player, dstn, amnt, desc)
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
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wtc", gui)
		end, formspec)
end

function atm.showform_wtlist (player, tlist)
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
	minetest.after((0.1), function(gui)
			return minetest.show_formspec(player:get_player_name(), "atm.form.wtl", gui)
		end, formspec)
end
