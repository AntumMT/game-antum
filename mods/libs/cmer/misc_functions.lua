

local function translate_name(name)
	if name:find(":") == 1 then
		name = name:sub(2)
	end

	return name
end

return translate_name
