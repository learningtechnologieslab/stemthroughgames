## =============================================================
## STEM Through Games — Day 4  |  Extension Challenge
## narrative_intro.gd  |  Attach to: Node
## =============================================================
## For EARLY FINISHERS — the Narrative Challenge from the lesson.
##
## CHALLENGE:
##   "Write variables that describe a game character's story setup
##   (max_health, starting_weapon, enemy_name, quest_name)
##   and print an intro scene using those variables."
##
## This script shows one complete example, then leaves a section
## for students to fill in their OWN character!
## =============================================================

extends Node


func _ready() -> void:
	_demo_example_character()
	_student_character_template()
	_bonus_data_types_preview()


# ─────────────────────────────────────────────────────────────
# EXAMPLE CHARACTER — Zara the Swift
# ─────────────────────────────────────────────────────────────

func _demo_example_character() -> void:
	print("╔══════════════════════════════════════╗")
	print("║  NARRATIVE INTRO CHALLENGE — EXAMPLE ║")
	print("╚══════════════════════════════════════╝")
	print("")

	# ── CHARACTER STATS VARIABLES ───────────────────────────
	var character_name  = "Zara the Swift"
	var max_health      = 150
	var current_health  = 150
	var attack_power    = 14
	var defense         = 9
	var speed           = 8
	var level           = 1
	var experience      = 0
	var gold            = 25
	var lives           = 3

	# ── STARTING GEAR ───────────────────────────────────────
	var starting_weapon = "Twin Daggers"
	var weapon_damage   = 14
	var armor           = "Leather Vest"
	var armor_defense   = 9

	# ── WORLD / QUEST VARIABLES ─────────────────────────────
	var quest_name         = "The Lost Crystal of Elara"
	var current_location   = "Dark Forest — Entrance"
	var enemy_name         = "Shadow Wraith"
	var enemy_health       = 80
	var enemy_damage       = 15
	var enemy_count        = 12

	# ── PRINT THE INTRO SCENE ────────────────────────────────
	print("  ╔══════════════════════════════╗")
	print("  ║       CHARACTER SHEET        ║")
	print("  ╚══════════════════════════════╝")
	print("")
	print("  Name:     ", character_name)
	print("  Level:    ", level)
	print("  HP:       ", current_health, " / ", max_health)
	print("  ATK:      ", attack_power, "  |  DEF: ", defense, "  |  SPD: ", speed)
	print("  Weapon:   ", starting_weapon, " (", weapon_damage, " dmg)")
	print("  Armor:    ", armor, " (", armor_defense, " def)")
	print("  Gold:     ", gold, "  |  Lives: ", lives)
	print("")
	print("  ── QUEST ──────────────────────────────────────")
	print("  ", quest_name)
	print("  Location: ", current_location)
	print("")
	print("  ── ENEMY ENCOUNTER ────────────────────────────")
	print("  A ", enemy_name, " appears!")
	print("  Enemy HP: ", enemy_health, "  |  DMG: ", enemy_damage)
	print("  Enemies in dungeon: ", enemy_count)
	print("")

	# ── SIMULATE COMBAT (using math operators) ───────────────
	print("  ── COMBAT LOG ─────────────────────────────────")
	var round_num = 0

	# Round 1: Player attacks
	round_num = round_num + 1
	enemy_health = enemy_health - attack_power
	print("  Round ", round_num, ": ", character_name, " attacks for ", attack_power)
	print("           Enemy HP: ", enemy_health)

	# Round 1: Enemy counter-attacks
	var actual_damage = enemy_damage - defense    # defense reduces damage
	if actual_damage < 1:
		actual_damage = 1
	current_health = current_health - actual_damage
	print("  Round ", round_num, ": ", enemy_name, " hits back")
	print("           Damage reduced by armor: ", enemy_damage, " - ", defense, " = ", actual_damage)
	print("           Your HP: ", current_health, " / ", max_health)
	print("")

	# Round 2: Critical hit (double damage with *)
	round_num = round_num + 1
	var crit_damage = attack_power * 2
	enemy_health = enemy_health - crit_damage
	print("  Round ", round_num, ": CRITICAL HIT! (", attack_power, " × 2 = ", crit_damage, " dmg)")
	print("           Enemy HP: ", enemy_health)
	print("")

	if enemy_health <= 0:
		var xp_gained   = 30
		var gold_gained = gold + 15
		experience = experience + xp_gained
		gold = gold_gained
		enemy_count = enemy_count - 1
		print("  ★ Victory! ", enemy_name, " defeated!")
		print("  XP gained: +", xp_gained, "  | Gold now: ", gold)
		print("  Enemies remaining: ", enemy_count)
		print("")

		# Bonus life check using modulo
		var milestone = experience % 100
		print("  XP milestone check: ", experience, " %% 100 = ", milestone)
		if milestone == 0:
			print("  ★ LEVEL UP BONUS!")
		else:
			print("  Need ", 100 - milestone, " more XP to level up")

	print("")


