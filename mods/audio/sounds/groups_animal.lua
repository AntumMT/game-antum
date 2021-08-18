
--- Pre-defined Animal Sound Groups
--
--  @topic animal_groups



--- Amphibian
--
--  @section amphibian


--- @sndgroup sounds.frog
--  @snd frog
sounds.frog = SoundGroup({
	"frog",
})



--- Bat
--
--  @section bat


--- @sndgroup sounds.bat
--  @snd bat_01
--  @snd bat_02
--  @snd bat_03
sounds.bat = SoundGroup({
	"bat_01",
	"bat_02",
	"bat_03",
})



--- Bear
--
--  @section bear


--- @sndgroup sounds.bear
--  @snd bear_01
--  @snd bear_02
sounds.bear = SoundGroup({
	"bear_01",
	"bear_02",
})



--- Bovine
--
--  @section bovine


--- @sndgroup sounds.cow_moo
--  @snd cow_moo_01
--  @snd cow_moo_02
sounds.cow_moo = SoundGroup({
	"cow_moo_01",
	"cow_moo_02",
})

--- @sndgroup sounds.yak
--  @snd yak (imitation)
sounds.yak = SoundGroup({
	"yak",
})

--- <br>
--
--  Includes:
--
--  - `sounds.cow_moo`
--  - `sounds.yak`
--
--  @sndgroup sounds.bovine
sounds.bovine = sounds.cow_moo + sounds.yak



--- Camelid
--
--  @section camelid


--- @sndgroup sounds.camel
--  @snd camel_01
--  @snd camel_02
sounds.camel = SoundGroup({
	"camel_01",
	"camel_02",
})



--- Canine
--
--  @section canine


--- @sndgroup sounds.coyote_howl
--  @snd coyote_howl
sounds.coyote_howl = SoundGroup({
	"coyote_howl",
})

--- @sndgroup sounds.dog_bark
--  @snd dog_bark
sounds.dog_bark = SoundGroup({
	"dog_bark",
})

--- @sndgroup sounds.puppy_bark
--  @snd puppy_bark
sounds.puppy_bark = SoundGroup({
	"puppy_bark",
})

--- <br>
--
-- Includes:
--
--  - `sounds.dog_bark`
--  - `sounds.puppy_bark`
--
--  @sndgroup sounds.dog
sounds.dog = sounds.dog_bark + sounds.puppy_bark

--- @sndgroup sounds.hyena
--  @snd hyena_01
--  @snd hyena_02
--  @snd hyena_03
sounds.hyena = SoundGroup({
	"hyena_01",
	"hyena_02",
	"hyena_03",
})

--- @sndgroup sounds.wolf_howl
--  @snd wolf_howl
sounds.wolf_howl = SoundGroup({
	"wolf_howl",
})

--- @sndgroup sounds.wolf_snarl
--  @snd wolf_snarl
sounds.wolf_snarl = SoundGroup({
	"wolf_snarl",
})

--- <br>
--
--  Includes:
--
--  - `sounds.wolf_howl`
--  - `sounds.wolf_snarl`
--
--  @sndgroup sounds.wolf
sounds.wolf = sounds.wolf_howl + sounds.wolf_snarl

--- <br>
--
--  Includes:
--
--  - `sounds.coyote_howl`
--  - `sounds.dog`
--  - `sounds.hyena`
--  - `sounds.wolf`
--
--  @sndgroup sounds.canine
sounds.canine = sounds.coyote_howl + sounds.dog + sounds.hyena + sounds.wolf



--- Caprine
--
--  @section caprine


--- @sndgroup sounds.goat_bleat
--  @snd goat_bleat_01
--  @snd goat_bleat_02
--  @snd goat_bleat_03
sounds.goat_bleat = SoundGroup({
	"goat_bleat_01",
	"goat_bleat_02",
	"goat_bleat_03",
})

--- @sndgroup sounds.lamb
--  @snd lamb
sounds.lamb = SoundGroup({
	"lamb",
})

