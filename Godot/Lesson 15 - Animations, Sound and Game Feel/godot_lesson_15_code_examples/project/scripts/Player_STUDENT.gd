## Player_STUDENT.gd
## ============================================================
## STEM Through Games – Day 15: Student Worksheet Version
## ============================================================
##
## YOUR NAME: _______________________________
## DATE:      _______________________________
##
## INSTRUCTIONS:
##   Everywhere you see a blank line marked with # TODO,
##   fill in the correct GDScript code.
##
##   Use Player.gd as a reference if you get stuck.
##   Try to write it yourself FIRST before looking!
##
## ============================================================

extends CharacterBody2D

# ── CONSTANTS ─────────────────────────────────────────────────
# TODO: Set the player's movement speed in pixels/second
const SPEED      := ___._

# TODO: Set the jump force (hint: it should be negative!)
const JUMP_FORCE := ___._

# Gravity from project settings (leave this one as-is)
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


# ════════════════════════════════════════════════════════════
# _physics_process()
# ════════════════════════════════════════════════════════════
func _physics_process(delta: float) -> void:

	# ── STEP 1: Apply gravity ────────────────────────────────
	# TODO: Add gravity to vertical velocity when NOT on the floor
	# Hint: velocity.y += ___ * ___
	if not is_on_floor():
		___

	# ── STEP 2: Jumping ──────────────────────────────────────
	# TODO: When the "jump" action is pressed AND we're on the floor,
	#       set velocity.y to JUMP_FORCE and play the JumpSound
	if ___ and ___:
		velocity.y = ___
		$JumpSound.___()

	# ── STEP 3: Horizontal movement ──────────────────────────
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	# ── STEP 4: Move ─────────────────────────────────────────
	move_and_slide()

	# ── STEP 5: Update animation ─────────────────────────────
	_update_animation()

	# ── STEP 6: Flip sprite ───────────────────────────────────
	_update_facing()


# ════════════════════════════════════════════════════════════
# _update_animation() – Fill in the animation logic
# ════════════════════════════════════════════════════════════
func _update_animation() -> void:
	# TODO: If the player is NOT on the floor, play the "jump" animation
	if ___:
		$AnimatedSprite2D.play(___)

	# TODO: If the player IS on the floor AND moving (velocity.x != 0),
	#       play the "run" animation
	elif ___:
		$AnimatedSprite2D.play(___)

	# TODO: Otherwise, play the "idle" animation
	else:
		$AnimatedSprite2D.play(___)


# ════════════════════════════════════════════════════════════
# _update_facing() – Flip the sprite based on direction
# ════════════════════════════════════════════════════════════
func _update_facing() -> void:
	# TODO: If moving left (velocity.x < 0), set flip_h to TRUE
	if ___:
		$AnimatedSprite2D.flip_h = ___

	# TODO: If moving right (velocity.x > 0), set flip_h to FALSE
	elif ___:
		$AnimatedSprite2D.flip_h = ___


# ════════════════════════════════════════════════════════════
# 🧮 MATH QUESTIONS – Answer in comments below
# ════════════════════════════════════════════════════════════

# Q1: Your run animation has 8 frames at 12 FPS.
#     How long is one loop?
#     Formula: loop_time = frames / fps
#     MY ANSWER: ___ / ___ = ___ seconds

# Q2: You want a jump animation to take exactly 0.4 seconds.
#     It has 6 frames. What FPS should you set?
#     Formula: fps = frames / time
#     MY ANSWER: ___ / ___ = ___ FPS

# Q3: Your player moves at 200 px/sec.
#     The run loop takes 0.667 seconds.
#     How far does the player travel in one loop?
#     Formula: distance = speed × time
#     MY ANSWER: ___ × ___ = ___ pixels

# ════════════════════════════════════════════════════════════
# 🎵 REFLECTION – Write your answers as comments
# ════════════════════════════════════════════════════════════

# What emotion does your game's sound create?
# MY ANSWER:

# How does faster animation FPS change game feel?
# MY ANSWER:

# What would change if you played your game with all sound removed?
# MY ANSWER:
