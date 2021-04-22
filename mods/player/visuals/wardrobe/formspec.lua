
wardrobe.formspec_name = "wardrobe_wardrobeSkinForm"

function wardrobe.show_formspec(player, page)
	local playerName = player:get_player_name();
	if not playerName or playerName == "" then return; end

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
		local skin = wardrobe.skins[i];
		local skinName = core.formspec_escape(wardrobe.skinNames[skin]);
		table.insert(skins, {skin, skinName})
	end

	local formspec = "size[5,10]"
		.. "label[0,0;Change Into:]"
		.. "label[1.8,0.5;Page " .. tostring(page) .. " / " .. tostring(page_count) .. "]"

		for idx, s in ipairs(skins) do
			formspec = formspec
				.. "button_exit[0," .. idx ..";5,1;s:" .. s[1] .. ";" .. s[2] .. "]"
		end

		formspec = formspec
			.. "button[0,9;1,1;n:p" .. tostring(page_prev) .. ";prev]"
			.. "button[4,9;1,1;n:p" .. tostring(page_next) .. ";next]"

	core.show_formspec(playerName, wardrobe.formspec_name, formspec)
end
