# =============================================================================
# Exercises.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# STUDENT SANDBOX — Run these exercises to practice conditionals!
#
# HOW TO USE:
#   1. Attach this script to any Node in a scene
#   2. Run the scene — all exercises print to the Output panel
#   3. Read each exercise, understand what it does, then try modifying it
#
# You can also call any exercise function individually from the Godot console.
# =============================================================================

extends Node


func _ready() -> void:
	print("\n")
	print("╔══════════════════════════════════════════╗")
	print("║  STEM Through Games — Day 9 Exercises    ║")
	print("╚══════════════════════════════════════════╝")
	print("")

	run_all_exercises()


func run_all_exercises() -> void:
	exercise_1_basic_if()
	exercise_2_elif_chain()
	exercise_3_comparison_operators()
	exercise_4_boolean_and()
	exercise_5_boolean_or()
	exercise_6_boolean_not()
	exercise_7_nested_conditionals()
	exercise_8_your_turn()


# =============================================================================
# EXERCISE 1: Basic if / else
# =============================================================================
func exercise_1_basic_if() -> void:
	print("─── Exercise 1: Basic if / else ───────────────")

	var health: int = 100

	# A simple if/else with ONE condition
	if health > 0:
		print("  Player is alive. Health: ", health)
	else:
		print("  Player is dead.")

	# Now test with a different value
	health = 0
	if health > 0:
		print("  Player is alive. Health: ", health)
	else:
		print("  Player is dead.")

	# ------------------------------------------------------------------
	# 🔧 TRY IT: Change health to -10. What happens? Does the output change?
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 2: if / elif / else chain (from the lesson)
# =============================================================================
func exercise_2_elif_chain() -> void:
	print("─── Exercise 2: if / elif / else ──────────────")

	# Test the SAME chain with different values
	var test_values: Array = [100, 50, 25, 0, -5]

	for health in test_values:
		print("  Testing health = ", health, " ...")

		if health <= 0:
			print("    → BRANCH 1 ran: Game Over! (health <= 0 is TRUE)")
		elif health < 30:
			print("    → BRANCH 2 ran: Low health warning! (health < 30 is TRUE)")
		else:
			print("    → BRANCH 3 ran: Normal. (neither above condition was true)")

	# ------------------------------------------------------------------
	# 🔧 TRY IT: Add a new elif for health < 60 that prints "Moderate health".
	#           Where should it go in the chain? Does order matter? (YES!)
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 3: Comparison operators
# =============================================================================
func exercise_3_comparison_operators() -> void:
	print("─── Exercise 3: Comparison Operators ──────────")

	var score: int = 7

	# Each comparison operator returns TRUE or FALSE
	# We use print() to see the result directly
	print("  score = ", score)
	print("  score == 7  → ", score == 7)   # Equal to
	print("  score != 7  → ", score != 7)   # Not equal to
	print("  score <  10 → ", score < 10)   # Less than
	print("  score >  5  → ", score > 5)    # Greater than
	print("  score <= 7  → ", score <= 7)   # Less than or equal to
	print("  score >= 10 → ", score >= 10)  # Greater than or equal to

	# ------------------------------------------------------------------
	# 🔧 TRY IT: Change score to 10. Which comparisons flip from false to true?
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 4: Boolean AND (&&) — BOTH must be true
# =============================================================================
func exercise_4_boolean_and() -> void:
	print("─── Exercise 4: Boolean AND (&&) ──────────────")

	var health: int = 50
	var has_key: bool = true

	print("  health = ", health, "  has_key = ", has_key)

	# AND: BOTH sides must be TRUE for the whole condition to be TRUE
	if health > 0 && has_key:
		print("  ✓ Player can open the door (alive AND has key)")
	else:
		print("  ✗ Can't open door")

	# What if the player doesn't have the key?
	has_key = false
	print("  health = ", health, "  has_key = ", has_key)
	if health > 0 && has_key:
		print("  ✓ Player can open the door")
	else:
		print("  ✗ Can't open door (has_key is false — AND fails)")

	# ------------------------------------------------------------------
	# 🔧 TRY IT: Add a third condition: score >= 5. Now all three must
	#           be true. What happens when score is 3? When it's 7?
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 5: Boolean OR (||) — EITHER can be true
# =============================================================================
func exercise_5_boolean_or() -> void:
	print("─── Exercise 5: Boolean OR (||) ────────────────")

	var is_jumping: bool = false
	var is_crouching: bool = true

	print("  is_jumping = ", is_jumping, "  is_crouching = ", is_crouching)

	# OR: EITHER side being TRUE makes the whole condition TRUE
	if is_jumping || is_crouching:
		print("  ✓ Player is in a non-standing pose")
	else:
		print("  ✗ Player is standing normally")

	# What if neither is true?
	is_crouching = false
	print("  is_jumping = ", is_jumping, "  is_crouching = ", is_crouching)
	if is_jumping || is_crouching:
		print("  ✓ Non-standing pose")
	else:
		print("  ✗ Player is standing (both are false — OR fails)")

	# ------------------------------------------------------------------
	# 🔧 TRY IT: What happens when BOTH are true? Does OR still work? (YES)
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 6: Boolean NOT (!) — Inverts the value
# =============================================================================
func exercise_6_boolean_not() -> void:
	print("─── Exercise 6: Boolean NOT (!) ────────────────")

	var is_game_over: bool = false

	print("  is_game_over = ", is_game_over)
	print("  !is_game_over = ", !is_game_over)   # NOT flips it

	# "Only run movement if the game is NOT over"
	if !is_game_over:
		print("  ✓ Game is active — movement allowed")
	else:
		print("  ✗ Game is over — movement blocked")

	# Now flip the flag
	is_game_over = true
	print("  is_game_over = ", is_game_over)
	if !is_game_over:
		print("  ✓ Game is active")
	else:
		print("  ✗ Game is over — movement blocked")

	# ------------------------------------------------------------------
	# 🔧 TRY IT: Rewrite the condition WITHOUT using !
	#           (Hint: if is_game_over == false)
	#           Both versions do the same thing — which is easier to read?
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 7: Nested conditionals
# =============================================================================
func exercise_7_nested_conditionals() -> void:
	print("─── Exercise 7: Nested Conditionals ───────────")

	var score: int = 12
	var health: int = 8

	# A conditional INSIDE another conditional
	if score >= 10:
		print("  Score is enough to win!")

		# Inner check — only runs if the outer condition was already true
		if health < 10:
			print("  🏆  YOU WIN! But it was a close call — only ", health, " HP left!")
		else:
			print("  🏆  YOU WIN! Finished strong with ", health, " HP remaining.")
	else:
		print("  Not enough score yet. Need ", 10 - score, " more point(s).")

	# ------------------------------------------------------------------
	# 🔧 TRY IT:
	#   - Change score to 8. Does the inner block ever run?
	#   - Change health to 50. Which win message prints?
	# ------------------------------------------------------------------
	print("")


# =============================================================================
# EXERCISE 8: YOUR TURN — Write your own conditional
# =============================================================================
func exercise_8_your_turn() -> void:
	print("─── Exercise 8: Your Turn! ─────────────────────")
	print("  Edit this function and add your own conditional below.")
	print("")

	# === STUDENT CODE GOES HERE ===

	var my_score: int = 5         # Change this value
	var my_health: int = 60       # Change this value
	var my_has_shield: bool = false  # Change this value

	# TODO: Write an if/elif/else that checks my_score:
	#   - if score >= 10: print "You Win!"
	#   - elif score >= 5: print "Halfway there!"
	#   - else: print "Keep going!"

	# TODO: Write an AND condition:
	#   - if score >= 10 AND health > 0: print "Perfect victory!"

	# TODO: Write a NOT condition:
	#   - if NOT has_shield: print "Watch out — no shield!"

	print("  (Add your code above this line)")
	print("")
	print("╔══════════════════════════════════════════╗")
	print("║  All exercises complete! Check Output.   ║")
	print("╚══════════════════════════════════════════╝")
