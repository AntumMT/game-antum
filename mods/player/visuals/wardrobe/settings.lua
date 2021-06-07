
--- Number of skins shown per page.
--
--  default: 8
wardrobe.skins_per_page = tonumber(core.settings:get("wardrobe.skins_per_page")) or 8

--- Show preview images.
wardrobe.previews = core.settings:get_bool("wardrobe.previews", true)


-- 8 is max
if wardrobe.skins_per_page > 8 then
	wardrobe.log("warning", "max skins per page is 8")
	wardrobe.skins_per_page = 8
elseif wardrobe.skins_per_page < 1 then
	wardrobe.log("warning", "min skins per page is 1")
	wardrobe.skins_per_page = 1
end