# ─────────────────────────────────────────────────────────────
# STUDENT TEMPLATE — Design YOUR OWN character!
# ─────────────────────────────────────────────────────────────

func _student_character_template() -> void:
	print("╔══════════════════════════════════════╗")
	print("║  YOUR TURN — Design your character!  ║")
	print("╚══════════════════════════════════════╝")
	print("")
	print("  Replace each value with YOUR own ideas.")
	print("  What kind of hero (or villain!) will you create?")
	print("")

	# ── FILL THESE IN! ──────────────────────────────────────
	#    Change every value on the RIGHT side of the =

	var my_character_name = "YOUR NAME HERE"   # example: "Dragon Knight"
	var my_max_health     = 100                # how tough is your hero?
	var my_attack_power   = 10                 # how hard do they hit?
	var my_starting_weapon = "YOUR WEAPON"     # sword? staff? fists?
	var my_enemy_name     = "YOUR ENEMY"       # who do they fight?
	var my_quest_name     = "YOUR QUEST"       # what's the mission?
	var my_gold           = 10                 # starting coins
	var my_lives          = 3                  # extra chances?

	# ── PRINT YOUR INTRO ────────────────────────────────────
	print("  Character: ", my_character_name)
	print("  HP:        ", my_max_health)
	print("  ATK:       ", my_attack_power)
	print("  Weapon:    ", my_starting_weapon)
	print("  Enemy:     ", my_enemy_name)
	print("  Quest:     ", my_quest_name)
	print("  Gold:      ", my_gold)
	print("  Lives:     ", my_lives)
	print("")

	# BONUS: add a print() here that uses a math operator!
	# example: print("Max damage with power-up: ", my_attack_power * 2)


# ─────────────────────────────────────────────────────────────
# BONUS PREVIEW — Different data types a variable can hold
# Connects to: "Could a variable store words AND numbers?"
# ─────────────────────────────────────────────────────────────

func _bonus_data_types_preview() -> void:
	print("╔══════════════════════════════════════╗")
	print("║  BONUS: What CAN a variable hold?    ║")
	print("╚══════════════════════════════════════╝")
	print("")

	# Integer — whole numbers (no decimals)
	var score: int = 500
	print("  int (whole number):  score = ", score)

	# Float — numbers with decimals
	var speed: float = 5.5
	print("  float (decimal):     speed = ", speed)

	# String — text wrapped in quotes
	var player_name: String = "Hero"
	print("  String (text):       player_name = ", player_name)

	# Boolean — true or false (we'll use these on Day 5!)
	var is_alive: bool = true
	var has_key: bool  = false
	print("  bool (true/false):   is_alive = ", is_alive)
	print("  bool (true/false):   has_key  = ", has_key)

	print("")
	print("  All of these are variables!")
	print("  Same idea — a labeled box — different types of values.")
	print("")
	print("  On Day 5, we use 'bool' with if/else:")
	print("  if is_alive == false:")
	print("      print(\"Game Over!\")")
	print("")
