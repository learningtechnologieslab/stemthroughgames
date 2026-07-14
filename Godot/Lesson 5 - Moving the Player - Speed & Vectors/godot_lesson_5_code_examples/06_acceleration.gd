# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 06_acceleration.gd
# LEVEL: Extension Challenge — Make movement feel more realistic!
# =============================================================================
#
# THE PROBLEM WITH INSTANT MOVEMENT:
#   In 01_basic_movement.gd, the character jumps from 0 to full speed instantly.
#   Real objects (and fun game characters) accelerate and decelerate gradually.
#
# WHAT THIS SCRIPT ADDS:
#   • Acceleration — gradually speeds up when a key is held
#   • Deceleration (friction) — gradually slows down when keys are released
#
# THE MATH:
#   Instead of: velocity = direction * speed  (instant)
#   We use:     velocity = lerp(velocity, target_velocity, t)
#
#   lerp() = "linear interpolation"
#   lerp(a, b, t) moves from value a toward value b by fraction t
#
#   Example:
#     current velocity = (0, 0)     (standing still)
#     target velocity  = (200, 0)   (full speed right)
#     lerp at t=0.2    = (40, 0)    (20% of the way there)
#
#   Next frame:
#     current velocity = (40, 0)
#     target velocity  = (200, 0)
#     lerp at t=0.2    = (72, 0)    (20% closer again)
#   ...and so on until we reach 200.
#
# PHYSICS CONNECTION:
#   This simulates friction and inertia — concepts from Newton's Laws!
#   • Inertia: objects resist changes in velocity
#   • Friction: a force that opposes motion
# =============================================================================

extends CharacterBody2D

# ── Configuration — try changing these! ───────────────────────────────────────

var speed = 250

# How quickly the character reaches full speed (0.0 = never, 1.0 = instant)
# Try: 0.05 (sluggish tank), 0.2 (normal), 0.8 (snappy/responsive)
@export var acceleration = 0.15

# How quickly the character stops when no key is pressed
# Try: 0.05 (ice / slippery), 0.2 (normal), 0.9 (instant stop)
@export var friction = 0.2


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
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	# ── Acceleration & Friction using lerp ───────────────────────────────────
	
	if direction != Vector2.ZERO:
		# Player is pressing a key: accelerate toward the target velocity
		var target_velocity = direction * speed
		velocity = velocity.lerp(target_velocity, acceleration)
		
	else:
		# No key pressed: decelerate toward zero (friction / drag)
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	move_and_slide()


# =============================================================================
# 🎮 FEEL EXPERIMENT — What do these settings remind you of?
# =============================================================================
#
#   acceleration = 0.05, friction = 0.05
#     → Feels like: an ice rink, a spaceship, underwater
#
#   acceleration = 0.15, friction = 0.15
#     → Feels like: a normal platformer character
#
#   acceleration = 0.8, friction = 0.8
#     → Feels like: snappy, arcade-style movement
#
#   acceleration = 0.05, friction = 0.9
#     → Feels like: slow to start, but stops instantly (sticky feet on ice?)
#
#   acceleration = 0.9, friction = 0.05
#     → Feels like: full-speed instantly, but slides forever (rocket boots!)
#
# Q: What combination feels most fun to you?
# Q: If you were making a racing game, which settings would you choose?
# Q: What about a ghost / horror character? A superhero?
# =============================================================================


# =============================================================================
# 📐 LERP MATH — Understanding interpolation
# =============================================================================
#
# lerp(a, b, t) formula:
#   result = a + (b - a) * t
#
# Example: lerp(0, 200, 0.2)
#   = 0 + (200 - 0) * 0.2
#   = 0 + 40
#   = 40
#
# This is the same as: a * (1-t) + b * t
#   = 0 * 0.8 + 200 * 0.2
#   = 0 + 40 = 40  ✓
#
# After N frames of lerp(current, 200, 0.2):
#   Frame 0: velocity =   0
#   Frame 1: velocity =  40  (20% of 200)
#   Frame 2: velocity =  72  (20% of 160 remaining → +32)
#   Frame 3: velocity =  97.6
#   Frame 10: velocity ≈ 178.5   (89% of max speed)
#   Frame 20: velocity ≈ 198.8   (99% of max speed)
#   → It approaches 200 but never quite reaches it exactly!
# =============================================================================
