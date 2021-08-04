
local S = core.get_translator(listitems.modname)


local options = {
	["-v"] = {name="verbose", description=S("Display descriptions")},
	["-s"] = {name="shallow", description=S("Don't search descriptions")},
}

--- Valid list types.
--
-- @table known_types
-- @local
local known_types = {
	"items",
	"entities",
	"nodes",
	"ores",
	"tools",
}

if core.global_exists("mobs") then
	table.insert(known_types, "mobs")
end


--- Checks if value is contained in list.
--
-- @function listContains
-- @local
-- @tparam table tlist List to be iterated.
-- @tparam string v String to search for in list.
-- @treturn boolean ***true*** if string found within list.
function listContains(tlist, v)
	for index, value in ipairs(tlist) do
		if v == value then
			return true
		end
	end

	return false
end


--- Replaces duplicates found in a list.
--
-- @function removeListDuplicates
-- @local
-- @tparam table tlist
-- @treturn table
function removeListDuplicates(tlist)
	local cleaned = {}
	if tlist ~= nil then
		for index, value in ipairs(tlist) do
			if not listContains(cleaned, value) then
				table.insert(cleaned, value)
			end
		end
	end

	return cleaned
end


return {
	options = options,
	known_types = known_types,
	listContains = listContains,
	removeListDuplicates = removeListDuplicates,
}
