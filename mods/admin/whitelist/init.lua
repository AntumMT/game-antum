--[[
 Whiter List mod by Jordan Irwin (AntumDeluge)
 License: MIT

 Original Whitelist mod by ShadowNinja
 License: WTFPL
--]]

local world_path = core.get_worldpath()
local admin = core.settings:get("name")
local whitelist = {}

local S = core.get_translator(core.get_current_modname())

-- Enabled by default
local enabled = core.settings:get_bool("whitelist.enable", true)
local deny_message = core.settings:get("whitelist.message") or S("This server is whitelisted and you are not on the whitelist.")

local function load_whitelist()
	local file, err = io.open(world_path .. "/whitelist.txt", "r")
	if err then return end

	for line in file:lines() do
		whitelist[line] = true
	end

	file:close()
end

local function save_whitelist()
	local file, err = io.open(world_path .. "/whitelist.txt", "w")
	if err then return end

	for item in pairs(whitelist) do
		file:write(item .. "\n")
	end

	file:close()
end

if enabled then
	core.register_on_prejoinplayer(function(name, ip)
		load_whitelist()
		if name == "singleplayer" or name == admin or whitelist[name] then
			return
		end

		return deny_message
	end)
end

core.register_chatcommand("whitelist", {
	params = "[{add|remove} <name>]",
	help = S("Manipulate the whitelist"),
	privs = {ban=true},
	func = function(name, param)
		local action, whitename
		if param:find(" ") then
			action, whitename = param:match("^([^ ]+) ([^ ]+)$")
		else
			action = param
		end

		if action == "" then
			local names = {}
			for k, v in pairs(whitelist) do
				table.insert(names, k)
			end

			return true, S("Whitelisted names: @1", table.concat(names, ", "))
		end

		if not whitename then
			return false, S("Must supply name parameter.")
		end

		if action == "query" then
			local msg
			if whitelist[whitename] then
				msg = S("@1 is already on the whitelist.", whitename)
			else
				msg = S("@1 is not on the whitelist.", whitename)
			end

			return true, msg
		elseif action == "add" then
			if whitelist[whitename] then
				return false, S("@1 is already on the whitelist.", whitename)
			end

			whitelist[whitename] = true
			save_whitelist()
			return true, S("Added @1 to the whitelist.", whitename)
		elseif action == "remove" then
			if not whitelist[whitename] then
				return false, S("@1 is not on the whitelist.", whitename)
			end

			whitelist[whitename] = nil
			save_whitelist()
			return true, S("Removed @1 from the whitelist.", whitename)
		end

		return false, S("Invalid action: @1", action)
	end,
})
