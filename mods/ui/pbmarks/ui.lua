
local ui_handlers = {
	"sfinv_buttons",
}

if not core.global_exists("sfinv_buttons") then
	pbmarks.log("warning", "compatible UI handler not available, please install one of "
		.. core.serialize(ui_handlers):gsub("return ", ""))
	return
end


sfinv_buttons.register_button(pbmarks.modname, {
	title = "Personal Bookmarks",
	image = "pbmarks_check.png",
	action = function(player)
		pbmarks.show_formspec(player:get_player_name())
	end,
})
