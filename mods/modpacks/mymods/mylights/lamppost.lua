

--register the bottom node box

minetest.register_node("mylights:lamppost", {
	description = "Lamp Post",
	inventory_image = "mylights_lpost_inv.png",
	weild_image = "batlpost_inv.png",
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
			{-0.25, -0.5, -0.25, 0.25, -0.1875, 0.25}, -- NodeBox2
			{-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375}, -- NodeBox3
		}
	},
--once placed it sets the middle and top nodes
	after_place_node = function(pos)
		minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z},{name = "mylights:lpost_top"})
		minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z},{name = "mylights:lantern_p"})
	end,
--when you dig this removes the 2 nodes above
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "mylights:lpost_top" then
			minetest.remove_node(pos2)
		end
		local pos3 = { x = pos.x, y=pos.y + 2, z = pos.z }
		if minetest.get_node(pos3).name == "mylights:lantern_p" then
			minetest.remove_node(pos3)
		end
	end,

--this checks to make sure there is enough space above to place it. without this any blocks above would be replaced
    on_place = function(itemstack, placer, pointed_thing)
        local pos = pointed_thing.above
        if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" and
           minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name ~= "air" then
            minetest.chat_send_player( placer:get_player_name(), "Not enough vertical space to place a server!" )
            return
        end
        return minetest.item_place(itemstack, placer, pointed_thing)
    end
})

--register the middle node
minetest.register_node("mylights:lpost_top", {
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanterntb.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}, -- NodeBox1
		}
	},

-- after dig this removes the node above and below
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y = pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "mylights:lantern_p" then
			minetest.remove_node(pos2)
		end
		local pos3 = { x = pos.x, y = pos.y - 1, z = pos.z }
		if minetest.get_node(pos3).name == "mylights:lpost" then
			minetest.remove_node(pos3)
		end
	end,
})
--Lantern

minetest.register_node("mylights:lantern_p", {
	tiles = {
		"mylights_lanterntb.png",
		"mylights_lanterntb.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png",
		"mylights_lanternside.png"
	},
	sunlight_propagates = true,
	walkable = true,
	light_source = 14,
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.4375, -0.3125, 0.3125, -0.3125, 0.3125}, -- NodeBox1
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, -0.1875, 0.375, -0.1875}, -- NodeBox3
			{-0.3125, -0.375, 0.1875, -0.1875, 0.375, 0.3125}, -- NodeBox4
			{0.1875, -0.375, 0.1875, 0.3125, 0.375, 0.3125}, -- NodeBox5
			{0.1875, -0.375, -0.3125, 0.3125, 0.375, -0.1875}, -- NodeBox6
			{-0.4375, 0.375, -0.4375, 0.4375, 0.1875, 0.4375}, -- NodeBox7
		}
	},

--after dig this removes the 2 nodes below
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y - 1, z = pos.z }
		if minetest.get_node(pos2).name == "mylights:lpost_top" then
			minetest.remove_node(pos2)
		end
		local pos3 = { x = pos.x, y=pos.y - 2, z = pos.z }
		if minetest.get_node(pos3).name == "mylights:lpost" then
			minetest.remove_node(pos3)
		end
	end,
})

--craft
minetest.register_craft({
		output = "mylights:lpost 1",
		recipe = {
			{'','mylights:lantern_120',''},
			{'','default:fence_wood','dye:black'},
			{'','default:fence_wood','dye:black'}
			}
	})
