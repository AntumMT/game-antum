--localize functions for better performance
local string_byte = string.byte
local string_sub = string.sub
local get_item_group = minetest.get_item_group
local add_particlespawner = minetest.add_particlespawner
local add_item = minetest.add_item
local get_node = minetest.get_node
local add_entity = minetest.add_entity

local modpath = minetest.get_modpath("hot_air_balloons")
local set_rescue, mark_for_deletion_if_piloted = dofile(modpath .. "/absent_ballooner_rescuing.lua")
local handle_movement = dofile(modpath .. "/movement.lua")

local is_in_creative = function(name)
	return creative and creative.is_enabled_for
		and creative.is_enabled_for(name)
end

local get_fire_particle = function (pos)
	pos.y = pos.y + 3
	return {
		amount = 3,
		time = 1,
		minpos = pos,
		maxpos = pos,
		minvel = {x = 0, y = 1, z = 0},
		maxvel = {x = 0, y = 1, z = 0},
		minexptime = 1,
		maxexptime = 1,
		minsize = 10,
		maxsize = 5,
		collisiondetection = false,
		vertical = false,
		texture = "hot_air_balloons_flame.png"
	}
end

local function get_fuel_value(item)
	input = {
		method = "fuel",
		items = {item},
	}
	return minetest.get_craft_result(input).time or 0
end

local add_heat = function(self, player)
	local item_stack = player:get_wielded_item()
	local fuelval = get_fuel_value(item_stack)
	if not fuelval or fuelval == 0 then
		return false
	end
	local heat = self.heat
	heat = heat + 30 * fuelval --for coal lump 1 min until heat is back to original
	if heat < 12000 --cap heat at 12000 (10 min)
	then
		self.heat = heat
		--adding particle effect
		local pos = self.object:get_pos()
		add_particlespawner(get_fire_particle(pos))
		if not is_in_creative(player:get_player_name())
		then
			item_stack:take_item()
			player:set_wielded_item(item_stack)
		end
	end
	return true
end

--global table, has fields get_entity_def and get_item_def
--custom balloons right now turn into normal ones when the pilot leaves
hot_air_balloons = {}
hot_air_balloons.get_entity = function(name, mesh_name, texture_name)
	return
	name,
	{
		initial_properties =
		{
			hp_max = 1,
			physical = true,
			weight = 5,
			collisionbox = {-0.65, -0.01, -0.65, 0.65, 1.11, 0.65},
			visual = "mesh",
			mesh = "hot_air_balloons_balloon.obj",
			textures = {"hot_air_balloons_balloon_model.png"},
			is_visible = true,
			makes_footstep_sound = false,
			backface_culling = false,
		},
		heat = 0,
		balloon_type = name,
		
		on_step = function(self, dtime)
			--decrease heat, move
			if self.heat > 0
			then
				self.heat = self.heat - 1
			end
			handle_movement(self)
		end,
		on_rightclick = function (self, clicker)
			--if hoding coal, increase heat, else mount/dismount
			if not clicker or not clicker:is_player()
			then
				return
			end
			--checking if clicker is holding coal
			--heating balloon and returning if yes
			if add_heat(self, clicker)
			then
				return
			end
			
			--if not holding coal:
			local playername = clicker:get_player_name()
			if self.pilot and self.pilot == playername
			then
				self.pilot = nil
				clicker:set_detach()
			elseif not self.pilot
			then
				--attach
				self.pilot = playername
				clicker:set_attach(self.object, "",
					{x = 0, y = 1, z = 0}, {x = 0, y = 0, z = 0})
			end
		end,
		--if pilot leaves start sinking and prepare for next pilot
		on_detach_child = function(self, child)
			self.heat = 0
			self.object:setvelocity({x = 0, y = 0, z = 0})
		end,
		
		on_activate = function(self, staticdata, dtime_s)
			self.object:set_armor_groups({punch_operable = 1})
			--so balloons don't get lost
			self.object:setvelocity({x = 0, y = 0, z = 0})
			
			--checking if balloon was spawned from item or unloaded without pilot
			if staticdata == ""
			then
				return
			end
			--checking if balloon should despawn when pilot logged off
			local first_char = string_byte(staticdata)
			--ballooner logged off, balloon will respawn when ballooner logs back in
			if  first_char == 82 --chr 82 = R 
			then
				self.object:remove()
				return
			--absent ballooner logged back in
			elseif first_char == 80 --chr 80 = P
			then
				set_rescue(self, string_sub(staticdata, 2))
			end
		end,
		
		get_staticdata = mark_for_deletion_if_piloted,
		
		
		on_punch = function(self, puncher) --drop balloon item
			if self.pilot
			then
				return
			elseif not (puncher and puncher:is_player())
			then
				return
			else
				self.object:remove()
				local inv = puncher:get_inventory()
				if not is_in_creative(puncher:get_player_name())
					or not inv:contains_item("main", "hot_air_balloons:item")
				then
					local leftover = inv:add_item("main", "hot_air_balloons:item")
					if not leftover:is_empty()
					then
						add_item(self.object:get_pos(), leftover)
					end
				end
			end
		end,
	}
end

hot_air_balloons.get_item = function(name, description, texture, object_name)
return
	name,
	{
		description = description,
		inventory_image = texture,
		stack_max = 1,
		liquids_pointable = true,
		groups = {flammable = 2},
		on_place =
		function (itemstack, placer, pointed_thing)
			--places balloon if the clicked thing is a node and the above node is air
			if pointed_thing.type == "node"
				and get_node (pointed_thing.above).name == "air"
			then
				if not is_in_creative(placer:get_player_name())
				then
					itemstack:take_item()
				end
				local pos_to_place = pointed_thing.above
				pos_to_place.y = pos_to_place.y - 0.5 --subtracting 0.5 to place on ground
				add_entity(pointed_thing.above, object_name)
			end
			--add remaining items to inventory
			return itemstack
		end
	}
end
--registering the balloon entity, item and recepies

minetest.register_entity(hot_air_balloons.get_entity(
		"hot_air_balloons:balloon",
		"hot_air_balloons_balloon.obj",
		"hot_air_balloons_balloon_model.png"))

minetest.register_craftitem(hot_air_balloons.get_item(
		"hot_air_balloons:item",
		minetest.translate("hot_air_balloons", "Hot Air Balloon"),
		"hot_air_balloons_balloon.png",
		"hot_air_balloons:balloon"))
		

dofile(modpath .. "/craft.lua")
