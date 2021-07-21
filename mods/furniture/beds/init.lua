--------------------------------------------------------
-- Minetest :: Beds Redux Mod (beds)
--
-- See README.txt for licensing and other information.
-- Copyright (c) 2016-2020, Leslie E. Krause
--
-- ./games/minetest_game/mods/beds/init.lua
--------------------------------------------------------

beds = { }

local config = minetest.load_config( {
	filename = "player_spawns.txt",
	spawn_pos = minetest.setting_get_pos( "static_spawnpoint" ) or vector.new( )
} )
local world_path = minetest.get_worldpath( )
local player_sleeping_count = 0

local player_spawns = { }
local player_states = { }

--------------------- 
-- Private Methods -- 
---------------------

local function export_spawns( )
	local data = minetest.serialize( player_spawns )
	if not data then
		error( "Could not serialize player spawn data." )
	end

	local file = io.open( world_path .. "/" .. config.filename, "w" )
	if not file then
		error( "Could not save player spawn data." )
	end
	file:write( data )
	file:close( ) 
end

local function import_spawns( )
	local file = io.open( world_path .. "/" .. config.filename, "r" )
	if not file then
		export_spawns( )
		file = io.open( world_path .. "/" .. config.filename, "r" )
		if not file then
			error("Could not load player spawn data.")
		end
	end

	local data = file:read( "*all" )
	if data == "" then
		player_spawns = { }   -- initialize if empty file
	else
		player_spawns = minetest.deserialize( data )
		if type( player_spawns ) ~= "table" then
			error( "Could not deserialize player spawn data." )
		end
	end
	file:close( )
end

local function set_spawn( name, pos )
	player_spawns[ name ] = pos 
end

local function unset_spawn( name )
	player_spawns[ name ] = nil 
end

local function is_spawn_at( spawn_pos, name )
	return player_spawns[ name ] and vector.equals( player_spawns[ name ], spawn_pos ) 
end

local function unset_spawn_at( spawn_pos )
	for name, pos in pairs( player_spawns ) do
		if vector.equals( pos, spawn_pos ) then
			player_spawns[ name ] = nil
		end
	end 
end

local function open_sleep_viewer( name, pos )
	local node = minetest.get_node( pos )
	local ndef = minetest.registered_nodes[ node.name ]
	local snooze_seq = 0
	local star_list = { }

	if not ndef.transforms then return end  -- quick sanity check

	for i = 1, 8 do
		-- above moon
		table.insert( star_list, { x = math.random( 0, 11 ) + 0.5, y = math.random( 0, 4 ) + 0.5 } )
	end
	for i = 1, 4 do
		-- left of moon
		table.insert( star_list, { x = math.random( 0, 3 ) + 0.5, y = math.random( 5, 8 ) + 0.5 } )
	end
	for i = 1, 4 do
		-- right of moon
		table.insert( star_list, { x = math.random( 8, 11 ) + 0.5, y = math.random( 5, 8 ) + 0.5 } )
	end

	local function get_random_alpha( )
		return math.random( 0, 9 ) * 11
	end

	local function get_formspec( )
		local player_count = #minetest.get_connected_players( )
		local formspec = "size[12,15;true]" ..
			"no_prepend[]" ..
			"bgcolor[#080808BB;true]" ..
			"image[4.5,5.5;4.0,3.8;beds_sleeping.png]" ..
			"button_exit[3.0,12.0;2.5,0.7;leave;Wake Up]" ..
			string.format( "button[6.5,12.0;2.5,0.7;%s]",
				is_spawn_at( pos, name ) and "unset_home;Unset Home" or "set_home;Set Home"
			) ..

			string.format( "label[3.8,11.0;%d of %d players are currently sleeping]", player_sleeping_count, player_count )

		if player_sleeping_count >= player_count / 2 then
			formspec = formspec ..
				"button_exit[4.0,10.0;4.0,0.7;skip_night;Skip Night]"
		end

		for i, v in ipairs( star_list ) do
			formspec = formspec ..
				string.format( "image[%0.1f,%0.1f;0.3,0.3;beds_star.png^[colorize:#000000%02d]",
					v.x, v.y, get_random_alpha( )
				)
		end

		for i = 0, 2 do
			formspec = formspec ..
				string.format( "image[%0.1f,%0.1f;%0.1f,%0.1f;beds_snooze.png^[colorize:#000000%02d]",
					6.5 + i / 2, 5.5 - i / 2, 0.5 - i / 10, 0.5 - i / 10, snooze_seq % 3 == i and 22 or 99
				)
		end

		snooze_seq = snooze_seq + 1

		return formspec
	end

	local function on_close( state, player, fields )
		if fields.quit == minetest.FORMSPEC_SIGEXIT then
			beds.stand_up( name )
		elseif fields.quit == minetest.FORMSPEC_SIGTIME then
			if beds.to_daypart( ).half == "nighttime" or config.can_always_sleep then
				minetest.update_form( name, get_formspec( ) )
			else
				minetest.destroy_form( name )
				minetest.chat_send_player( name, string.format( "Good morning, %s!", name ) )
				beds.stand_up( name )
			end
		end

		if fields.set_home then
			set_spawn( name, pos )
			minetest.chat_send_player( name, "Your assigned active spawnpoint is " ..  minetest.pos_to_string( pos ) .. "." ) 
			minetest.update_form( name, get_formspec( ) )

		elseif fields.unset_home then
			unset_spawn( name )
			minetest.chat_send_player( name, "Your assigned static spawnpoint is " ..  minetest.pos_to_string( config.spawn_pos ) .. "." ) 
			minetest.update_form( name, get_formspec( ) )

		elseif fields.skip_night then
			minetest.set_timeofday( 0.25 )
			minetest.chat_send_player( name, string.format( "Good morning, %s!", name ) )
			beds.stand_up( name )
		end
	end

	minetest.create_form( nil, name, get_formspec( ), on_close )
	minetest.get_form_timer( name ).start( 1.5 )
