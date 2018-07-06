-- Armors --
armor:register_armor("amber:helmet", {
  		description = "Amber Helmet",
  		inventory_image = "amber_inv_helmet_amber.png",
  		groups = {armor_head=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.005, physics_gravity=0.005},
  		armor_groups = {fleshy=10},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:chestplate", {
  		description = "Amber Chestplate",
  		inventory_image = "amber_inv_chestplate_amber.png",
  		groups = {armor_torso=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.02, physics_gravity=0.02},
  		armor_groups = {fleshy=15},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:leggings", {
  		description = "Amber Leggings",
  		inventory_image = "amber_inv_leggings_amber.png",
  		groups = {armor_legs=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.015, physics_gravity=0.015},
  		armor_groups = {fleshy=15},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  	})
  	armor:register_armor("amber:boots", {
  		description = "Amber Boots",
  		inventory_image = "amber_inv_boots_amber.png",
  		groups = {armor_feet=1, armor_heal=0, armor_use=900,
  			physics_speed=-0.005, physics_gravity=0.005},
  		armor_groups = {fleshy=10},
  		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
  })

  armor:register_armor("amber:shield", {
		description = "Amber Shield",
		inventory_image = "amber_inv_shield_amber.png",
		groups = {armor_shield=1, armor_heal=0, armor_use=900,
			physics_speed=-0.015, physics_gravity=0.015},
		armor_groups = {fleshy=10},
		damage_groups = {cracky=2, snappy=3, choppy=2, crumbly=1, level=2},
		reciprocate_damage = true
})

-- Ancient Armors --
anch_armor = "006699"
armor:register_armor("amber:helmet_ancient", {
  		description = "Ancient Amber Helmet",
  		inventory_image = "amber_inv_helmet_amber.png^(amber_outline_helmet.png^[colorize:#" .. anch_armor .. ")",
  		groups = {armor_head=1, armor_heal=14, armor_use=100},
  		armor_groups = {fleshy=20},
  		damage_groups = {cracky=1, snappy=1, choppy=1, crumbly=1, level=3},
  	})
  	armor:register_armor("amber:chestplate_ancient", {
  		description = "Ancient Amber Chestplate",
  		inventory_image = "amber_inv_chestplate_amber.png^(amber_outline_chest.png^[colorize:#" .. anch_armor .. ")",
  		groups = {armor_torso=1, armor_heal=14, armor_use=100},
  		armor_groups = {fleshy=25},
  		damage_groups = {cracky=1, snappy=1, choppy=1, crumbly=1, level=3},
  	})
  	armor:register_armor("amber:leggings_ancient", {
  		description = "Ancient Amber Leggings",
  		inventory_image = "amber_inv_leggings_amber.png^(amber_outline_leggings.png^[colorize:#" .. anch_armor .. ")",
  		groups = {armor_legs=1, armor_heal=14, armor_use=100},
  		armor_groups = {fleshy=25},
  		damage_groups = {cracky=1, snappy=1, choppy=1, crumbly=1, level=3},
  	})
  	armor:register_armor("amber:boots_ancient", {
  		description = "Ancient Amber Boots",
  		inventory_image = "amber_inv_boots_amber.png^(amber_outline_boots.png^[colorize:#" .. anch_armor .. ")",
  		groups = {armor_feet=1, armor_heal=14, armor_use=100},
  		armor_groups = {fleshy=20},
  		damage_groups = {cracky=1, snappy=1, choppy=1, crumbly=1, level=3},
  })

  armor:register_armor("amber:shield_ancient", {
		description = "Ancient Amber Shield",
		inventory_image = "amber_inv_shield_amber.png^(amber_outline_shield.png^[colorize:#" .. anch_armor .. ")",
		groups = {armor_shield=1, armor_heal=14, armor_use=100},
		armor_groups = {fleshy=20},
		damage_groups = {cracky=1, snappy=1, choppy=1, crumbly=1, level=3},
		reciprocate_damage = true,
		on_damage = function(player, index, stack)
			play_sound_effect(player, "default_dig_glass")
		end,
		on_destroy = function(player, index, stack)
			play_sound_effect(player, "default_dug_glass")
		end,
})
