--[[ MIT LICENSE HEADER
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
--]]


--- *hidename* mod API
--
-- @script api.lua


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


--- Checks if player's nametag is hidden.
--
-- Compares alpha level of player's nametag against 0 (0 being transparent).
--
-- TODO: Check for empty string instead of alpha value
--
-- @tparam table nametag_data Nametag data retrieved by *player:get_nametag_attributes()*.
-- @treturn bool ***true*** if player's nametag is hidden
function hidename.hidden(nametag_data)
	if hidename.use_alpha then
		return nametag_data.color.a == 0
	end
	
	return nametag_data.text == '' or nametag_data.text == nil
end


--- Messages info to player about nametag text & visibility.
--
-- @tparam string name Name of player to check & message
function hidename.tellStatus(name)
	local player = core.get_player_by_name(name)
	local nametag = player:get_nametag_attributes()
	
	local status = 'Status: '
	if hidename.hidden(nametag) then
		status = status .. 'hidden'
	else
		status = status .. 'visible'
	end
	
	-- Use name parameter value if nametag.text is empty
	if nametag.text == '' or nametag.text == nil then
		nametag.text = name
	end
	
	core.chat_send_player(name, S('Nametag:') .. ' ' .. nametag.text)
	core.chat_send_player(name, S(status))
end


--- Hides a player's nametag.
--
-- @tparam string name Name of player whose nametag should be made hidden
-- @treturn bool ***true*** if player's nametag is hidden
function hidename.hide(name)
	local player = core.get_player_by_name(name)
	local nametag = player:get_nametag_attributes()
	
	if hidename.hidden(nametag) then
		core.chat_send_player(name, S('Nametag is already hidden'))
		return true
	end
	
	if hidename.use_alpha then
		-- Preserve nametag alpha level
		player:set_attribute('nametag_stored_alpha', nametag.color.a)
		nametag.color.a = 0
		
		-- Set nametag alpha level to 0
		player:set_nametag_attributes({
			color = nametag.color,
		})
	else
		-- Remove text from nametag
		player:set_nametag_attributes({
			text = '',
		})
	end
	
	if hidename.hidden(player:get_nametag_attributes()) then
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
-- @tparam string name Name of player whose nametag should be made visible
-- @treturn bool ***true*** if player's nametag is visible
function hidename.show(name)
	local player = core.get_player_by_name(name)
	local nametag = player:get_nametag_attributes()
	
	if not hidename.hidden(nametag) then
		core.chat_send_player(name, S('Nametag is already visible'))
		return true
	end
	
	if hidename.use_alpha then
		-- Restore nametag alpha level
		local stored_alpha = player:get_attribute('nametag_stored_alpha')
		if stored_alpha ~= nil then
			nametag.color.a = stored_alpha
			-- Reset player attribute
			player:set_attribute('nametag_stored_alpha', nil)
		end
		
		player:set_nametag_attributes({
			color = nametag.color,
		})
	else
		-- Restore nametag text
		player:set_nametag_attributes({
			text = name,
		})
	end
	
	if not hidename.hidden(player:get_nametag_attributes()) then
		core.chat_send_player(name, S('Nametag is now visible'))
	else
		core.chat_send_player(name, S('ERROR: Could not show nametag'))
		core.log('error', 'Could not set nametag to "visible" for player ' .. name)
		core.log('error', 'Please submit an error report to the "hidename" mod developer')
	end
	
	return shown
end


-- Ensure that nametag text attribute is not empty when player logs on
if not hidename.use_alpha then
	-- Sets the player's nametag text attribute to player name.
	local function setNametagText(player)
		local nametag = player:get_nametag_attributes()
		if nametag.text == '' or nametag.text == nil then
			player:set_nametag_attributes({
				text = player:get_player_name(),
			})
		end
	end
	
	core.register_on_joinplayer(setNametagText)
end
