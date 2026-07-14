# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 08_math_worksheet.gd
# LEVEL: Math Practice — Run this to check your vector calculations!
# =============================================================================
#
# WHAT THIS SCRIPT DOES:
#   This is NOT a movement script — it has no player or physics.
#   Attach it to any Node and run it (F5).
#   It prints a complete vector math worksheet to the Output panel,
#   showing the step-by-step calculations for all the lesson examples.
#
# HOW TO USE:
#   1. Create a new scene with a single Node (not CharacterBody2D)
#   2. Attach this script to that Node
#   3. Press F5 — read the Output panel
#   4. Try predicting each answer BEFORE you see it!
# =============================================================================

extends Node


func _ready():
	print_worksheet()


func print_worksheet():
	
	# ── SECTION 1: 1D Number Line ────────────────────────────────────────────
	_section("PART 1: 1D Number Line (Warm-Up Review)")
	
	_problem("Start: 5, Move: +3", "Where do you land?")
	_show_calc_1d(5, 3)
	
	_problem("Start: 8, Move: -5", "Where do you land?")
	_show_calc_1d(8, -5)
	
	_problem("Start: 0, Move: -4", "Where do you land?")
	_show_calc_1d(0, -4)
	
	
	# ── SECTION 2: 2D Vectors ────────────────────────────────────────────────
	_section("PART 2: 2D Coordinate Plane")
	
	_problem("Start: (2, 3), Move by: (4, -1)", "Where do you land?")
	_show_calc_2d(Vector2(2, 3), Vector2(4, -1))
	
	_problem("Start: (0, 0), Move by: (3, 5)", "Where do you land?")
	_show_calc_2d(Vector2(0, 0), Vector2(3, 5))
	
	_problem("Start: (10, 10), Move by: (-3, -7)", "Where do you land?")
	_show_calc_2d(Vector2(10, 10), Vector2(-3, -7))
	
	
	# ── SECTION 3: Direction × Speed = Velocity ──────────────────────────────
	_section("PART 3: velocity = direction * speed")
	
	var speed = 200.0
	
	_problem("direction = Vector2(1, 0),  speed = 200", "What is velocity?")
	_show_velocity(Vector2(1, 0), speed)
	
	_problem("direction = Vector2(-1, 0), speed = 200", "What is velocity?")
	_show_velocity(Vector2(-1, 0), speed)
	
	_problem("direction = Vector2(0, -1), speed = 200", "What is velocity?  (Which way on screen?)")
	_show_velocity(Vector2(0, -1), speed)
	
	_problem("direction = Vector2(0, 1),  speed = 200", "What is velocity?  (Which way on screen?)")
	_show_velocity(Vector2(0, 1), speed)
	
	_problem("direction = Vector2(1, -1), speed = 200", "What is velocity?  (Is it faster?)")
	_show_velocity(Vector2(1, -1), speed)
	
	
	# ── SECTION 4: Normalization ─────────────────────────────────────────────
	_section("PART 4: Normalization — Fixing the Diagonal Speed Bug")
	
	_problem("direction = Vector2(1, -1)", "What is the length?  What is the normalized vector?")
	_show_normalization(Vector2(1, -1), speed)
	
	_problem("direction = Vector2(1, 1)", "What is the length?  What is the normalized vector?")
	_show_normalization(Vector2(1, 1), speed)
	
	_problem("direction = Vector2(3, 4)", "What is the length?  (Hint: Pythagorean theorem!)")
	_show_normalization(Vector2(3, 4), speed)
	
	
	# ── SECTION 5: Speed & Time ──────────────────────────────────────────────
	_section("PART 5: Real-World Connection — Speed × Time = Distance")
	
	print("  Formula: distance = speed × time")
	print("")
	_problem("speed = 200 px/sec, time = 3 seconds", "How far does the player move?")
	_show_distance(200, 3)
	
	_problem("speed = 50 px/sec, time = 5 seconds", "How far does the player move?")
	_show_distance(50, 5)
	
	_problem("A screen is 1280 pixels wide. Speed = 300 px/sec.", "How many seconds to cross the screen?")
	_show_time_to_cross(1280, 300)
	
	print("")
	print("══════════════════════════════════════════════")
	print("  End of worksheet. Well done! 🎮")
	print("══════════════════════════════════════════════")


# ── Helper display functions ──────────────────────────────────────────────────

func _section(title: String):
	print("")
	print("══════════════════════════════════════════════")
	print("  " + title)
	print("══════════════════════════════════════════════")

func _problem(given: String, question: String):
	print("")
	print("  Given:    " + given)
	print("  Question: " + question)
	print("  Answer:")

func _show_calc_1d(start: float, move: float):
	var result = start + move
	print("    %s + (%s) = %s" % [start, move, result])

func _show_calc_2d(start: Vector2, move: Vector2):
	var result = start + move
	print("    x: %s + (%s) = %s" % [start.x, move.x, result.x])
	print("    y: %s + (%s) = %s" % [start.y, move.y, result.y])
	print("    Landing position: (%s, %s)" % [result.x, result.y])

func _show_velocity(direction: Vector2, speed: float):
	var vel = direction * speed
	print("    velocity.x = direction.x × speed = %s × %s = %s" % [direction.x, speed, vel.x])
	print("    velocity.y = direction.y × speed = %s × %s = %s" % [direction.y, speed, vel.y])
	print("    velocity = (%s, %s)" % [vel.x, vel.y])
	print("    Actual speed (magnitude) = √(%s² + %s²) = %s px/sec" % [vel.x, vel.y, snapped(vel.length(), 0.01)])
	if direction.y < 0:
		print("    → Moving UP on screen (negative Y = up in Godot)")
	elif direction.y > 0:
		print("    → Moving DOWN on screen")
	if direction.x != 0 and direction.y != 0:
		print("    ⚠️  DIAGONAL: Actual speed (%s) ≠ set speed (%s)!" % [snapped(vel.length(), 0.1), speed])

func _show_normalization(direction: Vector2, speed: float):
	var length = direction.length()
	var normalized = direction.normalized()
	var vel_raw  = direction * speed
	var vel_norm = normalized * speed
	print("    Raw direction:         (%s, %s)" % [direction.x, direction.y])
	print("    Length (magnitude):    √(%s² + %s²) = √%s ≈ %s" % [
		direction.x, direction.y,
		snapped(direction.x*direction.x + direction.y*direction.y, 0.01),
		snapped(length, 0.001)])
	print("    Normalized:            (%s, %s)  (length = %s)" % [
		snapped(normalized.x, 0.001), snapped(normalized.y, 0.001),
		snapped(normalized.length(), 0.001)])
	print("    Velocity (raw):        (%s, %s)  → speed = %s px/sec" % [
		vel_raw.x, vel_raw.y, snapped(vel_raw.length(), 0.1)])
	print("    Velocity (normalized): (%s, %s)  → speed = %s px/sec ✓" % [
		snapped(vel_norm.x, 0.1), snapped(vel_norm.y, 0.1), snapped(vel_norm.length(), 0.1)])

func _show_distance(spd: float, time: float):
	var dist = spd * time
	print("    distance = %s × %s = %s pixels" % [spd, time, dist])

func _show_time_to_cross(distance: float, spd: float):
	var time = distance / spd
	print("    time = distance ÷ speed = %s ÷ %s = %s seconds" % [distance, spd, snapped(time, 0.01)])
