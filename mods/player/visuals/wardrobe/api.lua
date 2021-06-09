
wardrobe.skins = {}
wardrobe.skinNames = {}
wardrobe.skin_count = 0


local function removePrefix(str, prefix)
	local n = #prefix
	if #str >= n and string.sub(str, 1, n) == prefix then
		return string.sub(str, n+1)
	else
		return str
	end
end

local function removeSuffix(str, suffix)
	local n = #suffix
	if #str >= n and string.sub(str, -n, -1) == suffix then
		return string.sub(str, 1, -(n+1))
	else
		return str
	end
end

local function trimTail(str)
	local e = string.find(str, "%s+$")
	return (e and string.sub(str, e-1)) or str
end

local function parsePlayerSkinLine(line)
	local k, v
	local p = string.find(line, "%S")
	if p and not string.find(line, "^%-%-", p) then
		local ss, se = string.find(line, "%s*:%s*", p)
		if ss then
			k = string.sub(line, p, ss-1)
			v = trimTail(string.sub(line, se+1))
			if k == "" then k = nil end
			if v == "" then v = nil end
		end
	end
	return k, v
end

local function parseSkinLine(line)
	local k, v, n, e

	local p = string.find(line, "%S")
	if p then
		n, e = string.find(line, "^%-%-?", p)
		if not n or n == e then
			if n then p = n+1 end
			local ss, se = string.find(line, "%s*:%s*", p)
			if ss then
				k = string.sub(line, p, ss-1)
				v = trimTail(string.sub(line, se+1))
				if v == "" then v = nil end
			else
				k = trimTail(string.sub(line, p))
			end
			if k == "" then k = nil end
		end
	end

	return k, v, n
end

--- Parses the files with the given paths for key/value pairs.  Once a key is
 -- negated, it stays negated.  Otherwise, the last (non-nil) value assigned to
 -- a key wins.
 --
 -- @return A list of non-negated keys.  This may include keys for which the
 --         values are nil.
 -- @return A map from key to value for all non-negated keys with non-nil
 --         values.
 --
local function loadSkinsFromFiles(filePaths)
	local normKeys, values, negKeys = {}, {}, {}

	for _, filePath in ipairs(filePaths) do
		local file = io.open(filePath, "r")
		if file then
			for line in file:lines() do
				local k, v, n = parseSkinLine(line)

				if k then
					if n then
						normKeys[k] = nil
						values[k] = nil
						negKeys[k] = k
					elseif not negKeys[k] then
						normKeys[k] = k
						if v then
							values[k] = v
						end
					end
				end
			end
			file:close()
		end
	end

	local keyList = {}
	for k in pairs(normKeys) do
		table.insert(keyList, k)
	end

	return keyList, values
end

local function getSkinIndex(skin)
	local idx = nil
	for i, k in ipairs(wardrobe.skins) do
		if k == skin then
			idx = i
			break
		end
	end

	return idx
end

--- Organizes outfit names alphabetically.
--
--  @function wardrobe.sortNames
function wardrobe.sortNames()
	local default_skin = "character.png"
	local default_idx = getSkinIndex(default_skin)
	if default_idx then
		table.remove(wardrobe.skins, default_idx)
	end

	table.sort(wardrobe.skins, function(sL, sR)
		return wardrobe.skinNames[sL] < wardrobe.skinNames[sR]
	end)

	if default_idx then
		-- keep default skin at top
		table.insert(wardrobe.skins, 1, default_skin)
	end
end

--- Registers a single skin.
--
--  Does not sort automatically.
--
--  @function wardrobe.registerSkin
--  @param k Texture file name
--  @param v Name to display in wardrobe
function wardrobe.registerSkin(k, v)
	table.insert(wardrobe.skins, k)
	wardrobe.skinNames[k] = v

	wardrobe.skin_count = wardrobe.skin_count+1
end

--- Loads skin names from skin files, storing the result in wardrobe.skins and
 -- wardrobe.skinNames.
 --
 -- Overwrites any previously registered skins.
