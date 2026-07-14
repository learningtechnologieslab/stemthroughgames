## PlayerChallengeSolution.gd
## STEM Through Games – Day 6: CHALLENGE SOLUTIONS
## =============================================================================
## Full working implementations of all four extension challenges.
## TEACHER: Share this only after students have attempted on their own!
## =============================================================================

extends CharacterBody2D

const SPEED:                float = 250.0
const JUMP_VELOCITY:        float = -500.0
const MAX_JUMPS:            int   = 2       # 2 = double jump enabled
const COYOTE_FRAMES:        int   = 6
const JUMP_CUT_MULTIPLIER:  float = 0.45

var jumps_remaining: int  = MAX_JUMPS
var coyote_timer:    int  = 0
var _was_on_floor:   bool = false

func _physics_process(delta: float) -> void:

	# ── GRAVITY ───────────────────────────────────────────────────────────────
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ── LANDING RESET ─────────────────────────────────────────────────────────
	if is_on_floor() and not _was_on_floor:
		jumps_remaining = MAX_JUMPS
		coyote_timer    = 0

	# ── CHALLENGE 3 SOLUTION: COYOTE TIME ─────────────────────────────────────
	if _was_on_floor and not is_on_floor():
		# Just walked off a ledge — start the grace timer
		coyote_timer = COYOTE_FRAMES
	elif coyote_timer > 0:
		coyote_timer -= 1

	# The player can jump if on the floor, inside the coyote window, or has
	# remaining air jumps (double jump / triple jump).
	var can_jump: bool = is_on_floor() or coyote_timer > 0 or jumps_remaining > 0

	# ── CHALLENGE 2 SOLUTION: DOUBLE JUMP ─────────────────────────────────────
	if Input.is_action_just_pressed("jump") and can_jump:
		velocity.y      = JUMP_VELOCITY
		jumps_remaining -= 1
		coyote_timer    = 0  # Consume coyote window immediately on jump

	# ── CHALLENGE 1 SOLUTION: VARIABLE JUMP HEIGHT ───────────────────────────
	if Input.is_action_just_released("jump") and velocity.y < 0:
		# Player let go of jump early while still rising — cut the jump short.
		velocity.y *= JUMP_CUT_MULTIPLIER

	# ── CHALLENGE 4 SOLUTION: WALL JUMP ──────────────────────────────────────
	if not is_on_floor() and Input.is_action_just_pressed("jump"):
		for i in get_slide_collision_count():
			var col    := get_slide_collision(i)
			var normal := col.get_normal()
			# A wall normal is mostly horizontal (|x| > |y|)
			if abs(normal.x) > abs(normal.y):
				# Launch away from the wall and upward
				velocity.x = normal.x * SPEED * 1.2
				velocity.y = JUMP_VELOCITY * 0.9
				break

	# ── HORIZONTAL MOVEMENT ───────────────────────────────────────────────────
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	_was_on_floor = is_on_floor()
	move_and_slide()