--- @sndgroup sounds.sheep_baa
--  @snd sheep_baa
sounds.sheep_baa = SoundGroup({
	"sheep_baa",
})

--- <br>
--
--  Includes:
--
--  - `sounds.lamb`
--  - `sounds.sheep_baa`
--
--  @sndgroup sounds.sheep
sounds.sheep = sounds.lamb + sounds.sheep_baa

--- <br>
--
--  Includes:
--
--  - `sounds.goat_bleat`
--  - `sounds.sheep`
--
--  @sndgroup sounds.caprine
sounds.caprine = sounds.goat_bleat + sounds.sheep



--- Cetacean
--
--  @section cetacean


--- @sndgroup sounds.dolphin_chirp
--  @snd dolphin_chirp
sounds.dolphin_chirp = SoundGroup({
	"dolphin_chirp",
})

--- @sndgroup sounds.dolphin_click
--  @snd dolphin_click
sounds.dolphin_click = SoundGroup({
	"dolphin_click",
})

--- <br>
--
--  Includes:
--
--  - `sounds.dolphin_chirp`
--  - `sounds.dolphin_click`
--
--  @sndgroup sounds.dolphin
sounds.dolphin = sounds.dolphin_chirp + sounds.dolphin_click

--- @sndgroup sounds.whale
--  @snd whale
sounds.whale = SoundGroup({
	"whale",
})

--- <br>
--
--  Includes:
--
--  - `sounds.dolphin`
--  - `sounds.whale`
--
--  @sndgroup sounds.cetacean
sounds.cetacean = sounds.dolphin + sounds.whale



--- Elephant
--
--  @section elephant


--- @sndgroup sounds.elephant_trumpet
--  @snd elephant_trumpet
sounds.elephant_trumpet = SoundGroup({
	"elephant_trumpet",
})



--- Equine
--
--  @section equine


--- @sndgroup sounds.horse_neigh
--  @snd horse_neigh_01
--  @snd horse_neigh_02
sounds.horse_neigh = SoundGroup({
	"horse_neigh_01",
	"horse_neigh_02",
})

--- @sndgroup sounds.horse_snort
--  @snd horse_snort_01
--  @snd horse_snort_02
sounds.horse_snort = SoundGroup({
	"horse_snort_01",
	"horse_snort_02",
})

--- <br>
--
--  Includes:
--
--  - `sounds.horse_neigh`
--  - `sounds.horse_snort`
--
--  @sndgroup sounds.horse
sounds.horse = sounds.horse_neigh + sounds.horse_snort

--- @sndgroup sounds.zebra
--  @snd zebra
sounds.zebra = SoundGroup({
	"zebra",
})

--- <br>
--
--  Includes:
--
--  - `sounds.horse`
--  - `sounds.zebra`
--
--  @sndgroup sounds.equine
sounds.equine = sounds.horse + sounds.zebra



--- Feline
--
--  @section feline


--- @sndgroup sounds.cat_meow
--  @snd cat_meow
sounds.cat_meow = SoundGroup({
	"cat_meow",
})

--- @sndgroup sounds.jaguar
--  @snd jaguar_saw
sounds.jaguar = SoundGroup({
	"jaguar_saw",
})

--- @sndgroup sounds.leopard_growl
--  @snd leopard_growl_01
--  @snd leopard_growl_02
--  @snd leopard_growl_03
sounds.leopard_growl = SoundGroup({
	"leopard_growl_01",
	"leopard_growl_02",
	"leopard_growl_03",
})

--- @sndgroup sounds.leopard_roar
--  @snd leopard_roar_01
--  @snd leopard_roar_02
--  @snd leopard_roar_03
--  @snd leopard_roar_04
--  @snd leopard_roar_05
sounds.leopard_roar = SoundGroup({
	"leopard_roar_01",
	"leopard_roar_02",
	"leopard_roar_03",
	"leopard_roar_04",
	"leopard_roar_05",
})

