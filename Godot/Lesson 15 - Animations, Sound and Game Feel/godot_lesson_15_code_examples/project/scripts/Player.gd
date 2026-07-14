## Player.gd
## ============================================================
## STEM Through Games – Day 15: Animations, Sound & Game Feel
## ============================================================
##
## This script controls the player character.
## It handles:
##   1. Movement physics (walk, jump)
##   2. Animation state switching (idle, run, jump, hurt)
##   3. Sound effects (jump, hurt, land)
##   4. Sprite flipping based on direction
##
## HOW TO USE:
##   Attach this script to a CharacterBody2D node that has:
##     - AnimatedSprite2D (child node named "AnimatedSprite2D")
##     - JumpSound       (AudioStreamPlayer child)
##     - LandSound       (AudioStreamPlayer child)
##     - HurtSound       (AudioStreamPlayer child)
##
## ============================================================

extends CharacterBody2D

# ── MOVEMENT CONSTANTS ────────────────────────────────────────
## How fast the player moves left/right (pixels per second)
const SPEED       := 200.0

## How strong the jump force is (negative = upward in Godot)
const JUMP_FORCE  := -480.0

## How quickly the player slows down on the ground
const FRICTION    := 800.0

## How quickly the player accelerates when moving
const ACCELERATION := 1200.0

# ── GRAVITY ───────────────────────────────────────────────────
## Pull from project physics settings (so changing gravity there affects this)
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# ── STATE TRACKING ────────────────────────────────────────────
## Is the player currently in a hurt state?
var is_hurt: bool = false

## Timer so hurt animation plays for a minimum time
var hurt_timer: float = 0.0
const HURT_DURATION := 0.5  # seconds

# ── ANIMATION NAMES ──────────────────────────────────────────
## These must match the animation names you set in SpriteFrames!
const ANIM_IDLE  := "idle"
const ANIM_RUN   := "run"
const ANIM_JUMP  := "jump"
const ANIM_FALL  := "fall"
const ANIM_HURT  := "hurt"


# ════════════════════════════════════════════════════════════
# _ready() – Called once when the scene loads
# ════════════════════════════════════════════════════════════
func _ready() -> void:
	# Make sure the sprite starts on idle
	$AnimatedSprite2D.play(ANIM_IDLE)


# ════════════════════════════════════════════════════════════
# _physics_process(delta) – Called every physics frame (~60/sec)
# delta = time since last frame (usually ~0.016 seconds)
# ════════════════════════════════════════════════════════════
func _physics_process(delta: float) -> void:
	# ── STEP 1: Apply gravity ────────────────────────────────
	# Every frame, add gravity to vertical velocity
	# (Unless the player is standing on the floor)
	if not is_on_floor():
		velocity.y += gravity * delta

	# ── STEP 2: Handle jumping ───────────────────────────────
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		$JumpSound.play()      # 🔊 Play jump sound
		_check_land_flag()     # Reset landing detection

	# ── STEP 3: Horizontal movement ──────────────────────────
	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		# Smoothly accelerate toward the target speed
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		# Smoothly decelerate to a stop (friction)
		velocity.x = move_toward(velocity.x, 0.0, FRICTION * delta)

	# ── STEP 4: Move and detect floor collisions ─────────────
	var was_in_air := not is_on_floor()
	move_and_slide()

	# Play a landing sound when the player hits the ground
	if was_in_air and is_on_floor():
		$LandSound.play()      # 🔊 Play landing thud

	# ── STEP 5: Update animation ─────────────────────────────
	_update_animation(delta)

	# ── STEP 6: Flip sprite to face direction of travel ──────
	_update_facing()


# ════════════════════════════════════════════════════════════
# _update_animation() – Chooses the right animation to play
# ════════════════════════════════════════════════════════════
func _update_animation(delta: float) -> void:
	# ── HURT overrides everything ────────────────────────────
	if is_hurt:
		hurt_timer -= delta
		if hurt_timer <= 0.0:
			is_hurt = false         # Hurt state ended
		else:
			$AnimatedSprite2D.play(ANIM_HURT)
			return                  # Skip other animation logic

	# ── AIRBORNE: jump or fall ───────────────────────────────
	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite2D.play(ANIM_JUMP)   # Rising
		else:
			$AnimatedSprite2D.play(ANIM_FALL)   # Falling
		return

	# ── GROUNDED: run or idle ────────────────────────────────
	if velocity.x != 0:
		$AnimatedSprite2D.play(ANIM_RUN)
	else:
		$AnimatedSprite2D.play(ANIM_IDLE)


# ════════════════════════════════════════════════════════════
# _update_facing() – Flips sprite based on movement direction
## MATH NOTE: velocity.x is positive = moving right,
##            negative = moving left
# ════════════════════════════════════════════════════════════
func _update_facing() -> void:
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true    # Facing left
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false   # Facing right
	# If velocity.x == 0, keep the last direction (no change)


# ════════════════════════════════════════════════════════════
# take_hurt() – Called externally (e.g. by an enemy or hazard)
# ════════════════════════════════════════════════════════════
func take_hurt() -> void:
	if is_hurt:
		return  # Can't get hurt again while already hurt
	is_hurt = true
	hurt_timer = HURT_DURATION
	$HurtSound.play()         # 🔊 Play hurt sound
	# Knock the player back slightly
	velocity.x = -sign(velocity.x) * 150.0
	velocity.y = -200.0


# ════════════════════════════════════════════════════════════
# _check_land_flag() – Internal helper for landing detection
# ════════════════════════════════════════════════════════════
func _check_land_flag() -> void:
	# Nothing stored here yet – just a placeholder
	# Students can extend this to track consecutive jumps, etc.
	pass


# ════════════════════════════════════════════════════════════
# ── 🧮 MATH CHALLENGE ZONE ──────────────────────────────────
# ════════════════════════════════════════════════════════════
#
# QUESTION 1:
#   The run animation has 8 frames at 12 FPS.
#   How long does one loop take?
#   Formula: loop_time = frames / fps
#   Answer: 8 / 12 = 0.667 seconds
#
# QUESTION 2:
#   If you want the jump animation to finish in exactly 0.3 seconds
#   and it has 6 frames, what FPS should you set?
#   Formula: fps = frames / desired_time
#   Answer: 6 / 0.3 = 20 FPS
#
# QUESTION 3:
#   The player moves at SPEED = 200 px/sec.
#   One run animation loop = 0.667 sec.
#   How far does the player travel in one loop?
#   Formula: distance = speed × time
#   Answer: 200 × 0.667 = 133.4 pixels per loop
#
# ════════════════════════════════════════════════════════════
