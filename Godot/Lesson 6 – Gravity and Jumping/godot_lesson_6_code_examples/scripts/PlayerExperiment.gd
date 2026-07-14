## PlayerExperiment.gd
## STEM Through Games – Day 6: EXPERIMENT SANDBOX
## =============================================================================
## This version of the player script is designed for EXPERIMENTATION.
## All the "magic numbers" are exposed as @export variables so you can
## tweak them in the Godot Inspector without editing code!
##
## STUDENT CHALLENGE: Try every experiment below. Write your observations
## in your Game Design Journal.
## =============================================================================

extends CharacterBody2D

# ─── EXPORT VARIABLES (editable in the Inspector!) ────────────────────────────
# @export makes these show up in Godot's Inspector panel on the right.
# You can change them while the game is stopped AND while it's running!

@export_group("Movement")
## How fast the player moves horizontally.
@export var speed: float = 250.0

@export_group("Jumping")
## The upward speed burst when jumping. Must be NEGATIVE to go up!
## EXPERIMENT: Change this to -200, -500, -800. How does each feel?
@export var jump_velocity: float = -500.0

## Allow the player to jump more than once before landing?
## EXPERIMENT: Set to 2 for a double-jump!
@export var max_jumps: int = 1

## Extra frames after walking off a ledge where you can still jump.
## This is called "coyote time" – a real technique in professional games!
## EXPERIMENT: Set to 0 vs 8 – notice the difference at ledge edges.
@export var coyote_frames: int = 6

@export_group("Gravity Override")
## Set to true to override the project gravity with the value below.
@export var override_gravity: bool = false

## Custom gravity value (pixels/sec²). Only used if override_gravity = true.
## EXPERIMENT: Try 300 (floaty moon), 980 (Earth default), 2500 (heavy planet).
@export var custom_gravity: float = 980.0

# ─── INTERNAL STATE ───────────────────────────────────────────────────────────
var _jumps_remaining: int = 0
var _coyote_timer: int = 0
var _was_on_floor: bool = false

# ─── READY ────────────────────────────────────────────────────────────────────
func _ready() -> void:
	_jumps_remaining = max_jumps

# ─── PHYSICS PROCESS ──────────────────────────────────────────────────────────
func _physics_process(delta: float) -> void:

	# ── GRAVITY ───────────────────────────────────────────────────────────────
	if not is_on_floor():
		var grav: Vector2
		if override_gravity:
			grav = Vector2(0, custom_gravity)
		else:
			grav = get_gravity()
		velocity += grav * delta
	else:
		# Reset jump count when landing
		if not _was_on_floor:
			_jumps_remaining = max_jumps

	# ── COYOTE TIME ───────────────────────────────────────────────────────────
	# Give the player a few frames of grace after walking off a ledge.
	if _was_on_floor and not is_on_floor():
		_coyote_timer = coyote_frames
	elif _coyote_timer > 0:
		_coyote_timer -= 1

	var can_jump: bool = is_on_floor() or _coyote_timer > 0 or _jumps_remaining > 0

	# ── JUMPING ───────────────────────────────────────────────────────────────
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y = jump_velocity
		_jumps_remaining -= 1
		_coyote_timer = 0  # Consume coyote time immediately

	# ── HORIZONTAL MOVEMENT ───────────────────────────────────────────────────
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed if direction != 0 else move_toward(velocity.x, 0, speed)

	_was_on_floor = is_on_floor()
	move_and_slide()
