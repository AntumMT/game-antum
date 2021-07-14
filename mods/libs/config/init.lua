--------------------------------------------------------
-- Minetest :: Configuration Panel Mod (config)
--
-- See README.txt for licensing and other information.
-- Copyright (c) 2016-2020, Leslie E. Krause
--
-- ./games/minetest_game/mods/config/init.lua
--------------------------------------------------------

local env = minetest.request_insecure_environment( )
local world_path =  minetest.get_worldpath( )
local configured_mods = { }

---------------------
-- Private Methods --
---------------------

local function import( config, filename )
	local func = loadfile( filename )
	if func then
		setfenv( func, config )
		local status = pcall( func )
		if not status then
			error( "Error in configuration file: " .. filename )
		end
		return true
	end
	return false
end

local function load_world_config( mod_name )
	local file = env.io.open( world_path .. "/config/" .. mod_name .. ".lua", "r" )
	if not file then return nil end

	local data = file:read( "*all" )
	file:close( )
	return data
end

local function load_game_config( mod_name )
	local file = env.io.open( minetest.get_modpath( mod_name ) .. "/config.lua", "r" )
	if not file then return nil end

	local data = file:read( "*all" )
	file:close( )
	return data
end

local function save_world_config( mod_name, data )
	local file = env.io.open( world_path .. "/config/" .. mod_name .. ".lua", "w" )
	if not file then return false end

	file:write( data )
	file:close( )
	return true
end

local function save_game_config( mod_name, data )
	local file = env.io.open( minetest.get_modpath( mod_name ) .. "/config.lua", "w" )
	if not file then return false end

	file:write( data )
	file:close( )
	return true
end

local function create_world_config( mod_name )
	local file = env.io.open( world_path .. "/config/" .. mod_name .. ".lua", "w" )
	if not file then return false end

	file:close( )
	return true
end

local function create_game_config( mod_name )
	local file = env.io.open( minetest.get_modpath( mod_name ) .. "/config.lua", "w" )
	if not file  then return false end

	file:close( )
	return true
end

local function delete_world_config( mod_name )
	return env.os.remove( world_path .. "/config/" .. mod_name .. ".lua" ) ~= nil
end

local function delete_game_config( mod_name )
	return env.os.remove( minetest.get_modpath( mod_name ) .. "/config.lua" ) ~= nil
end

local function open_config_editor( player_name, mod_name )
	local origin_idx
	local content
	local delete_config, create_config, load_config, save_config

	local function reset_origin_map( idx )
		origin_idx = idx

		if origin_idx == 1 then
			delete_config = delete_game_config
			create_config = create_game_config
			load_config = load_game_config
			save_config = save_game_config
		else
			delete_config = delete_world_config
			create_config = create_world_config
			load_config = load_world_config
			save_config = save_world_config
		end
	end

	local function get_formspec( )
		local formspec =
			"size[10.0,8.5]" ..
			default.gui_bg ..
			default.gui_bg_img ..

			string.format( "label[0.0,0.1;Configuration for mod '%s']", mod_name ) ..
			"label[2.2,8.0;Origin:]" ..
		       	string.format( "dropdown[3.1,7.9;2.6,1.0;origin;Game Config,World Config;%d;true]", origin_idx )

		if not content then
			formspec = formspec ..
				"box[0.0,0.8;9.8.0,6.6;#222222]" ..
				"label[4.0,3.8;File does not exist.]" ..

				"button_exit[0.0,7.8;2.0,1.0;close;Close]" ..
				"button[8.0,7.8;2.0,1.0;create;Create]"
		else
			formspec = formspec ..
				"textarea[0.3,0.8;10.0,7.6;content;;" .. minetest.formspec_escape( content ) .. "]" ..
			
				"button_exit[0.0,7.8;2.0,1.0;close;Close]" ..
				"button[6.0,7.8;2.0,1.0;delete;Delete]" ..
				"button[8.0,7.8;2.0,1.0;save;Save]"
		end

		return formspec
	end

	local function on_close( state, player, fields )
		if fields.quit then return end   -- short-circuit on form closure

		if fields.save then
			content = fields.content
			save_config( mod_name, content )

		elseif fields.load then
			content = load_config( mod_name )
			minetest.update_form( player_name, get_formspec ( ) )

		elseif fields.delete then
			if not delete_config( mod_name ) then
				minetest.destroy_form( player_name )
				minetest.chat_send_player( player_name, "Unable to delete configuration file." )
			end
			content = nil
			minetest.update_form( player_name, get_formspec ( ) )

		elseif fields.create then
			if not create_config( mod_name ) then
				minetest.destroy_form( player_name )
				minetest.chat_send_player( player_name, "Unable to create configuration file." )
			end
			content = ""
			minetest.update_form( player_name, get_formspec ( ) )

		elseif fields.origin then
			reset_origin_map( fields.origin )
			content = load_config( mod_name )
			minetest.update_form( player_name, get_formspec ( ) )

		end
	end

	reset_origin_map( 1 )
	content = load_config( mod_name )

	minetest.create_form( nil, player_name, get_formspec( ), on_close )
end

--------------------
-- Public Methods --
--------------------

minetest.load_config = function ( base_config, options )
	local name = minetest.get_current_modname( )
	local path = minetest.get_modpath( name )
	local config = base_config or { }
	local status

	if not options then options = { } end
	
	config.core = {
		MOD_NAME = name,
		MOD_PATH = path,
		WORLD_PATH = world_path,
		tonumber = tonumber,
		tostring = tostring,
		sprintf = string.format,
		tolower = string.lower,
		toupper = string.upper,
		concat = table.concat,
		random = math.random,
		max = math.max,
		min = math.min,
		print = print,
		next = next,
		pairs = pairs,
		ipairs = ipairs,
		date = os.date,
		time = os.time,
		assert = assert,
		error = error,
	}

	if options.can_override then
		status = import( config, path .. "/config.lua" )
		status = import( config, world_path .. "/config/" .. name .. ".lua" ) or status
	else
		status = import( config, path .. "/config.lua" ) or import( config, world_path .. "/config/" .. name .. ".lua" )
	end

	if not status then
		minetest.log( "warning", "Missing configuration file for mod \"" .. name .. "\"" )
	end

	configured_mods[ name ] = {
		base_config = base_config,
		can_refresh = options.can_refresh,
		can_override = options.can_override,
	}
	config.core = nil

	return config
end

------------------------------
-- Registered Chat Commands --
------------------------------

minetest.register_chatcommand( "config", {
	description = "View and edit the configuration for a given mod.",
	privs = { server = true },
	func = function( player_name, param )
		if not env then
			return false, "This feature is disabled in a secure environment."
		elseif not minetest.create_form then
			return false, "This feature is not supported."
		end

		if not string.match( param, "^[a-zA-Z0-9_]+$" ) then
			return false, "Invalid mod name." 
		elseif not configured_mods[ param ] then
			return false, "Configuration not available."
		end

		open_config_editor( player_name, param )
		return true
	end
} )
