--ELEVATOR mod by orwell


--table
--[[format:
	[n]={
		motor_pos=pos
		xdir=bool
		entries={
			name=str
			deep=int
			sidecoord=1 or 2
		}
	}
]]

elevators={}

elevator_fpath=minetest.get_worldpath().."/elevators"
local file, err = io.open(elevator_fpath, "r")
if not file then
	local er=err or "Unknown Error"
	print("[elevators]Failed loading file:"..er)
else
	elevators = minetest.deserialize(file:read("*a"))
	if type(elevators) ~= "table" then
		elevators={}
	end
	file:close()
end



elevator_save_cntdn=10
elevator_save_stuff=function(dtime)--warning dtime can be missing (on shutdown)
	--and it will save everything

	local datastr = minetest.serialize(elevators)
	if not datastr then
		minetest.log("error", "[elevator] Failed to serialize data!")
		return
	end
	local file, err = io.open(elevator_fpath, "w")
	if err then
		print(err)
		return
	end
	file:write(datastr)
	file:close()
	
end
minetest.register_globalstep(function(dtime)
	if elevator_save_cntdn<=0 then
		elevator_save_cntdn=10 --10 seconds interval!
	end
	elevator_save_cntdn=elevator_save_cntdn-dtime
end)
minetest.register_on_shutdown(elevator_save_stuff)

minetest.register_node("elevator:elev_rail", {
	drawtype="torchlike",
	tiles={"elevator_rail_bt.png", "elevator_rail_bt.png", "elevator_rail.png"},
	inventory_image = "elevator_rail.png",
	wield_image = "elevator_rail.png",
	paramtype="light",
	sunlight_propagates=true,
	paramtype2="wallmounted",
	description="Elevator Rail (place on wall!!!)",
	walkable=false,
	groups={elevator_rail=1, not_blocking_elevators=1, crumbly=1, oddly_breakable_by_hand=1, attached_node=1},
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		wall_side = {-0.5, -0.5, -0.1, 0.1, 0.5, 0.1},
	},
})

minetest.register_node("elevator:elev_motor", {

	drawtype = "normal",
	tiles = {"elevator_motor_top.png", "elevator_motor_bottom.png", "elevator_motor_side1.png", "elevator_motor_side3.png", "elevator_motor_side2.png", "elevator_motor_side4.png"},
        --^ Textures of node; +Y, -Y, +X, -X, +Z, -Z

	description="Elevator Motor",

	groups={crumbly=1, oddly_breakable_by_hand=1}, --kann man nicht abbauen

	after_place_node=function(pos, placer, itemstack, pointed_thing)
		--can this node be placed here?
		local xdir=elevator_node_has_group(elevator_posadd(pos, {x=1, y=0, z=0}), "elevator_rail") and elevator_node_has_group(elevator_posadd(pos, {x=-1, y=0, z=0}), "elevator_rail")
		local zdir=elevator_node_has_group(elevator_posadd(pos, {x=0, y=0, z=1}), "elevator_rail") and elevator_node_has_group(elevator_posadd(pos, {x=0, y=0, z=-1}), "elevator_rail")
		if not (xdir or zdir) then
			if placer and placer:get_inventory() then
				placer:get_inventory():add_item("main", "elevator:elev_motor")
			end
			minetest.set_node(pos, {name="air"})
		end
		--create new table instance
		local ev={}
		ev.xdir=xdir
		ev.motor_pos=pos
		ev.entries={}
		table.insert(elevators, ev)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		for id,elev in pairs(elevators) do
			if elev.motor_pos.x==pos.x and elev.motor_pos.y==pos.y and elev.motor_pos.z==pos.z then
				elevator_purge(id, digger)
			end
		end
	end
})

