
local S = core.get_translator(alternode.modname)


function alternode.get(pos, key)
	return core.get_meta(pos):get_string(key)
end

function alternode.set(pos, key, value)
	local meta = core.get_meta(pos)
	meta:set_string(key, value)
	return meta:get_string(key) == value
end

function alternode.unset(pos, key)
	local meta = core.get_meta(pos)
	meta:set_string(key, nil)
	return meta:get_string(key) == ""
end
