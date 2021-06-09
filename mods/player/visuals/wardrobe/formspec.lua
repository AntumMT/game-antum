
wardrobe.formspec_name = "wardrobe_wardrobeSkinForm"

function wardrobe.show_formspec(player, page)
	local pname = player:get_player_name()
	if not pname or pname == "" then return end

	local page_count = math.ceil(wardrobe.skin_count / wardrobe.skins_per_page)
	local page_prev = page-1
	local page_next = page+1
	if page_prev < 1 then
		page_prev = page_count
	elseif page_next > page_count then
		page_next = 1
	end

	local n = wardrobe.skin_count
	if n <= 0 then return end
	local nPages = math.ceil(n / wardrobe.skins_per_page)

	if not page or page > nPages then page = 1 end
	local s = 1 + wardrobe.skins_per_page*(page-1) -- first skin index for page
	local e = math.min(s+wardrobe.skins_per_page-1, n) -- last skin index for page

	local skins = {}
	for i = s, e do
		local skin = wardrobe.skins[i]
		local skinName = core.formspec_escape(wardrobe.skinNames[skin])
		table.insert(skins, {skin, skinName})
	end

	local formspec
	if not wardrobe.previews then
		formspec = "size[5,10]"
			.. "label[0,0;Change Into:]"
			.. "label[1.8,0.5;Page " .. tostring(page) .. " / " .. tostring(page_count) .. "]"

		for idx, s in ipairs(skins) do
			formspec = formspec
				.. "button_exit[0," .. idx ..";5,1;s:" .. s[1] .. ";" .. s[2] .. "]"
		end

		formspec = formspec
			.. "button[1.5,9;1,1;n:p" .. tostring(page_prev) .. ";prev]"
			.. "button[2.5,9;1,1;n:p" .. tostring(page_next) .. ";next]"
	else
		formspec = "size[12,10]"
			.. "label[0,0;Change Into:]"
			.. "label[5.3,0.5;Page " .. tostring(page) .. " / " .. tostring(page_count) .. "]"

		local border_l = 0
		local addon = 1
		for idx, s in ipairs(skins) do
			local preview = s[1]:split(".png")[1] .. "-preview.png"

			if idx % 5 == 0 then
				addon = 1
				border_l = border_l + 6
			end

			formspec = formspec
				.. "button_exit[" .. border_l .. "," .. addon+.5 ..";5,1;s:" .. s[1] .. ";" .. s[2] .. "]"
				.. "image[" .. border_l+5 .. "," .. addon .. ";1,2;" .. preview .."]"

			addon = addon + 2
		end

		formspec = formspec
			.. "button[5,9;1,1;n:p" .. tostring(page_prev) .. ";prev]"
			.. "button[6,9;1,1;n:p" .. tostring(page_next) .. ";next]"

	end

	core.show_formspec(pname, wardrobe.formspec_name, formspec)
end


core.register_on_player_receive_fields(function(player, formName, fields)
	if formName ~= wardrobe.formspec_name then return end

	local pname = player:get_player_name()
	if not pname or pname == "" then return end

	for fieldName in pairs(fields) do
		if #fieldName > 2 then
			local action = string.sub(fieldName, 1, 1)
			local value = string.sub(fieldName, 3)

			if action == "n" then
				wardrobe.show_formspec(player, tonumber(string.sub(value, 2)))
				return
			elseif action == "s" then
				wardrobe.changePlayerSkin(pname, value)
				return
			end
		end
	end
end)
