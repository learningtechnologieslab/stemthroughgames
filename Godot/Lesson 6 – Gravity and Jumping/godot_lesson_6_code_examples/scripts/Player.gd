## Player.gd
## STEM Through Games – Day 6: Gravity & Jumping
## =============================================================================
## This script is the heart of today's lesson. Read every comment carefully!
##
## KEY CONCEPTS COVERED:
##   • Gravity as constant acceleration (added to velocity every frame)
##   • Jumping via an upward (negative Y) velocity burst
##   • Why JUMP_VELOCITY is negative (screen-space Y axis is flipped)
##   • How delta makes physics frame-rate independent
##   • The parabola: why jump arcs curve the way they do
## =============================================================================

extends CharacterBody2D

# ─── CONSTANTS ────────────────────────────────────────────────────────────────
# Constants never change while the game runs. We use ALL_CAPS by convention.

## How fast the player moves left and right (pixels per second).
const SPEED: float = 250.0

## The upward velocity applied when the player jumps.
## WHY NEGATIVE? In Godot's 2D coordinate system, Y increases DOWNWARD.
## So to move UP the screen, we need a NEGATIVE Y value.
## Try changing this! Smaller number (e.g. -200) = tiny hop.
## Larger number (e.g. -800) = huge jump.
const JUMP_VELOCITY: float = -500.0

# ─── CALLED EVERY PHYSICS FRAME ───────────────────────────────────────────────
## _physics_process runs every physics tick (default: 60 times per second).
## delta = the time in seconds since the last frame (usually ~0.016 at 60fps).
## Multiplying by delta makes movement frame-rate independent.
func _physics_process(delta: float) -> void:

	# ── STEP 1: APPLY GRAVITY ─────────────────────────────────────────────────
	# get_gravity() returns the gravity vector from Project Settings.
	# By default this is Vector2(0, 980) — 980 pixels/sec² downward.
	#
	# We only add gravity when the player is NOT standing on the floor.
	# If we added it while on the floor, the character would sink into the ground.
	#
	# MATH CONNECTION:
	#   velocity.y += gravity * delta
	#   This is exactly: Δv = a × Δt  (change in velocity = acceleration × time)
	#   Doing this every frame = constant acceleration = GRAVITY!
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ── STEP 2: JUMPING ───────────────────────────────────────────────────────
	# is_action_just_pressed fires on the EXACT frame the key is pressed.
	# (vs. is_action_pressed which fires every frame the key is held down)
	#
	# We also check is_on_floor() so the player can only jump from the ground.
	# Without this check, the player could jump infinitely in the air!
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		# WHAT HAPPENS NEXT:
		# Frame 1:  velocity.y = -500   (shooting upward)
		# Frame 2:  velocity.y = -500 + 16.3 ≈ -484  (gravity slows the rise)
		# Frame 30: velocity.y ≈ 0       (peak of the jump – momentarily still)
		# Frame 31: velocity.y ≈ +16     (now falling back down)
		# → This arc is a PARABOLA: y(t) = v₀t + ½gt²

	# ── STEP 3: HORIZONTAL MOVEMENT ──────────────────────────────────────────
	# Preview of Day 7 – left/right movement is included so students can
	# actually move around the level and test their jumping.
	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		# Gradually slow down when no key is pressed (friction simulation).
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# ── STEP 4: MOVE AND DETECT COLLISIONS ────────────────────────────────────
	# move_and_slide() does two things:
	#   1. Moves the character by velocity * delta automatically
	#   2. Handles collision detection and response with the physics engine
	#
	# IMPORTANT: This MUST be the last call in _physics_process.
	# It reads velocity, applies movement, and updates is_on_floor().
	move_and_slide()
