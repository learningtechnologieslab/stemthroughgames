## Player.gd
## STEM Through Games — Day 7: Collision Detection
##
## This script controls the player character.
## It was set up on Days 1-6. Today (Day 7) we will:
##   1. Look at the CollisionShape2D already attached to this node
##   2. Understand how it defines the player's "hitbox"
##   3. Detect when the player overlaps an Area2D (collectible)
##
## LESSON NOTE FOR STUDENTS:
##   Open the scene in Godot and click on the Player node.
##   You should see a CollisionShape2D child node in the Scene panel.
##   That orange rectangle is the player's hitbox — it tells Godot
##   WHERE the player physically exists in the world.

extends CharacterBody2D

# ─────────────────────────────────────────────────────────────
#  CONSTANTS
# ─────────────────────────────────────────────────────────────

## How fast the player moves in pixels per second
const SPEED: float = 180.0

## How strong the jump is (negative = upward in Godot's Y axis)
const JUMP_VELOCITY: float = -380.0

## Gravity — pulled from the project settings so it stays consistent
const GRAVITY: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# ─────────────────────────────────────────────────────────────
#  VARIABLES
# ─────────────────────────────────────────────────────────────

## The player's current score (coins collected)
## This is updated by the Coin scene when a collection happens.
var score: int = 0


# ─────────────────────────────────────────────────────────────
#  READY
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	print("Player ready! Score: ", score)
	print("CollisionShape2D is attached — the player has a hitbox.")


# ─────────────────────────────────────────────────────────────
#  PHYSICS PROCESS (runs every physics frame ~60/sec)
# ─────────────────────────────────────────────────────────────

func _physics_process(delta: float) -> void:
	# ── Apply gravity when not on floor ──────────────────────
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# ── Handle jump ──────────────────────────────────────────
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# ── Handle left/right movement ───────────────────────────
	var direction: float = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		# Slow down smoothly when no key is pressed
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# ── Move and handle collisions ────────────────────────────
	# move_and_slide() uses the CollisionShape2D to detect walls/floors
	move_and_slide()


# ─────────────────────────────────────────────────────────────
#  SCORE
# ─────────────────────────────────────────────────────────────

## Called by a Coin when the player collects it.
## Increases score and prints feedback to the Output panel.
func add_score(amount: int = 1) -> void:
	score += amount
	print("Score: ", score)


# ─────────────────────────────────────────────────────────────
#  DAY 7 STUDENT CHALLENGE
# ─────────────────────────────────────────────────────────────
#
#  CHALLENGE 1 (Starter):
#    The Coin scene uses body_entered to detect the player.
#    Open Coin.gd and read through _on_body_entered().
#    Try moving the player into a coin — what happens?
#
#  CHALLENGE 2 (Intermediate):
#    Change SPEED to 250 and JUMP_VELOCITY to -500.
#    How does this affect gameplay feel?
#    Does the hitbox need to change too?
#
#  CHALLENGE 3 (Advanced):
#    The player hitbox is a RectangleShape2D.
#    In the Inspector, try making it smaller than the sprite.
#    Does the game feel more or less fair? Why?
#
