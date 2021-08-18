
-- override built-in type function
local otype = type
type = function(obj)
	local base_type = otype(obj)
	if base_type == "table" then
		local meta_type = otype(obj.__type)
		if meta_type == "string" then
			return obj.__type
		elseif meta_type == "function" then
			return obj:__type()
		end
	end

	return base_type
end

-- override node registration
local register_node_orig = core.register_node
core.register_node = function(name, def)
	if type(def.sounds) == "table" then
		if type(def.sounds.dig) == "SoundGroup" then
			local on_punch_orig = def.on_punch
			local s_group = SoundGroup(def.sounds.dig)
			def.sounds.dig = "" -- override default sound
			def.on_punch = function(...)
				s_group() -- FIXME: should retrieve built-in sound spec

				if type(on_punch_orig) == "function" then
					return on_punch_orig(...)
				end
			end
		end

		if type(def.sounds.dug) == "SoundGroup" then
			local on_dig_orig = def.on_dig
			local s_group = SoundGroup(def.sounds.dug)
			def.sounds.dug = nil
			def.on_dig = function(...)
				s_group()

				if type(on_dig_orig) == "function" then
					return on_dig_orig(...)
				end

				core.node_dig(...)
			end
		end

		if type(def.sounds.footstep) == "SoundGroup" then

		end

		-- FIXME: should be overridden in register_craftitem
		if type(def.sounds.place) == "SoundGroup" then
			local on_place_orig = def.on_place
			local s_group = SoundGroup(def.sounds.place)
			def.sounds.place = nil
			def.on_place = function(stack, ...)
				s_group()

				if type(on_place_orig) == "function" then
					return on_place_orig(stack, ...)
				end

				return core.item_place(stack, ...)
			end
		end

		if type(def.sounds.place_failed) == "SoundGroup" then
			-- FIXME: which callback to override
			def.sounds.place_failed = def.sounds.place_failed:get_random()
		end

		if type(def.sounds.fall) == "SoundGroup" then
			-- FIXME: which callback to override
			def.sounds.fall = def.sounds.fall:get_random()
		end
	end

	return register_node_orig(name, def)
end
