# =============================================================================
# Enemy_StateMachine.gd
# STEM Through Games – Day 11, Part 2: Patrol + Chase State Machine
# =============================================================================
# PURPOSE:
#   A more sophisticated enemy that has two behaviours (states):
#     PATROL  →  walks left and right on a fixed path
#     CHASE   →  charges directly toward the player
#
#   It transitions between states based on distance to the player.
#
# CS CONCEPTS:
#   enum         →  a named list of possible states (like a vocabulary)
#   match        →  Godot's version of switch/case — cleaner than if/elif chains
#   State machine →  a system where the object is always in ONE state, and
#                    explicit rules govern when it switches
#
# MATH CONCEPTS:
#   distance_to()  →  |v| = √(Δx² + Δy²) — the length of the vector between
#                    two points (same formula as Pythagorean theorem)
#   .normalized()  →  produces a unit vector (length = 1) pointing toward target
#
# HOW TO USE:
#   Attach this script to a CharacterBody2D node in your scene.
#   Adjust the exported variables in the Inspector to tune behaviour.
# =============================================================================

extends CharacterBody2D

# ── State definitions ─────────────────────────────────────────────────────────
#
# enum creates a set of named integer constants.
# State.PATROL == 0,  State.CHASE == 1  (Godot assigns numbers automatically)
# Using names instead of magic numbers makes the code much easier to read.
#
enum State {
	PATROL,  ## Walking left/right, not yet aware of the player
	CHASE,   ## Charging directly at the player
}

# ── Inspector-editable properties ─────────────────────────────────────────────
@export var speed:         float = 100.0  ## Movement speed in pixels per second
@export var detect_range:  float = 200.0  ## Distance (px) at which enemy detects player
@export var patrol_range:  float = 120.0  ## How far left/right from spawn to patrol

# ── Internal state ─────────────────────────────────────────────────────────────
var player:         CharacterBody2D            # Reference to the Player node
var current_state:  State = State.PATROL       # Start in patrol mode
var patrol_dir:     int   = 1                  # 1 = moving right, -1 = moving left
var spawn_position: Vector2                    # Remember where we started patrolling

# ── Node references ────────────────────────────────────────────────────────────
@onready var sprite:       ColorRect = $Sprite
@onready var label:        Label     = $NameLabel
@onready var debug_label:  Label     = $DebugLabel
@onready var detect_area:  Node2D    = $DetectVisual   # Visual ring showing detect range


# =============================================================================
func _ready() -> void:
	player         = get_node("/root/Game/Player")
	spawn_position = global_position   # Remember start position for patrol bounds

	sprite.color = Color(0.9, 0.5, 0.1)  # Orange for state-machine enemy
	label.text   = "PATROL/CHASE"

	# Draw the detection radius visually (see _draw below)
	queue_redraw()


# =============================================================================
func _physics_process(_delta: float) -> void:

	# ══════════════════════════════════════════════════════════════════════════
	# PHASE 1 — TRANSITION CHECK
	# Measure distance to player and decide which state we should be in.
	# ══════════════════════════════════════════════════════════════════════════
	#
	# distance_to() computes: √( (px-ex)² + (py-ey)² )
	# This is the Pythagorean theorem — the straight-line distance in pixels.
	#
	var dist: float = global_position.distance_to(player.global_position)

	if dist < detect_range:
		current_state = State.CHASE    # Player is close — switch to chase
	else:
		current_state = State.PATROL   # Player is far — go back to patrol

	# ══════════════════════════════════════════════════════════════════════════
	# PHASE 2 — STATE BEHAVIOUR
	# Execute the behaviour for whichever state we are currently in.
	# ══════════════════════════════════════════════════════════════════════════
	match current_state:

		# ── PATROL ────────────────────────────────────────────────────────────
		# Move horizontally. Reverse direction when we reach the patrol boundary.
		State.PATROL:
			sprite.color = Color(0.9, 0.5, 0.1)  # Orange = patrol

			# Set horizontal velocity only; y velocity stays 0 (top-down game)
			velocity = Vector2(patrol_dir * speed, 0)

			# Check patrol bounds relative to spawn position
			var offset: float = global_position.x - spawn_position.x
			if offset > patrol_range:
				patrol_dir = -1   # Reached right edge → turn left
			elif offset < -patrol_range:
				patrol_dir = 1    # Reached left edge → turn right

		# ── CHASE ─────────────────────────────────────────────────────────────
		# Calculate direction to player, normalize, multiply by speed.
		State.CHASE:
			sprite.color = Color(0.9, 0.1, 0.1)  # Red = chasing!

			# This is the core vector math from Part 1:
			#   1. Subtract positions to get the direction vector
			#   2. Normalize to get a unit vector (length = 1)
			#   3. Multiply by speed to get the final velocity
			var direction: Vector2 = (
				player.global_position - global_position
			).normalized()

			velocity = direction * speed

	# Apply movement with collision detection
	move_and_slide()

	# ── Debug HUD ─────────────────────────────────────────────────────────────
	var state_name: String = "PATROL" if current_state == State.PATROL else "CHASE"
	debug_label.text = (
		"State: %s\n" % state_name +
		"Dist:  %.0f px\n" % dist +
		"Range: %.0f px" % detect_range
	)


# =============================================================================
# _draw() — called by queue_redraw() to paint the detection radius on screen
# This helps students SEE the detect_range value as a circle around the enemy.
# =============================================================================
func _draw() -> void:
	# Draw the detection circle in the enemy's LOCAL space (origin = self)
	draw_arc(
		Vector2.ZERO,         # center (local origin = this node's position)
		detect_range,         # radius in pixels
		0.0,                  # start angle
		TAU,                  # end angle (TAU = 2π = full circle)
		48,                   # number of segments
		Color(1.0, 0.5, 0.1, 0.3),  # orange, semi-transparent fill hint
		1.5                   # line width
	)