function wardrobe.loadSkins(skin_files)
	skin_files = skin_files or wardrobe.skin_files

	local skins, skinNames = loadSkinsFromFiles(skin_files)

	for i, skin in ipairs(skins) do
		local name = skinNames[skin]

		if not name then
			local s, e

			name = removeSuffix(
							removePrefix(
								removePrefix(skin, wardrobe.modname .. "_"),
								"skin_"),
							".png")

			if name == "" then
				name = skin
			else
				name = string.gsub(name, "_", " ")
			end
		end

		skinNames[skin] = name
	end

	-- overwrite registered skins
	wardrobe.skins = skins
	wardrobe.skinNames = skinNames
	wardrobe.skin_count = #wardrobe.skins

	wardrobe.sortNames()
end

--- Loads additional skins from a file.
--
--  @function wardrobe.registerSkinFiles
--  @param skin_files
function wardrobe.registerSkinFiles(skin_files)
	if type(skin_files) == "string" then
		skin_files = {skin_files,}
	end

	local skins, skinNames = loadSkinsFromFiles(skin_files)

	for i, skin in ipairs(skins) do
		local name = skinNames[skin]

		if not name then
			local s, e

			name = removeSuffix(
							removePrefix(
								removePrefix(skin, wardrobe.modname .. "_"),
								"skin_"),
							".png")

			if name == "" then
				name = skin
			else
				name = string.gsub(name, "_", " ")
			end
		end

		skinNames[skin] = name
	end

	-- add to registered skins
	for _, sk in ipairs(skins) do
		wardrobe.registerSkin(sk, skinNames[sk])
	end

	wardrobe.sortNames()
end

--- Parses the player skins database file and stores the result in
 -- wardrobe.playerSkins.
 --
function wardrobe.loadPlayerSkins(player_skin_db)
	player_skin_db = player_skin_db or wardrobe.player_skin_db
	local playerSkins = {}

	local file = io.open(player_skin_db, "r")
	if file then
		for line in file:lines() do
			local name, skin = parsePlayerSkinLine(line)
			if name then
				playerSkins[name] = skin
			end
		end
		file:close()
	end

	wardrobe.playerSkins = playerSkins
end

--- Writes wardrobe.playerSkins to the player skins database file.
 --
function wardrobe.savePlayerSkins(player_skin_db)
	player_skin_db = player_skin_db or wardrobe.player_skin_db

	local file = io.open(player_skin_db, "w")
	if not file then error("Couldn't write file '" .. filePath .. "'") end

	for name, skin in pairs(wardrobe.playerSkins) do
		file:write(name, ":", skin, "\n")
	end

	file:close()
end


local playerMesh = "character.b3d"
-- autodetect version of player mesh used by default
if default and default.registered_player_models then
	local haveCharName = false -- 'character.*' has priority
	local name = nil
	local nNames = 0

	for k in pairs(default.registered_player_models) do
		if string.find(k, "^character\\.[^\\.]+$") then
			if haveCharName then
				nNames = 2
				break
			end
			name = k
			nNames = 1
			haveCharName = true
		elseif not haveCharName then
			name = k
			nNames = nNames + 1
		end
	end

	if nNames == 1 then playerMesh = name end
end

local function changeWardrobeSkin(playerName, skin)
	local player = core.get_player_by_name(playerName)
	if not player then
		error("unknown player '" .. playerName .. "'")
	end
	if skin and not wardrobe.skinNames[skin] then
		error("unknown skin '" .. skin .. "'")
	end

	wardrobe.playerSkins[playerName] = skin
	wardrobe.savePlayerSkins()
end

function wardrobe.updatePlayerSkin(player)
	if wardrobe.use_3d_armor then
		armor:update_player_visuals(player)
	else
		local pname = player:get_player_name()
		if not pname or pname == "" then return end

		local skin = wardrobe.playerSkins[pname]
		if not skin or not wardrobe.skinNames[skin] then return end

		player:set_properties({
			visual = "mesh",
			visual_size = {x=1, y=1},
			mesh = playerMesh,
			textures = {skin},
		})
	end
end

wardrobe.setPlayerSkin = wardrobe.updatePlayerSkin

function wardrobe.changePlayerSkin(playerName, skin)
	changeWardrobeSkin(playerName, skin)

	if wardrobe.use_3d_armor then
		armor.textures[playerName].skin = skin
	end

	local player = core.get_player_by_name(playerName)
	if player then wardrobe.updatePlayerSkin(player) end
end

if not wardrobe.use_3d_armor then
	core.register_on_joinplayer(function(player)
		core.after(1, wardrobe.updatePlayerSkin, player)
	end)
end
