--[[ LICENSE HEADER

  The MIT License (MIT)

  Copyright © 2017-2021 Jordan Irwin (AntumDeluge)

	See: LICENSE.txt
--]]


function antum.log(lvl, msg, modname)
	if not msg then
		msg = lvl
		lvl = nil
	end

	modname = modname or core.get_current_modname()
	if not modname then
		modname = antum.modname
	end

	msg = "[" .. modname .. "] " .. msg
	if not lvl then
		core.log(msg)
	else
		core.log(lvl, msg)
	end
end

function antum.logAction(msg)
	antum.log("warning", "\antum.logAction\" deprecated, use \"antum.log\"")
	antum.log("action", msg)
end

function antum.logWarn(msg)
	antum.log("warning", "\antum.logWarn\" deprecated, use \"antum.log\"")
	antum.log("warning", msg)
end

function antum.logError(msg)
	antum.log("warning", "\antum.logError\" deprecated, use \"antum.log\"")
	antum.log("error", msg)
end


-- Checks if a file exists
function antum.fileExists(file_path)
	local fexists = io.open(file_path, "r")

	if not fexists then return false end

	io.close(fexists)
	return true
end


-- Retrieves path for currently loaded mod
function antum.getCurrentModPath()
	return core.get_modpath(core.get_current_modname())
end


--- Loads a mod sub-script.
--
--  @function antum.loadScript
--  @param script_name Name or base name of the script file.
--  @tparam bool lua_ext If `true`, appends ".lua" extension to script filename (default: `true`).
function antum.loadScript(script_name, lua_ext)
	-- Default 'true'
	lua_ext = lua_ext ~= false

	local script = antum.getCurrentModPath() .. "/" .. script_name
	if lua_ext then
		script = script .. ".lua"
	end

	if antum.fileExists(script) then
		dofile(script)
	else
		antum.log("error", "Could not load, script does not exists: " .. script)
	end
end


-- Loads multiple mod sub-scripts
function antum.loadScripts(script_list)
	for _, s in ipairs(script_list) do
		antum.loadScript(s)
	end
end


-- Registers a craft & displays a log message
function antum.registerCraft(def)
	if antum.verbose then
		antum.log("action", "Registering craft recipe for \"" .. def.output .. "\"")
	end

	core.register_craft(def)
end


-- De-registers a craft by output
function antum.clearCraftOutput(output)
	if antum.verbose then
		antum.log("action", "Clearing craft by output: " .. output)
	end

	core.clear_craft({
		output = output
	})
end


-- De-registers craft by recipe
function antum.clearCraftRecipe(recipe)
	if antum.verbose then
		local recipe_string = ""
		local icount = 0
		for I in pairs(recipe) do
			icount = icount + 1
		end

		for I in pairs(recipe) do
			recipe_string = recipe_string .. " {" .. table.concat(recipe[I], " + ") .. "}"
		end

		antum.log("action", "Clearing craft by recipe: " .. recipe_string)
	end

	core.clear_craft({
		recipe = recipe,
	})
end


-- Overrides a previously registered craft using output
function antum.overrideCraftOutput(def)
	antum.clearCraftOutput(def.output)
	antum.registerCraft(def)
end


-- Overrides a previously registered craft using recipe
function antum.overrideCraftRecipe(def)
	antum.clearCraftRecipe(def.replace)
	antum.registerCraft(def)
end


-- Checks if dependencies are satisfied
function antum.dependsSatisfied(depends)
	for _, dep in ipairs(depends) do
		if not core.get_modpath(dep) then
			return false
		end
	end

	return true
end


--- Retrieves an item from registered items using name string.
--
--  @function antum.getItem
--  @tparam string item_name Item name to search for.
--  @treturn ItemRef Item with name matching `item_name` parameter.
function antum.getItem(item_name)
	return core.registered_items[item_name]
end


--- Retrieves a list of items containing a string.
--
--  @function antum.getItemNames
--  @tparam string substring String to match within item names.
--  @tparam bool case_sensitive If `true`, `substring` case must match that of item name.
--  @treturn table List of item names matching `substring`.
function antum.getItemNames(substring, case_sensitive)
	antum.logAction("Checking registered items for \"" .. substring .. "\" in item name ...")

	-- Convert to lowercase
	if not case_sensitive then
		substring = string.lower(substring)
	end

	local item_names = {}

	for index in pairs(core.registered_items) do
		local item_name = core.registered_items[index].name
		if not case_sensitive then
			item_name = string.lower(item_name)
		end

		-- Check item name for substring
		if string.find(item_name, substring) then
			table.insert(item_names, item_name)
		end
	end

	return item_names
end


--- Un-registers an item & converts its name to an alias.
--
--  @function antum.convertItemToAlias
--  @tparam string item_name Name of the item to override.
--  @tparam string alias_of Name of the item to be aliased.
function antum.convertItemToAlias(item_name, alias_of)
	antum.log("action", "Overridding \"" .. item_name .. "\" with \"" .. alias_of .. "\"")
	core.unregister_item(item_name)
	core.register_alias(item_name, alias_of)
end


--- Changes object description.
--
--  @function antum.overrideItemDescription
--  @tparam string item_name Name of item to be altered.
--  @tparam string description New description.
function antum.overrideItemDescription(item_name, description)
	-- Original item definition
	local item = antum.getItem(item_name)
	-- Change description
	item.description = description

	-- Unregister original item
	core.unregister_item(item.name)
	core.register_craftitem(":" .. item.name, item)
end


--- Registers a new item under "antum" namespace.
--
--  @function antum.registerItem
--  @tparam string name Base name of new item.
--  @tparam table def Item definition.
function antum.registerItem(name, def)
	name = antum.modname .. ":" .. name
	core.register_craftitem(name, def)
end