end

local function play_respawn_fx( pos )
	local id = minetest.add_particlespawner( {
		amount = 30,
		time = 2.0,
		minpos = vector.offset_y( pos, 1.5 ),
		maxpos = pos,
		minvel = { x = -1.0, y = 0.0, z = -1.0 },
		maxvel = { x = 1.0, y = 1.0, z = 1.0 },
		minacc = vector.origin,
		maxacc = vector.origin,
		minexptime = 0.8,
		maxexptime = 1.2,
		minsize = 2.5,
		maxsize = 2.5,
		collisiondetection = false,
		vertical = false,
		texture = "beds_particles.png",
	} )

	-- https://freesound.org/people/tim.kahn/sounds/128590/
	minetest.sound_play( "respawn_whoosh", { pos = pos, gain = 0.3, max_hear_distance = 20 } )
end

local function apply_physics_override( pos, player, override )
	player:setpos( vector.add( pos, override.pos ) )
	player:set_look_yaw( override.yaw )
	player:set_eye_offset( vector.new( 0, override.off, 0 ), vector.origin )

	player:set_physics_override( { speed = 0, jump = 0, gravity = 0 } )
	player:hud_set_flags( { wielditem = false } ) 
end

local function clear_physics_override( pos, player, base_pos )
	if base_pos then
		player:setpos( vector.add( pos, base_pos ) )
	end
	player:set_eye_offset( vector.origin, vector.origin )

	player:set_physics_override( { speed = 1, jump = 1, gravity = 1 } )
	player:hud_set_flags( { wielditem = true } ) 
end

-------------------- 
-- Public Methods -- 
--------------------

beds.sit_down = function ( name, pos )
	if player_states[ name ] or default.player_attached[ name ] then return end

	local player = minetest.get_player_by_name( name )
	local node = minetest.get_node( pos )
	local transforms = minetest.registered_nodes[ node.name ].transforms

	if not transforms or not transforms.sitting then return end   -- quick sanity check for properties

	-- prevent the player from sitting on air
	apply_physics_override( pos, player, transforms.sitting[ node.param2 ] or transforms.sitting[ 1 ] )

	default.player_set_animation( player, "sit", 30 )
	default.player_attached[ name ] = true

	player_states[ name ] = { type = "sit", pos = pos, obj = player } 
end

beds.lay_down = function ( name, pos )
	if player_states[ name ] or default.player_attached[ name ] then return end

	local player = minetest.get_player_by_name( name )
	local node = minetest.get_node( pos )
	local transforms = minetest.registered_nodes[ node.name ].transforms

	if not transforms or not transforms.laying then return end   -- quick sanity check for properties

	-- prevent the player from sitting on air
	apply_physics_override( pos, player, transforms.laying[ node.param2 ] or transforms.laying[ 1 ] )

	default.player_set_animation( player, "lay", 0 )
	default.player_attached[ name ] = true

	player_sleeping_count = player_sleeping_count + 1
	player_states[ name ] = { type = "lay", pos = pos, obj = player }
end

