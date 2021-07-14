--------------------------------------------------------
-- Minetest :: ActiveFormspecs Mod v2.6 (formspecs)
--
-- See README.txt for licensing and release notes.
-- Copyright (c) 2016-2019, Leslie Ellen Krause
--
-- ./games/just_test_tribute/mods/formspecs/init.lua
--------------------------------------------------------

print( "Loading ActiveFormspecs Mod" )

minetest.FORMSPEC_SIGEXIT = "true"	-- player clicked exit button or pressed esc key (boolean for backward compatibility)
minetest.FORMSPEC_SIGQUIT = 1		-- player logged off
minetest.FORMSPEC_SIGKILL = 2		-- player was killed
minetest.FORMSPEC_SIGTERM = 3		-- server is shutting down
minetest.FORMSPEC_SIGPROC = 4		-- procedural closure
minetest.FORMSPEC_SIGTIME = 5		-- timeout reached
minetest.FORMSPEC_SIGSTOP = 6		-- procedural closure (cannot be trapped)
minetest.FORMSPEC_SIGHOLD = 7		-- child form opened, parent is suspended
minetest.FORMSPEC_SIGCONT = 8		-- child form closed, parent can continue

local afs = { }		-- obtain localized, protected namespace

afs.forms = { }
afs.timers = { }
afs.session_id = 0
afs.session_seed = math.random( 0, 65535 )

afs.stats = { active = 0, opened = 0, closed = 0 }

afs.stats.on_open = function ( self )
	self.active = self.active + 1
	self.opened = self.opened + 1
end

afs.stats.on_close = function ( self )
	self.active = self.active - 1
	self.closed = self.closed + 1
end

-----------------------------------------------------------------
-- trigger callbacks at set intervals within timer queue
-----------------------------------------------------------------

do
	-- localize needed object references for efficiency
	local get_us_time = minetest.get_us_time
	local timers = afs.timers
	local t_cur = get_us_time( )
	local t_off = -t_cur

	-- step monotonic clock with graceful 32-bit overflow
	local step_clock = function( )
		local t_new = get_us_time( )

		if t_new < t_cur then
			t_off = t_off + 4294967290
		end

		t_cur = t_new
		return t_off + t_new
	end
	afs.get_uptime = function( )
		return ( t_off + t_cur ) / 1000000
	end

	minetest.register_globalstep( function( dtime )
--local x = get_us_time( )
		local curtime = step_clock( ) / 1000000
		local idx = #timers

		-- iterate through table in reverse order to allow removal
		while idx > 0 do
			local self = timers[ idx ]

			if curtime >= self.exptime then
				self.counter = self.counter + 1
				self.overrun = curtime - self.exptime
				self.exptime = curtime + self.form.timeout

				self.form.newtime = math.floor( curtime )
				self.form.on_close( self.form.meta, self.form.player, { quit = minetest.FORMSPEC_SIGTIME } )

				self.overrun = 0.0
      		        	end
			idx = idx - 1
        	end
	end )
end

-----------------------------------------------------------------
-- override node registrations for attached formspecs
-----------------------------------------------------------------

local on_rightclick = function( pos, node, player )
	local nodedef = minetest.registered_nodes[ node.name ]
	local meta = nodedef.before_open and nodedef.before_open( pos, node, player ) or pos
	local formspec = nodedef.on_open( meta, player )

	if formspec then
		local player_name = player:get_player_name( )
		minetest.create_form( meta, player_name, formspec, nodedef.on_close )
		afs.forms[ player_name ].origin = node.name
	end
end

local old_register_node = minetest.register_node
local old_override_item = minetest.override_item

minetest.register_node = function ( name, def )
	if def.on_open and not def.on_rightclick then
		def.on_rightclick = on_rightclick
	end
	old_register_node( name, def )
end

minetest.override_item = function ( name, def )
	if minetest.registered_nodes[ name ] and def.on_open then
		def.on_rightclick = on_rightclick
	end
	old_override_item( name, def )
end

-----------------------------------------------------------------
-- trigger callbacks during formspec events
-----------------------------------------------------------------

