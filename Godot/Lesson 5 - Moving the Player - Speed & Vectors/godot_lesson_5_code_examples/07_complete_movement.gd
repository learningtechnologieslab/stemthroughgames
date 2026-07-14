# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 07_complete_movement.gd
# LEVEL: Putting It All Together — A production-ready movement script!
# =============================================================================
#
# This script combines EVERYTHING from today's lesson into a single,
# well-organized, professional-quality movement controller.
#
# FEATURES:
#   ✓ 4-directional movement with arrow keys / WASD
#   ✓ Normalized direction (no diagonal speed bug)
#   ✓ Smooth acceleration and friction
#   ✓ Sprint (hold Shift for 2× speed) — Extension feature
#   ✓ Clean variable organization with @export for Inspector tweaking
#   ✓ Debug mode toggle (press D)
#
# CONCEPTS USED:
#   Vector2, normalization, lerp, scalar multiplication,
#   Input handling, _physics_process, move_and_slide
# =============================================================================

extends CharacterBody2D

# ── @export makes these variables editable in the Godot Inspector ─────────────
# You can change them without touching the code!

@export_group("Movement")
@export var walk_speed: float  = 200.0   # Normal movement speed (px/sec)
@export var sprint_speed: float = 400.0  # Speed when holding Shift
@export var acceleration: float = 0.18   # How quickly we reach full speed
@export var friction: float    = 0.22    # How quickly we stop

@export_group("Debug")
@export var debug_mode: bool = false     # Toggle debug output


# ── Private variables (internal use only) ─────────────────────────────────────
var _is_sprinting: bool = false
var _current_speed: float = 0.0          # Actual speed this frame (for HUD)


# ── Ready ─────────────────────────────────────────────────────────────────────

func _ready():
	print("Player ready! Press D to toggle debug mode.")


# ── Physics Process ───────────────────────────────────────────────────────────

func _physics_process(delta: float):
	
	# 1. Read input direction
	var direction = _get_input_direction()
	
	# 2. Get the target speed (walk or sprint)
	var target_speed = sprint_speed if _is_sprinting else walk_speed
	
	# 3. Apply acceleration or friction
	if direction != Vector2.ZERO:
		var target_velocity = direction * target_speed
		velocity = velocity.lerp(target_velocity, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	
	# 4. Move and store actual speed
	move_and_slide()
	_current_speed = velocity.length()
	
	# 5. Debug output
	if debug_mode:
		_debug_print(direction, target_speed)


# ── Input Handler ─────────────────────────────────────────────────────────────

func _input(event: InputEvent):
	# Toggle debug mode with D key
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_D:
			debug_mode = !debug_mode
			print("Debug mode: ", "ON" if debug_mode else "OFF")


# ── Helper Functions ──────────────────────────────────────────────────────────

func _get_input_direction() -> Vector2:
	# Reads all movement keys and returns a normalized direction vector
	
	var direction = Vector2.ZERO
	
	# Support both Arrow Keys and WASD
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		direction.x += 1
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		direction.y += 1
	
	# Check sprint (Left Shift or Right Shift)
	_is_sprinting = Input.is_key_pressed(KEY_SHIFT)
	
	# Normalize so diagonal speed matches straight speed
	if direction.length() > 0:
		direction = direction.normalized()
	
	return direction


func _debug_print(direction: Vector2, target_speed: float):
	# Print a compact debug line every 20 frames
	if Engine.get_process_frames() % 20 == 0:
		var mode = "SPRINT" if _is_sprinting else "WALK  "
		print("[%s] dir=(%s,%s) | vel=(%s,%s) | speed=%s / %s px/s" % [
			mode,
			snapped(direction.x, 0.01),
			snapped(direction.y, 0.01),
			snapped(velocity.x, 0.1),
			snapped(velocity.y, 0.1),
			snapped(_current_speed, 0.1),
			target_speed
		])


# ── Public API — other scripts can call these ─────────────────────────────────

func get_current_speed() -> float:
	# Returns the player's actual speed this frame
	return _current_speed

func is_moving() -> bool:
	# Returns true if the player is currently moving
	return _current_speed > 5.0

func is_sprinting() -> bool:
	return _is_sprinting


# =============================================================================
# 📋 WHAT MAKES THIS "PROFESSIONAL"?
# =============================================================================
#
# 1. @export variables
#    A designer can tune walk_speed, sprint_speed, etc. in the Inspector
#    without touching a single line of code. This is how real game studios
#    work — programmers write the code, designers tune the values.
#
# 2. Separation of concerns
#    _get_input_direction()  — only reads input
#    _physics_process()      — only handles physics
#    _debug_print()          — only handles debug output
#    Each function does ONE job. Easier to read, test, and change.
#
# 3. Type hints (: float, : Vector2, -> bool)
#    Tell Godot (and other programmers) what type of data each variable holds.
#    Helps catch bugs early and makes the code self-documenting.
#
# 4. Public vs private variables
#    Variables starting with _ (like _is_sprinting) are "private" —
#    they're only meant to be used inside this script.
#    Variables without _ can be read by other scripts.
#
# 5. Comments that explain WHY, not just WHAT
#    "# Normalize so diagonal speed matches straight speed" is useful.
#    "# Sets direction to normalized" is not — the code already says that!
# =============================================================================
