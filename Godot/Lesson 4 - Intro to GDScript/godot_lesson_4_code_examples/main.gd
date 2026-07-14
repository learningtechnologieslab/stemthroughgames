## =============================================================
## STEM Through Games — Day 4: Intro to GDScript: Variables & Print
## main.gd  |  Attach to: Node (scene root)
## =============================================================
## This script runs ALL Day 4 lesson examples in order.
## Press F5 (or the Play button) to run, then read the Output panel.
## Each section is separated by a clear header in the output.
##
## LESSON SECTIONS:
##   1. Starter Script   — your very first variables
##   2. Modify & Explore — changing values and seeing results
##   3. Math Operators   — +  -  *  /  %  in game context
##   4. Extension        — narrative character setup
## =============================================================

extends Node


func _ready() -> void:
	_print_banner()
	_section_1_starter_script()
	_section_2_modify_and_explore()
	_section_3_math_operators()
	_section_4_extension_narrative()
	_print_footer()


# ─────────────────────────────────────────────────────────────
# BANNER
# ─────────────────────────────────────────────────────────────

func _print_banner() -> void:
	print("╔══════════════════════════════════════════════════╗")
	print("║   STEM Through Games — DAY 4                     ║")
	print("║   Intro to GDScript: Variables & Print           ║")
	print("║   Focus: Variables as Game Data                  ║")
	print("╚══════════════════════════════════════════════════╝")
	print("")


# ─────────────────────────────────────────────────────────────
# SECTION 1 — The Starter Script
# Exactly what students type in the Main Activity (Step 2)
# ─────────────────────────────────────────────────────────────

func _section_1_starter_script() -> void:
	print("──────────────────────────────────────────────────")
	print("SECTION 1 › The Starter Script")
	print("  (This is the code you typed in Step 2!)")
	print("──────────────────────────────────────────────────")

	# --- DECLARE VARIABLES ---
	# A variable is a labeled box that stores a value.
	# 'var' tells GDScript: "create a new box with this label."

	var player_name = "Hero"   # stores text (a String)
	var health      = 100      # stores a whole number (an int)
	var score       = 0        # starts at zero — no points yet!

	# --- PRINT THE VALUES ---
	# print() displays the value in the Output panel below.

	print(player_name)
	print("Health: ", health)
	print("Score: ", score)
	print("")


# ─────────────────────────────────────────────────────────────
# SECTION 2 — Modify & Explore
# Shows what happens when you change values (Step 3 challenges)
# ─────────────────────────────────────────────────────────────

func _section_2_modify_and_explore() -> void:
	print("──────────────────────────────────────────────────")
	print("SECTION 2 › Modify & Explore")
	print("  What happens when we change the values?")
	print("──────────────────────────────────────────────────")

	# TRY IT: Change player_name to YOUR name
	var player_name = "Alex"   # <-- change "Alex" to your name!
	print("Player name changed to: ", player_name)
	print("")

	# TRY IT: Change health to 50
	var health = 50
	print("Health changed to: ", health)
	print("")

	# CHALLENGE: score = score + 10
	# GDScript reads the RIGHT side first:
	#   1. Look inside the 'score' box  → 0
	#   2. Add 10                       → 10
	#   3. Put the result back in 'score'
	var score = 0
	print("score starts at: ", score)
	score = score + 10
	print("After  score = score + 10,  score is now: ", score)
	print("")

	# CHALLENGE: health = health - 25  (taking damage!)
	print("health starts at: ", health)
	health = health - 25
	print("After  health = health - 25,  health is now: ", health)
	print("  --> This is how a game subtracts HP when you get hit!")
	print("")


# ─────────────────────────────────────────────────────────────
# SECTION 3 — Math Operators in Game Context
# All five GDScript operators with real game examples
# ─────────────────────────────────────────────────────────────

func _section_3_math_operators() -> void:
	print("──────────────────────────────────────────────────")
	print("SECTION 3 › Math Operators  (+  -  *  /  %)")
	print("  Real game examples for each operator")
	print("──────────────────────────────────────────────────")

	# ── + ADDITION ──────────────────────────────────────────
	# Game use: picking up a coin adds to the score
	var score = 0
	score = score + 50      # found a coin worth 50 points
	print("+ Addition   | score after coin pickup:    ", score)

	# ── - SUBTRACTION ───────────────────────────────────────
	# Game use: enemy hits the player, reducing health
	var health = 100
	var damage = 30
	health = health - damage
	print("- Subtraction| health after enemy hit:     ", health)

	# ── * MULTIPLICATION ─────────────────────────────────────
	# Game use: double damage from a power-up
	var base_damage = 10
	var double_damage = base_damage * 2
	print("* Multiply   | double damage power-up:     ", double_damage)

	# Game use: enemies get faster each level
	var base_speed = 5
	var level      = 3
	var enemy_speed = base_speed * level
	print("* Multiply   | enemy speed at level ", level, ":    ", enemy_speed)

	# ── / DIVISION ──────────────────────────────────────────
	# Game use: split loot equally among 4 players
	var total_coins = 100
	var players     = 4
	var each_share  = total_coins / players
	print("/  Division  | coins per player (100/4):   ", each_share)

	# Note: integer division in GDScript drops the decimal!
	var odd_coins   = 10
	var three_players = 3
	var share = odd_coins / three_players
	print("/  Division  | 10 coins / 3 players:       ", share, "  (decimals are dropped!)")

	# ── % MODULO (REMAINDER) ─────────────────────────────────
	# Game use: check if score is a multiple of 100 (bonus life!)
	var current_score = 300
	var remainder = current_score % 100
	print("%  Modulo    | 300 %% 100 (bonus life check): ", remainder, "  (0 = bonus!)")

	current_score = 250
	remainder = current_score % 100
	print("%  Modulo    | 250 %% 100 (bonus life check): ", remainder, "  (not yet)")

	# Game use: toggle between two states (even/odd turns)
	print("")
	print("  --- Using %% to alternate turns ---")
	for turn in range(1, 7):
		var player_turn = (turn % 2) + 1   # alternates between Player 1 and 2
		print("  Turn ", turn, " → Player ", player_turn, "'s move")

	print("")


