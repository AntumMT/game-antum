
local S = core.get_translator(alternode.modname)


function alternode.show_formspec(pos, node, player)
	local nmeta = core.get_meta(pos)
	local infostring = S("pos: x@=@1, y@=@2, z@=@3; name@=@4",
		tostring(pos.x), tostring(pos.y), tostring(pos.z), node.name)

	-- some commonly used meta keys
	for _, key in ipairs({"id", "infotext", "owner"}) do
		local value = nmeta:get_string(key)
		if value and value ~= "" then
			infostring = infostring .. "; "
				.. key .. "=" .. value
		end
	end

	-- linebreaks are added here so we can keep translator string same as on on_use method
	infostring = infostring:gsub("; ", "\n")

	local formspec = "formspec_version[4]"
		.. "size[16,10]"
		.. "label[0.15,0.25;" .. core.formspec_escape(infostring) .. "]"

	-- TODO: add fields for get, set, & unset meta data

	core.show_formspec(player:get_player_name(), alternode.modname .. ":meta", formspec)
end
