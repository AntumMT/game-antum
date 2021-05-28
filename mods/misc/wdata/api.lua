
--- World Data Manager API
--
--  @module api.lua


-- store formatted world path
local world_path = core.get_worldpath():gsub("\\", "/")

--- Retrieves directory path where file is located.
--
--  @local
--  @function get_dir
--  @tparam string fpath Full path to file.
--  @treturn string Full path to directory.
local function get_dir(fpath)
	-- format to make working with easier
	fpath = fpath:gsub("\\", "/")
	local idx = fpath:find("/[^/]*$")

	-- use world directory by default
	if not idx or idx == 0 then
		return world_path
	end

	return fpath:sub(1, idx-1)
end


--- Reads config file from world directory.
--
--  @function wdata.read
--  @tparam string fname Base filename with optional directory structure (e.g. "my_mod/my_config")
--  @treturn table Table with contents read from json file or `nil`.
function wdata.read(fname)
	local fpath = world_path .. "/" .. fname .. ".json"

	-- check if file exists
	local fopen = io.open(fpath, "r")
	if not fopen then
		wdata.log("warning", "file not found: " .. fpath)
		return
	end

	local table_data = core.parse_json(fopen:read("*a"))
	io.close(fopen)

	if not table_data then
		wdata.log("error", "cannot read json data from file: " .. fpath)
		return
	end

	return table_data
end


--- Writes to config file in world directory.
--
--  @function wdata.write
--  @tparam string fname Base filename with optional directory structure (e.g. "my_mod/my_config").
--  @tparam table data Table data to be written to config file.
--  @tparam[opt] bool styled Outputs in a human-readable format if this is set (default: `true`).
--  @treturn bool `true` if succeeded, `false` if not.
function wdata.write(fname, data, styled)
	styled = styled ~= false

	local json_data = core.write_json(data, styled)
	if not json_data then
		wdata.log("error", "cannot convert data to json format")
		return false
	end

	local fpath = world_path .. "/" .. fname .. ".json"

	-- create directory tree if necessary
	local dirname = get_dir(fpath)
	if dirname ~= world_path then
		if not core.mkdir(dirname) then
			wdata.log("error", "cannot create directory: " .. dirname)
			return false
		end
	end

	return core.safe_file_write(fpath, json_data)
end


--- Aliases
--
--  @section aliases

--- Alias of `wdata.read`.
--
--  @falias minetest.read_world_config
if not core.read_world_config then
	core.read_world_config = wdata.read
end

--- Alias of `wdata.write`.
--
--  @falias minetest.write_world_config
if not core.write_world_config then
	core.write_world_config = wdata.write
end
