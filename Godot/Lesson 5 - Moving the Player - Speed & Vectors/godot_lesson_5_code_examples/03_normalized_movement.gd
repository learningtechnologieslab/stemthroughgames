# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 03_normalized_movement.gd
# LEVEL: Bonus Challenge — Fix the Diagonal Speed Bug!
# =============================================================================
#
# THE PROBLEM:
#   In 01_basic_movement.gd, pressing two arrow keys at once makes the
#   character move FASTER diagonally. This is a real bug found in many games!
#
# THE MATH:
#   When direction = Vector2(1, -1):
#     length = √(1² + (-1)²) = √(1 + 1) = √2 ≈ 1.414
#   So velocity = direction * speed = (1.414 * 200) ≈ 282.8 px/sec
#   That's 41% faster than the intended 200 px/sec!
#
# THE FIX:
#   direction.normalized() scales the vector so its LENGTH = 1,
#   without changing its DIRECTION.
#   Then (1, -1).normalized() = (0.707, -0.707)   (length = exactly 1.0)
#   So velocity = (0.707, -0.707) * 200 = (141.4, -141.4)  →  speed = 200 ✓
#
# MATH CONNECTION:
#   Normalizing a vector = dividing each component by the vector's length
#   normalized.x = x / length
#   normalized.y = y / length
# =============================================================================

extends CharacterBody2D

var speed = 200


func _physics_process(delta):
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	# ── THE FIX: Normalize the direction vector ───────────────────────────────
	#
	# Before normalization:  direction = (1, -1)     length ≈ 1.414
	# After normalization:   direction = (0.707, -0.707)  length = 1.0
	#
	# We check length() > 0 first to avoid a "divide by zero" error
	# when direction is Vector2.ZERO (no keys pressed).
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Now velocity will always be exactly `speed` pixels per second,
	# regardless of whether moving straight or diagonally.
	velocity = direction * speed
	
	move_and_slide()
	
	# ── Debug display ─────────────────────────────────────────────────────────
	# Uncomment these lines to see the speed printed in real-time:
	# if direction != Vector2.ZERO:
	#     print("Actual speed: ", snapped(velocity.length(), 0.1), " px/sec (target: ", speed, ")")


# =============================================================================
# 🔬 EXPERIMENT: Compare with and without normalization
# =============================================================================
#
# WITHOUT .normalized() (comment out the if-block above):
#   Straight movement:   speed = 200 px/sec  ✓
#   Diagonal movement:   speed ≈ 283 px/sec  ✗  (too fast!)
#
# WITH .normalized():
#   Straight movement:   speed = 200 px/sec  ✓
#   Diagonal movement:   speed = 200 px/sec  ✓  (fixed!)
#
# Q: Can you FEEL the difference while playing?
# Q: Does the fixed version feel "better" or just "different"?
# Q: Can you think of a game where faster diagonal movement is actually fun?
# =============================================================================


# =============================================================================
# 📐 THE MATH — Pythagorean Theorem in Action
# =============================================================================
#
# Remember: a² + b² = c²
#
# For diagonal direction Vector2(1, 1):
#   a = 1  (x component)
#   b = 1  (y component)
#   c = √(1² + 1²) = √2 ≈ 1.414  ← this is the length / magnitude
#
# After normalizing:
#   normalized.x = 1 / √2 ≈ 0.707
#   normalized.y = 1 / √2 ≈ 0.707
#   new length   = √(0.707² + 0.707²) = √(0.5 + 0.5) = √1 = 1.0  ✓
#
# Multiplied by speed 200:
#   velocity.x = 0.707 × 200 ≈ 141.4
#   velocity.y = 0.707 × 200 ≈ 141.4
#   actual speed = √(141.4² + 141.4²) = √(19994 + 19994) ≈ 200  ✓
# =============================================================================
