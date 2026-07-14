## =============================================================
## STEM Through Games — Day 4
## game_variables_demo.gd  |  Attach to: any Node
## =============================================================
##
## THIS IS THE STARTER SCRIPT from Main Activity, Step 2.
##
## TEACHER INSTRUCTIONS:
##   1. In Godot, add a Node to your scene.
##   2. Right-click the Node → Attach Script.
##   3. Name it "game_variables_demo.gd" and click Create.
##   4. Have students TYPE (not paste) the code below.
##   5. Press F5 to run — read the Output panel together.
##
## STUDENT ACTIVITY PROGRESSION:
##   Step A — Type and run the starter script as-is.
##   Step B — Change player_name to your own name. Re-run.
##   Step C — Change health to 50. Re-run. What changed?
##   Step D — Add the score challenge line inside _ready().
##   Step E — Predict what each print() will show BEFORE running.
## =============================================================

extends Node


# ─────────────────────────────────────────────────────────────
# VARIABLES  (your game's memory — the "labeled boxes")
# ─────────────────────────────────────────────────────────────

# var means "I am declaring a new variable"
# player_name is the LABEL on the box
# = "Hero" puts the value "Hero" INSIDE the box

var player_name = "Hero"   # try changing "Hero" to your name!
var health      = 100      # try changing 100 to 50
var score       = 0        # starts at 0 — no points yet


# ─────────────────────────────────────────────────────────────
# _ready()  runs automatically when the scene starts
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	# print() shows a value in the Output panel (bottom of Godot)
	print(player_name)
	print("Health: ", health)
	print("Score: ", score)

	# ── STEP D CHALLENGE ────────────────────────────────────
	# Uncomment the lines below (remove the #) to try the challenge!

	# score = score + 10        # open the box, add 10, put it back
	# print("New score: ", score)

	# health = health - 25      # taking damage!
	# print("Health after hit: ", health)


# =============================================================
# EXPECTED OUTPUT (with default values):
#
#   Hero
#   Health: 100
#   Score: 0
#
# After uncommenting the challenge lines:
#
#   Hero
#   Health: 100
#   Score: 0
#   New score: 10
#   Health after hit: 75
# =============================================================
