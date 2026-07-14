## PlayerChallenge.gd
## STEM Through Games – Day 6: EXTENSION CHALLENGES
## =============================================================================
## This script has INTENTIONAL GAPS marked with # TODO comments.
## Students fill in the missing code to complete each challenge.
##
## CHALLENGE LEVELS:
##   ★     Challenge 1 – Variable jump height (release early = shorter jump)
##   ★★    Challenge 2 – Double jump (jump once more while airborne)
##   ★★★   Challenge 3 – Coyote time (grace window after leaving a ledge)
##   ★★★★  Challenge 4 – Wall jump (jump off vertical surfaces)
##
## TEACHER NOTES:
##   Full solutions are in scripts/solutions/ folder.
##   Encourage students to attempt before looking at solutions!
## =============================================================================

extends CharacterBody2D

const SPEED:          float = 250.0
const JUMP_VELOCITY:  float = -500.0

# ── CHALLENGE 2: Double Jump ───────────────────────────────────────────────────
# We need to track how many jumps are left before landing.
var jumps_remaining: int = 1  # Start with 1 (the normal ground jump)
const MAX_JUMPS: int = 2      # ★★ Change this to 2 to enable double-jump

# ── CHALLENGE 3: Coyote Time ──────────────────────────────────────────────────
# Count down frames after leaving the floor. If > 0, the player can still jump.
var coyote_timer: int = 0
const COYOTE_FRAMES: int = 6  # ★★★ How many frames of grace to allow

# ── CHALLENGE 1: Variable Jump Height ─────────────────────────────────────────
# If the player releases the jump key early, we cut the upward velocity in half.
# This is how most modern platformers (Mario, Celeste) implement variable jumps.
const JUMP_CUT_MULTIPLIER: float = 0.45  # ★ Multiply velocity.y by this on early release

# Track whether we were on the floor last frame (needed for coyote time reset).
var _was_on_floor: bool = false

func _physics_process(delta: float) -> void:

	# ── GRAVITY ───────────────────────────────────────────────────────────────
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ── FLOOR LANDING: RESET JUMP COUNT ───────────────────────────────────────
	if is_on_floor() and not _was_on_floor:
		jumps_remaining = MAX_JUMPS

	# ── CHALLENGE 3: COYOTE TIME ──────────────────────────────────────────────
	# TODO: Fill in the coyote time logic.
	# HINT: If the player WAS on the floor last frame but ISN'T now, start the timer.
	#       Each frame, count the timer down by 1.
	#       If the timer > 0, let the player jump even though is_on_floor() is false.

	# if _was_on_floor and not is_on_floor():
	# 	coyote_timer = ???          # ← set timer to COYOTE_FRAMES
	# elif coyote_timer > ???:
	# 	coyote_timer -= ???         # ← count down each frame

	# ── CHALLENGE 2: DOUBLE JUMP ──────────────────────────────────────────────
	# TODO: Modify the jump condition to allow jumping in the air.
	# HINT: The player should be able to jump when:
	#   a) They are on the floor, OR
	#   b) They have jumps_remaining > 0 (and are in the air)
	#   Remember to decrease jumps_remaining when jumping!

	if Input.is_action_just_pressed("jump") and is_on_floor():
		# ← This currently only allows ground jumps.
		# ← Change the condition to also allow jumping when jumps_remaining > 0!
		velocity.y = JUMP_VELOCITY
		# jumps_remaining -= ???    # ← Uncomment and fill in for Challenge 2

	# ── CHALLENGE 1: VARIABLE JUMP HEIGHT ────────────────────────────────────
	# TODO: Cut the jump short when the player releases the jump key early.
	# HINT: Check if the jump key was RELEASED (use is_action_just_released)
	#       AND the player is moving upward (velocity.y < 0).
	#       If both are true, multiply velocity.y by JUMP_CUT_MULTIPLIER.

	# if Input.is_action_just_released("???") and velocity.y < ???:
	# 	velocity.y *= ???

	# ── CHALLENGE 4: WALL JUMP ────────────────────────────────────────────────
	# TODO (Advanced): Detect when the player is touching a wall using
	# get_last_slide_collision() and check the collision normal.
	# If touching a wall AND pressing jump, launch away from the wall.
	# HINT: A left wall normal is Vector2(1, 0), right wall is Vector2(-1, 0).

	# ── HORIZONTAL MOVEMENT ───────────────────────────────────────────────────
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	_was_on_floor = is_on_floor()
	move_and_slide()
