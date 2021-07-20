

local light_armors = {}

--- Register an item to emit light when equipped in the armor inventory.
--
--  @param item Item name or `ItemStack`.
--  @tparam[opt] int lvalue Light value (default: 10).
function armor_light.register(item, lvalue)
	lvalue = lvalue or 10

	local item_name = item
	if not type(item_name) == "string" then
		item_name = item_name:get_name()
	end

	wielded_light.register_item_light(item_name, lvalue)
	light_armors[item_name] = true
end

--- Checks if an item is registered as light-emitting from armor inventory.
--
-- @param item Item name or `ItemStack`.
-- @treturn bool
function armor_light.is_lighted(item)
	local item_name = item
	if not type(item_name) == "string" then
		item_name = item_name:get_name()
	end

	if light_armors[item_name] then
		return true
	end

	return false
end
