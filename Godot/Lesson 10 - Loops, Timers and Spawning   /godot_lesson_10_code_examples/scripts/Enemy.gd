extends CharacterBody2D

# =============================================================================
# STEM Through Games Program — Day 10: Loops, Timers & Spawning
# Script: Enemy.gd
# =============================================================================
# This script controls a single enemy that falls from the top of the screen.
#
# CONCEPTS DEMONSTRATED:
#   • CharacterBody2D + move_and_slide() — physics-based movement
#   • Custom signals — reached_bottom alerts MainGame
#   • @export vars   — tweak speed in Inspector without editing code
#   • _process()     — per-frame logic
#   • Boundary detection — remove offscreen nodes to save memory
# =============================================================================

# Emitted when the enemy reaches the bottom of the screen (y > 620)
signal reached_bottom

# Speed in pixels per second — adjust this in the Inspector to vary difficulty
@export var speed: float = 80.0

# Optional: enemies can drift left/right as well as falling
@export var horizontal_speed: float = 0.0


# =============================================================================
# _ready()
# =============================================================================
func _ready() -> void:
	# Give each enemy a slightly randomised speed for variety
	# randi_range is used here for a ±20 px/s variation
	speed += randi_range(-20, 20)

	# Optional horizontal drift: random direction each spawn
	horizontal_speed = randi_range(-30, 30)

	# Register in group so Day 11 collision can find all enemies
	add_to_group("enemies")


# =============================================================================
# _physics_process() — runs at a fixed timestep (default 60 fps)
# =============================================================================
func _physics_process(delta: float) -> void:
	# Move downward (positive Y = downward in Godot's coordinate system)
	velocity = Vector2(horizontal_speed, speed)
	move_and_slide()

	# ─── BOUNDARY DETECTION ──────────────────────────────────────────────────
	# If the enemy falls off the bottom of the screen, signal MainGame and
	# remove ourselves. This prevents memory leaks from accumulating nodes.
	if position.y > 640:
		reached_bottom.emit()
		queue_free()

	# Wrap horizontally so enemies don't disappear off the sides
	if position.x < -20:
		position.x = 820
	elif position.x > 820:
		position.x = -20