# ─────────────────────────────────────────────────────────────
# SECTION 4 — Extension Challenge: Narrative Character Setup
# For early finishers — variables that tell a story
# ─────────────────────────────────────────────────────────────

func _section_4_extension_narrative() -> void:
	print("──────────────────────────────────────────────────")
	print("SECTION 4 › Extension Challenge")
	print("  Narrative Character Setup — variables tell a story!")
	print("──────────────────────────────────────────────────")

	# ── CHARACTER STATS ─────────────────────────────────────
	var character_name    = "Zara the Swift"
	var max_health        = 150
	var current_health    = 150
	var starting_weapon   = "Short Sword"
	var attack_power      = 12
	var defense           = 8
	var level             = 1
	var gold              = 25

	# ── WORLD INFO ──────────────────────────────────────────
	var quest_name        = "The Lost Crystal of Elara"
	var enemy_name        = "Shadow Wraith"
	var enemy_health      = 80
	var enemy_damage      = 15
	var current_location  = "Dark Forest — Entrance"

	# ── PRINT AN INTRO SCENE ────────────────────────────────
	# Using variables inside print() to build a story!

	print("  ╔═══════════════════════════════════╗")
	print("  ║     GAME INTRODUCTION SCENE       ║")
	print("  ╚═══════════════════════════════════╝")
	print("")
	print("  Hero:     ", character_name)
	print("  Level:    ", level)
	print("  Health:   ", current_health, " / ", max_health)
	print("  Weapon:   ", starting_weapon, "  (ATK: ", attack_power, ")")
	print("  Defense:  ", defense)
	print("  Gold:     ", gold)
	print("")
	print("  Location: ", current_location)
	print("  Quest:    ", quest_name)
	print("")
	print("  A ", enemy_name, " blocks the path!")
	print("  Enemy HP: ", enemy_health)
	print("")

	# ── SIMULATE ONE ROUND OF COMBAT ────────────────────────
	print("  --- Round 1 of combat ---")

	# Player attacks enemy
	enemy_health = enemy_health - attack_power
	print("  ", character_name, " attacks for ", attack_power, " damage!")
	print("  ", enemy_name, " HP: ", enemy_health)

	# Enemy attacks player
	current_health = current_health - enemy_damage
	print("  ", enemy_name, " strikes back for ", enemy_damage, " damage!")
	print("  ", character_name, " HP: ", current_health, " / ", max_health)

	# Award XP and gold after combat
	var xp_earned   = 30
	var gold_earned = 15
	gold = gold + gold_earned
	print("")
	print("  ", enemy_name, " defeated!")
	print("  XP earned: +", xp_earned, "  |  Gold earned: +", gold_earned)
	print("  Total gold: ", gold)
	print("")

	# ── ALL VARIABLES — EXTENSION CHALLENGE 1 ───────────────
	print("  --- All character variables (Extension Challenge 1) ---")
	var lives         = 3
	var enemy_count   = 12
	var current_level = 1
	print("  lives:         ", lives)
	print("  enemy_count:   ", enemy_count)
	print("  current_level: ", current_level)
	print("")

	# ── MODULO — EXTENSION CHALLENGE 2 ─────────────────────
	print("  --- Modulo challenge: print(10 %% 3) ---")
	print("  10 %% 3 = ", 10 % 3)
	print("  Why? 10 divided by 3 = 3 remainder 1")
	print("  3 × 3 = 9,  10 - 9 = 1  ← that's the remainder!")
	print("")


# ─────────────────────────────────────────────────────────────
# FOOTER
# ─────────────────────────────────────────────────────────────

func _print_footer() -> void:
	print("══════════════════════════════════════════════════")
	print("  Day 4 Complete!  Next up → Day 5: Conditionals")
	print("  if health <= 0:")
	print("      print(\"Game Over!\")")
	print("══════════════════════════════════════════════════")
