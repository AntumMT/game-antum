local util = {}

local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function util.randomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return util.randomString(length - 1) .. charset[math.random(1, #charset)]
end

function util.deepcopy(obj, seen)
	if type(obj) ~= 'table' then
		return obj
	end
	if seen and seen[obj] then
		return seen[obj]
	end
	local s = seen or {}
	local copy = setmetatable({}, getmetatable(obj))
	s[obj] = copy
	for k, v in pairs(obj) do
		copy[util.deepcopy(k, s)] = util.deepcopy(v, s)
	end
	return copy
end

return util
