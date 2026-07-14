# =============================================================================
# Enemy_Challenge.gd
# STEM Through Games – Day 11, CHALLENGE EXTENSION
# =============================================================================
# PURPOSE:
#   Extended state machine with FOUR states for students who finish early
#   or want to explore further. Builds directly on Enemy_StateMachine.gd.
#
# NEW STATES:
#   PATROL  →  left/right movement within bounds (same as Part 2)
#   CHASE   →  charges at the player (same as Part 2)
#   WAIT    →  pauses briefly before chasing (new — uses a timer)
#   RETURN  →  walks back to spawn point after losing the player (new)
#
# CHALLENGE TASKS (see CHALLENGE comments throughout):
#   Level 1 — patrol + chase with distance_to()  (already done in Part 2)
#   Level 2 — add WAIT and RETURN states          (implemented here)
#   Level 3 — add line-of-sight check             (stub provided at bottom)
#
# NEW CONCEPTS:
#   Timer node   →  wait_time, start(), timeout signal
#   Signal       →  _on_wait_timer_timeout()
#   Lerp         →  smooth speed ramp-up on start of chase
# =============================================================================

extends CharacterBody2D

# ── State definitions ──────────────────────────────────────────────────────
enum State {
	PATROL,   ## Patrolling left/right
	WAIT,     ## Spotted player — pausing before chase starts
	CHASE,    ## Actively chasing the player
	RETURN,   ## Lost sight — walking back to spawn
}

# ── Inspector properties ───────────────────────────────────────────────────
@export var speed:          float = 100.0  ## Base movement speed (px/s)
@export var chase_speed:    float = 160.0  ## Faster speed while chasing
@export var detect_range:   float = 220.0  ## Distance to start detecting player (px)
@export var lose_range:     float = 310.0  ## Distance to give up chasing (px)
@export var patrol_range:   float = 130.0  ## Left/right patrol distance from spawn (px)
@export var wait_duration:  float = 0.8    ## Seconds to pause before chasing
@export var return_threshold: float = 8.0  ## How close to spawn = "arrived home" (px)

# ── Internal state ─────────────────────────────────────────────────────────
var player:          CharacterBody2D
var current_state:   State   = State.PATROL
var patrol_dir:      int     = 1
var spawn_position:  Vector2
var wait_elapsed:    float   = 0.0
var current_speed:   float   = 100.0       # Lerped speed for smooth ramp-up

# ── Node references ─────────────────────────────────────────────────────────
@onready var sprite:       ColorRect = $Sprite
@onready var label:        Label     = $NameLabel
@onready var debug_label:  Label     = $DebugLabel

# State colors for instant visual feedback
const COLOR_PATROL = Color(0.3, 0.6, 1.0)    # Blue
const COLOR_WAIT   = Color(1.0, 1.0, 0.1)    # Yellow
const COLOR_CHASE  = Color(1.0, 0.15, 0.15)  # Red
const COLOR_RETURN = Color(0.5, 0.85, 0.5)   # Green


# =============================================================================
func _ready() -> void:
	player         = get_node("/root/Game/Player")
	spawn_position = global_position
	current_speed  = speed
	label.text     = "SMART ENEMY"
	queue_redraw()


