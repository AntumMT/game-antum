--[[ LICENSE HEADER

  This file is part of boats2 mod for Luanti.

  boats2 is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as
  published by the Free Software Foundation, either version 3 of
  the License, or (at your option) any later version.

  boats2 is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with boats2. If not, see
  <http://www.gnu.org/licenses/>.
]]


core.register_craft({
	output = "boats:row_boat",
	recipe = {
		{"",           "",           ""          },
		{"group:wood", "",           "group:wood"},
		{"group:wood", "boats:boat", "group:wood"},
	},
})


core.register_craft({
	output = "boats:sail_boat",
	recipe = {
		{"", "group:wool", ""},
		{"group:wood", "group:wool", "group:wood"},
		{"group:tree", "boats:row_boat", "group:tree"},
	},
})
