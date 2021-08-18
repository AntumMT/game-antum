
--- Server Shops Nodes
--
--  @topic nodes


local ss = server_shop
local S = core.get_translator(ss.modname)


local node_sound
if core.global_exists("sounds") then
	node_sound = sounds.node_stone()
end

local def = {
	base = {
		description = S("Shop"),
		groups = {oddly_breakable_by_hand=1},
		paramtype2 = "facedir",
		sounds = node_sound,
		after_place_node = function(pos, placer)
			-- set node owner
			core.get_meta(pos):set_string("owner", placer:get_player_name())
		end,
		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			local pmeta = player:get_meta()

			-- store node pos in player meta for retrieval in callbacks
			pmeta:set_string(ss.modname .. ":pos", core.serialize(pos))
			-- store selected index in player meta for retrieval in callbacks
			pmeta:set_int(ss.modname .. ":selected", 1)

			ss.show_formspec(pos, player)
		end,
		can_dig = function(pos, player)
			return ss.is_shop_owner(pos, player) or ss.is_shop_admin(player)
		end,
	},

	--- Small Shop Node
	--
	--  @node server_shop:shop_small
	small = {
		drawtype = "normal",
		tiles = {
			"server_shop_side.png",
			"server_shop_side.png",
			"server_shop_side.png",
			"server_shop_side.png",
			"server_shop_side.png",
			"server_shop_front.png",
			"server_shop_side.png",
		},
	},

	--- Large Shop Node
	--
	--  @node server_shop:shop_large
	--  @img server_shop_front.png
	large = {
		drawtype = "mesh",
		mesh = "node_1x2x1.obj",
		tiles = {"server_shop_mesh.png",},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
	},
}

--[[ FIXME: nodes are rotated when colored
if core.get_modpath("unifieddyes") then
	def.base.groups.ud_param2_colorable = 1
	def.base.paramtype2 = "colorfacedir"
	def.base.palette = "unifieddyes_palette_extended.png"
	def.base.on_dig = unifieddyes.on_dig
end
]]

for _, size in ipairs({"small", "large"}) do
	local full_def = table.copy(def.base)
	for k, v in pairs(def[size]) do
		full_def[k] = v
	end

	core.register_node(ss.modname..":shop_"..size, full_def)
end

core.register_alias(ss.modname..":shop", ss.modname..":shop_small")
core.register_alias(ss.modname..":sell", ss.modname..":shop_small")
core.register_alias(ss.modname..":buy", ss.modname..":shop_small")
