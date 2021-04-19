function generate(size, inventory_name)
	local cfg

	-- chest inventory name
	local  inv_name = inventory_name
	if inv_name == nil then
		inv_name = "main"
	end

	if size == "small" then
		cfg = {
			window_width = 8,
			window_height = 9,
			chest_width = 8,
			chest_height = 4,
		}
	elseif size == "big" then
		cfg = {
			window_width = 14,
			window_height = 10,
			chest_width = 14,
			chest_height = 5,
		}
	end
	-- calc padding to vertically align center the chest and the player's inventory
	local player_inv_y_orig = cfg.chest_height + 0.85
	local player_inv_x_orig = (cfg.window_width - 8) / 2 -- 8=player_inv_width
	return "size[" ..
		cfg.window_width .. "," .. cfg.window_height .. "]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list["..((inv_name == "main") and "current_name" or "current_player")..";"..inv_name..";0,0.3;" ..
		cfg.chest_width .. "," .. cfg.chest_height .. ";]" ..
		"list[current_player;main;" ..
		player_inv_x_orig .. "," .. player_inv_y_orig ..
		";8,1;]" ..
		"list[current_player;main;" ..
		player_inv_x_orig .. "," .. (player_inv_y_orig + 1.15) ..
		";8,3;8]" ..
		"listring["..(inv_name == "main" and "current_name" or "current_player")..";"..inv_name.."]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(player_inv_x_orig, player_inv_y_orig)
end

return generate
