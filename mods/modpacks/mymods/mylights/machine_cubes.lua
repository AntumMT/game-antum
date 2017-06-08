local cubelight = {}
local lightbox = {}
local makebox_ok = {}
local makecube_ok = {}
local anzahl = {}
local lbanzahl = {}
minetest.register_node("mylights:machine_cubes", {
	description = "Light Box and Cube Machine",
	tiles = {
		{name="mylights_cmach_t.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		{name="mylights_cmach_b.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		{name="mylights_cmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		{name="mylights_cmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		{name="mylights_cmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		{name="mylights_cmach_s.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=4}},
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 11,
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.3125, -0.375, 0.375, 0.125, 0.375}, -- NodeBox1
			{0.1875, -0.5, -0.375, 0.375, -0.25, -0.1875}, -- NodeBox2
			{-0.375, -0.5, 0.1875, -0.1875, -0.3125, 0.375}, -- NodeBox3
			{0.1875, -0.5, 0.1875, 0.375, -0.3125, 0.375}, -- NodeBox4
			{-0.375, -0.5, -0.375, -0.1875, -0.3125, -0.1875}, -- NodeBox5
			{-0.125, 0.1875, -0.125, 0.125, 0.4375, 0.125}, -- NodeBox6
			{-0.1875, 0.0625, -0.1875, 0.1875, 0.1875, 0.1875}, -- NodeBox7
			{0.125, 0.1875, -0.1875, 0.1875, 0.4375, -0.125}, -- NodeBox8
			{-0.1875, 0.1875, -0.1875, -0.125, 0.4375, -0.125}, -- NodeBox9
			{-0.1875, 0.1875, 0.125, -0.125, 0.4375, 0.1875}, -- NodeBox10
			{0.125, 0.1875, 0.125, 0.1875, 0.4375, 0.1875}, -- NodeBox11
			{-0.1875, 0.4375, -0.1875, 0.1875, 0.5, -0.125}, -- NodeBox12
			{0.125, 0.4375, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox13
			{-0.1875, 0.4375, -0.1875, -0.125, 0.5, 0.1875}, -- NodeBox14
			{-0.1875, 0.4375, 0.125, 0.1875, 0.5, 0.1875}, -- NodeBox15 

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
			meta:set_string("infotext",  "Light Box and Cube Machine (owned by " .. (placer:get_player_name() or "") .. ")");
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
	elseif not inv:is_empty("ingot4") then
		return false
	elseif not inv:is_empty("ingot5") then
		return false
	elseif not inv:is_empty("boxout") then
		return false
	elseif not inv:is_empty("cubeout") then
		return false
	end
	return true
end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[9,10;]"..
		"background[-0.15,-0.25;9.40,10.75;mylights_background2.png]"..
		"label[0,0;Light Box and Cubes:]"..
		"label[0.5,0.5;Wool colors supported - White, Green, Red, Blue, Orange, Yellow]"..
		"label[3,1;Wool]"..
		"list[current_name;ingot1;2,1;1,1;]"..
		"label[3,2;Light Bulb]"..
		"list[current_name;ingot2;2,2;1,1;]"..
		"label[3,3;Obsidian]"..
		"list[current_name;ingot3;2,3;1,1;]"..
		"list[current_name;boxout;2,4.5;1,1;]"..
		"button[1,4.5;1,1;makebox;Make]"..

		"label[5,1;Wool]"..
		"list[current_name;ingot4;6,1;1,1;]"..
		"label[4.5,2;Light Bulb]"..
		"list[current_name;ingot5;6,2;1,1;]"..
		"list[current_name;cubeout;6,4.5;1,1;]"..
		"button[5,4.5;1,1;makecube;Make]"..


		"list[current_player;main;0.5,6;8,4;]")
	meta:set_string("infotext", "Light Box and Cubes Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot1", 1)
	inv:set_size("ingot2", 1)
	inv:set_size("ingot3", 1)
	inv:set_size("ingot4", 1)
	inv:set_size("ingot5", 1)
	inv:set_size("boxout", 1)
	inv:set_size("cubeout", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["makebox"] 
then

	if fields["makebox"] then
		makebox_ok = "0"
		makecube_ok = "0"
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

		local boxstack = inv:get_stack("boxout", 1)
----------------------------------------------------------------------------------
--register nodes
----------------------------------------------------------------------------------
local box_tab = {
		{"wool:white" , "mylights:lightbulb30" , "mylights:lightbox30_white"},
		{"wool:white" , "mylights:lightbulb60" , "mylights:lightbox60_white"},
		{"wool:white" , "mylights:lightbulb90" , "mylights:lightbox90_white"},
		{"wool:white" , "mylights:lightbulb120" , "mylights:lightbox120_white"},

		{"wool:green" , "mylights:lightbulb30" , "mylights:lightbox30_green"},
		{"wool:green" , "mylights:lightbulb60" , "mylights:lightbox60_green"},
		{"wool:green" , "mylights:lightbulb90" , "mylights:lightbox90_green"},
		{"wool:green" , "mylights:lightbulb120" , "mylights:lightbox120_green"},

		{"wool:red" , "mylights:lightbulb30" , "mylights:lightbox30_red"},
		{"wool:red" , "mylights:lightbulb60" , "mylights:lightbox60_red"},
		{"wool:red" , "mylights:lightbulb90" , "mylights:lightbox90_red"},
		{"wool:red" , "mylights:lightbulb120" , "mylights:lightbox120_red"},

		{"wool:blue" , "mylights:lightbulb30" , "mylights:lightbox30_blue"},
		{"wool:blue" , "mylights:lightbulb60" , "mylights:lightbox60_blue"},
		{"wool:blue" , "mylights:lightbulb90" , "mylights:lightbox90_blue"},
		{"wool:blue" , "mylights:lightbulb120" , "mylights:lightbox120_blue"},

		{"wool:orange" , "mylights:lightbulb30" , "mylights:lightbox30_orange"},
		{"wool:orange" , "mylights:lightbulb60" , "mylights:lightbox60_orange"},
		{"wool:orange" , "mylights:lightbulb90" , "mylights:lightbox90_orange"},
		{"wool:orange" , "mylights:lightbulb120" , "mylights:lightbox120_orange"},

		{"wool:yellow" , "mylights:lightbulb30" , "mylights:lightbox30_yellow"},
		{"wool:yellow" , "mylights:lightbulb60" , "mylights:lightbox60_yellow"},
		{"wool:yellow" , "mylights:lightbulb90" , "mylights:lightbox90_yellow"},
		{"wool:yellow" , "mylights:lightbulb120" , "mylights:lightbox120_yellow"},
	}
for i in ipairs (box_tab) do
	local woolcol = box_tab[i][1]
	local watt = box_tab[i][2]
	local thebox = box_tab[i][3]


		if ingotstack1:get_name()== woolcol and
		   ingotstack2:get_name()== watt and
		   ingotstack3:get_name()=="default:obsidian" then
				lightbox = thebox
				makebox_ok = "1"
--				makecube_ok = "0"
		end

end

----------------------------------------------------------------------

		if makebox_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("boxout",lightbox)
			end
			ingotstack1:take_item()
			inv:set_stack("ingot1",1,ingotstack1)
			ingotstack2:take_item()
			inv:set_stack("ingot2",1,ingotstack2)
			ingotstack3:take_item()
			inv:set_stack("ingot3",1,ingotstack3)
		end 


end
if fields["makecube"] 
then



	if fields["makecube"] then
		makebox_ok = "0"
		makecube_ok = "0"
		lbanzahl = "1"
		if inv:is_empty("ingot4") or
		   inv:is_empty("ingot5") then
			return
		end
	end



		local ingotstack4 = inv:get_stack("ingot4", 1)
		local ingotstack5 = inv:get_stack("ingot5", 1)

		local cubestack = inv:get_stack("cubeout", 1)
----------------------------------------------------------------------------------
--register nodes
----------------------------------------------------------------------------------

local cube_tab = {
		{"wool:white" , "mylights:lightbulb30" , "mylights:light_cube_30_white"},
		{"wool:white" , "mylights:lightbulb60" , "mylights:light_cube_60_white"},
		{"wool:white" , "mylights:lightbulb90" , "mylights:light_cube_90_white"},
		{"wool:white" , "mylights:lightbulb120" , "mylights:light_cube_120_white"},

		{"wool:green" , "mylights:lightbulb30" , "mylights:light_cube_30_green"},
		{"wool:green" , "mylights:lightbulb60" , "mylights:light_cube_60_green"},
		{"wool:green" , "mylights:lightbulb90" , "mylights:light_cube_90_green"},
		{"wool:green" , "mylights:lightbulb120" , "mylights:light_cube_120_green"},

		{"wool:red" , "mylights:lightbulb30" , "mylights:light_cube_30_red"},
		{"wool:red" , "mylights:lightbulb60" , "mylights:light_cube_60_red"},
		{"wool:red" , "mylights:lightbulb90" , "mylights:light_cube_90_red"},
		{"wool:red" , "mylights:lightbulb120" , "mylights:light_cube_120_red"},

		{"wool:blue" , "mylights:lightbulb30" , "mylights:light_cube_30_blue"},
		{"wool:blue" , "mylights:lightbulb60" , "mylights:light_cube_60_blue"},
		{"wool:blue" , "mylights:lightbulb90" , "mylights:light_cube_90_blue"},
		{"wool:blue" , "mylights:lightbulb120" , "mylights:light_cube_120_blue"},

		{"wool:orange" , "mylights:lightbulb30" , "mylights:light_cube_30_orange"},
		{"wool:orange" , "mylights:lightbulb60" , "mylights:light_cube_60_orange"},
		{"wool:orange" , "mylights:lightbulb90" , "mylights:light_cube_90_orange"},
		{"wool:orange" , "mylights:lightbulb120" , "mylights:light_cube_120_orange"},

		{"wool:yellow" , "mylights:lightbulb30" , "mylights:light_cube_30_yellow"},
		{"wool:yellow" , "mylights:lightbulb60" , "mylights:light_cube_60_yellow"},
		{"wool:yellow" , "mylights:lightbulb90" , "mylights:light_cube_90_yellow"},
		{"wool:yellow" , "mylights:lightbulb120" , "mylights:light_cube_120_yellow"},
	}
for i in ipairs (cube_tab) do
	local woolcol = cube_tab[i][1]
	local watt = cube_tab[i][2]
	local thecube = cube_tab[i][3]


		if ingotstack4:get_name()== woolcol and
		   ingotstack5:get_name()== watt then
				cubelight = thecube
--				makebox_ok = "0"
				makecube_ok = "1"
		end

end
----------------------------------------------------------------------

		if makecube_ok == "1" then
			local givea = {}
			for j = 0, lbanzahl-1 do
				givea[j+1]=inv:add_item("cubeout",cubelight)
			end
			ingotstack4:take_item()
			inv:set_stack("ingot4",1,ingotstack4)
			ingotstack5:take_item()
			inv:set_stack("ingot5",1,ingotstack5)
		end 
end
end


})

--Craft

minetest.register_craft({
		output = 'mylights:machine_cubes',
		recipe = {
			{'default:glass', 'wool:red', 'default:glass'},
			{'wool:blue', 'default:torch', 'wool:yellow'},
			{'default:glass', "wool:green", 'default:glass'},		
		},
})