minetest.register_on_player_receive_fields( function( player, formname, fields )
	local player_name = player:get_player_name( )
	local form = afs.forms[ player_name ]

	-- perform a basic sanity check, since these shouldn't technically occur
	if not form or player ~= form.player or formname ~= form.name then return end

	-- handle reverse-lookups of dropdown indexes
	for name, keys in pairs( form.dropdowns ) do
		if fields[ name ] then
			fields[ name ] = keys[ fields[ name ] ]
		end
	end

	form.newtime = os.time( )
	form.on_close( form.meta, form.player, fields )

	-- end current session when closing formspec
	if fields.quit then
		minetest.get_form_timer( player_name ).stop( )

		afs.stats:on_close( )
		if form.parent_form then
			-- restore previous session
			form = form.parent_form
			afs.forms[ player_name ] = form

			-- delay a single tick to ensure formspec updates are handled by client
			minetest.after( 0.0, function ( )
				form.on_close( form.meta, form.player, { quit = minetest.FORMSPEC_SIGCONT } )
			end )
		else
			afs.forms[ player_name ] = nil
		end
	end
end )

-----------------------------------------------------------------
-- expose timer functionality within a helper object
-----------------------------------------------------------------

minetest.get_form_timer = function ( player_name, form_name )
	local self = { }
	local form = afs.forms[ player_name ]

	if not form or form_name and form_name ~= form.name then return end

	self.start = function ( timeout )
		if not form.timeout and timeout >= 0.5 then
			local curtime = afs.get_uptime( )

			form.timeout = timeout
			table.insert( afs.timers, { form = form, counter = 0, oldtime = curtime, exptime = curtime + timeout, overrun = 0.0 } )
		end
	end
	self.stop = function ( )
		if not form.timeout then return end

		form.timeout = nil

		for i, v in ipairs( afs.timers ) do
			if v.form == form then
				table.remove( afs.timers, i )
	                        return
			end
		end
	end
	self.get_state = function ( )
		if not form.timeout then return end

		for i, v in ipairs( afs.timers ) do
			local curtime = afs.get_uptime( )

			if v.form == form then
				return { elapsed = curtime - v.oldtime, remain = v.exptime - curtime, overrun = v.overrun, counter = v.counter }
			end
		end
	end

	return self
end

-----------------------------------------------------------------
-- parse specialized formspec elements and escapes codes
-----------------------------------------------------------------

local _ 
local function is_match( str, pat )
        -- use array for captures
        _ = { string.match( str, pat ) }
        return #_ > 0 and _ or nil
end

local function escape( str )
	return string.gsub( str, "\\.",
		{ ["\\]"] = "\\x5D", ["\\["] = "\\x5B", ["\\,"] = "\\x2C", ["\\;"] = "\\x3B" } )
end

local function unescape( str, is_raw )
	return string.gsub( str, "\\x..",
		{ ["\\x5D"] = "\\]", ["\\x5B"] = "\\[", ["\\x2C"] = "\\,", ["\\x3B"] = "\\;" } )
end

local function unescape_raw( str, is_raw )
	return string.gsub( str, "\\x..",
		{ ["\\x5D"] = "]", ["\\x5B"] = "[", ["\\x2C"] = ",", ["\\x3B"] = ";" } )
end

local function parse_elements( form, formspec )
	formspec = escape( formspec )
	form.dropdowns = { }	-- reset the dropdown lookup

	-- dropdown elements can optionally return the selected
        -- index rather than the value of the option itself
	formspec = string.gsub( formspec, "dropdown%[(.-)%]", function( params )
		if is_match( params, "^([^;]*;[^;]*;([^;]*);([^;]*);[^;]*);([^;]*)$" ) then
			local prefix = _[ 1 ]
			local name = _[ 2 ]
			local options = _[ 3 ]
			local use_index = _[ 4 ]

			if use_index == "true" then
				form.dropdowns[ name ] = { }
				for idx, val in ipairs( string.split( options, ",", true ) ) do
					form.dropdowns[ name ][ unescape_raw( val ) ] = idx     -- add to reverse lookup table
				end
				return string.format( "dropdown[%s]", prefix )
			elseif use_index == "false" or use_index == "" then
				return string.format( "dropdown[%s]", prefix )
			else
				return ""	-- strip invalid dropdown elements
			end
                end
		return string.format( "dropdown[%s]", params )
	end )

	-- hidden elements only provide default, initial values 
	-- for state table and are always stripped afterward
	formspec = string.gsub( formspec, "hidden%[(.-)%]", function( params )
		if is_match( params, "^([^;]*);([^;]*)$" ) or is_match( params, "^([^;]*);([^;]*);([^;]*)$" ) then
			local key = _[ 1 ]
			local value = _[ 2 ]
			local type = _[ 3 ]

			if key ~= "" and form.meta[ key ] == nil then
				-- parse according to specified data type
				if type == "string" or type == "" or type == nil then
					form.meta[ key ] = unescape_raw( value )
				elseif type == "number" then
					form.meta[ key ] = tonumber( value )
				elseif type == "boolean" then
					form.meta[ key ] = ( { ["1"] = true, ["0"] = false, ["true"] = true, ["false"] = false } )[ value ]
				end
			end
		end
		return ""       -- strip hidden elements prior to showing formspec
        end )

	return unescape( formspec )