beds.stand_up = function ( name, is_kick )
	if not player_states[ name ] then return end

	local player = minetest.get_player_by_name( name )
	local pos = player_states[ name ].pos
	local node = minetest.get_node( pos )
	local ndef = minetest.registered_nodes[ node.name ]

	clear_physics_override( pos, player, 
		player:get_hp( ) > 0 and ndef.base_spawn_pos or ndef.base_death_pos )

	if not is_kick then
		default.player_set_animation( player, "stand", 30 )
		default.player_attached[ name ] = false
	end

	if player_states[ name ].type == "lay" then
		player_sleeping_count = player_sleeping_count - 1
	end
	player_states[ name ] = nil
end

beds.to_daypart = function ( time )
	-- by half:
	-- * 6am - 6pm (daytime)
	-- * 6pm - 6am (nighttime)
	-- by quarter:
	-- * 6am - noon (morning)
	-- * noon - 6pm (afternoon)
	-- * 6pm - midnight (evening)
	-- * midnight - 6am (overnight)
	local quarter, half

	if time == nil then time = minetest.get_timeofday( ) end

	if time < 0.25 then
		quarter = "overnight"
	elseif time < 0.5 then
		quarter = "morning"
	elseif time < 0.75 then
		quarter = "afternoon"
	else
		quarter = "evening"
	end

	if time < 0.25 or time > 0.75 then
		half = "nighttime"
	else
		half = "daytime"
	end

	return { quarter = quarter, half = half } 
end

beds.is_occupied = function ( pos )
	for name, data in pairs( player_states ) do
		if vector.equals( data.pos, pos ) then
			return true
		end
	end
	return false
end

beds.get_spawn_pos = function ( name )
	return player_spawns[ name ] or config.spawn_pos
end

-------------------------- 
-- Registered Callbacks -- 
--------------------------

local on_respawnplayer = core.registered_on_respawnplayers[ 1 ]  -- hack to override builtin respawn callback

core.registered_on_respawnplayers[ 1 ] = function ( player )
	local name = player:get_player_name( )
	local pos = player:getpos( )
	local spawn_pos = player_spawns[ name ]

	if not spawn_pos then
		-- send player to static spawnpoint if no assigned bed
		return on_respawnplayer( player )
	end
	
	-- force load the relevant mapblock
	VoxelManip( ):read_from_map( spawn_pos, spawn_pos )
	
	local node = minetest.get_node( spawn_pos )
	local base_spawn_pos = minetest.registered_nodes[ node.name ].base_spawn_pos

	if not base_spawn_pos then
		-- send player to static spawnpoint if bed is missing
		minetest.log( "error", "Missing bed at " .. minetest.pos_to_string( spawn_pos ) .. ", found " .. node.name .. " instead" )
		return on_respawnplayer( player )
	end

	minetest.log( "action", "Moving " .. name .. " from " .. minetest.pos_to_string( pos ) .. " to active spawnpoint" )
	player:setpos( vector.add( spawn_pos, base_spawn_pos ) )
	play_respawn_fx( spawn_pos )

	return true
end

minetest.register_on_dieplayer( function ( player )
	local name = player:get_player_name( )

	beds.stand_up( name )
end )

minetest.register_on_leaveplayer( function ( player )
	local name = player:get_player_name( )

	beds.stand_up( name, true ) 
end )

minetest.register_on_shutdown( function( )
	export_spawns( )
end )

------------------------------ 
-- Registered Chat Commands -- 
------------------------------

core.register_chatcommand( "home", {
	description = "Show the coordinates of your assigned spawnpoint",
	func = function( name )
		local pos = player_spawns[ name ] or config.spawn_pos

		return true, "Your assigned " .. ( player_spawns[ name ] and "active" or "static" ) .. " spawnpoint is " .. minetest.pos_to_string( pos ) .. "."
	end,
} )

-------------------------
-- Register Globalstep --
-------------------------

minetest.register_globalstep( function( dtime )
	if not next( player_states ) then return end

	for name, state in pairs( player_states ) do
		local controls = state.obj:get_player_control( )
		if controls.sneak or controls.up or controls.down or controls.left or controls.right then
			beds.stand_up( name )
		end
	end
end )

------------------------- 
-- Registration Helper -- 
-------------------------

