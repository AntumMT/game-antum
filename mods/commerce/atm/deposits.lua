
local registered_monies = {}
registered_monies["currency:minegeld"] = 1
registered_monies["currency:minegeld_5"] = 5
registered_monies["currency:minegeld_10"] = 10
registered_monies["currency:minegeld_50"] = 50
registered_monies["currency:minegeld_100"] = 100


function atm.deposit(player, stack)
	local multiplier = registered_monies[stack:get_name()]
	if multiplier == nil then
		return 0
	end

	local pname = player:get_player_name()
	local total = stack:get_count() * multiplier

	atm.balance[pname] = atm.balance[pname] + total
	atm.saveaccounts()

	return -1
end