--- @sndgroup sounds.leopard_saw
--  @snd leopard_saw_01
--  @snd leopard_saw_02
--  @snd leopard_saw_03
sounds.leopard_saw = SoundGroup({
	"leopard_saw_01",
	"leopard_saw_02",
	"leopard_saw_03",
})

--- @sndgroup sounds.leopard_snarl
--  @snd leopard_snarl_01
--  @snd leopard_snarl_02
sounds.leopard_snarl = SoundGroup({
	"leopard_snarl_01",
	"leopard_snarl_02",
})

--- @sndgroup sounds.leopard_snort
--  @snd leopard_snort
sounds.leopard_snort = SoundGroup({
	"leopard_snort",
})

--- <br>
--
--  Includes:
--
--  - `sounds.leopard_growl`
--  - `sounds.leopard_roar`
--  - `sounds.leopard_saw`
--  - `sounds.leopard_snarl`
--  - `sounds.leopard_snort`
--
--  @sndgroup sounds.leopard
sounds.leopard = sounds.leopard_growl + sounds.leopard_roar + sounds.leopard_saw
	+ sounds.leopard_snarl + sounds.leopard_snort

--- @sndgroup sounds.lion
--  @snd lion_bellow
sounds.lion = SoundGroup({
	"lion_bellow",
})

--- @sndgroup sounds.tiger
--  @snd tiger_roar_01
--  @snd tiger_snarl_01
--  @snd tiger_snarl_02
--  @snd tiger_snarl_03
--  @snd tiger_snarl_04
sounds.tiger = SoundGroup({
	"tiger_roar_01",
	"tiger_snarl_01",
	"tiger_snarl_02",
	"tiger_snarl_03",
	"tiger_snarl_04",
})

--- <br>
--
--  Includes:
--
--  - `sounds.cat_meow`
--  - `sounds.jaguar`
--  - `sounds.lion`
--  - `sounds.tiger`
--
--  @sndgroup sounds.feline
sounds.feline = sounds.cat_meow + sounds.jaguar + sounds.leopard + sounds.lion
	+ sounds.tiger



--- Fowl
--
--  @section fowl


--- @sndgroup sounds.canary
--  @snd canary_01
--  @snd canary_02
--  @snd canary_03
sounds.canary = SoundGroup({
	"canary_01",
	"canary_02",
	"canary_03",
})

--- <br>
--
--  Includes:
--
--  - `sounds.canary`
--
--  @sndgroup sounds.bird
--  @snd bird_01
--  @snd bird_02
--  @snd bird_03
sounds.bird = SoundGroup({
	"bird_01",
	"bird_02",
	"bird_03",
}) + sounds.canary

--- @sndgroup sounds.chicken
--  @snd chicken_01
--  @snd chicken_02
sounds.chicken = SoundGroup({
	"chicken_01",
	"chicken_02",
})

--- @sndgroup sounds.crow_caw
--  @snd crow_caw
sounds.crow_caw = SoundGroup({
	"crow_caw",
})

--- @sndgroup sounds.duck_quack
--  @snd duck_quack
sounds.duck_quack = SoundGroup({
	"duck_quack",
})

--- @sndgroup sounds.goose
--  @snd goose
sounds.goose = SoundGroup({
	"goose",
})

--- @sndgroup sounds.owl
--  @snd owl_hoot
sounds.owl = SoundGroup({
	"owl_hoot",
})

--- @sndgroup sounds.parrot_chirp
--  @snd parrot_chirp
sounds.parrot_chirp = SoundGroup({
	"parrot_chirp",
})

--- @sndgroup sounds.parrot_whistle
--  @snd parrot_whistle
sounds.parrot_whistle = SoundGroup({
	"parrot_whistle",
})

--- <br>
--
--  Includes:
--
--  - `sounds.parrot_chirp`
--  - `sounds.parrot_whistle`
--
--  @sndgroup sounds.parrot
--  @snd parrot_01
--  @snd parrot_02
--  @snd parrot_03
sounds.parrot = SoundGroup({
	"parrot_01",
	"parrot_02",
	"parrot_03",
}) + sounds.parrot_chirp + sounds.parrot_whistle

