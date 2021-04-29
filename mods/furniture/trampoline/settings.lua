
--- Percent of damage absorbed when falling on tramp.
--
--  - min 0 (full damage)
--  - max 100 (no damage)
--  - default: 100
trampoline.damage_absorb = core.settings:get("trampoline.damage_absorb")
if trampoline.damage_absorb == nil then
	trampoline.damage_absorb = 100
else
	trampoline.damage_absorb = tonumber(trampoline.damage_absorb)
end
