biker = {}
biker.signs = minetest.get_modpath"signs"
if not minetest.global_exists"generate_texture" then biker.signs = false end
local settings = {
	-- Turning speed of bike, 1 is instant
	turn_power = 0.07,
	-- Top speed the bike can go
	max_speed = 17,
	-- Top speed in reverse
	max_reverse = 5,
	acceleration = 1.5,
	-- Braking power
	braking = 5,
	stepheight = 1.3,
	-- Whether the bike is breakable
	breakable = true,
	-- Same as max_speed but on nodes like dirt, sand, gravel ect
	crumbly_spd = 11,
	-- Ability to punch the motorbike to kick the rider
	kick = true,
	-- Enable custom plates, requires "signs" mod
	custom_plates = true
}
for setting, default in pairs(settings) do
	local value = minetest.settings:get("motorbike." .. setting)
	if value == nil then value = default else assert(type(value) == type(default)) end
	biker[setting] = value
end
biker.path = minetest.get_modpath"motorbike"
dofile(biker.path .. "/settings.lua")
dofile(biker.path .. "/functions.lua")
local bikelist = {
	"black",
	"blue",
	"brown",
	"cyan",
	"dark_green",
	"dark_grey",
	"green",
	"grey",
	"magenta",
	"orange",
	"pink",
	"red",
	"violet",
	"white",
	"yellow"
}
for _, colour in pairs(bikelist) do
	local texture = "motorbike_" .. colour .. ".png"
	minetest.register_entity("motorbike:bike_" .. colour, {
		visual = "mesh",
		mesh = "motorbike_body.b3d",
		textures = { texture, texture, texture, texture },
		stepheight = biker.stepheight,
		physical = true,
		collisionbox = {
			0.5,
			0.5,
			0.5,
			-0.5,
			-0.83,
			-0.5
		},
		drop = "motorbike:" .. colour,
		on_activate = function(self, staticdata)
			if staticdata and biker.signs then
				self.platenumber = staticdata
				local pos = self.object:get_pos()
				self.plate = minetest.add_entity(pos, "motorbike:licenseplate")
				if self.plate then
					self.plate:set_attach(self.object, "", { x = -0.2, y = -1.9, z = -12.12 }, { x = 0, y = 0, z = 0 })
				end
			end
			self.timer1 = 0
			self.timer2 = 0
			self.object:set_armor_groups{ immortal = 1 }
			biker.wheelspeed(self)
		end,
		on_rightclick = function(self, clicker)
			if not self.driver then
				biker.attach(self, clicker, false)
				minetest.sound_play("motorbike_start", {
					max_hear_distance = 24,
					gain = 1,
					object = self.object,
				})
				return
			end
			if self.driver and self.driver:get_player_name() == clicker:get_player_name() then
				biker.detach(clicker)
			end
		end,
		on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, _dir)
			if not puncher:is_player() then
				return
			end
			if not self.driver then
				if biker.breakable then
					if not biker.punch_inv then
						local pos = self.object:get_pos()
						local item = minetest.add_item(pos, self.drop)
						if item then
							self.object:remove()
							if self.plate then self.plate:remove() end
						end
					else
						local stack = ItemStack(self.drop)
						local pinv = puncher:get_inventory()
						if not pinv:room_for_item("main", stack) then
							core.chat_send_player(puncher:get_player_name(), "You do not have room in your inventory")
							return
						end
						pinv:add_item("main", stack)
						self.object:remove()
						if self.plate then self.plate:remove() end
					end
				end
				return
			end
			if biker.kick and puncher:get_player_name() ~= self.driver:get_player_name() and puncher:get_wielded_item():get_name() == "" and time_from_last_punch >= tool_capabilities.full_punch_interval and math.random(1, 2) == 1 then
				biker.detach(self.driver)
			end
		end,
		on_step = biker.drive,
		get_staticdata = function(self) if biker.signs then return self.platenumber end end
	})
	minetest.register_craftitem("motorbike:" .. colour, {
		description = colour:gsub("^%l", string.upper):gsub("_", " ") .. " bike",
		inventory_image = "motorbike_" .. colour .. "_inv.png",
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then return end
			local pos = { x = pointed_thing.above.x, y = pointed_thing.above.y + 1, z = pointed_thing.above.z }
			local bike = minetest.add_entity(pos, "motorbike:bike_" .. colour, biker.get_plate(placer:get_player_name()))
			bike:set_yaw(placer:get_look_horizontal())
			itemstack:take_item()
			return itemstack
		end
	})
	minetest.register_craft{
		output = "motorbike:" .. colour,
		recipe = {
			{ "", "", "default:stick" },
			{ "default:steel_ingot", "default:mese_crystal", "default:steel_ingot" },
			{ "motorbike:wheel", "wool:" .. colour, "motorbike:wheel" }
		}
	}
end
minetest.register_craftitem("motorbike:wheel", { description = "Motorbike Wheel", inventory_image = "motorbike_wheel_inv.png" })
minetest.register_craft{
	output = "motorbike:wheel",
	recipe = {
		{ "default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard" },
		{ "default:obsidian_shard", "default:steel_ingot", "default:obsidian_shard" },
		{ "default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard" }
	}
}
if biker.signs then
	minetest.register_entity("motorbike:licenseplate", {
		collisionbox = {
			0,
			0,
			0,
			0,
			0,
			0
		},
		visual = "upright_sprite",
		textures = { "blank.png" },
		visual_size = { x = 0.7, y = 0.7, z = 0.7 },
		physical = false,
		pointable = false,
		collide_with_objects = false,
		on_activate = function(self)
			-- HACK
			minetest.after(0.2, function()
				if not self.object:get_attach() then self.object:remove()
				else
					self.object:set_armor_groups{ immortal = 1 }
					local text = self.object:get_attach():get_luaentity().platenumber
					if not text then return end
					self.object:set_properties{ textures = { generate_texture(create_lines(text)) } }
				end
			end)
		end
	})
end
