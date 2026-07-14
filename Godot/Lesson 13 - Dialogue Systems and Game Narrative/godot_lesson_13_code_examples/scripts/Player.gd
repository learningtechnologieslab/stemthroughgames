# =============================================================================
# Player.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   Simple top-down player movement. The player can walk around the village
#   and interact with NPCs to trigger dialogue.
#
# CONTROLS:
#   WASD or Arrow Keys  → Move
#   E                   → Interact with NPCs
#   SPACE               → Also interact / advance dialogue
#
# MATH CONNECTION:
#   velocity is a Vector2 - it stores TWO numbers (x direction, y direction).
#   velocity = Vector2(1.0, 0.0) means "moving right at full speed"
#   velocity = Vector2(0.0, -1.0) means "moving up at full speed"
#   Speed is calculated using Pythagoras: the actual speed = sqrt(x² + y²)
#   normalize() ensures diagonal movement isn't faster than straight movement!
# =============================================================================

extends CharacterBody2D

# -----------------------------------------------------------------------------
# CONFIGURATION - tweak these in the Inspector
# -----------------------------------------------------------------------------
@export var move_speed: float = 200.0
@export var sprite_color: Color = Color(0.3, 0.8, 0.4)


# -----------------------------------------------------------------------------
# NODE REFERENCES
# -----------------------------------------------------------------------------
@onready var sprite:           Sprite2D       = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer if has_node("AnimationPlayer") else null


# -----------------------------------------------------------------------------
# BUILT-IN FUNCTIONS
# -----------------------------------------------------------------------------

func _ready() -> void:
	# Add to the "player" group so NPCs can detect us
	add_to_group("player")

	if sprite:
		sprite.modulate = sprite_color

	print("[Player] Ready. Use WASD to move, E to interact.")


func _physics_process(_delta: float) -> void:
	# Don't move while dialogue is active
	if DialogueManager.is_active:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	_handle_movement()


# -----------------------------------------------------------------------------
# MOVEMENT
# -----------------------------------------------------------------------------

func _handle_movement() -> void:
	# Get input direction as a Vector2
	# MATH: Input.get_vector returns a Vector2 with x and y between -1 and 1
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Fallback to arrow keys / WASD if actions aren't mapped yet
	if direction == Vector2.ZERO:
		direction.x = Input.get_axis("ui_left", "ui_right")
		direction.y = Input.get_axis("ui_up", "ui_down")

	# MATH: normalize() keeps speed consistent when moving diagonally
	# Without normalize: diagonal speed = sqrt(2) ≈ 1.41x normal speed (too fast!)
	# With normalize:    diagonal speed = 1.0x normal speed (correct)
	if direction.length() > 0:
		direction = direction.normalized()

	# MATH: velocity = direction * speed
	# If direction = (1, 0) and speed = 200, then velocity = (200, 0)
	velocity = direction * move_speed

	# Apply movement with collision detection
	move_and_slide()