function beds.register_bed( name, def )
	minetest.register_node( name .. "_bottom", {
		description = def.description,
		inventory_image = def.inventory_image,
		wield_image = def.wield_image,
		drawtype = "nodebox",
		tiles = def.tiles.bottom,
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		override_sneak = true,

		groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 1 },
		sounds = default.node_sound_wood_defaults( ),

		node_box = {
			type = "fixed",
			fixed = def.nodebox.bottom,
		},
		selection_box = {
			type = "fixed",
			fixed = def.selectionbox,
		},

		base_spawn_pos = def.base_spawn_pos,
		transforms = def.transforms,

		can_dig = function( pos, player )
			if beds.is_occupied( pos ) then
				minetest.chat_send_player( player:get_player_name( ), "This bed is currently occupied." )
				return false
			end
			return true
		end,
		after_place_node = function( pos )
			local node = minetest.get_node_or_nil( pos )

			if node then
				local dir = minetest.facedir_to_dir( node.param2 )
				local top_pos = vector.offset( pos, dir.x, 0, dir.z )
				local top_node = minetest.get_node( top_pos )
				local top_def = minetest.registered_items[ top_node.name ]

				if top_def and top_def.buildable_to then
					minetest.set_node( top_pos, {
						name = string.gsub( node.name, "_bottom$", "_top" ),
						param2 = node.param2
					} )
					return false
				end
			end

			minetest.remove_node( pos )
			return true
		end,
		after_dig_node = function( pos, old_node, old_meta, player )
			local dir = minetest.facedir_to_dir( old_node.param2 )
			local top_pos = vector.offset( pos, dir.x, 0, dir.z )
			local top_node = minetest.get_node( top_pos )
			local name = player:get_player_name( )

			if minetest.get_item_group( top_node.name, "bed" ) == 2 and old_node.param2 == top_node.param2 then
				minetest.remove_node( top_pos )
			end

			if is_spawn_at( pos, name ) then
				minetest.chat_send_player( name, "Your assigned static spawnpoint is " ..  minetest.pos_to_string( config.spawn_pos ) .. "." ) 
			end
			unset_spawn_at( pos )
		end,
		on_rightclick = function( pos, node, player )
			local name = player:get_player_name( )

			if player:get_player_control( ).sneak then
				-- holding sneak updates the spawnpoint
				if not is_spawn_at( pos, name ) then
					minetest.chat_send_player( name, "Your assigned active spawnpoint is " ..  minetest.pos_to_string( pos ) .. "." )
					set_spawn( name, pos )
				else
					minetest.chat_send_player( name, "Your assigned static spawnpoint is " ..  minetest.pos_to_string( config.spawn_pos ) .. "." ) 
					unset_spawn( name )
				end

			elseif vector.equals( player:get_player_velocity( ), vector.origin ) then
				-- only lay down if player is motionless and bed is unoccupied
				if beds.is_occupied( pos ) then
					minetest.chat_send_player( name, "This bed is already occupied." )

				elseif vector.distance( pos, player:getpos( ) ) > config.max_action_range then
					minetest.chat_send_player( name, "This bed is too far away." )

				elseif beds.to_daypart( ).half == "nighttime" or config.can_always_sleep then
					beds.lay_down( name, pos )
					open_sleep_viewer( name, pos )
				else
					beds.sit_down( name, pos )
				end
			end
		end,
		on_blast = function ( pos ) end,
	} )

	minetest.register_node( name .. "_top", {
		drawtype = "nodebox",
		tiles = def.tiles.top,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = { snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, bed = 2 },
		sounds = default.node_sound_wood_defaults( ),
		node_box = {
			type = "fixed",
			fixed = def.nodebox.top,
		},
		selection_box = {
			type = "fixed",
			fixed = { 0, 0, 0, 0, 0, 0 },
		},

		on_blast = function ( pos ) end   -- not affected by explosions
	} )

	minetest.register_alias( name, name .. "_bottom" )

	-- register recipe
	minetest.register_craft( {
		output = name,
		recipe = def.recipe
	} )
end