--- @sndgroup sounds.peacock
--  @snd peacock_01
--  @snd peacock_02
sounds.peacock = SoundGroup({
	"peacock_01",
	"peacock_02",
})

--- @sndgroup sounds.penguin
--  @snd penguin_01
--  @snd penguin_02
sounds.penguin = SoundGroup({
	"penguin_01",
	"penguin_02",
})

--- @sndgroup sounds.pigeon
--  @snd pigeon
sounds.pigeon = SoundGroup({
	"pigeon",
})

--- @sndgroup sounds.quail
--  @snd quail
sounds.quail = SoundGroup({
	"quail",
})

--- @sndgroup sounds.rooster
--  @snd rooster
sounds.rooster = SoundGroup({
	"rooster",
})

--- @sndgroup sounds.seagull
--  @snd seagull_01
--  @snd seagull_02
--  @snd seagulls
sounds.seagull = SoundGroup({
	"seagull_01",
	"seagull_02",
	"seagulls",
})

--- @sndgroup sounds.toucan
--  @snd toucan_01
--  @snd toucan_02
--  @snd toucan_03
sounds.toucan = SoundGroup({
	"toucan_01",
	"toucan_02",
	"toucan_03",
})

--- @sndgroup sounds.turkey_gobble
--  @snd turkey_gobble
sounds.turkey_gobble = SoundGroup({
	"turkey_gobble",
})

--- @sndgroup sounds.vulture
--  @snd vulture (imitation)
sounds.vulture = SoundGroup({
	"vulture",
})

--- @sndgroup sounds.woodpecker
--  @snd woodpecker_peck
sounds.woodpecker = SoundGroup({
	"woodpecker_peck",
})

--- <br>
--
--  Includes:
--
--  - `sounds.bird`
--  - `sounds.chicken`
--  - `sounds.crow_caw`
--  - `sounds.duck_quack`
--  - `sounds.goose`
--  - `sounds.owl`
--  - `sounds.parrot`
--  - `sounds.peacock`
--  - `sounds.penguin`
--  - `sounds.pigeon`
--  - `sounds.quail`
--  - `sounds.rooster`
--  - `sounds.seagull`
--  - `sounds.toucan`
--  - `sounds.turkey_gobble`
--  - `sounds.vulture`
--  - `sounds.woodpecker`
--
--  @sndgroup sounds.fowl
sounds.fowl = sounds.bird + sounds.chicken + sounds.crow_caw + sounds.duck_quack
	+ sounds.goose + sounds.owl + sounds.parrot + sounds.peacock + sounds.penguin
	+ sounds.pigeon + sounds.quail + sounds.rooster + sounds.seagull + sounds.toucan
	+ sounds.turkey_gobble + sounds.vulture + sounds.woodpecker



--- Giraffe
--
--  @section giraffe


--- @sndgroup sounds.giraffe_hum
--  @snd giraffe_hum
sounds.giraffe_hum = SoundGroup({
	"giraffe_hum",
})



--- Insect
--
--  @section insect


--- @sndgroup sounds.bee
--  @snd bee
--  @snd bumble_bee_01
--  @snd bumble_bee_02
--  @snd bees
sounds.bee = SoundGroup({
	"bee",
	"bumble_bee_01",
	"bumble_bee_02",
	"bees",
})

--- @sndgroup sounds.cricket
--  @snd cricket
sounds.cricket = SoundGroup({
	"cricket",
})

--- @sndgroup sounds.grasshopper
--  @snd grasshopper
sounds.grasshopper = SoundGroup({
	"grasshopper",
})

--- <br>
--
--  Includes:
--
--  - `sounds.bee`
--  - `sounds.cricket`
--  - `sounds.grasshopper`
--
--  @sndgroup sounds.insect
sounds.insect = sounds.bee + sounds.cricket + sounds.grasshopper



--- Pinniped
--
--  @section pinniped