# =============================================================================
func _physics_process(delta: float) -> void:
	var dist: float = global_position.distance_to(player.global_position)

	# ══════════════════════════════════════════════════════════════════════════
	# TRANSITION LOGIC — decides when to switch between states
	# ══════════════════════════════════════════════════════════════════════════
	match current_state:

		State.PATROL:
			if dist < detect_range:
				_enter_state(State.WAIT)   # Spotted! → pause before chasing

		State.WAIT:
			wait_elapsed += delta
			if wait_elapsed >= wait_duration:
				_enter_state(State.CHASE)  # Waited long enough → now chase!

		State.CHASE:
			if dist > lose_range:
				_enter_state(State.RETURN) # Lost sight → go home

		State.RETURN:
			var home_dist: float = global_position.distance_to(spawn_position)
			if home_dist < return_threshold:
				_enter_state(State.PATROL)  # Back home → resume patrol
			elif dist < detect_range:
				_enter_state(State.WAIT)    # Spotted again on the way back!

	# ══════════════════════════════════════════════════════════════════════════
	# BEHAVIOUR — what to DO in each state
	# ══════════════════════════════════════════════════════════════════════════
	match current_state:

		State.PATROL:
			sprite.color = COLOR_PATROL
			velocity = Vector2(patrol_dir * speed, 0)
			var offset: float = global_position.x - spawn_position.x
			if offset > patrol_range:  patrol_dir = -1
			elif offset < -patrol_range: patrol_dir =  1

		State.WAIT:
			sprite.color = COLOR_WAIT
			# Stand still — velocity decelerates to zero
			velocity = velocity.move_toward(Vector2.ZERO, speed * 4.0 * delta)

		State.CHASE:
			sprite.color = COLOR_CHASE
			# Smoothly ramp up to chase_speed using lerp
			# CHALLENGE: try changing 3.0 to 0.5 (slow ramp) or 20.0 (instant)
			current_speed = lerp(current_speed, chase_speed, 3.0 * delta)
			var dir: Vector2 = (player.global_position - global_position).normalized()
			velocity = dir * current_speed

		State.RETURN:
			sprite.color = COLOR_RETURN
			current_speed = lerp(current_speed, speed, 4.0 * delta)
			var home_dir: Vector2 = (spawn_position - global_position).normalized()
			velocity = home_dir * current_speed

	move_and_slide()
	_update_debug(dist)


# =============================================================================
# _enter_state() — called ONCE when transitioning into a new state
# Keeps entry logic separate from per-frame behaviour logic.
# =============================================================================
func _enter_state(new_state: State) -> void:
	current_state = new_state
	if new_state == State.WAIT:
		wait_elapsed = 0.0           # Reset the wait timer
	if new_state == State.CHASE:
		current_speed = speed        # Reset speed so ramp-up always starts low


# =============================================================================
# _update_debug() — updates the on-screen debug label every frame
# =============================================================================
func _update_debug(dist: float) -> void:
	var names: Dictionary = {
		State.PATROL: "PATROL",
		State.WAIT:   "WAIT (%.1f/%.1fs)" % [wait_elapsed, wait_duration],
		State.CHASE:  "CHASE",
		State.RETURN: "RETURN",
	}
	debug_label.text = (
		"State: %s\n"    % names[current_state] +
		"Dist:  %.0f px\n" % dist +
		"Speed: %.0f px/s"  % current_speed
	)


# =============================================================================
# _draw() — draws the detection and lose-range circles for visual feedback
# =============================================================================
func _draw() -> void:
	# Detection range — orange
	draw_arc(Vector2.ZERO, detect_range, 0.0, TAU, 48, Color(1.0, 0.5, 0.1, 0.35), 1.5)
	# Lose range — gray
	draw_arc(Vector2.ZERO, lose_range,   0.0, TAU, 48, Color(0.7, 0.7, 0.7, 0.2),  1.0)


# =============================================================================
# ── CHALLENGE LEVEL 3 STUB: Line-of-Sight Check ───────────────────────────
# =============================================================================
# To complete this challenge:
#   1. Add a RayCast2D node as a child of this enemy (call it "RayCast2D")
#   2. In _ready(), get a reference: @onready var ray: RayCast2D = $RayCast2D
#   3. Replace the distance check in PATROL's transition with _can_see_player()
#
# func _can_see_player() -> bool:
# 	# Point the ray from self toward the player
# 	ray.target_position = to_local(player.global_position)
# 	ray.force_raycast_update()
# 	# If the ray hits nothing, the path is clear — we can see the player!
# 	return not ray.is_colliding()
#
# Then in the PATROL transition block change:
#   if dist < detect_range:
# to:
#   if dist < detect_range and _can_see_player():
