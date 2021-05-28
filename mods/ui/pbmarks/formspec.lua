
local width = 10
local height = 8

local title = "Personal Bookmarks"


function pbmarks.get_formspec(pname)
	-- somewhat center title
	local title_x = math.floor(width / 2) - (math.floor(string.len(title)) / 10)

	local formspec = "formspec_version[4]"
		.. "size[" .. tostring(width) .. "," .. tostring(height) .. "]"
		.. "button[0.5,0.25;1.5,0.75;btn_back;Back]"
		.. "label[" .. tostring(title_x) .. ",0.5;" .. title .. "]"

	local init_y = 1.5 -- horizontal position of first bookmark
	for idx = 1, pbmarks.max do
		local pbm = pbmarks.get(pname, idx) or {}
		local label = pbm.label or ""
		local pos = pbm.pos or ""
		if type(pos) == "table" then
			pos = tostring(pos.x) .. "," .. tostring(pos.y) .. "," .. tostring(pos.z)
		end

		local fname = "input" .. tostring(idx)
		local btn_go = "btn_go" .. tostring(idx)
		local btn_set = "btn_set" .. tostring(idx)
		formspec = formspec
			.. "field[0.5," .. tostring(init_y) .. ";3,0.75;" .. fname .. ";;" .. label .. "]"
			.. "field_close_on_enter[" .. fname .. ";false]"
			.. "label[3.75," .. tostring(init_y) + 0.25 .. ";" .. core.formspec_escape(pos) .. "]"
			.. "button[6.25," .. tostring(init_y) .. ";1.5,0.75;" .. btn_go .. ";Go]" -- TODO: change to "button_exit"
			.. "button[8," .. tostring(init_y) .. ";1.5,0.75;" .. btn_set .. ";Set]"

		init_y = init_y + 1.25
	end

	return formspec
end


core.register_on_player_receive_fields(function(player, formname, fields)
	if formname == pbmarks.modname then
		if fields.btn_back then
			core.show_formspec(player:get_player_name(), "", player:get_inventory_formspec())
			return
		end

		local idx
		local go = false
		local set = false
		for x = 1, pbmarks.max do
			if fields["btn_go" .. tostring(x)] then
				go = true
				idx = x
			elseif fields["btn_set" .. tostring(x)] then
				set = true
				idx = x
			end

			if idx then break end
		end

		local pname = player:get_player_name()
		local pbm = pbmarks.get(pname, idx) or {}

		if go then
			if not pbm.pos then
				core.chat_send_player(pname, "This bookmark is not set.")
				return
			end

			core.close_formspec(pname, pbmarks.modname)

			pbm.pos.y = pbm.pos.y + 0.5 -- make sure we don't get stuck in the ground
			player:set_pos(pbm.pos)
		elseif set then
			local label = (fields["input" .. tostring(idx)] or ""):trim()
			if label == "" then
				core.chat_send_player(pname, "You must choose a label to set this bookmark")
				return
			end

			local pos = player:get_pos()
			pos.x = math.floor(pos.x)
			pos.y = math.floor(pos.y)
			pos.z = math.floor(pos.z)

			pbmarks.set(pname, idx, label, pos)
			pbmarks.show_formspec(pname)
		end
	end
end)
