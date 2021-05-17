
local function format_meta_values(meta, keys)
	local meta_values = ""
	for _, key in ipairs(keys) do
		local value = meta:get_string(key)
		if value ~= "" then
			if meta_values == "" then
				meta_values = meta_values .. " "
			else
				meta_values = meta_values .. ", "
			end

			meta_values = meta_values .. key .. "=" .. value
		end
	end

	return meta_values
end


return {
	format_meta_values = format_meta_values,
}
