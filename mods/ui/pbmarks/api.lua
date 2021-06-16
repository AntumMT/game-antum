
--- Personal Bookmarks API
--
--  @module api.lua


local S = core.get_translator(pbmarks.modname)

-- initialize bookmarks
local bookmarks = wdata.read("personal_bookmarks") or {}

local function update_pbmfile()
	wdata.write("personal_bookmarks", bookmarks)
end

local function can_access(pos, pname) return true end
local function get_owner(pos) return "" end

if core.global_exists("s_protect") then
	can_access = s_protect.can_access
	get_owner = function(pos)
		local claim = s_protect.get_claim(pos)
		if claim then return s_protect.get_claim(pos).owner end

		return ""
	end
end

--- Retrieves a bookmark.
--
--  @tparam string pname Player name referenced for bookmark.
--  @tparam int idx Index of bookmark to retrieve.
--  @treturn table `BookmarkTable`.
function pbmarks.get(pname, idx)
	return (bookmarks[pname] or {})[idx]
end

--- Sets bookmark information.
--
--  @tparam string pname Player name referenced for bookmark.
--  @tparam int idx Index of bookmark to be set.
--  @tparam string label Label used to identify bookmark.
--  @tparam table pos Position to be bookmarked.
function pbmarks.set(pname, idx, label, pos)
	-- check for protection
	if pbmarks.disallow_protected and not can_access(pos, pname) then
		core.chat_send_player(pname, S("You cannot set bookmarks in areas owned by @1.", get_owner(pos)))
		return
	end

	idx = idx or 1

	local pbm = bookmarks[pname] or {}
	pbm[idx] = {
		label = label,
		pos = pos,
	}

	bookmarks[pname] = pbm
	update_pbmfile()
end

--- Unsets bookmark information.
--
--  @tparam string pname Player name referenced for bookmark.
--  @tparam int idx Index of bookmark to be unset.
function pbmarks.unset(pname, idx)
	if not idx or idx < 1 or idx > pbmarks.max then
		pbmarks.log("error", "cannot unset bookmark, invalid index: " .. tostring(idx))
		return
	end

	local pbm = bookmarks[pname]
	if not pbm then
		pbmarks.log("error", "cannot unset bookmark, player not found: " .. pname)
		return
	end

	pbm[idx] = nil
	bookmarks[pname] = pbm
	update_pbmfile()
end


--- Bookmark table.
--
--  @table BookmarkTable
--  @tfield string label Label used to identify bookmark.
--  @tfield table pos Position table with x,y,z coordinates (example: *pos = {x=7, y=8, z=-12}*).
