-- License: CC0

local chatlog = minetest.get_worldpath().."/chatlog.txt"
monthfirst = minetest.settings:get_bool('chatlog.monthfirst') or true -- Whether month is displayed before day in timestamp


function playerspeak(name,msg)
	local f = io.open(chatlog, "a")
	if monthfirst then
		f:write(os.date("(%m/%d/%y %X) ["..name.."]: "..msg.."\n"))
	else
		f:write(os.date("(%d/%m/%y %X) ["..name.."]: "..msg.."\n"))
	end
	f:close()
end

minetest.register_on_chat_message(playerspeak)
