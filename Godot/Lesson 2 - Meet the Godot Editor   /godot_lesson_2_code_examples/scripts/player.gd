## player.gd
## STEM Through Games – Day 2
##
## Controls the player (robot) sprite using arrow keys or WASD.
##
## ── WHAT STUDENTS WILL NOTICE ─────────────────────────────────────────────
##
##   1. Moving RIGHT increases X  (same as math class)
##   2. Moving LEFT  decreases X  (same as math class)
##   3. Moving DOWN  increases Y  ← DIFFERENT from math class!
##   4. Moving UP    decreases Y  ← DIFFERENT from math class!
##
##   This is because Godot's Y=0 is at the TOP of the screen.
##
## ──────────────────────────────────────────────────────────────────────────
##
## CHALLENGE EXTENSION (for fast finishers):
##   Can you change SPEED to make the robot move faster or slower?
##   Can you find the line that keeps the robot on-screen and explain it?
##
## ──────────────────────────────────────────────────────────────────────────

extends Sprite2D

# ── CONSTANTS — try changing SPEED! ───────────────────────────────────────
const SPEED      : float = 250.0   # pixels per second  ← try 100 or 500!
const SCREEN_W   : float = 1024.0
const SCREEN_H   : float = 600.0
const HALF_W     : float = 24.0    # half of sprite width  (keeps sprite on screen)
const HALF_H     : float = 24.0    # half of sprite height

# ── Called every frame ─────────────────────────────────────────────────────
func _process(delta: float) -> void:
	# ── Read input ─────────────────────────────────────────────────────────
	# Input.get_axis returns -1, 0, or +1 depending on which keys are held.
	# "ui_left"/"ui_right" are Arrow Keys OR A/D (built-in Godot action names).
	var dir_x : float = Input.get_axis("ui_left", "ui_right")
	var dir_y : float = Input.get_axis("ui_up",   "ui_down")

	# ── Move ───────────────────────────────────────────────────────────────
	# We multiply by delta so the movement is the same speed regardless of
	# how fast your computer runs (frames per second).
	#
	#   new_x = old_x  +  direction  ×  speed  ×  time_since_last_frame
	#
	position.x += dir_x * SPEED * delta
	position.y += dir_y * SPEED * delta

	# ── Keep the robot on-screen ───────────────────────────────────────────
	# clamp(value, min, max) — makes sure the value stays between min and max.
	# Without this, the robot would fly off the edge of the screen.
	position.x = clamp(position.x, HALF_W,          SCREEN_W - HALF_W)
	position.y = clamp(position.y, HALF_H,          SCREEN_H - HALF_H)

	# ── Flip sprite to face movement direction ─────────────────────────────
	if dir_x < 0:
		flip_h = true    # facing left
	elif dir_x > 0:
		flip_h = false   # facing right


# ══════════════════════════════════════════════════════════════════════════
# ── STUDENT CHALLENGE SECTION ─────────────────────────────────────────────
# ══════════════════════════════════════════════════════════════════════════
#
# TODO 1 — Try setting position directly with Vector2:
#   Uncomment the line below in _ready() to place the robot at a specific spot.
#
#func _ready() -> void:
#	position = Vector2(300, 200)   # ← change these numbers!
#	# Question: where does (0, 0) put the robot?
#	# Question: what happens with a negative number?
#
#
# TODO 2 — Speed experiment:
#   Change SPEED at the top of this file to 50. Then try 600.
#   How does the robot feel different?
#
#
# TODO 3 — Boundary experiment:
#   What happens if you DELETE or COMMENT OUT the two clamp() lines above?
#   Try it! Then put them back.
#
# ══════════════════════════════════════════════════════════════════════════
