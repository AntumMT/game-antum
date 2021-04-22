
core.register_on_player_receive_fields(
	function(player, formName, fields)
		if formName ~= wardrobe.formspec_name then return; end

		local playerName = player:get_player_name();
		if not playerName or playerName == "" then return; end

		for fieldName in pairs(fields) do
			if #fieldName > 2 then
				local action = string.sub(fieldName, 1, 1);
				local value = string.sub(fieldName, 3);

				if action == "n" then
					wardrobe.show_formspec(player, tonumber(string.sub(value, 2)));
					return;
				elseif action == "s" then
					wardrobe.changePlayerSkin(playerName, value);
					return;
				end
			end
		end
	end);


core.register_node(
	"wardrobe:wardrobe",
	{
		description = "Wardrobe",
		paramtype2 = "facedir",
		tiles = {
			"wardrobe_wardrobe_topbottom.png",
			"wardrobe_wardrobe_topbottom.png",
			"wardrobe_wardrobe_sides.png",
			"wardrobe_wardrobe_sides.png",
			"wardrobe_wardrobe_sides.png",
			"wardrobe_wardrobe_front.png"
		},
		inventory_image = "wardrobe_wardrobe_front.png",
		sounds = default.node_sound_wood_defaults(),
		groups = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3 },
		on_rightclick = function(pos, node, player, itemstack, pointedThing)
			wardrobe.show_formspec(player, 1);
		end
	});

core.register_craft(
	{
		output = "wardrobe:wardrobe",
		recipe = {
			{ "group:wood", "group:stick", "group:wood" },
			{ "group:wood", "group:wool",  "group:wood" },
			{ "group:wood", "group:wool",  "group:wood" },
		}
	});