beds.register_bed( "beds:fancy_bed", {
	description = "Fancy Bed",
	inventory_image = "beds_bed_fancy.png",
	wield_image = "beds_bed_fancy.png",

	tiles = {
		bottom = {
			"beds_bed_top1.png",
			"default_wood.png",
			"beds_bed_side1.png",
			"beds_bed_side1.png^[transformFX",
			"default_wood.png",
			"beds_bed_foot.png",
		},
		top = {
			"beds_bed_top2.png",
			"default_wood.png",
			"beds_bed_side2.png",
			"beds_bed_side2.png^[transformFX",
			"beds_bed_head.png",
			"default_wood.png",
		}
	},
	nodebox = {
		bottom = {
			{ -0.5, -0.5, -0.5, -0.375, -0.065, -0.4375 },
			{ 0.375, -0.5, -0.5, 0.5, -0.065, -0.4375 },
			{ -0.5, -0.375, -0.5, 0.5, -0.125, -0.4375 },
			{ -0.5, -0.375, -0.5, -0.4375, -0.125, 0.5 },
			{ 0.4375, -0.375, -0.5, 0.5, -0.125, 0.5 },
			{ -0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5 },
		},
	  	top = {
			{ -0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5 },
			{ 0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5 },
			{ -0.5, 0, 0.4375, 0.5, 0.125, 0.5 },
			{ -0.5, -0.375, 0.4375, 0.5, -0.125, 0.5 },
			{ -0.5, -0.375, -0.5, -0.4375, -0.125, 0.5 },
			{ 0.4375, -0.375, -0.5, 0.5, -0.125, 0.5 },
			{ -0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375 },
		}
	},
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.06, 1.5 },

	base_spawn_pos = { x = 0, y = -0.5, z = 0 },
	transforms = {
		sitting = {
			[0] = { yaw = 3.15, pos = { x = 0, y = 0, z = 0 }, off = -7 },
			[1] = { yaw = 7.9, pos = { x = 0, y = 0, z = 0 }, off = -7 },
			[2] = { yaw = 6.28, pos = { x = 0, y = 0, z = 0 }, off = -7 },
			[3] = { yaw = 4.75, pos = { x = 0, y = 0, z = 0 }, off = -7 },
		},
		laying = {
			[0] = { yaw = 3.15, pos = { x = 0, y = 0, z = 0.5 }, off = -13 },
			[1] = { yaw = 7.9, pos = { x = 0.5, y = 0, z = 0 }, off = -13 },
			[2] = { yaw = 6.28, pos = { x = 0, y = 0, z = -0.5 }, off = -13 },
			[3] = { yaw = 4.75, pos = { x = -0.5, y = 0, z = 0 }, off = -13 },
		}
	},

	recipe = {
		{ "group:wool", "group:wool", "group:stick" },
		{ "group:wood", "group:wood", "group:wood" },
	},
} )

beds.register_bed( "beds:bed", {
	description = "Simple Bed",
	inventory_image = "beds_bed.png",
	wield_image = "beds_bed.png",

	tiles = {
		bottom = {
			"beds_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_bed_side_bottom_r.png",
			"beds_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_bed_side_bottom.png"
		},
		top = {
			"beds_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_bed_side_top_r.png",
			"beds_bed_side_top_r.png^[transformfx",
			"beds_bed_side_top.png",
			"beds_transparent.png",
		 }
	},
	nodebox = {
		bottom = { -0.5, -0.5, -0.5, 0.5, 0.06, 0.5 },
		top = { -0.5, -0.5, -0.5, 0.5, 0.06, 0.5 },
	},
	selectionbox = { -0.5, -0.5, -0.5, 0.5, 0.06, 1.5 },

	base_spawn_pos = { x = 0, y = -0.5, z = 0 },  -- respawn inside bed to account for low clearances
	transforms = {
		sitting = {
			[0] = { yaw = 3.15, pos = { x = 0, y = 0.1, z = 0 }, off = -7 },
			[1] = { yaw = 7.9, pos = { x = 0, y = 0.1, z = 0 }, off = -7 },
			[2] = { yaw = 6.28, pos = { x = 0, y = 0.1, z = 0 }, off = -7 },
			[3] = { yaw = 4.75, pos = { x = 0, y = 0.1, z = 0 }, off = -7 },
		},
		laying = {
			[0] = { yaw = 3.15, pos = { x = 0, y = 0.1, z = 0.5 }, off = -13 },
			[1] = { yaw = 7.9, pos = { x = 0.5, y = 0.1, z = 0 }, off = -13 },
			[2] = { yaw = 6.28, pos = { x = 0, y = 0.1, z = -0.5 }, off = -13 },
			[3] = { yaw = 4.75, pos = { x = -0.5, y = 0.1, z = 0 }, off = -13 },
		}
	},

	recipe = {
		{ "group:wool", "group:wool", "group:wool" },
		{ "group:wood", "group:wood", "group:wood" }
	},
} )

-------------------

import_spawns( )

-- compatibility for Minetest S3 engine

if minetest.get_modpath( "spawn" ) then
	minetest.log( "warning", "Spawn mod can override the functionality of Beds Redux" )
end

if not vector.offset or not vector.offset_y or not vector.origin then
        dofile( minetest.get_modpath( "beds" ) .. "/compatibility.lua" )
end