function elevator_create_entity_at(id, deep)
	local ent=minetest.add_entity({x=elevators[id].motor_pos.x, y=elevators[id].motor_pos.y-deep-2, z=elevators[id].motor_pos.z}, "elevator:elevator")
	if elevators[id].xdir then
		ent:setyaw(math.pi*0.5);
	end
	ent:set_armor_groups({immortal=1})
	local luaent=ent:get_luaentity()
	luaent.currdeep=deep
	luaent.xdir=elevators[id].xdir
	luaent.tardeep=deep
	luaent.tardeep_set=true
	luaent.id=id
	luaent.nodestroy=true
end

function elevator_entity_step(self, deltatime)

	--if not self.lastchk or not self.lifetime then
	--	self.lastchk=0
	--	self.lifetime=0
	--end
	--self.lifetime=self.lifetime+deltatime
	--if self.lifetime < self.lastchk + 0.2 then--skip step
	--	return
	--end
	--self.lastchk=self.lifetime

	--checking stuff
	
	if not elevators[self.id] then self:on_punch() return end

	--if minetest.get_node(self.motor_pos).name~="elevator:elev_motor" then
	--	print("[elevator]destroying due to missing motor block")
	--	self.object:remove()
	--	return
	--end

	--end
	if not self.tardeep then
		self.tardeep=self.currdeep or 0
	end
	
	if self.currdeep<0 then
		self.tardeep=0
	end

	if not self.movement then
		self.movement=0
	end

	local pos=self.object:getpos()
	--moving object before new movement is calculated
	self.object:setpos({x=math.floor(pos.x+0.5), y=pos.y, z=math.floor(pos.z+0.5)})

	--calculating movement
	pos=self.object:getpos()
	
	self.currdeep=(elevators[self.id].motor_pos.y-2)-math.floor(pos.y+0.5)

	--check if shaft is free and equipped with rails
	local pos1, pos2
	if self.xdir then
		pos1, pos2= {x=1, y=0, z=0}, {x=-1, y=0, z=0}
	else
		pos1, pos2= {x=0, y=0, z=1}, {x=0, y=0, z=-1}
	end

	local free=elevator_valid_room({x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5)+self.movement, z=math.floor(pos.z+0.5)}, pos1, pos2)
	if not free and self.currdeep~=self.tardeep then
		--[[if self.movement==1 then
			--minetest.chat_send_all("Elevator shaft is blocked, destroying...")
			--self.on_punch(self)
			--self.movement=-1
			self.tardeep=self.currdeep+1
		elseif self.movement==-1 then
			--minetest.chat_send_all("Elevator shaft blocked while driving down!!!")
			--self.currdeep=self.maxdeep+0
			--self.movement=1
			self.tardeep=self.currdeep-1
		elseif self.movement==0 then
			--self.maxdeep=self.currdeep-1
			self.tardeep=self.currdeep-1
			--self.currdeep=self.maxdeep-1
			
		end]]
		self.tardeep=self.currdeep
		self.tardeep_set=true
		self.getoffto=nil
	end

	--print(self.currdeep,self.tardeep,self.movement,pos.y,elevators[self.id].motor_pos.y-self.tardeep-2)
	
	local roundedpos={x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5)}
	if self.currdeep==self.tardeep and ((self.movement==1 and pos.y>=elevators[self.id].motor_pos.y-self.tardeep-2) or (self.movement==-1 and pos.y<=elevators[self.id].motor_pos.y-self.tardeep-2) or self.tardeep_set) then
		--target reached
		self.movement=0
		self.object:setpos({x=elevators[self.id].motor_pos.x, y=elevators[self.id].motor_pos.y-self.tardeep-2, z=elevators[self.id].motor_pos.z})
		--some extra stuff to get the player off
		if (self.oldmovement~=0 or self.tardeep_set) then
			elevator_open_door(elevator_posadd(roundedpos, {x=pos1.z, y=pos1.y-1, z=pos1.x}))
			elevator_open_door(elevator_posadd(roundedpos, {x=pos2.z, y=pos2.y-1, z=pos2.x}))--swaps x and z since pos1 and pos2 orient to rails...
		end
		if self.getoffto and (self.oldmovement~=0 or self.tardeep_set) and self.driver then
			--print("[elevator]halt. self:"..dump(self))
			local player=self.driver
			if self.getoffto==1 then--vertausche x und z, weil diese die Schienenposotionen angeben
				local setoffpos={x=elevators[self.id].motor_pos.x+(2*pos1.z), y=((elevators[self.id].motor_pos.y-2)-self.currdeep), z=elevators[self.id].motor_pos.z+(2*pos1.x)}
				minetest.after(0.5, function()
					player:set_detach()
					--minetest.chat_send_player(player:get_player_name(), "Get off to "..minetest.pos_to_string(setoffpos))
					minetest.after(0, function()
						player:setpos(setoffpos)
						player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
					end)
				end)
				self.driver=nil
			elseif self.getoffto==2 then
				local setoffpos={x=elevators[self.id].motor_pos.x+(2*pos2.z), y=((elevators[self.id].motor_pos.y-2)-self.currdeep), z=elevators[self.id].motor_pos.z+(2*pos2.x)}
				minetest.after(0.5, function()
					player:set_detach()
					--minetest.chat_send_player(player:get_player_name(), "Get off to "..minetest.pos_to_string(setoffpos))
					minetest.after(0, function()
						player:setpos(setoffpos)
						player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
					end)
				end)
				self.driver=nil
			end
		end
	elseif self.currdeep>self.tardeep then--moving up
		self.movement=1
		if self.oldmovement==0 then
			self.movestartfactor=0
			elevator_close_door(elevator_posadd(roundedpos, {x=pos1.z, y=pos1.y-1, z=pos1.x}))--swaps x and z since pos1 and pos2 orient to rails...
			elevator_close_door(elevator_posadd(roundedpos, {x=pos2.z, y=pos2.y-1, z=pos2.x}))
		end
	elseif self.currdeep<self.tardeep then--moving down
		self.movement=-1
		if self.oldmovement==0 then
			self.movestartfactor=0
			elevator_close_door(elevator_posadd(roundedpos, {x=pos1.z, y=pos1.y-1, z=pos1.x}))--swaps x and z since pos1 and pos2 orient to rails...
			elevator_close_door(elevator_posadd(roundedpos, {x=pos2.z, y=pos2.y-1, z=pos2.x}))
		end
	end
	self.oldmovement=self.movement+0
	--setting velocity after new movement has been calculated
	--self.object:moveto({x=elevators[self.id].motor_pos.x, y=elevators[self.id].motor_pos.y-self.tardeep-2, z=elevators[self.id].motor_pos.z},2)
	local spdfactor=math.max(math.min(math.abs((elevators[self.id].motor_pos.y-self.tardeep-2) - pos.y),8),0.5)--distance to target, but maximum 8 and minimum 0.5
	if not self.movestartfactor then
		self.movestartfactor=0
	end
	if self.movestartfactor<1 then
		self.movestartfactor=self.movestartfactor+0.05
	end
	local newvelocity=self.movement*spdfactor*self.movestartfactor
	--ensure vars are not nil
	if not self.forcevelocitytimer then self.forcevelocitytimer=5 end
	if not self.oldvelocity then self.oldvelocity=0 end
	
	self.forcevelocitytimer=self.forcevelocitytimer+deltatime--forces a velocity client send update every 5 secs or when velocity changes.
	if self.oldvelocity~=newvelocity or self.forcevelocitytimer>5 then
		self.object:setvelocity({x=0, y=newvelocity, z=0});
		self.forcevelocitytimer=0
	end
	self.oldvelocity=newvelocity
	self.tardeep_set=false
