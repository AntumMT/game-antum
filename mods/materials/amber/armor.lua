-- Armors --
if minetest.get_modpath("3d_armor") then
  armor:register_armor("amber:helmet_amber", {
  		description = "Amber Helmet",
  		inventory_image = "amber_inv_helmet_amber.png",
  		groups = {armor_head=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.005, physics_gravity=0.005},
  		armor_groups = {fleshy=10},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:chestplate_amber", {
  		description = "Amber Chestplate",
  		inventory_image = "amber_inv_chestplate_amber.png",
  		groups = {armor_torso=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.02, physics_gravity=0.02},
  		armor_groups = {fleshy=15},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:leggings_amber", {
  		description = "Amber Leggings",
  		inventory_image = "amber_inv_leggings_amber.png",
  		groups = {armor_legs=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.015, physics_gravity=0.015},
  		armor_groups = {fleshy=15},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:boots_amber", {
  		description = "Amber Boots",
  		inventory_image = "amber_inv_boots_amber.png",
  		groups = {armor_feet=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.005, physics_gravity=0.005},
  		armor_groups = {fleshy=10},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  })

  armor:register_armor("amber:shield_amber", {
		description = "Amber Shield",
		inventory_image = "amber_inv_shield_amber.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=900,
			physics_speed=-0.015, physics_gravity=0.015},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_glass")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_glass")
		end,
})
end
