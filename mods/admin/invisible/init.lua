-- Code by UjEdwin

minetest.register_alias("i", "invisible:tool")

invisible={time=0,armor=minetest.get_modpath("3d_armor")}
minetest.register_privilege("invisible", {
	description = "Be invisible",
	give_to_singleplayer= false,
})

invisible.toogle=function(user,sneak)
	local name=user:get_player_name()
	if minetest.check_player_privs(user:get_player_name(), {invisible=true}) then
		if not invisible[name] then
			user:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
			invisible[name]={}
			invisible[name].tool=sneak
			invisible[name].collisionbox=user:get_properties().collisionbox
			invisible[name].visual_size=user:get_properties().visual_size
			invisible[name].textures=user:get_properties().textures
			user:set_properties({
				visual = "mesh",
				textures={"invisible_skin.png"},
				visual_size = {x=0, y=0},
				collisionbox = {0,0,0, 0,0,0},
			})
			minetest.chat_send_player(name, "invisible on")			
		else
			user:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
			user:set_properties({
				visual = "mesh",
				textures=invisible[name].textures,
				visual_size = invisible[name].visual_size,
				collisionbox=invisible[name].collisionbox
			})
			invisible[name]=nil

			if invisible.armor then
				armor:set_player_armor(user)
				armor:update_inventory(user)
			end


			minetest.chat_send_player(name, "invisible off")
		end
	else
	
		if not invisible[name] then
			invisible[name]={}
			user:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
		else
			user:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
			invisible[name]=nil
		end
	end
end

minetest.register_tool("invisible:tool", {
	description = "invisible",
	inventory_image = "wand.png",
	groups = {not_in_creative_inventory=1},
	on_use = function(itemstack, user, pointed_thing)
		if minetest.check_player_privs(user:get_player_name(), {invisible=true}) then
				invisible.toogle(user,true)
		else
			itemstack:replace(nil)
		end
		return itemstack
	end
})

minetest.register_globalstep(function(dtime)
	invisible.time=invisible.time+dtime
	if invisible.time<0.5 then return end
	invisible.time=0
	for _, player in pairs(minetest.get_connected_players()) do
		local name=player:get_player_name()
		local sneak=player:get_player_control().sneak
		if (sneak and not invisible[name]) or (sneak==false and invisible[name] and not invisible[name].tool) then
			invisible.toogle(player)
		end
	end
end)