end

function elevator_entity_rightclick(self, clicker)--now it begins to get interesting
	if not clicker or not clicker:is_player() then
		return
	end
	if self.driver and clicker == self.driver and self.movement==0 then
		minetest.show_formspec(clicker:get_player_name(), "elevator_drive_"..self.id, elevator_get_formspec(elevators[self.id].entries, self.currdeep))
	elseif not self.driver and not self.shaft_exploration then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_eye_offset({x=0,y=-5,z=0},{x=0,y=-5,z=0})
		minetest.show_formspec(clicker:get_player_name(), "elevator_drive_"..self.id, elevator_get_formspec(elevators[self.id].entries, self.currdeep))
	end
	--print("[elevator] [dbg] [entries] "..dump(self.entries))
end
function elevator_get_formspec(entries, currdeep)
	--step 1: buttons for goto
	local form="size[10, 8]"
	local exit1, exit2
	for index, entry in ipairs(entries) do
		form=form.."button_exit[1,"..(index/1.5)..";5,1;goto"..entry.deep..":"..entry.sidecoord..";"..entry.name.."]"
		if entry.deep==currdeep then
			if entry.sidecoord==1 then
				exit1=entry.name
			elseif entry.sidecoord==2 then
				exit2=entry.name
			end
		end
	end
	--step 2 getoff buttons

	if exit1 then
		form=form.."button_exit[1,7;4,1;getoff1;Get off at "..exit1.."]"
	end
	if exit2 then
		form=form.."button_exit[5,7;4,1;getoff2;Get off at "..exit2.."]"
	end
	return form
