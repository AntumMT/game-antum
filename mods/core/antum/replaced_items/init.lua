
-- animalmaterials:contract
core.register_craftitem(":ritems:contract", {
	description = "Contract",
	image = "ritems_contract.png",
	stack_max=10,
})

if core.registered_items["animalmaterials:contract"] then
	override.replaceItems("animalmaterials:contract", "ritems:contract")
end

if core.get_modpath("default") then
	minetest.register_craft({
		output = "ritems:contract",
		recipe = {
			{"default:paper"},
			{"default:paper"},
		}
	})
end

-- animalmaterials:scale_*
for _, color in pairs({"blue", "golden", "grey", "white"}) do
	core.register_craftitem(":ritems:scale_" .. color, {
		description = "Scale (" .. color .. ")",
		image = "ritems_scale_" .. color .. ".png",
		stack_max = 25
	})

	if core.registered_items["animalmaterials:scale_" .. color] then
		override.replaceItems("animalmaterials:scale_" .. color, "ritems:scale_" .. color)
	end
end
