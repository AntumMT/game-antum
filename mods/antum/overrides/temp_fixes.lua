--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
--]]


-- TODO: Use file in world directory & function that waits until server is loaded

-- Add tables of {old, new} to be temporarily removed (cleaned) to this list.
-- Recommended to add source mod to 'depends.txt'.
-- WARNING: 'old' item will be un-registered from game & all instances converted to 'new' item.
--          Clearing this list will re-register 'old' item on following run, but will not convert
--          instances back.
local replace_items = {
	{'throwing:arrow', 'castle_weapons:crossbow_bolt'},
}

for index, item_group in ipairs(replace_items) do
	antum.convertItemToAlias(item_group[1], item_group[2])
end