end
function elevator_receives_fields(self, player, fields)
	if not player or not self.driver or self.driver~=player then
		return
	end
	for key, value in pairs(fields) do
		local get, side=string.match(key, "goto([0-9%-]+):([12])")
		if get then
			self.tardeep=get+0
			self.getoffto=side+0;
			self.tardeep_set=true
			minetest.chat_send_player(player:get_player_name(), "Elevator driving to "..value)
			return
		end
	end

	local pos1, pos2
	if not self.xdir then
		pos1, pos2= {x=1, y=0, z=0}, {x=-1, y=0, z=0}
	else
		pos1, pos2= {x=0, y=0, z=1}, {x=0, y=0, z=-1}
	end

	if fields.getoff1 then
		player:set_detach()
		player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
		local setoffpos={x=elevators[self.id].motor_pos.x+(2*pos1.x), y=((elevators[self.id].motor_pos.y-2)-self.currdeep), z=elevators[self.id].motor_pos.z+(2*pos1.z)}
		--minetest.chat_send_player(player:get_player_name(), "Get off to"..minetest.pos_to_string(setoffpos))
		minetest.after(0.2, function() player:setpos(setoffpos) end)
		self.driver=nil
	elseif fields.getoff2 then
		player:set_detach()
		player:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
		local setoffpos={x=elevators[self.id].motor_pos.x+(2*pos2.x), y=((elevators[self.id].motor_pos.y-2)-self.currdeep), z=elevators[self.id].motor_pos.z+(2*pos2.z)}
		--minetest.chat_send_player(player:get_player_name(), "Get off to"..minetest.pos_to_string(setoffpos))
		minetest.after(0.2, function() player:setpos(setoffpos) end)
		self.driver=nil
	end
end
---register
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local idstr=string.match(formname, "elevator_drive_(.+)")
	if idstr then
		print(idstr)
		local id=idstr+0
		for obj_id, ent in pairs(minetest.luaentities) do
			if ent.is_elevator and ent.id and ent.id==id then
				elevator_receives_fields(ent, player, fields)
				--minetest.chat_send_all("click elevator")
				return nil
			end
		end
	end
	local nposs=string.match(formname, "elevator_setname_(%(.+%))")
	if nposs then
		local nos=minetest.string_to_pos(nposs)
		if not fields.name or fields.name=="" then
			player:get_inventory():add_item("main", "elevator:elev_entry")
			minetest.set_node(nos, {name="air"})
		else
			elevator_set_name(nos, fields.name, player)
		end
	end
end)

