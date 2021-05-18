
--- API
--
-- @module api.lua


local S = core.get_translator(alternode.modname)


--- Retrieves node meta value of a given key.
--
--  @function alternode.get
--  @tparam table pos Position of node.
--  @tparam string key Key to check for in node meta.
--  @treturn string Value of key.
function alternode.get(pos, key)
	return core.get_meta(pos):get_string(key)
end

--- Sets node meta value of a given key.
--
--  @function alternode.set
--  @tparam table pos Position of node.
--  @tparam string key Key to be set.
--  @tparam string value Value to be set for `key`.
--  @treturn bool `true` if succeeded.
function alternode.set(pos, key, value)
	local meta = core.get_meta(pos)
	meta:set_string(key, value)
	return meta:get_string(key) == value
end

--- Unsets node meta value of a given key.
--
--  @function alternode.unset
--  @tparam table pos Position of node.
--  @tparam string key Key to be unset.
--  @treturn bool `true` if succeeded.
function alternode.unset(pos, key)
	local meta = core.get_meta(pos)
	meta:set_string(key, nil)
	return meta:get_string(key) == ""
end
