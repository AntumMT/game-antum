-------------------------------------------------------------------------------------------
-- How to try this example:
-- 1) Move this file into a new "afs_test" directory under mods and rename it "init.lua".
-- 2) Create a "depends.txt" file in the new directory with the following lines of text:
--		nyancat
--		formspecs
-- 3) Launch your Minetest server and enable the "afs_test" mod. Then, login as usual!
-------------------------------------------------------------------------------------------

minetest.register_privilege( "uptime", "View the uptime of the server interactively" )

local get_nyancat_formspec = function( meta )
	local uptime = minetest.get_server_uptime( )
	local formspec = "size[4,3]"
		.. default.gui_bg_img
		.. string.format( "label[0.5,0.5;%s %0.1f %s]",
			minetest.colorize( "#FFFF00", "Server Uptime:" ),
			meta.is_minutes == true and uptime / 60 or uptime,
			meta.is_minutes == true and "mins" or "secs"
		)
		.. "checkbox[0.5,1;is_minutes;Show Minutes;" .. tostring( meta.is_minutes ) .. "]"
		.. "button[0.5,2;2.5,1;update;Refresh]"
		.. "hidden[view_count;1;number]"
		.. "hidden[view_limit;10;number]"		-- limit the number of refreshes!
	return formspec
end

minetest.override_item( "nyancat:nyancat", {
	description = "System Monitor",
        
	on_open = function( meta, player )
		local player_name = player:get_player_name( )

		if meta.is_minutes == nil then meta.is_minutes = true end

		if minetest.check_player_privs( player, "uptime" ) then
			return get_nyancat_formspec( meta )
		else
                        minetest.chat_send_player( player_name, "Your privileges are insufficient." )
		end
	end,
	on_close = function( meta, player, fields )
		local player_name = player:get_player_name( )

		if not minetest.check_player_privs( player, "uptime" ) then return end

		if fields.update then
			if meta.view_count == meta.view_limit then
				minetest.destroy_form( player_name )
                	        minetest.chat_send_player( player_name, "You've exceeded the refresh limit." )
			else
				meta.view_count = meta.view_count + 1
				minetest.update_form( player_name, get_nyancat_formspec( meta ) )
			end

		elseif fields.is_minutes then
			meta.is_minutes = fields.is_minutes == "true"
			minetest.update_form( player_name, get_nyancat_formspec( meta ) )
		end
	end
} )

minetest.register_chatcommand( "uptime", {
	description = "View the uptime of the server interactively",
	func = function( player_name, param )
		local is_refresh = true

		local get_formspec = function( )
			local uptime = minetest.get_server_uptime( )

			local formspec = "size[4,2]"
				.. default.gui_bg_img
				.. string.format( "label[0.5,0.5;%s %d secs]",
					minetest.colorize( "#FFFF00", "Server Uptime:" ), uptime
				)
				.. "checkbox[0.5,1;is_refresh;Auto Refresh;" .. tostring( is_refresh ) .. "]"
			return formspec
		end
		local on_close = function( meta, player, fields )
			if fields.quit == minetest.FORMSPEC_SIGTIME then
				minetest.update_form( player_name, get_formspec( ) )

			elseif fields.is_refresh then
				is_refresh = fields.is_refresh == "true"
				if is_refresh == true then
					minetest.get_form_timer( player_name ).start( 1 )
				else
					minetest.get_form_timer( player_name ).stop( )
				end
			end
		end

		minetest.create_form( nil, player_name, get_formspec( ), on_close )
		minetest.get_form_timer( player_name ).start( 1 )
	end
} )
