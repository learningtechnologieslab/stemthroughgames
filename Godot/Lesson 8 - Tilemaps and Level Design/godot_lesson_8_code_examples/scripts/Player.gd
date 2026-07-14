## Player.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## Controls the player character using CharacterBody2D (Godot 4).
##
## PHYSICS PREVIEW (Day 9 will go deeper!):
##   • Gravity pulls the player DOWN every frame (velocity.y increases)
##   • When the player presses Jump, we give velocity.y a large NEGATIVE value
##     (upward in Godot's coordinate system — y increases downward)
##   • move_and_slide() handles collision with TileMap tiles automatically
##
## KEY CONCEPTS:
##   velocity   → a Vector2 storing horizontal (x) and vertical (y) speed
##   is_on_floor() → returns true when CharacterBody2D is touching ground tiles
##   delta      → time since the last frame (keeps physics frame-rate independent)
## ─────────────────────────────────────────────────────────────────────────

extends CharacterBody2D

# ── Exported constants (edit these in the Inspector!) ─────────────────────
@export var SPEED:        float = 250.0   # pixels per second, horizontal
@export var JUMP_FORCE:   float = 500.0   # pixels per second, upward
@export var GRAVITY:      float = 1200.0  # pixels per second², downward

# ── Sprite reference (for flipping left/right) ────────────────────────────
@onready var sprite: ColorRect = $PlayerSprite

# ── Internal state ────────────────────────────────────────────────────────
var _facing_right: bool = true

# ─────────────────────────────────────────────────────────────────────────
func _ready() -> void:
	print("Player ready at position:", global_position)
	print("Controls: A/D or Arrow Keys = move,  Space/W/Up = jump")

# ─────────────────────────────────────────────────────────────────────────
func _physics_process(delta: float) -> void:

	# ── 1. Apply gravity every frame ──────────────────────────────────────
	# When the player is NOT on the floor, gravity increases downward speed.
	# This simulates real-world physics: objects accelerate as they fall.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# ── 2. Read horizontal input ──────────────────────────────────────────
	# Input.get_axis returns:  -1.0 (left),  0.0 (none),  +1.0 (right)
	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	# Flip the sprite to face the direction of movement
	if direction > 0.0:
		_facing_right = true
		sprite.scale.x = 1.0
	elif direction < 0.0:
		_facing_right = false
		sprite.scale.x = -1.0

	# ── 3. Jump ───────────────────────────────────────────────────────────
	# We can only jump when standing on the floor (no double-jumping yet).
	# A NEGATIVE y velocity moves the player UPWARD (Godot y-axis is flipped).
	#
	# DAY 9 EXTENSION: Try changing JUMP_FORCE to see how it affects the arc!
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_FORCE
		print("Jump! velocity.y =", -JUMP_FORCE)

	# ── 4. Move and collide ───────────────────────────────────────────────
	# move_and_slide() uses velocity to move the body, then automatically
	# handles collisions with physics tiles in the TileMap.
	move_and_slide()

# ─────────────────────────────────────────────────────────────────────────
## Returns the player's current grid (tile) coordinate.
## MATH CONNECTION: Uses the pixel→grid formula from the lesson.
func get_grid_position() -> Vector2i:
	const TILE_SIZE: int = 64
	return Vector2i(
		int(global_position.x / TILE_SIZE),
		int(global_position.y / TILE_SIZE)
	)
