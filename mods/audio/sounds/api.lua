
--- Sounds API
--
--  @topic api


local failed = {}


-- initialize random number generator
local rand = PcgRandom(os.time())


--- Plays a sound.
--
--
--  @function sounds:play
--  @tparam string name Sound file without .ogg suffix.
--  @tparam[opt] SoundParams sp Sound parameters.
--  @treturn int Sound handle or `nil`.
--  @usage
--  local handle = sounds:play("sound1", {gain=1.0})
--  if handle then
--    print("Sound handle: " .. handle)
--  end
sounds.play = function(self, name, sp)
	local s_type = type(name)
	if s_type ~= "string" then
		sounds.log("error", "cannot play non-string type: " .. s_type)
		return
	end

	if not sounds.cache[name] then
		if not failed[name] then
			failed[name] = true
			sounds.log("error", "\"" .. name .. "\" not available for playing")
		end

		return
	end

	local s_handle = core.sound_play(name, sp)

	-- TODO: register check to see if sound is still playing & remove from "playing" list
	--playing[s_handle] = name

	return s_handle
end


--- Objects
--
--  @section objects

--- Sound Group.
--
--  @table SoundGroup
--  @tfield SoundGroup:count count Retrieves number of available sounds.
--  @tfield SoundGroup:play play Plays indexed or random sound.
--  @tfield bool no_prepend If set to `true`, omits prepending "sounds_" to sound filenames when played.
SoundGroup = {
	--- Constructor.
	--
	--  @function SoundGroup
	--  @tparam table def Sound definition.
	--  @treturn SoundGroup Sound group definition table.
	--  @usage
	--  -- create new sound groups
	--  local s_group1 = SoundGroup({"sound1", "sound2"})
	--  local s_group2 = SoundGroup({"modname_sound1", "modname_sound2", no_prepend=true})
	--
	--  -- play sound at index
	--  s_group1:play(2)
	--
	--  -- play random sound from group
	--  s_group1:play()
	--
	--  -- play sound at index with parameters
	--  s_group1:play(1, {gain=1.0, max_hear_distance=100})
	--
	--  -- play random sound with parameters
	--  s_group1:play({gain=1.0, max_hear_distance=100})
	--
	--  -- calling a SoundGroup instance directly is the same as executing the "play" method
	--  s_group(1, {gain=1.0, max_hear_distance=100})
	__init = {
		__call = function(self, def)
			def = def or {}

			for k, v in pairs(self) do
				if k ~= "new" and k ~= "__init" and def[k] == nil then
					def[k] = v
				end
			end

			def.__type = "SoundGroup"

			def.__init = {
				-- execute "play" methode when called directly
				__call = self.play,

				-- allow arithmetic operation to join groups
				__add = function(self, g1)
					local new_group = {}
					for _, snd in ipairs(self) do
						table.insert(new_group, snd)
					end
					for _, snd in ipairs(g1) do
						table.insert(new_group, snd)
					end

					return SoundGroup(new_group)
				end,
			}
			setmetatable(def, def.__init)

			return def
		end,
	},

	--- Retrieves number of sounds in group.
	--
	--  @function SoundGroup:count
	--  @treturn int
	count = function(self)
		local s_count = 0
		for _, idx in ipairs(self) do
			s_count = s_count + 1
		end

		return s_count
	end,

	--- Plays a sound from the group.
	--
	--  If ***idx*** is not specified, an available sound will be selected
	--  randomly from the group.
	--
	--  @function SoundGroup:play
	--  @tparam[opt] int idx Sound index.
	--  @tparam[opt] SoundParams sp Sound parameters.
	--  @treturn int Sound handle or `nil`.
	--  @note idx & sp parameters positions can be switched.
	--  @usage
	--  local handle = SoundGroup:play(2, {gain=1.0})
	--  if handle then
	--    print("Sound handle: " .. handle)
	--  end
	play = function(self, idx, sp)
		local s_count = self:count()
		if s_count < 1 then
			sounds.log("error", "no sounds to play")
			return
		end

		-- allow second parameter to be sound parameters table
		if type(idx) == "table" then
			local sp_old = sp
			sp = table.copy(idx)
			idx = sp_old
			sp_old = nil
		end

		-- play random
		if not idx then
			if s_count == 1 then
				idx = 1
			else
				idx = rand:next(1, s_count)
			end
		end

		if type(idx) ~= "number" then
			print("idx must be a number")
			return
		end

		if idx > s_count then
			sounds.log("error", "sound index " .. idx .. " out of range: max " .. s_count)
			return
		end

		local selected = self[idx]
		if type(selected) == "string" and self.no_prepend ~= true then
			selected = "sounds_" .. selected
		end

		return sounds:play(selected, sp)
	end,

	--- Retrieves random name from group.
	--
	--  @function SoundGroup:get_random
	--  @treturn string
	get_random = function(self)
		local name
		local s_count = self:count()
		if s_count > 0 then
			if s_count == 1 then
				name = self[1]
			else
				name = self[rand:next(1, s_count)]
			end

			if self.no_prepend ~= true then
				name = "sounds_" .. name
			end
		end

		return name
	end,

	--- Retrieves sounds names in group.
	--
	--  If `idx` is supplied, a `string` or `nil` is returned. If
	--  there is only one sound in the group, the `string` name of
	--  that sound is returned. Otherwise, a table is returned with
	--  all sound file names.
	--
	--  @function SoundGroup:get
	--  @tparam[opt] int idx Sound index.
	--  @return `string` or `table` containing sound file names.
	get = function(self, idx)
		local count = self:count()
		if count == 0 then return end

		local retval
		if type(idx) == "number" then
			retval = self[idx]
		elseif count == 1 then
			retval = self[1]
		else
			retval = {}
			for _, snd in ipairs(self) do
				table.insert(retval, snd)
			end
		end

		if self.no_prepend ~= true then
			local rtype = type(retval)
			if rtype == "string" then
				retval = "sounds_" .. retval
			elseif rtype == "table" then
				for idx, snd in ipairs(retval) do
					retval[idx] = "sounds_" .. snd
				end
			end
		end

		return retval
	end,
}
setmetatable(SoundGroup, SoundGroup.__init)