--- @sndgroup sounds.sea_lion
--  @snd sea_lion_01
--  @snd sea_lion_02
--  @snd sea_lion_03
sounds.sea_lion = SoundGroup({
	"sea_lion_01",
	"sea_lion_02",
	"sea_lion_03",
})



--- Primate
--
--  @section primate


--- @sndgroup sounds.gorilla_grunt
--  @snd gorilla_grunt
sounds.gorilla_grunt = SoundGroup({
	"gorilla_grunt",
})

--- @sndgroup sounds.gorilla_roar
--  @snd gorilla_roar
sounds.gorilla_roar = SoundGroup({
	"gorilla_roar",
})

--- @sndgroup sounds.gorilla_snarl
--  @snd gorilla_snarl_01
--  @snd gorilla_snarl_02
--  @snd gorilla_snarl_03
--  @snd gorilla_snarl_04
sounds.gorilla_snarl = SoundGroup({
	"gorilla_snarl_01",
	"gorilla_snarl_02",
	"gorilla_snarl_03",
	"gorilla_snarl_04",
})

--- <br>
--
--  Includes:
--
--  - `sounds.gorilla_grunt`
--  - `sounds.gorilla_roar`
--  - `sounds.gorilla_snarl`
--
--  @sndgroup sounds.gorilla
sounds.gorilla = sounds.gorilla_grunt + sounds.gorilla_roar + sounds.gorilla_snarl

--- @sndgroup sounds.monkey
--  @snd monkey_01 (imitation)
--  @snd monkey_02 (imitation)
--  @snd monkey_03 (imitation)
sounds.monkey = SoundGroup({
	"monkey_01",
	"monkey_02",
	"monkey_03",
})

--- <br>
--
--  Includes:
--
--  - `sounds.gorilla`
--  - `sounds.monkey`
--
--  @sndgroup sounds.primate
sounds.primate = sounds.gorilla + sounds.monkey



--- Raccoon
--
--  @section raccoon


--- @sndgroup sounds.raccoon
--  @snd raccoon_chatter
--  @snd raccoon_chatter_baby_01
--  @snd raccoon_chatter_baby_02
sounds.raccoon = SoundGroup({
	"raccoon_chatter",
	"raccoon_chatter_baby_01",
	"raccoon_chatter_baby_02",
})


--- Rodent
--
--  @section rodent


--- @sndgroup sounds.mouse
--  @snd mouse (imitation)
sounds.mouse = SoundGroup({
	"mouse",
})

--- @sndgroup sounds.squirrel
--  @snd squirrel_01
--  @snd squirrel_02
--  @snd squirrel_03
sounds.squirrel = SoundGroup({
	"squirrel_01",
	"squirrel_02",
	"squirrel_03",
})

--- <br>
--
--  Includes:
--
--  - `sounds.mouse`
--  - `sounds.squirrel`
--
--  @sndgroup sounds.rodent
sounds.rodent = sounds.mouse + sounds.squirrel



--- Snake
--
--  @section snake


--- @sndgroup sounds.cobra
--  @snd cobra_01
--  @snd cobra_02
sounds.cobra = SoundGroup({
	"cobra_01",
	"cobra_02",
})

--- @sndgroup sounds.snake_rattle
--  @snd snake_rattle
sounds.snake_rattle = SoundGroup({
	"snake_rattle",
})

--- <br>
--
--  Includes:
--
--  - `sounds.cobra`
--  - `sounds.snake_rattle`
--
--  @sndgroup sounds.snake
sounds.snake = sounds.cobra + sounds.snake_rattle



--- Swine
--
--  @section swine


--- @sndgroup sounds.pig_snort
--  @snd pig_snort
sounds.pig_snort = SoundGroup({
	"pig_snort",
})

--- @sndgroup sounds.pig_squeal
--  @snd pig_squeal
sounds.pig_squeal = SoundGroup({
	"pig_squeal",
})

--- <br>
--
--  Includes:
--
--  - `sounds.pig_snort`
--  - `sounds.pig_squeal`
--
--  @sndgroup sounds.pig
sounds.pig = sounds.pig_snort + sounds.pig_squeal