------------------------helpers
--[[function elevator_get_elev_data(pos)
	if minetest.get_node(pos).name~="elevator:elev_motor" then
		return nil
	end

	local xdir=elevator_node_has_group(elevator_posadd(pos, {x=1, y=0, z=0}), "elevator_rail") and elevator_node_has_group(elevator_posadd(pos, {x=-1, y=0, z=0}), "elevator_rail")
	local zdir=elevator_node_has_group(elevator_posadd(pos, {x=0, y=0, z=1}), "elevator_rail") and elevator_node_has_group(elevator_posadd(pos, {x=0, y=0, z=-1}), "elevator_rail")
	if xdir and not zdir then
		return elevator_get_deep(elevator_posadd(pos, {x=0, y=-2, z=0}), {x=1, y=0, z=0}, {x=-1, y=0, z=0})
	elseif zdir and not xdir then
		return elevator_get_deep(elevator_posadd(pos, {x=0, y=-2, z=0}), {x=0, y=0, z=1}, {x=0, y=0, z=-1})
	else
		return nil
	end
end

--crawls down and does the actual work
function elevator_get_deep(pos, railp1, railp2)
	local curry=0
	local entries={}
	while elevator_valid_room(elevator_posadd(pos, {x=0, y=-curry, z=0}), railp1, railp2) do
		if elevator_node_has_group(elevator_posadd(pos, {x=railp1.z, y=-curry, z=railp1.x}), "elevator_entry") then
			local meta=minetest.get_meta(elevator_posadd(pos, {x=railp1.z, y=-curry, z=railp1.x}))
			if meta then
				local n=meta:get_string("entry_name")
				table.insert(entries, {deep=curry, name=n})
			end
		end
		if elevator_node_has_group(elevator_posadd(pos, {x=railp2.z, y=-curry, z=railp2.x}), "elevator_entry") then
			local meta=minetest.get_meta(elevator_posadd(pos, {x=railp1.z, y=-curry, z=railp1.x}))
			if meta then
				local n=meta:get_string("entry_name")
				table.insert(entries, {deep=curry, name=n})
			end
		end
		curry=curry+1
	end
	if curry<=0 then
		return nil
	end

	return curry-1, entries

end]]--no longer needed

function elevator_valid_room(pos, railp1, railp2)
	local posis={
		{x=1, y=0, z=1},
		{x=0, y=0, z=1},
		{x=-1, y=0, z=1},
		{x=1, y=0, z=0},
		{x=0, y=0, z=0},
		{x=-1, y=0, z=0},
		{x=1, y=0, z=-1},
		{x=0, y=0, z=-1},
		{x=-1, y=0, z=-1}
	}
	for _,posi in ipairs(posis) do
		if not elevator_node_has_group(elevator_posadd(pos, posi), "not_blocking_elevators") then
			return false
		end
	end
	return elevator_node_has_group(elevator_posadd(pos, railp1), "elevator_rail") and elevator_node_has_group(elevator_posadd(pos, railp2), "elevator_rail")
end

function elevator_node_has_group(pos, group)
	local node=minetest.get_node(pos)
	if not node then return true end
	local def=minetest.registered_nodes[node.name].groups
	if not def then return false end
	return def[group]
end
function elevator_posadd(pos, add)
	return {x=pos.x+add.x, y=pos.y+add.y, z=pos.z+add.z}
end
function elevator_purge(id, player)
	local elev=table.remove(elevators, id)
	for k,v in pairs(elev.entries) do
		minetest.remove_node(v.pos)
		if player then player:get_inventory():add_item("main", "elevator:elev_entry") end
	end
