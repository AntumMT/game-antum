local material = {}
local shape = {}
local make_ok = {}
local anzahl = {}

minetest.register_node("mysheetmetal:machine", {
	description = "Eavestrough Machine",
	tiles = {
		"mysheetmetal_mach_top.png",
		"mysheetmetal_mach_top.png",
		"mysheetmetal_mach_side.png",
		"mysheetmetal_mach_side.png",
		"mysheetmetal_mach_back.png",
		"mysheetmetal_mach_front.png",
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.0625, -0.3125, 0.5, 0.0625, 0.1875},
			{-0.5, 0.125, -0.3125, 0.5, 0.1875, 0.125},
			{-0.5, 0.1875, -0.25, 0.5, 0.25, 0.125},
			{-0.5, -0.0625, -0.4375, 0.5, 0.0625, -0.3125},
			{0, -0.25, -0.4375, 0.0625, -0.0625, -0.375},
			{0, -0.3125, -0.4375, 0.5, -0.25, -0.375},
			{-0.5, -0.5, 0.0625, -0.375, -0.0625, 0.1875},
			{0, 0.25, 0, 0.0625, 0.5, 0.0625},
			{0.0625, 0.4375, 0, 0.5, 0.5, 0.0625},
			{-0.5, 0.0625, 0.125, 0.5, 0.1875, 0.1875},
			{-0.5, -0.5, -0.3125, -0.375, -0.0625, -0.1875},


			{0.5, -0.0625, -0.3125, 1.5, 0.0625, 0.1875},
			{0.5, 0.125, -0.3125, 1.5, 0.1875, 0.125},
			{0.5, 0.1875, -0.25, 1.5, 0.25, 0.125},
			{0.5, -0.0625, -0.4375, 1.5, 0.0625, -0.3125},
			{1, -0.25, -0.4375, 1.0625, -0.0625, -0.375},
			{0.5, -0.3125, -0.4375, 1.0625, -0.25, -0.375},

			{1.375, -0.5, 0.0625, 1.5, -0.0625, 0.1875},
			{1, 0.25, 0, 1.0625, 0.5, 0.0625},
			{0.5, 0.4375, 0, 1.0625, 0.5, 0.0625},
			{0.5, 0.0625, 0.125, 1.5, 0.1875, 0.1875},
			{1.375, -0.5, -0.3125, 1.5, -0.0625, -0.1875},

		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.0625, -0.3125, 1.5, 0.0625, 0.1875},
			{-0.5, 0.125, -0.3125, 1.5, 0.1875, 0.125},
			{-0.5, 0.1875, -0.25, 1.5, 0.25, 0.125},
			{-0.5, -0.0625, -0.4375, 1.5, 0.0625, -0.3125},
			{0, -0.25, -0.4375, 0.0625, -0.0625, -0.375},
			{0, -0.3125, -0.4375, 1.0625, -0.25, -0.375},
			{-0.5, -0.5, 0.0625, -0.375, -0.0625, 0.1875},
			{0, 0.25, 0, 0.0625, 0.4375, 0.0625},
			{0, 0.4375, 0, 1.0625, 0.5, 0.0625},
			{-0.5, 0.0625, 0.125, 1.5, 0.1875, 0.1875},
			{-0.5, -0.5, -0.3125, -0.375, -0.0625, -0.1875},


			{1, -0.25, -0.4375, 1.0625, -0.0625, -0.375},

			{1.375, -0.5, 0.0625, 1.5, -0.0625, 0.1875},
			{1, 0.25, 0, 1.0625, 0.4375, 0.0625},
			{1.375, -0.5, -0.3125, 1.5, -0.0625, -0.1875},
		}
	},

	after_place_node = function(pos, placer)
	local meta = minetest.get_meta(pos);
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Eavestrough Machine is empty (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

can_dig = function(pos,player)
	local meta = minetest.env:get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") or
	not inv:is_empty("ingot2") or
	not inv:is_empty("res") then
		return false
	end
	return true
end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[10,11;]"..
		"background[-0.15,-0.25;10.40,11.75;mysheetmetal_background.png]"..
		"label[3,5;Steel Ingot:]"..
		"list[current_name;ingot;3,5.5;1,1;]"..
		"label[4.5,5;White Dye:]"..
		"list[current_name;ingot2;4.5,5.5;1,1;]"..
		"label[6.5,5;Output:]"..
		"list[current_name;res;6.5,5.5;1,1;]"..
		"label[0,0;Choose Eavestrough:]"..
		"label[0.5,0.5;Sheet Metal]"..
		"image_button[0.5,1;1,1;mysheetmetal_mach1.png;et; ]"..
		"image_button[1.5,1;1,1;mysheetmetal_mach2.png;etocorner; ]"..
		"image_button[2.5,1;1,1;mysheetmetal_mach3.png;eticorner; ]"..
		"image_button[3.5,1;1,1;mysheetmetal_mach4.png;etds; ]"..
		"image_button[4.5,1;1,1;mysheetmetal_mach5.png;ds; ]"..
		"image_button[5.5,1;1,1;mysheetmetal_mach6.png;etcapl; ]"..
		"image_button[6.5,1;1,1;mysheetmetal_mach7.png;etcapr; ]"..
		"label[0.5,2;Soffit]"..
		"image_button[0.5,2.5;1,1;mysheetmetal_mach8.png;soffit; ]"..
		"image_button[1.5,2.5;1,1;mysheetmetal_mach9.png;scorner; ]"..
		"image_button[2.5,2.5;1,1;mysheetmetal_mach10.png;scap; ]"..
		"image_button[3.5,2.5;1,1;mysheetmetal_mach11.png;scicorner; ]"..
		"image_button[4.5,2.5;1,1;mysheetmetal_mach12.png;scocorner; ]"..
		"label[0.5,3.5;Fascia]"..
		"image_button[0.5,4;1,1;mysheetmetal_mach13.png;fascia; ]"..

		"list[current_player;main;1,7;8,4;]")
	meta:set_string("infotext", "Sheet Metal Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot", 1)
	inv:set_size("ingot2", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["et"] 
or fields["etocorner"]
or fields["eticorner"] 
or fields["etds"] 
or fields["ds"]
or fields["etcapl"]
or fields["etcapr"]

or fields["soffit"]
or fields["scorner"]
or fields["scap"]
or fields["scicorner"]
or fields["scocorner"]

or fields["fascia"]
then

	if fields["et"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mysheetmetal:eavestrough"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["etocorner"] then
		make_ok = "0"
		anzahl = "6"
		shape = "mysheetmetal:eavestrough_ocorner"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["eticorner"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mysheetmetal:eavestrough_icorner"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["etds"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mysheetmetal:eavestrough_downspout"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["ds"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mysheetmetal:downspout"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["etcapl"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mysheetmetal:eavestrough_lc"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["etcapr"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mysheetmetal:eavestrough_rc"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["soffit"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mysheetmetal:soffit"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["scorner"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mysheetmetal:soffit_corner"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["scap"] then
		make_ok = "0"
		anzahl = "6"
		shape = "mysheetmetal:soffit_cap"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["scicorner"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mysheetmetal:soffit_cap_icorner"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["scocorner"] then
		make_ok = "0"
		anzahl = "8"
		shape = "mysheetmetal:soffit_cap_ocorner"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["fascia"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mysheetmetal:fascia"
		if inv:is_empty("ingot") then
			return
		end
	end

		local ingotstack = inv:get_stack("ingot", 1)
		local ingotstack2 = inv:get_stack("ingot2", 1)
		local resstack = inv:get_stack("res", 1)

		if ingotstack:get_name()=="default:steel_ingot" and
		   ingotstack2:get_name()=="dye:white" then
				make_ok = "1"
		end

		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res",shape)
			end
			if not minetest.settings:get_bool("creative_mode") then
				ingotstack:take_item()
				ingotstack2:take_item()
			end
			inv:set_stack("ingot",1,ingotstack)
			inv:set_stack("ingot2",1,ingotstack2)
		end            	
end
end


})

--Craft

minetest.register_craft({
		output = 'mysheetmetal:machine',
		recipe = {
			{'default:iron_lump', '', 'default:iron_lump'},
			{'default:wood', 'default:wood', 'default:wood'},
			{'default:wood', "default:wood", 'default:wood'},		
		},
})













