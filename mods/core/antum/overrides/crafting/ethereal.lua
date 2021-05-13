--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin (AntumDeluge)
  
  See: LICENSE.txt
]]


if antum.dependsSatisfied({'ethereal',}) then
	antum.overrideCraftOutput({
		output = 'ethereal:bowl',
		recipe = {
			{'group:tree', '', 'group:tree'},
			{'', 'group:tree', ''},
		},
	})
end
