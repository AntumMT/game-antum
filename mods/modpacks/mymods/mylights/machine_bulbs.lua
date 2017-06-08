local material = {}
local make_ok = {}
local make_ok2 = {}
local anzahl = {}
local lbanzahl = {}
minetest.register_node("mylights:machine", {
	description = "Light Bulb Machine",
	tiles = {
		{name="mylights_lmach_t.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		{name="mylights_cmach_b.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		{name="mylights_lmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		{name="mylights_lmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		{name="mylights_lmach_s2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		{name="mylights_lmach_s2.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 8,
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.3125, -0.375, 0.375, 0.125, 0.375}, -- NodeBox1
			{0.1875, -0.5, -0.375, 0.375, -0.25, -0.1875}, -- NodeBox2
			{-0.375, -0.5, 0.1875, -0.1875, -0.3125, 0.375}, -- NodeBox3
			{0.1875, -0.5, 0.1875, 0.375, -0.3125, 0.375}, -- NodeBox4
			{-0.375, -0.5, -0.375, -0.1875, -0.3125, -0.1875}, -- NodeBox5
			{-0.125, 0.125, -0.125, 0.125, 0.4375, 0.125}, -- NodeBox6
			{-0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625}, -- NodeBox16
			{-0.1875, 0.125, -0.0625, 0.1875, 0.375, 0.0625}, -- NodeBox17
			{-0.0625, 0.125, -0.1875, 0.0625, 0.375, 0.1875}, -- NodeBox18
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.125, 0.375}, 
		}
	},

	after_place_node = function(pos, placer)
	local meta = minetest.get_meta(pos);
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Light Bulb Machine (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot1") then
		return false
	elseif not inv:is_empty("ingot2") then
		return false
	elseif not inv:is_empty("ingot3") then
		return false
	elseif not inv:is_empty("tabl1") then
		return false
	elseif not inv:is_empty("tabl2") then
		return false
	elseif not inv:is_empty("tabl3") then
		return false
	elseif not inv:is_empty("tabl4") then
		return false
	elseif not inv:is_empty("res1") then
		return false
	elseif not inv:is_empty("res2") then
		return false
	end
	return true
end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[9,10;]"..
		"background[-0.15,-0.25;9.40,10.75;mylights_background.png]"..
		"label[0,0;Light Bulbs:]"..
		"label[3,1;Glass]"..
		"list[current_name;ingot1;2,1;1,1;]"..
		"label[3,2;Torch]"..
		"list[current_name;ingot2;2,2;1,1;]"..
		"label[3,3;Copper Lump]"..
		"list[current_name;ingot3;2,3;1,1;]"..
		"list[current_name;res1;2,4.5;1,1;]"..
		"button[1,4.5;1,1;make;Make]"..

		"list[current_name;tabl1;6,2;1,1;]"..
		"list[current_name;tabl2;6,3;1,1;]"..
		"list[current_name;res2;6,4.5;1,1;]"..
		"button[5,4.5;1,1;make2;Make]"..

		"list[current_player;main;0.5,6;8,4;]")
	meta:set_string("infotext", "Light Bulb Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot1", 1)
	inv:set_size("ingot2", 1)
	inv:set_size("ingot3", 1)
	inv:set_size("tabl1", 1)
	inv:set_size("tabl2", 1)
	inv:set_size("tabl3", 1)
	inv:set_size("tabl4", 1)
	inv:set_size("res1", 1)
	inv:set_size("res2", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["make"]
then

	if fields["make"] then
		make_ok = "0"
		anzahl = "1"
		if inv:is_empty("ingot1") or
		   inv:is_empty("ingot2") or
		   inv:is_empty("ingot3") then
			return
		end
	end





		local ingotstack1 = inv:get_stack("ingot1", 1)
		local ingotstack2 = inv:get_stack("ingot2", 1)
		local ingotstack3 = inv:get_stack("ingot3", 1)

		local resstack1 = inv:get_stack("res1", 1)
----------------------------------------------------------------------------------
--register nodes
----------------------------------------------------------------------------------
		if ingotstack1:get_name()=="default:glass" and
		   ingotstack2:get_name()=="default:torch" and
		   ingotstack3:get_name()=="default:copper_lump" then
				material = "mylights:lightbulb30"
				make_ok = "1"
				make_ok2 = "0"
		end


----------------------------------------------------------------------

		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res1",material)
			end
			ingotstack1:take_item()
			inv:set_stack("ingot1",1,ingotstack1)
			ingotstack2:take_item()
			inv:set_stack("ingot2",1,ingotstack2)
			ingotstack3:take_item()
			inv:set_stack("ingot3",1,ingotstack3)
		end 
         	
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
if fields["make2"] 
then



	if fields["make2"] then
		make_ok2 = "0"
		lbanzahl = "1"
		if inv:is_empty("tabl1") or
		   inv:is_empty("tabl2") then
			return
		end
	end




		local tablstack1 = inv:get_stack("tabl1", 1)
		local tablstack2 = inv:get_stack("tabl2", 1)

		local resstack2 = inv:get_stack("res2", 1)
----------------------------------------------------------------------------------
--register nodes
----------------------------------------------------------------------------------

		if tablstack1:get_name()=="mylights:lightbulb30" and
		   tablstack2:get_name()=="mylights:lightbulb30" then
				material = "mylights:lightbulb60"
				make_ok = "0"
				make_ok2 = "2"
		end
		if tablstack1:get_name()=="mylights:lightbulb30" and
		   tablstack2:get_name()=="mylights:lightbulb60" then
				material = "mylights:lightbulb90"
				make_ok = "0"
				make_ok2 = "2"
		end
		if tablstack1:get_name()=="mylights:lightbulb30" and
		   tablstack2:get_name()=="mylights:lightbulb90" then
				material = "mylights:lightbulb120"
				make_ok = "0"
				make_ok2 = "2"
		end
		if tablstack1:get_name()=="mylights:lightbulb60" and
		   tablstack2:get_name()=="mylights:lightbulb30" then
				material = "mylights:lightbulb90"
				make_ok = "0"
				make_ok2 = "2"
		end
		if tablstack1:get_name()=="mylights:lightbulb60" and
		   tablstack2:get_name()=="mylights:lightbulb60"then
				material = "mylights:lightbulb120"
				make_ok = "0"
				make_ok2 = "2"
		end
		if tablstack1:get_name()=="mylights:lightbulb90" and
		   tablstack2:get_name()=="mylights:lightbulb30" then
				material = "mylights:lightbulb120"
				make_ok = "0"
				make_ok2 = "2"
		end

----------------------------------------------------------------------

		if make_ok2 == "2" then
			local givea = {}
			for j = 0, lbanzahl-1 do
				givea[j+1]=inv:add_item("res2",material)
			end
			tablstack1:take_item()
			inv:set_stack("tabl1",1,tablstack1)
			tablstack2:take_item()
			inv:set_stack("tabl2",1,tablstack2)
		end          	
end
end


})

--Craft

minetest.register_craft({
		output = 'mylights:machine',
		recipe = {
			{'default:glass', 'default:copper_ingot', 'default:glass'},
			{'default:glass', 'default:torch', 'default:glass'},
			{'default:glass', "default:glass", 'default:glass'},		
		},
})