end
function elevator_set_name(pos, name, player)
	
	--register in elevator
	--find one
	local found_id, sidecoord, nodedircrd, temp_nodedircrd
	local found_layer=31000
	for id,elev in ipairs(elevators) do
		--is it a possible elevator
		local mpos=elev.motor_pos
		local xdir=elev.xdir
		local pos1, pos2
		if not xdir then
			pos1, pos2= elevator_posadd(mpos,{x=1, y=0, z=0}), elevator_posadd(mpos,{x=-1, y=0, z=0})
			temp_nodedircrd={2, 0}
		else
			pos1, pos2= elevator_posadd(mpos,{x=0, y=0, z=1}), elevator_posadd(mpos,{x=0, y=0, z=-1})
			temp_nodedircrd={1, 3}
		end
		
		--sidecoord=1
		if (pos.x==pos1.x and pos.z==pos1.z) then
			print(xdir,"SIDECOORD 1",dump(nodedircrd))
			if found_layer>mpos.y and mpos.y>pos.y then
				found_layer=mpos.y
				found_id=id
				sidecoord=1
				nodedircrd=temp_nodedircrd
			end
		end
		if (pos.x==pos2.x and pos.z==pos2.z) then
			print(xdir," SIDECOORD 2",dump(nodedircrd))
			if found_layer>mpos.y and mpos.y>pos.y then
				found_layer=mpos.y
				found_id=id
				sidecoord=2
				nodedircrd=temp_nodedircrd
			end
		end
	end
	if found_id then
		--find pos to insert
		local added=false
		for key,entry in ipairs(elevators[found_id].entries) do
			if entry.deep>(found_layer-pos.y-3) then
				table.insert(elevators[found_id].entries,key,{name=name, deep=found_layer-pos.y-3, sidecoord=sidecoord, pos=pos})
				added=true
				break
			end
		end
		if not added then
			table.insert(elevators[found_id].entries,{name=name, deep=found_layer-pos.y-3, sidecoord=sidecoord, pos=pos})
		end
		--local num=#elevators[found_id].entries+1
		
		--turn the block the right direction...
		minetest.set_node(pos, {name="elevator:elev_entry", param2=nodedircrd[sidecoord]})
		
		local meta=minetest.get_meta(pos)
		if meta then
			meta:set_string("calls_id", found_id)
			meta:set_string("calls_deep", found_layer-pos.y-3)
		end
		print("added",name,"to",found_id,"deep",found_layer-pos.y-3)
		--print(dump(elevators))
		
	else
		minetest.chat_send_player(player:get_player_name(),"No elevator found here!")
		minetest.remove_node(pos)
		player:get_inventory():add_item("main", "elevator:elev_entry")
	end
end

--opening/closing doors (lol)
function elevator_open_door(pos)
	local node=minetest.get_node_or_nil(pos)
	--print("opening door ",minetest.pos_to_string(pos)," node:",dump(node))
	if node and node.name=="elevator:elev_entry" then
		--print(" is right door type, will open...")
		minetest.swap_node(pos, {name="elevator:elev_entry_half", param2=node.param2})
		minetest.after(0.3,function()
			minetest.swap_node(pos, {name="elevator:elev_entry_open", param2=node.param2})
		end)
	end
end
function elevator_close_door(pos)
	local node=minetest.get_node_or_nil(pos)
	--print("closing door ",minetest.pos_to_string(pos)," node:",dump(node))
	if node and node.name=="elevator:elev_entry_open" then
		--print(" is right door type, will close...")
		minetest.swap_node(pos, {name="elevator:elev_entry_half", param2=node.param2})
		minetest.after(0.3,function()
			minetest.swap_node(pos, {name="elevator:elev_entry", param2=node.param2})
		end)
	end
end


local entry_nodebox_open={
	-- A fixed box (facedir param2 is used, if applicable)
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, -0.2, 0.5, 0.5},--base node
		{-0.4, 0.5, -1.0, -0.3, 2.5, -0.5},--left wing
		{-0.4, 0.5, 0.5, -0.3, 2.5, 1.0},--right wing
		
		{-0.5, 0.5, -1.5, -0.4, 2.5, -0.5},--left panel
		{-0.5, 0.5, 0.5, -0.4, 2.5, 1.5},--right panel
		
	}
}
local entry_nodebox_half={
	-- A fixed box (facedir param2 is used, if applicable)
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, -0.2, 0.5, 0.5},--base node
		{-0.4, 0.5, -0.75, -0.4, 2.5, -0.25},--left wing
		{-0.4, 0.5, 0.25, -0.3, 2.5, 0.75},--right wing
		
		{-0.5, 0.5, -1.5, -0.4, 2.5, -0.5},--left panel
		{-0.5, 0.5, 0.5, -0.4, 2.5, 1.5},--right panel
	}
}
local entry_nodebox_closed={
	-- A fixed box (facedir param2 is used, if applicable)
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, -0.2, 0.5, 0.5},--base node
		{-0.4, 0.5, -0.5, -0.3, 2.5, 0.5},--door
		
		{-0.5, 0.5, -1.5, -0.4, 2.5, -0.5},--left panel
		{-0.5, 0.5, 0.5, -0.4, 2.5, 1.5},--right panel
	}
}

