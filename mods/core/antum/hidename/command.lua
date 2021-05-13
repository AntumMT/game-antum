--[[ MIT LICENSE HEADER
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
--]]


--- *hidename* chat commands
--
-- @script command.lua


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


local params = {
	'hide',
	'show',
	'status',
}

local params_string = '[' .. table.concat(params, '|') .. ']'

--- *nametag* chat command.
--
-- Displays nametag info or sets visibility.
--
-- @chatcmd nametag
-- @chatparam mode
-- @option ***hide*** : Sets player nametag hidden.
-- @option ***show*** : Sets player nametag visible.
-- @option ***status*** : Displays player nametag text & visible state in chat (default if ***option*** is omitted)
-- @usage
-- /nametag [option]
-- /nametag hide
core.register_chatcommand('nametag', {
	params = params_string,
	description = S('Get nametag info or set visibility'),
	func = function(name, param)
		-- Split parameters into case-insensitive list
		param = string.split(string.lower(param), ' ')
		
		local mode = param[1]
		
		-- Default to "status"
		if mode == nil or mode == 'status' then
			hidename.tellStatus(name)
			return true
		elseif mode == 'hide' then
			return hidename.hide(name)
		elseif mode == 'show' then
			return hidename.show(name)
		end
		
		core.chat_send_player(name, S('Error: Unknown parameter:') .. ' ' .. mode)
		return false
	end
})


--- Alias for ***/nametag hide***.
--
-- @chatcmd hidename
-- @usage /hidename
core.register_chatcommand('hidename', {
	description = S('Make nametag hidden'),
	func = function(name, param)
		return hidename.hide(name)
	end,
})


--- Alias for ***/nametag show***.
-- @chatcmd showname
-- @usage /showname
core.register_chatcommand('showname', {
	description = S('Make nametag visible'),
	func = function(name, param)
		return hidename.show(name)
	end,
})
