--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]

--- Override Mod API
--
-- @script api.lua


--- Unregisters craft items & adds them as aliases.
--
-- Unregisters items & set names as aliases for another existing item.
--
-- @function override.replaceItems
-- @param items List of item names to be overridden (can be string for single item override).
-- @param target Item name of aliases' target.
function override.replaceItems(items, target)
	if type(items) == 'string' then
		override.logDebug('Overriding item "' .. items .. '" with "' .. target .. '"')
		
		core.unregister_item(items)
		if items ~= target then
			core.register_alias(items, target)
		end
	else
		for i, it in ipairs(items) do
			override.logDebug('Overriding item "' .. it .. '" with "' .. target .. '"')
			core.unregister_item(it)
			if it ~= target then
				core.register_alias(it, target)
			end
		end
	end
end


--- Unregisters craft items & registers names as aliases for new item.
--
-- Registers a new craft item & adds overridden item names as aliases.
--
-- @function override.overrideItems
-- @tparam string name Name of new item.
-- @tparam table def Item definition.
-- @see override.overrideItems.def
function override.overrideItems(name, def)
	local overrides = def.overrides
	def.overrides = nil
	
	override.replaceItems(overrides, name)
	core.register_craftitem(name, def)
end

--- Item definition table for *override.overrideItems*
--
-- @table override.overrideItems.def
-- @tfield table overrides Old items to be overridden (can be *string* for single item override).
-- @tfield string description Inventory tooltip.
-- @tfield table groups The groups of the craftitem.
-- @tfield imagestring inventory_image Texture displayed in inventory.
-- @tfield imagestring wield_image Texture displayed when wielded.
-- @tfield pos wield_scale Scale of *wield_image*.
-- @tfield int stack_max Maximum amount of items per stack (default: 99).
-- @tfield bool liquids_pointable Whether the player can point at liquids while wielding the item or not (default: false).
-- @field metadata
-- @tfield callback on_place Called on *rightclick*.
-- @tfield callback on_drop Called when dropping the item.
-- @tfield callback on_use Called on *leftclick*.
-- @see override.overrideItems
