# =============================================================================
# Player.gd
# STEM Through Games – Day 11: Enemy Behavior & Simple AI
# =============================================================================
# PURPOSE:
#   A simple top-down player controller. The player moves with WASD or arrow
#   keys. The Enemy scripts will read this node's global_position to calculate
#   chase direction.
#
# CONCEPTS COVERED:
#   • Input.get_vector() — reads four inputs and returns a normalized 2D vector
#   • CharacterBody2D / move_and_slide() — physics-based movement with collisions
#   • global_position — world-space position, used by enemy AI
# =============================================================================

extends CharacterBody2D

# ── Exported variables (editable in the Godot Inspector) ─────────────────────
@export var speed: float = 180.0   ## How fast the player moves (pixels per second)

# ── Internal references ──────────────────────────────────────────────────────
@onready var sprite: ColorRect = $Sprite
@onready var label:  Label     = $NameLabel

# =============================================================================
func _ready() -> void:
	# Make the player visually distinct (bright green square)
	sprite.color = Color(0.2, 0.85, 0.3)
	label.text   = "PLAYER"


# =============================================================================
func _physics_process(_delta: float) -> void:
	# ── Read input ────────────────────────────────────────────────────────────
	# Input.get_vector() reads four named actions and returns a Vector2.
	# The result is ALREADY normalized — diagonal movement won't be faster.
	#
	#   Input.get_vector("left", "right", "up", "down")
	#                      ↑       ↑       ↑      ↑
	#               negative-x  positive-x  negative-y  positive-y
	#
	var direction: Vector2 = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)

	# ── Apply velocity ────────────────────────────────────────────────────────
	# Multiply the unit direction vector by speed to get pixels-per-second.
	# If direction is zero (no key held), velocity becomes Vector2.ZERO.
	velocity = direction * speed

	# ── Move ─────────────────────────────────────────────────────────────────
	# move_and_slide() applies velocity, handles wall collisions, and updates
	# the CharacterBody2D's position automatically.
	move_and_slide()
