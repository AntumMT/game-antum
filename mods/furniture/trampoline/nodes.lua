-- Nodes registration for trampoline mod


trampoline.register_tramp("tramp", {
	description = "Trampoline",
	overlay = "sides_overlay.png",
	bounce_rate = trampoline.bounce * trampoline.multi_high,
})


local aliases = {
	-- backward compatibility
	"trampoline:regular",
	"trampoline:brown",

	-- other aliases
	"trampoline:trampoline",
	"trampoline",
	"tramp",
}

for a in pairs(aliases) do
	minetest.register_alias(aliases[a], "trampoline:tramp")
end
