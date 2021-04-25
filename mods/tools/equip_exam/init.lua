
equip_exam = {}
equip_exam.name = core.get_current_modname()
equip_exam.path = core.get_modpath(equip_exam.name)

local files = {
	"formspec",
	"node",
	"crafting",
}

for _, f in pairs(files) do
	dofile(equip_exam.path .. "/" .. f .. ".lua")
end
