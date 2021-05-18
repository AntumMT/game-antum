
--- Formspecs
--
--  @module formspec.lua


local S = core.get_translator(alternode.modname)

local misc = dofile(alternode.modpath .. "/misc_functions.lua")


--- Formspec definitions.
--
--  @section fs_def


--- Retrieves formspec layout for `alternode:wand` item.
--
--  TODO: add fields for get, set, & unset meta data
--
--  @function alternode.get_wand_formspec
--  @param pos
--  @param node
--  @param player
--  @treturn string Formspec formatted string.
function alternode.get_wand_formspec(pos, node, player, key, msg)
	local nmeta = core.get_meta(pos)
	local infostring = S("Pos: x@=@1, y@=@2, z@=@3; Name: @4; Select meta info:",
		tostring(pos.x), tostring(pos.y), tostring(pos.z), node.name)

	-- linebreaks are added here so we can keep translator string same as on on_use method
	infostring = infostring:gsub("; ", "\n")

	-- some commonly used meta keys
	-- FIXME: why is this being trimmed from formspec?
	infostring = infostring .. misc.format_meta_values(nmeta, {"id", "infotext", "owner"})

	local value = ""
	if key then
		value = nmeta:get_string(key)
	else
		key = ""
	end

	local formspec = "formspec_version[4]"
		.. "size[10.65,8]"
		.. "label[0.15,0.25;" .. core.formspec_escape(infostring) .. "]"
		.. "field[0.15,3.375;3,0.75;input_key;" .. S("Key:") .. ";" .. key .. "]"
		.. "field_close_on_enter[input_key;false]"
		.. "textarea[3.3,3;3,1.5;input_value;" .. S("Value:") .. ";" .. value .. "]"
		.. "button[6.45,3.375;1.25,0.75;btn_get;" .. S("Get") .. "]"
		.. "button[7.85,3.375;1.25,0.75;btn_set;" .. S("Set") .. "]"
		.. "button[9.25,3.375;1.25,0.75;btn_unset;" .. S("Unset") .. "]"

	if msg then
		formspec = formspec
			.. "label[0.15,5.5;" .. msg .. "]"
	end

	return formspec
end

--- Retrieves formspec layout for `alternode:pencil` item.
--
--  @function alternode.get_pencil_formspec
--  @param pos
--  @treturn string Formspec formatted string.
function alternode.get_pencil_formspec(pos)
	local infotext = core.get_meta(pos):get_string("infotext")
	local formspec = "formspec_version[4]"
		.. "size[6,4]"
		.. "textarea[1,1;4,1.5;input;" .. S("Infotext") .. ";" .. infotext .. "]"
		.. "button_exit[1.5,2.75;1.25,0.75;btn_write;" .. S("Write") .. "]"
		.. "button_exit[3.3,2.75;1.25,0.75;btn_erase;" .. S("Erase") .. "]"

	return formspec
end


--- Formspec event handling.
--
--  @section fs_event


core.register_on_player_receive_fields(function(player, formname, fields)
	if formname == alternode.modname .. ":wand" then
		local pmeta = player:get_meta()

		if fields.quit then
			-- clear position info from player meta
			pmeta:set_string(alternode.modname .. ":pos", nil)
			return
		end

		if not fields.input_key then
			alternode.log("error", "could not retrieve key input field")
			return
		elseif not fields.input_value then
			alternode.log("error", "could not retrieve value input field")
			return
		end

		-- FIXME: how to get node & node meta without storing in player meta?
		local node = core.deserialize(pmeta:get_string(alternode.modname .. ":node"))
		local pos = core.deserialize(pmeta:get_string(alternode.modname .. ":pos"))
		local nmeta = core.get_meta(pos)

		if not node then
			alternode.log("error", "could not retrieve node")
			return
		end
		if not nmeta then
			alternode.log("error", "could not retrieve node meta")
			return
		end

		local msg = nil
		if fields.input_key:trim() == "" then
			msg = S("Key cannot be empty")
		elseif fields.btn_set then
			local new_value = fields.input_value:trim()
			if new_value == "" then
				msg = S("Value cannot be empty")
			else
				nmeta:set_string(fields.input_key, new_value)
				msg = S('Key "@1" has been set to "@2"', fields.input_key, new_value)
			end
		elseif fields.btn_unset then
			nmeta:set_string(fields.input_key, nil)
			msg = S('Key "@1" has been unset', fields.input_key)
		elseif nmeta:get_string(fields.input_key) == "" then
			msg = S('Key "@1" is not set', fields.input_key)
		end

		core.show_formspec(player:get_player_name(), alternode.modname .. ":wand",
			alternode.get_wand_formspec(pos, node, player, fields.input_key, msg))
	elseif formname == alternode.modname .. ":pencil" then
		local pmeta = player:get_meta()

		if fields.btn_write or fields.btn_erase then
			-- FIXME: how to get node meta without storing in player meta?
			local pos = core.deserialize(pmeta:get_string(alternode.modname .. ":pos"))
			local nmeta = core.get_meta(pos)

			if fields.btn_write then
				if fields.input:trim() == "" then
					nmeta:set_string("infotext", nil)
				else
					nmeta:set_string("infotext", fields.input)
				end
			elseif fields.btn_erase then
				nmeta:set_string("infotext", nil)
			end
		end

		-- clear position info from player meta
		pmeta:set_string(alternode.modname .. ":pos", nil)
	end
end)
