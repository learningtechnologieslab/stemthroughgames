# =============================================================================
# Enemy_Chase.gd
# STEM Through Games – Day 11, Part 1: Basic Chase Behavior
# =============================================================================
# PURPOSE:
#   The simplest possible enemy AI. Every physics frame, the enemy calculates
#   the direction to the player and moves straight toward them.
#
# MATH CONCEPTS:
#   Vector subtraction   →  target_pos − self_pos  =  direction vector
#   .normalized()        →  converts any vector to length 1 (unit vector)
#   velocity = dir * speed  →  applies the correct speed in that direction
#
# HOW TO USE:
#   1. Attach this script to a CharacterBody2D node.
#   2. Make sure your Game scene has a node at  /root/Game/Player
#      (or update the get_node() path below to match your scene tree).
#   3. Press Play and use WASD to move the player. The enemy follows!
# =============================================================================

extends CharacterBody2D

# ── Inspector-editable properties ────────────────────────────────────────────
@export var speed: float = 120.0  ## Enemy movement speed in pixels per second

# ── Internal state ────────────────────────────────────────────────────────────
var player: CharacterBody2D       # Reference to the Player node

# ── Node references ───────────────────────────────────────────────────────────
@onready var sprite:     ColorRect = $Sprite
@onready var label:      Label     = $NameLabel
@onready var debug_label: Label    = $DebugLabel


# =============================================================================
func _ready() -> void:
	# Get a reference to the player node.
	# The path "/root/Game/Player" means:
	#   /root  →  the scene tree root
	#   Game   →  the main Game node (your root scene node)
	#   Player →  the Player child node
	#
	# ⚠️ If your scene is structured differently, change this path!
	player = get_node("/root/Game/Player")

	# Visual setup
	sprite.color = Color(0.9, 0.2, 0.2)   # Red for enemy
	label.text   = "CHASER"


# =============================================================================
func _physics_process(_delta: float) -> void:

	# ── STEP 1: Calculate the direction vector ────────────────────────────────
	#
	#   (player.global_position - global_position)
	#    ↑ target position          ↑ my position
	#
	#   Subtracting MY position FROM the TARGET gives a vector that POINTS
	#   from me toward the target. Try reversing this — what happens?
	#
	var raw_direction: Vector2 = player.global_position - global_position

	# ── STEP 2: Normalize the direction ──────────────────────────────────────
	#
	#   raw_direction might be (300, 200) — that's too big to use as velocity!
	#   .normalized() divides the vector by its own length, giving a unit
	#   vector with length exactly 1.0.
	#
	#   EXPERIMENT: Replace .normalized() with nothing and watch the enemy
	#   teleport! The velocity would be the raw pixel distance each frame.
	#
	var direction: Vector2 = raw_direction.normalized()

	# ── STEP 3: Multiply by speed ─────────────────────────────────────────────
	#
	#   A unit vector × speed  =  a velocity of exactly 'speed' pixels/second
	#   in the correct direction.
	#
	velocity = direction * speed

	# ── STEP 4: Move ──────────────────────────────────────────────────────────
	move_and_slide()

	# ── Debug display (teacher/student helper) ────────────────────────────────
	var dist: float = global_position.distance_to(player.global_position)
	debug_label.text = (
		"Dir: (%.1f, %.1f)\n" % [direction.x, direction.y] +
		"Raw len: %.0f\n"     % raw_direction.length() +
		"Dist: %.0f px"       % dist
	)
