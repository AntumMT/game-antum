local BRUSH_USES = 3
local CAN_USES = 100

function check_paintcan(pos, node)
	local name = node.name
	if string.sub(name, 1, 14) ~= "mypaint:paint_" then
		return
	end
	local color = string.sub(name, 15)
	local meta = minetest.get_meta(pos)
	stack = ItemStack("mypaint:brush_"..color)
	if minetest.setting_getbool("creative_mode") then
		return stack
	end
	local uses = meta:get_int("mypaint:uses") - 1
	meta:set_int("mypaint:uses", uses)
	if uses <= 0 then
		minetest.dig_node(pos)
	else
		local info = meta:get_string("infotext")
		info = string.gsub(info, "%(.*%)", "("..uses.." uses)")
		meta:set_string("infotext", info)
	end
	return stack
end

function paint_node(pos, node, col, itemstack)
	local s, e
	local nname = node.name
	s, e = string.find(nname, "_[^_]+$")
	local color
	if s and e then
		color = string.sub(nname, s + 1, e)
		if mypaint.colors[color] then
			nname = string.sub(nname, 1, s - 1)
			if color == col then
				return
			end
		end
	end

	for name, colors in pairs(mypaint.paintables) do
		if (nname == name) then
			if not col then
				if color then
					minetest.set_node(pos, {name = name, param2 = node.param2})
				end
				return
			end
			if not colors[col] then
				return
			end
			minetest.set_node(pos, {name = name.."_"..col, param2 = node.param2})
			if not minetest.setting_getbool("creative_mode") then
				local wear = itemstack:get_wear() + 65535 / BRUSH_USES
				if wear < 65535 then
					itemstack:set_wear(wear)
				else
					itemstack = ItemStack("mypaint:brush")
				end
				return itemstack
			end
		end
	end
end

minetest.register_tool("mypaint:brush", {
	description = "Paint Brush",
	inventory_image = "mypaint_brush.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		if string.sub(node.name, 1, 8) ~= "mypaint:" then
			return
		end
		return check_paintcan(pos, node)
	end
})

minetest.register_tool("mypaint:scraper", {
	description = "Paint Scraper",
	inventory_image = "mypaint_scraper.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		local pos = pointed_thing.under
		local node = minetest.get_node(pos)
		return paint_node(pos, node, nil, itemstack)
	end
})

for color, entry in pairs(mypaint.colors) do
	local desc = entry[1]
	local cstring = entry[2]

	minetest.register_tool("mypaint:brush_"..color, {
		description = "Paint Brush ("..desc.." Paint)",
		inventory_image = "mypaint_brush.png^(mypaint_brush_color.png^[colorize:#"..cstring..")",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type ~= "node" then
				return
			end
			local pos = pointed_thing.under
			local node = minetest.get_node(pos)
			local ret = check_paintcan(pos, node)
			if ret then
				return ret
			end
			return paint_node(pos, node, color, itemstack)
		end,
	})

	minetest.register_node("mypaint:paint_"..color, {
		description = desc.." Paint",
		drawtype = "mesh",
		paramtype = "light",
		paramtype2 = "facedir",
		mesh = "mypaint_can.obj",
		tiles = {"(mypaint_can_color.png^[colorize:#"..cstring..")^mypaint_can_base.png"},
		stack_max = 1,
		drop = "",
		groups = {oddly_breakable_by_hand = 3, dig_immediate = 3, not_in_creative_inventory = 1},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, -0.25, 0.25, 0., 0.25}, 
			}
		},
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			if not digger then
				return
			end
			local inv = digger:get_inventory()
			if not inv then
				return
			end
			local itemstack = ItemStack("mypaint:paintcan_"..color)
			local uses = tonumber(oldmetadata.fields["mypaint:uses"])
			if not uses then
				uses = 100
			end
			if uses <= 0 then
				return
			end
			itemstack:set_wear((CAN_USES - uses) * (65535 / CAN_USES))
			if inv:room_for_item("main", itemstack) then
				inv:add_item("main", itemstack)
			else
				minetest.add_item(pos, itemstack)
			end
		end
	})

	minetest.register_tool("mypaint:paintcan_"..color, {
		description = desc.." Paint",
		inventory_image = "mypaint_inv_can_base.png^(mypaint_inv_can_color.png^[colorize:#"..cstring..":alpha)",
		on_place = function(itemstack, user, pointed_thing)
			local pname = "mypaint:paint_"..color
			local paint = ItemStack(pname)
			paint = minetest.item_place_node(paint, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then
				if not paint or (paint:get_count() > 0) then
					return
				end
			end
			local pos = pointed_thing.under
			local node = minetest.get_node(pos)
			local meta = minetest.get_meta(pos)
			if node.name ~= pname or (meta:get_int("mypaint:uses") > 0) then
				pos = pointed_thing.above
				node = minetest.get_node(pos)
				meta = minetest.get_meta(pos)
				if node.name ~= pname or (meta:get_int("mypaint:uses") > 0) then
					return
				end
			end
			local uses = math.floor(CAN_USES - itemstack:get_wear() / (65535 / CAN_USES))
			meta:set_int("mypaint:uses", uses)
			meta:set_string("infotext", desc.." Paint ("..uses.." uses)")
			itemstack:take_item()
			return itemstack
		end
	})

	minetest.register_craft({
		output = "mypaint:paintcan_"..color,
		recipe = {
			{"bucket:bucket_water","dye:"..color}
		},
		replacements = {{"bucket:bucket_water","bucket:bucket_empty"}},
	})
end

minetest.register_craft({
		output = 'mypaint:brush',
		recipe = {
			{'wool:white'},
			{'group:stick'},
		}
})

minetest.register_craft({
		output = 'mypaint:scraper',
		recipe = {
			{'default:steel_ingot', ''},
			{'', 'group:stick'},
		}
})

