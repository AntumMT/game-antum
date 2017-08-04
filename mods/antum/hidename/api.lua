--[[ MIT LICENSE HEADER
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
--]]


--- *hidename* mod API


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


-- Default alpha level (FIXME: Should be player attribute)
local stored_alpha = 255


--- Checks if player's nametag is hidden.
--
-- Compares alpha level of player's nametag against 0 (0 being transparent).
--
-- TODO: Check for empty string instead of alpha value
--
-- @param alpha Can be an integer between 0-255 or player's name string
-- @return ***true*** if player's nametag is hidden
function hidename.hidden(alpha)
	if type(alpha) == 'string' then
	local player = core.get_player_by_name(alpha)
	alpha = player:get_nametag_attributes().color.a
	end
	
	return alpha == 0
end


--- Messages info to player about nametag text & visibility.
--
-- @param name Name of player to check & message
function hidename.tellStatus(name)
	local player = core.get_player_by_name(name)
	local nametag = player:get_nametag_attributes()
	
	local status = 'Status: '
	if hidename.hidden(nametag.color.a) then
		status = status .. 'hidden'
	else
		status = status .. 'visible'
	end
	
	-- Use parameter value if nametag.text is empty
	-- FIXME: This may cause issues if text value is used instead of transparency
	--        to determine if nametag is hidden
	if nametag.text == '' then
		nametag.text = name
	end
	
	core.chat_send_player(name, S('Nametag:') .. ' ' .. nametag.text)
	core.chat_send_player(name, S(status))
end


--- Hides a player's nametag.
--
-- @param name Name of player whose nametag should be made hidden
-- @return ***true*** if player's nametag is hidden
function hidename.hide(name)
	local player = core.get_player_by_name(name)
	local nametag_color = player:get_nametag_attributes().color
	
	if hidename.hidden(nametag_color.a) then
		core.chat_send_player(name, S('Nametag is already hidden'))
		return true
	end
	
	-- Set nametag alpha level to 0
	nametag_color.a = 0
	player:set_nametag_attributes({
		color = nametag_color,
	})
	
	-- Test new alpha level
	local hidden = player:get_nametag_attributes().color.a == 0
	if hidden then
		core.chat_send_player(name, S('Nametag is now hidden'))
	else
		core.chat_send_player(name, S('ERROR: Could not hide nametag'))
		core.log('error', 'Could not set nametag to "hidden" for player ' .. name)
		core.log('error', 'Please submit an error report to the "hidename" mod developer')
	end
	
	return hidden
end


--- Makes a player's nametag visible.
--
-- @param name Name of player whose nametag should be made visible
-- @return ***true*** if player's nametag is visible
function hidename.show(name)
	local player = core.get_player_by_name(name)
	local nametag_color = player:get_nametag_attributes().color
	local alpha = nametag_color.a
	
	if not hidename.hidden(alpha) then
		core.chat_send_player(name, S('Nametag is already visible'))
		return true
	end
	
	-- Restore nametag alpha level (currently static)
	nametag_color.a = stored_alpha
	player:set_nametag_attributes({
		color = nametag_color,
	})
	
	-- Test new alpha level
	local shown = player:get_nametag_attributes().color.a ~= 0
	if shown then
		core.chat_send_player(name, S('Nametag is now visible'))
	else
		core.chat_send_player(name, S('ERROR: Could not show nametag'))
		core.log('error', 'Could not set nametag to "visible" for player ' .. name)
		core.log('error', 'Please submit an error report to the "hidename" mod developer')
	end
	
	return shown
end