end

-----------------------------------------------------------------
-- open detached formspec with session-based state table
-----------------------------------------------------------------

minetest.create_form = function ( meta, player_name, formspec, on_close, signal )
	-- short circuit whenever required params are missing
	if not player_name or not formspec then return end

	if type( player_name ) ~= "string" then
		player_name = player_name:get_player_name( )
	end

	local form = afs.forms[ player_name ]

	-- trigger previous callback before formspec closure
	if form then
		minetest.get_form_timer( player_name, form.name ).stop( )
		if signal ~= minetest.FORMSPEC_SIGSTOP then
			form.on_close( form.meta, form.player, { quit = signal or minetest.FORMSPEC_SIGPROC } )
		end
		if signal ~= minetest.FORMSPEC_SIGHOLD then
			form = nil
			afs.stats:on_close( )
		end
	end

	-- start new session when opening formspec
	afs.session_id = afs.session_id + 1

	form = { parent_form = form }
	form.id = afs.session_id
	form.name = minetest.get_password_hash( player_name, afs.session_seed + afs.session_id )
	form.player = minetest.get_player_by_name( player_name )
	form.origin = string.match( debug.getinfo( 2 ).source, "^@.*[/\\]mods[/\\](.-)[/\\]" ) or "?"
	form.on_close = on_close or function ( ) end
	form.meta = meta or { }
	form.oldtime = math.floor( afs.get_uptime( ) )
	form.newtime = form.oldtime

	afs.forms[ player_name ] = form
	afs.stats:on_open( )
	minetest.show_formspec( player_name, form.name, parse_elements( form, formspec ) )

	return form.name
end

minetest.update_form = function ( player, formspec )
	local pname = type( player ) == "string" and player or player:get_player_name( )
	local form = afs.forms[ pname ]

	if form then
		form.oldtime = math.floor( afs.get_uptime( ) )
		minetest.show_formspec( pname, form.name, parse_elements( form, formspec ) )
	end
end

minetest.destroy_form = function ( player, signal )
	local pname = type( player ) == "string" and player or player:get_player_name( )
	local form = afs.forms[ pname ]

	if form then
		minetest.close_formspec( pname, form.name )
		minetest.get_form_timer( pname ):stop( )

		if signal ~= minetest.FORMSPEC_SIGSTOP then
			form.on_close( form.meta, form.player, { quit = signal or minetest.FORMSPEC_SIGPROC } )
		end

		afs.stats:on_close( )
		afs.forms[ pname ] = nil
	end
end

-----------------------------------------------------------------
-- trigger callbacks after unexpected formspec closure
-----------------------------------------------------------------

minetest.register_on_leaveplayer( function( player, is_timeout )
	local pname = player:get_player_name( )
	local form = afs.forms[ pname ]

	if form then
		minetest.get_form_timer( pname, form.name ).stop( )

		form.newtime = os.time( )
		form.on_close( form.meta, form.player, { quit = minetest.FORMSPEC_SIGQUIT } )

		afs.stats:on_close( )
		afs.forms[ pname ] = nil
	end
end )

minetest.register_on_dieplayer( function( player )
	local pname = player:get_player_name( )
	local form = afs.forms[ pname ]

	if form then
		minetest.get_form_timer( pname, form.name ).stop( )

		form.newtime = os.time( )
		form.on_close( form.meta, form.player, { quit = minetest.FORMSPEC_SIGKILL } )

		afs.stats:on_close( )
		afs.forms[ pname ] = nil
	end
end )

minetest.register_on_shutdown( function( )
	for _, form in pairs( afs.forms ) do
		minetest.get_form_timer( form.player:get_player_name( ), form.name ).stop( )

		form.newtime = os.time( )
		form.on_close( form.meta, form.player, { quit = minetest.FORMSPEC_SIGTERM } )

		afs.stats:on_close( )
	end
	afs.forms = { }
end )

