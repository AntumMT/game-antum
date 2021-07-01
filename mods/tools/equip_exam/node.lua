
local S = core.get_translator(equip_exam.name)


local common_name = S("Equipment Examiner")

local function update_formspec(pos)
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		local contents = inv:get_list("input")[1]

		meta:set_string("formspec", equip_exam:get_formspec(contents,
			inv:is_empty("input"), meta))
end

local node_def = {
	description = common_name,
	short_description = common_name,
	drawtype = "normal",
	tiles = {
		"equip_exam_examiner.png",
		"equip_exam_examiner.png",
		"equip_exam_examiner.png",
		"equip_exam_examiner.png",
		"equip_exam_examiner.png",
		"equip_exam_examiner_front.png",
		"equip_exam_examiner.png",
	},
	groups = {oddly_breakable_by_hand=1,},
	is_gound_content = false,
	stack_max = 1,
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = core.get_meta(pos)
		meta:set_string("infotext", common_name)
		local inv = meta:get_inventory()
		inv:set_size("input", 1)
		update_formspec(pos)
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		update_formspec(pos)
	end,
	can_dig = function(pos, player)
		local meta = core.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("input")
	end,
	-- FIXME: both are called when item is replaced with another
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		update_formspec(pos)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		update_formspec(pos)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.techname then
			local nmeta = core.get_meta(pos)
			if fields.techname == "true" then
				nmeta:set_string("show_technical", "true")
			else
				nmeta:set_string("show_technical", nil)
			end

			update_formspec(pos)
		end
	end
}

core.register_node("equip_exam:examiner", node_def)
