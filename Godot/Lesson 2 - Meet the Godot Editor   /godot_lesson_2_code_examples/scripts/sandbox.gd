## sandbox.gd
## STEM Through Games – Day 2
##
## ════════════════════════════════════════════════════════════════════════
## STUDENT SANDBOX — THIS IS YOUR SPACE TO EXPERIMENT!
## ════════════════════════════════════════════════════════════════════════
##
## This scene has one sprite called "MySprite".
## Your job: move it around using Vector2 positions.
##
## HOW TO USE:
##   1. Read the TODO comments below
##   2. Change the numbers inside Vector2( ... )
##   3. Press F5 (or the Play button) to run
##   4. Watch where MySprite appears!
##
## REMEMBER:
##   • (0, 0)        = TOP-LEFT corner
##   • (1024, 0)     = top-right corner
##   • (0, 600)      = bottom-left corner
##   • (1024, 600)   = bottom-right corner
##   • (512, 300)    = CENTER of screen
##   • Larger Y  →   LOWER on screen
##   • Larger X  →   FURTHER RIGHT
##
## ════════════════════════════════════════════════════════════════════════

extends Node2D

# Reference to our sprite
var my_sprite : Sprite2D
var pos_label : Label


func _ready() -> void:
	my_sprite = $MySprite
	pos_label = $UI/Panel/VBox/PosLabel

	# Wire up the back button
	$UI/BackBtn.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/main.tscn"))

	_style_panel()

	# ── TODO 1 ───────────────────────────────────────────────────────────
	# Change the numbers below to move the sprite somewhere new.
	# Then press F5 to play and see where it ends up!
	#
	my_sprite.position = Vector2(512, 300)
	#                            ^^^  ^^^
	#                             X    Y
	#
	# Try: Vector2(0, 0)       ← where does this go?
	# Try: Vector2(1024, 600)  ← what about this?
	# Try: Vector2(200, 400)   ← and this?
	# ─────────────────────────────────────────────────────────────────────

	_update_label()


func _process(_delta: float) -> void:
	_update_label()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:

		# Press SPACE to re-run your position from _ready()
		if event.keycode == KEY_SPACE:
			_run_student_challenge()

		# Press R to reset to center
		if event.keycode == KEY_R:
			my_sprite.position = Vector2(512, 300)

		# Press number keys to jump to preset positions
		match event.keycode:
			KEY_1: my_sprite.position = Vector2(0, 0);       _show_hint("(0,0) — top-left corner!")
			KEY_2: my_sprite.position = Vector2(1024, 0);    _show_hint("(1024,0) — top-right corner!")
			KEY_3: my_sprite.position = Vector2(0, 600);     _show_hint("(0,600) — bottom-left corner!")
			KEY_4: my_sprite.position = Vector2(1024, 600);  _show_hint("(1024,600) — bottom-right corner!")
			KEY_5: my_sprite.position = Vector2(512, 300);   _show_hint("(512,300) — center!")


func _run_student_challenge() -> void:
	# ── TODO 2 ───────────────────────────────────────────────────────────
	# Write the Vector2 that places MySprite exactly at:
	#   • One quarter of the way across the screen
	#   • Three quarters of the way down the screen
	#
	# Hint: the screen is 1024 wide and 600 tall.
	# What are the correct X and Y values?
	#
	my_sprite.position = Vector2(256, 450)   # ← is this right? check your math!
	# ─────────────────────────────────────────────────────────────────────


func _update_label() -> void:
	var px := roundi(my_sprite.position.x)
	var py := roundi(my_sprite.position.y)
	pos_label.text = "MySprite is at:  x = %d ,  y = %d" % [px, py]


func _show_hint(hint: String) -> void:
	# Briefly changes the label to show a hint, then reverts
	pos_label.text = hint


func _style_panel() -> void:
	var s := StyleBoxFlat.new()
	s.bg_color          = Color(0.08, 0.05, 0.18, 0.88)
	s.border_width_left = 3
	s.border_color      = Color(0.08, 0.72, 0.64, 0.9)
	s.corner_radius_top_left     = 6
	s.corner_radius_top_right    = 6
	s.corner_radius_bottom_left  = 6
	s.corner_radius_bottom_right = 6
	$UI/Panel.add_theme_stylebox_override("panel", s)


## ════════════════════════════════════════════════════════════════════════
## EXTENSION CHALLENGES
## ════════════════════════════════════════════════════════════════════════
##
## If you finish early, try these:
##
## CHALLENGE A — Animation loop:
##   Instead of setting position once in _ready(), move the sprite
##   in _process() so it drifts slowly to the right:
##
##     func _process(delta):
##         my_sprite.position.x += 50 * delta
##
##   What happens when it reaches the edge?
##   How would you make it wrap around to the left side?
##
## CHALLENGE B — Diagonal line:
##   Write code that places THREE sprites in a diagonal line.
##   If sprite 1 is at (100, 100), where should sprites 2 and 3 go?
##
## CHALLENGE C — Screen corners:
##   Use 1-key, 2-key, 3-key, 4-key to visit each corner.
##   Write down each position. Can you see the pattern in the numbers?
##
## ════════════════════════════════════════════════════════════════════════
