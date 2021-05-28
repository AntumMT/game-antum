
-- initialize bookmarks
local bookmarks = wdata.read("personal_bookmarks") or {}


function pbmarks.get(pname, idx)
	return (bookmarks[pname] or {})[idx]
end


function pbmarks.set(pname, idx, label, pos)
	idx = idx or 1

	local pbm = bookmarks[pname] or {}
	pbm[idx] = {
		label = label,
		pos = pos,
	}

	bookmarks[pname] = pbm
	wdata.write("personal_bookmarks", bookmarks)
end


function pbmarks.show_formspec(pname)
	core.show_formspec(pname, pbmarks.modname, pbmarks.get_formspec(pname))
end
