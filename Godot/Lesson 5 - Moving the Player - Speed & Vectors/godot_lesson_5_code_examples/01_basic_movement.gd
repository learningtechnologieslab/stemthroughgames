# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 01_basic_movement.gd
# LEVEL: Starter (follow along with teacher)
# =============================================================================
#
# WHAT THIS SCRIPT DOES:
#   Moves a character using arrow keys.
#   This is the core script for today's lesson.
#
# HOW TO USE:
#   1. Create a CharacterBody2D node in Godot
#   2. Add a CollisionShape2D child (use a RectangleShape2D or CapsuleShape2D)
#   3. Add a Sprite2D child (or ColorRect so you can see the character)
#   4. Attach this script to the CharacterBody2D
#   5. Press F5 to run!
#
# MATH CONNECTION:
#   velocity = direction * speed
#   This is vector multiplication:
#     direction is a Vector2 (has x and y parts)
#     speed is a number (called a "scalar")
#     multiplying them gives us velocity — also a Vector2
# =============================================================================

extends CharacterBody2D

# ── Variables ─────────────────────────────────────────────────────────────────

var speed = 200   # How many pixels the player moves per second
                  # Try changing this! (see the challenges at the bottom)


# ── Physics Process ───────────────────────────────────────────────────────────
# _physics_process() is called automatically by Godot 60 times per second.
# We use it for movement because it syncs with the physics engine.
# "delta" = the time since the last frame (usually about 0.016 seconds)

func _physics_process(delta):
	
	# Step 1: Start with no direction (standing still)
	var direction = Vector2.ZERO
	# Vector2.ZERO means Vector2(0, 0) — no movement in either axis
	
	# Step 2: Check which keys are held down, and update direction
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1      # Moving RIGHT: positive X
	
	if Input.is_action_pressed("ui_left"):
		direction.x = -1     # Moving LEFT: negative X
	
	if Input.is_action_pressed("ui_up"):
		direction.y = -1     # Moving UP: NEGATIVE Y
		                     # ⚠️ In Godot, Y increases DOWNWARD on screen
		                     #    So to move UP, we use negative Y!
	
	if Input.is_action_pressed("ui_down"):
		direction.y = 1      # Moving DOWN: positive Y
	
	# Step 3: Calculate velocity
	# velocity = direction × speed
	# Example: direction = (1, 0), speed = 200
	#          velocity = (1 × 200, 0 × 200) = (200, 0)  → moving right at 200 px/sec
	velocity = direction * speed
	
	# Step 4: Move the character!
	# move_and_slide() uses the velocity we just set.
	# It also handles collisions (the character won't pass through walls).
	move_and_slide()


# =============================================================================
# 🎮 CHALLENGES — Try these after the basic script works!
# =============================================================================
#
# CHALLENGE 1 — Slow Motion
#   Change: var speed = 50
#   Q: How does the game feel? What genre would use this speed?
#
# CHALLENGE 2 — Hyperspeed
#   Change: var speed = 800
#   Q: Is this fun? When might a designer want extreme speed?
#
# CHALLENGE 3 — Diagonal Speed Bug
#   Press two arrow keys at once (e.g. right + up).
#   Q: Does diagonal feel faster? Why? (Hint: think about Pythagoras!)
#   See file 03_normalized_movement.gd for the fix.
#
# CHALLENGE 4 — Remove Vector2.ZERO
#   Comment out the line: # var direction = Vector2.ZERO
#   Q: What happens? Why does the character behave strangely?
#
# CHALLENGE 5 — One Axis Only
#   Delete the up/down if-blocks so only left/right work.
#   Q: What kind of game only needs horizontal movement?
# =============================================================================