elevator_on_entry_rightclick=function(pos, node, clicker)
	if not clicker or not clicker:is_player() then return end

	local meta=minetest.get_meta(pos)
	local ids=meta:get_string("calls_id")
	if not ids or ids=="" then return end--fixed fast doubleclick
	local id=ids+0
	if id and elevators[id] then
		local deep=meta:get_string("calls_deep")+0
		for obj_id, ent in pairs(minetest.luaentities) do
			if ent.is_elevator and ent.id==id then
				if not ent.driver then
					if math.abs(ent.currdeep-deep)<(math.max((minetest.setting_get("active_block_range") or 0)-1,1)*16) then
						ent.tardeep=deep
						ent.getoffto=nil
						ent.tardeep_set=true
						minetest.chat_send_player(clicker:get_player_name(), "Called Elevator.")
						return nil
					else
						ent:on_punch()
					end
				else
					minetest.chat_send_player(clicker:get_player_name(), "Another player is using this elevator! Can't call!")
					return nil
				end
			end
		end
		elevator_create_entity_at(id, deep)
		minetest.chat_send_player(clicker:get_player_name(), "Spawned Elevator.")
		
	else
		minetest.chat_send_player(clicker:get_player_name(), "Invalid Metadata")
		--print(dump(elevators))
		--print(dump(meta:to_table()))
		--print(id)
	end
end,

minetest.register_node("elevator:elev_entry", {

	drawtype = "nodebox",
	node_box = entry_nodebox_closed,
	selection_box = entry_nodebox_closed,
	collision_box = entry_nodebox_closed,
	
	tiles = {"elevator_entry.png"},

	paramtype2="facedir",
	paramtype="light",
	
	description="Elevator Door",
	inventory_image="elevator_entry.png",
	wield_image="elevator_entry.png",
	
	
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if placer and pos then
			minetest.show_formspec(placer:get_player_name(), "elevator_setname_"..minetest.pos_to_string(pos), "field[name;Name of door;]")
		end
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		print(dump(oldmetadata))
		if not oldmetadata.fields.calls_id then return end
		local id=oldmetadata.fields["calls_id"]+0
		if id and elevators[id] then
			for key,entry in pairs(elevators[id].entries) do
				if entry.pos.x==pos.x and entry.pos.y==pos.y and entry.pos.z==pos.z then
					table.remove(elevators[id].entries,key)
				end
			end
		end
	end,
	--on_rightclick=elevator_on_entry_rightclick,
	groups={not_blocking_elevators=1, elevator_entry=1, cracky=1, oddly_breakable_by_hand=1},
	
	on_rightclick=function(pos, node, clicker)
		elevator_on_entry_rightclick(pos, node, clicker)
	end
})

