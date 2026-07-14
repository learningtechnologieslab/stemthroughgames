extends CharacterBody2D

# =============================================================================
# STEM Through Games Program — Day 10: Loops, Timers & Spawning
# Script: Player.gd
# =============================================================================
# Simple left/right player movement for the Day 10 playground.
# Day 11 will expand this with health, collision responses, and animation.
#
# CONCEPTS DEMONSTRATED:
#   • Input.get_axis()        — clean way to read keyboard left/right
#   • move_and_slide()        — built-in physics movement with collision
#   • Constants (SPEED)       — use constants for values that don't change
#   • Groups ("player")       — allows CoinPickup to identify the player
# =============================================================================

const SPEED: float = 220.0     # Pixels per second — change to adjust feel

# Gravity constant — used to keep the player on the ground
const GRAVITY: float = 980.0


# =============================================================================
# _ready()
# =============================================================================
func _ready() -> void:
	# Add to "player" group so coins and enemies can identify us
	add_to_group("player")


# =============================================================================
# _physics_process()
# =============================================================================
func _physics_process(delta: float) -> void:
	# ─── HORIZONTAL MOVEMENT ─────────────────────────────────────────────────
	# get_axis returns -1 (left), 0 (none), or +1 (right)
	var direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	# ─── GRAVITY ─────────────────────────────────────────────────────────────
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0.0

	move_and_slide()

	# ─── SCREEN WRAPPING ─────────────────────────────────────────────────────
	# Keep the player within the horizontal bounds of the 800px viewport
	position.x = clamp(position.x, 20, 780)