-----------------------------------------------------------------
-- display realtime information about form sessions
-----------------------------------------------------------------

minetest.register_chatcommand( "fs", {
        description = "Display realtime information about form sessions",
	privs = { server = true },
        func = function( pname, param )
		local page_idx = 1
		local page_size = 10
		local sorted_forms

		local get_sorted_forms = function( )
			local f = { }
			for k, v in pairs( afs.forms ) do
				table.insert( f, v )
			end
			table.sort( f, function( a, b ) return a.id < b.id end )
			return f
		end
		local get_formspec = function( )
			local uptime = math.floor( afs.get_uptime( ) )

			local formspec = "size[9.5,7.5]"
				.. default.gui_bg
				.. default.gui_bg_img

				.. "label[0.1,6.7;ActiveFormspecs v2.6"
				.. string.format( "label[0.1,0.0;%s]label[0.1,0.5;%d min %02d sec]",
					minetest.colorize( "#888888", "uptime:" ), math.floor( uptime / 60 ), uptime % 60 )
				.. string.format( "label[5.6,0.0;%s]label[5.6,0.5;%d]",
					minetest.colorize( "#888888", "active" ), afs.stats.active )
				.. string.format( "label[6.9,0.0;%s]label[6.9,0.5;%d]",
					minetest.colorize( "#888888", "opened" ), afs.stats.opened )
				.. string.format( "label[8.2,0.0;%s]label[8.2,0.5;%d]",
					minetest.colorize( "#888888", "closed" ), afs.stats.closed )

				.. string.format( "label[0.5,1.5;%s]label[3.5,1.5;%s]label[6.9,1.5;%s]label[8.2,1.5;%s]",
					minetest.colorize( "#888888", "player" ), 
					minetest.colorize( "#888888", "origin" ), 
					minetest.colorize( "#888888", "idletime" ), 
					minetest.colorize( "#888888", "lifetime" )
				)

				.. "box[0,1.2;9.2,0.1;#111111]"
				.. "box[0,6.2;9.2,0.1;#111111]"

			local num = 0
			for idx = ( page_idx - 1 ) * page_size + 1, math.min( page_idx * page_size, #sorted_forms ) do
				local form = sorted_forms[ idx ]

				local player_name = form.player:get_player_name( )
				local lifetime = uptime - form.oldtime
				local idletime = uptime - form.newtime

				local vert = 2.0 + num * 0.5

				formspec = formspec 
					.. string.format( "button[0.1,%0.1f;0.5,0.3;del:%s;x]", vert + 0.1, player_name )
					.. string.format( "label[0.5,%0.1f;%s]", vert, player_name )
					.. string.format( "label[3.5,%0.1f;%s]", vert, form.origin )
					.. string.format( "label[6.9,%0.1f;%dm %02ds]", vert, math.floor( idletime / 60 ), idletime % 60 )
					.. string.format( "label[8.2,%0.1f;%dm %02ds]", vert, math.floor( lifetime / 60 ), lifetime % 60 )
				num = num + 1
			end

			formspec = formspec
				.. "button[6.4,6.5;1,1;prev;<<]"
				.. string.format( "label[7.4,6.7;%d of %d]", page_idx, math.max( 1, math.ceil( #sorted_forms / page_size ) ) )
				.. "button[8.4,6.5;1,1;next;>>]"

			return formspec
		end
		local on_close = function( meta, player, fields )
			if fields.quit == minetest.FORMSPEC_SIGTIME then
				sorted_forms = get_sorted_forms( )
				minetest.update_form( pname, get_formspec( ) )

			elseif fields.prev and page_idx > 1 then
				page_idx = page_idx - 1
				minetest.update_form( pname, get_formspec( ) )

			elseif fields.next and page_idx < #sorted_forms / page_size then
				page_idx = page_idx + 1
				minetest.update_form( pname, get_formspec( ) )

			else
				local player_name = string.match( next( fields, nil ), "del:(.+)" )
				if player_name and afs.forms[ player_name ] then
					minetest.destroy_form( player_name )
				end
			end
		end

		sorted_forms = get_sorted_forms( )

		minetest.create_form( nil, pname, get_formspec( ), on_close )
		minetest.get_form_timer( pname ).start( 1 )

		return true
	end,
} )
