-- atm interface

local registered_currencies = {
	["currency:minegeld"] = 1,
	["currency:minegeld_5"] = 5,
	["currency:minegeld_10"] = 10,
	["currency:minegeld_50"] = 50,
	["currency:minegeld_100"] = 100,
}

local deposit = core.create_detached_inventory("atm", {
	allow_put = function(inv, listname, index, stack, player)
		local multiplier = registered_currencies[stack:get_name()]
		if multiplier then
			local pname = player:get_player_name()
			atm.balance[pname] = atm.balance[pname] + (multiplier * stack:get_count())
			atm.saveaccounts()
			-- refresh formspec
			atm.showform(player)

			return -1
		end

		return 0
	end,
})
deposit:set_size("deposit", 1)


function atm.showform (player)
	atm.ensure_init(player:get_player_name())
	local formspec =
	"size[12,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[0.5,0;Your account balance: $".. atm.balance[player:get_player_name()].. "]" ..
	"label[0.5,0.35;Deposit:]" ..
	"list[detached:atm;deposit;0.5,1.25;1,1;0]" ..
	"label[6.5,0.35;Withdraw:]" ..
	"label[6.5,0.75;1s]" ..
	"label[7.5,0.75;5s]" ..
	"label[8.5,0.75;10s]" ..
	"label[9.5,0.75;50s]" ..
	"label[10.5,0.75;100s]" ..
	"item_image_button[6.5,1.25;1,1;".. "currency:minegeld" ..";i-1;]" ..
	"label[6.55,1.75;x1]" ..
	"item_image_button[7.5,1.25;1,1;".. "currency:minegeld_5" ..";i-5;]" ..
	"label[7.55,1.75;x1]" ..
	"item_image_button[8.5,1.25;1,1;".. "currency:minegeld_10" ..";i-10;]" ..
	"label[8.55,1.75;x1]" ..
	"item_image_button[9.5,1.25;1,1;".. "currency:minegeld_50" ..";i-50;]" ..
	"label[9.55,1.75;x1]" ..
	"item_image_button[10.5,1.25;1,1;".. "currency:minegeld_100" ..";i-100;]" ..
	"label[10.55,1.75;x1]" ..
	"item_image_button[6.5,2.25;1,1;".. "currency:minegeld" ..";t-10;]" ..
	"label[6.55,2.75;x10]" ..
	"item_image_button[7.5,2.25;1,1;".. "currency:minegeld_5" ..";t-50;]" ..
	"label[7.55,2.75;x10]" ..
	"item_image_button[8.5,2.25;1,1;".. "currency:minegeld_10" ..";t-100;]" ..
	"label[8.55,2.75;x10]" ..
	"item_image_button[9.5,2.25;1,1;".. "currency:minegeld_50" ..";t-500;]" ..
	"label[9.55,2.75;x10]" ..
	"item_image_button[10.5,2.25;1,1;".. "currency:minegeld_100" ..";t-1000;]" ..
	"label[10.55,2.75;x10]" ..
	"item_image_button[6.5,3.25;1,1;".. "currency:minegeld" ..";c-100;]" ..
	"label[6.55,3.75;x100]" ..
	"item_image_button[7.5,3.25;1,1;".. "currency:minegeld_5" ..";c-500;]" ..
	"label[7.55,3.75;x100]" ..
	"item_image_button[8.5,3.25;1,1;".. "currency:minegeld_10" ..";c-1000;]" ..
	"label[8.55,3.75;x100]" ..
	"item_image_button[9.5,3.25;1,1;".. "currency:minegeld_50" ..";c-5000;]" ..
	"label[9.55,3.75;x100]" ..
	"item_image_button[10.5,3.25;1,1;".. "currency:minegeld_100" ..";c-10000;]" ..
	"label[10.55,3.75;x100]" ..
	"button_exit[5.5,3;1,2;Quit;Quit]" ..
	"list[current_player;main;2,4.5;8,1;]"..
	"list[current_player;main;2,5.75;8,3;8]"..
	"listring[]"..
	default.get_hotbar_bg(2, 4.5)
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