minetest.register_node("elevator:elev_entry_open", {
	
	drawtype = "nodebox",
	node_box = entry_nodebox_open,
	selection_box = entry_nodebox_open,
	collision_box = entry_nodebox_open,
	
	
	tiles = {"elevator_entry.png"},
	
	description="Elevator Door (open) (you hacker you...)",
	
	paramtype2="facedir",
	paramtype="light",
	
	
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		print(dump(oldmetadata))
		local id=(oldmetadata.fields["calls_id"] or -1)+0
		if id and elevators[id] then
			for key,entry in pairs(elevators[id].entries) do
				if entry.pos.x==pos.x and entry.pos.y==pos.y and entry.pos.z==pos.z then
					table.remove(elevators[id].entries,key)
				end
			end
		end
	end,
	drop = 'elevator:elev_entry',
	groups={not_blocking_elevators=1, elevator_entry=1, cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	on_rightclick=function(pos, node, clicker)
		elevator_on_entry_rightclick(pos, node, clicker)
	end
	
})
minetest.register_node("elevator:elev_entry_half", {
	
	drawtype = "nodebox",
	node_box = entry_nodebox_half,
	selection_box = entry_nodebox_half,
	collision_box = entry_nodebox_half,
	
	
	tiles = {"elevator_entry.png"},
	
	description="Elevator Door (half-open) (you hacker you...)",
	
	paramtype2="facedir",
	paramtype="light",
	
	
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		print(dump(oldmetadata))
		local id=(oldmetadata.fields["calls_id"] or -1)+0
		if id and elevators[id] then
			for key,entry in pairs(elevators[id].entries) do
				if entry.pos.x==pos.x and entry.pos.y==pos.y and entry.pos.z==pos.z then
					table.remove(elevators[id].entries,key)
				end
			end
		end
	end,
	drop = 'elevator:elev_entry',
	groups={not_blocking_elevators=1, elevator_entry=1, cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	on_rightclick=function(pos, node, clicker)
		elevator_on_entry_rightclick(pos, node, clicker)
	end
})

minetest.register_entity("elevator:elevator", {
	is_elevator=true,
	on_step=elevator_entity_step,
	on_activate=function(self, staticdata)
		if staticdata=="destroy" then
			self.on_punch(self)
		end
	end,
	get_staticdata=function(self)
		return "destroy"
	end,
	on_rightclick=elevator_entity_rightclick,
	on_punch=function(self, puncher)
		--if elevators[self.id] then
		--	minetest.set_node(elevators[self.id].motor_pos, {name="air"})
		--end
		--close doors here...
		if self.xdir then
			pos1, pos2= {x=1, y=0, z=0}, {x=-1, y=0, z=0}
		else
			pos1, pos2= {x=0, y=0, z=1}, {x=0, y=0, z=-1}
		end
		local pos=self.object:getpos()
		local roundedpos={x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5)}
		elevator_close_door(elevator_posadd(roundedpos, {x=pos1.z, y=pos1.y-1, z=pos1.x}))--swaps x and z since pos1 and pos2 orient to rails...
		elevator_close_door(elevator_posadd(roundedpos, {x=pos2.z, y=pos2.y-1, z=pos2.x}))
		
		--if not puncher or not puncher:is_player() then return true end
		if self.driver then
			self.driver:set_detach()
			self.driver:set_eye_offset({x=0,y=0,z=0},{x=0,y=0,z=0})
		end
		
		self.object:remove()
		
		--local inv = puncher:get_inventory()
		--if minetest.setting_getbool("creative_mode") then
		--	if not inv:contains_item("main", "elevator:elev_motor") then
		--		inv:add_item("main", "elevator:elev_motor")
		--	end
		--else
		--	inv:add_item("main", "elevator:elev_motor")
		--end
		--return true
	end,

	visual = "mesh",
	mesh = "elevator.x",
	textures = {
		"elevator_obj.png"
	},
	collide_with_objects = true
})

minetest.after(0, function()
	minetest.registered_nodes.air.groups.not_blocking_elevators=1;
	minetest.registered_nodes["default:torch"].groups.not_blocking_elevators=1;
end)

minetest.register_craft(
	{
        output = 'elevator:elev_rail 16',
        recipe = {
            {'', 'default:steel_ingot'},
            {'default:steel_ingot', 'default:steel_ingot'},
            {'', 'default:steel_ingot'}, -- Also groups; e.g. 'group:crumbly'
        },
    }
)
minetest.register_craft(
	{
        output = 'elevator:elev_motor',
        recipe = {
            {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
            {'default:copper_ingot', 'default:gold_ingot', 'default:copper_ingot'},
            {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}, -- Also groups; e.g. 'group:crumbly'
        },
    }
)
minetest.register_craft(
	{
        output = 'elevator:elev_entry',
        recipe = {
            {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
            {'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
            {'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'}, -- Also groups; e.g. 'group:crumbly'
        },
    }
)
