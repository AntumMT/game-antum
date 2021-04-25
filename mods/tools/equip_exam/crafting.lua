
if not core.get_modpath("default") then return end -- default mod required for craft recipe

local main_ingredient = "default:obsidianbrick"
local circuit = "basic_materials:ic"
if core.registered_items[circuit] then
	main_ingredient = circuit
end

local recipe = {
	{"default:steel_ingot", "default:bronze_ingot", "default:steel_ingot",},
	{"default:bronze_ingot", main_ingredient, "default:bronze_ingot",},
	{"default:steel_ingot", "default:bronze_ingot", "default:steel_ingot",},
}

core.register_craft({
	output = "equip_exam:examiner",
	recipe = recipe,
})
