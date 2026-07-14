# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 04_speed_experiment.gd
# LEVEL: Design Explorer — Feel how speed changes the game!
# =============================================================================
#
# WHAT THIS SCRIPT DOES:
#   Lets you change speed IN REAL TIME while the game is running,
#   using number keys 1–5. No need to stop and restart!
#
# CONTROLS:
#   Arrow Keys    — Move the character
#   1             — speed = 50    (slow / horror / puzzle)
#   2             — speed = 150   (careful / methodical)
#   3             — speed = 250   (natural / platformer)  ← default
#   4             — speed = 500   (fast / action)
#   5             — speed = 900   (extreme / racing / chaos)
#   R             — Reset to starting position
#
# DESIGN LESSON:
#   Speed is not just a number — it changes how a game FEELS.
#   Game designers call this "game feel" or "juiciness."
# =============================================================================

extends CharacterBody2D

# ── Configuration ─────────────────────────────────────────────────────────────

var speed = 250   # Starting speed (try all 5 presets!)

# The five speed presets — indexed 0–4
const SPEED_PRESETS = [50, 150, 250, 500, 900]
const SPEED_LABELS  = [
	"50  — Slow & Heavy (Horror / Puzzle)",
	"150 — Careful & Deliberate (Strategy)",
	"250 — Natural & Smooth (Platformer / RPG)",
	"500 — Fast & Energetic (Action / Shooter)",
	"900 — Extreme / Chaos (Racing / Bullet-Hell)"
]

# Store the starting position so we can reset with R
var start_position: Vector2


func _ready():
	# _ready() is called once when the scene loads
	start_position = global_position
	print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	print("SPEED EXPERIMENT — Controls:")
	print("  Arrow keys: Move")
	print("  Keys 1–5:   Change speed preset")
	print("  R:          Reset position")
	print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
	_announce_speed()


func _physics_process(delta):
	
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()


func _input(event):
	# _input() is called whenever the player presses a key or clicks
	# We use it here to handle the speed-change hotkeys
	
	if event is InputEventKey and event.pressed:
		
		# Number keys 1–5 select speed presets
		if event.keycode == KEY_1:
			_set_speed(0)
		elif event.keycode == KEY_2:
			_set_speed(1)
		elif event.keycode == KEY_3:
			_set_speed(2)
		elif event.keycode == KEY_4:
			_set_speed(3)
		elif event.keycode == KEY_5:
			_set_speed(4)
		
		# R resets position to where the scene started
		elif event.keycode == KEY_R:
			global_position = start_position
			velocity = Vector2.ZERO
			print("↩  Position reset.")


func _set_speed(preset_index: int):
	speed = SPEED_PRESETS[preset_index]
	print("")
	print("⚡ Speed changed to: ", SPEED_LABELS[preset_index])
	_announce_speed()


func _announce_speed():
	print("   Current speed = ", speed, " px/sec")
	print("   At this speed, crossing 500px takes: ", snapped(500.0 / speed, 0.01), " seconds")


# =============================================================================
# 🎨 DESIGN JOURNAL — After experimenting, write down your answers:
# =============================================================================
#
# Speed 50:
#   How does it feel? ___________________________________________
#   What emotions does it create? ________________________________
#   What game genre fits? _______________________________________
#
# Speed 250:
#   How does it feel? ___________________________________________
#   Does this feel "natural"? Why or why not? ___________________
#
# Speed 900:
#   How does it feel? ___________________________________________
#   Is it fun or frustrating? ___________________________________
#   What would make it fun instead of frustrating? ______________
#
# YOUR CHOICE:
#   If you were making a game about a ___________ [fill in],
#   you would use speed = _____ because ________________________.
# =============================================================================
