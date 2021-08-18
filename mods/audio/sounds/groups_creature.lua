
--- Pre-defined Creature Sound Groups
--
--  @topic creature_groups



--- Undead
--
--  @section undead


--- @sndgroup sounds.skeleton
--  @snd skeleton_bones
sounds.skeleton = SoundGroup({
	"skeleton_bones",
})

--- @sndgroup sounds.undead_moan
--  @snd undead_moan_01
--  @snd undead_moan_02
--  @snd undead_moan_03
--  @snd undead_moan_04
sounds.undead_moan = SoundGroup({
	"undead_moan_01",
	"undead_moan_02",
	"undead_moan_03",
	"undead_moan_04",
})

--- <br>
--
--  Includes:
--
--  - `sounds.skeleton`
--  - `sounds.undead_moan`
--
--  @sndgroup sounds.undead
sounds.undead = sounds.skeleton + sounds.undead_moan



--- Misc.
--
--  @section misc


--- @sndgroup sounds.laugh_evil
--  @snd laugh_evil_01
--  @snd laugh_evil_02
sounds.laugh_evil = SoundGroup({
	"laugh_evil_01",
	"laugh_evil_02",
})
