## main.gd
## STEM Through Games – Day 2: Coordinate Explorer
##
## This script powers the main scene. It:
##   - Draws a visible coordinate grid on the screen
##   - Updates the UI to show the player's X/Y position in real time
##   - Handles teleporting the player on mouse click
##   - Tracks star collection and distance to target
##
## ── KEY MATH CONCEPT ───────────────────────────────────────────────────────
##   In Godot, (0, 0) is the TOP-LEFT corner of the screen.
##   Y increases DOWNWARD (opposite to math class!).
##   X still increases to the RIGHT, just like in math.
## ──────────────────────────────────────────────────────────────────────────

extends Node2D

# ── Constants ──────────────────────────────────────────────────────────────
const SCREEN_W     : int   = 1024
const SCREEN_H     : int   = 600
const GRID_SPACING : int   = 50    # pixels between grid lines
const GRID_COLOR   : Color = Color(0.28, 0.18, 0.55, 0.35)
const AXIS_COLOR   : Color = Color(0.08, 0.72, 0.64, 0.85)
const LABEL_COLOR  : Color = Color(0.76, 0.70, 1.0,  0.90)
const ORIGIN_COLOR : Color = Color(0.99, 0.83, 0.30, 1.0)

# ── Settings ───────────────────────────────────────────────────────────────
var show_grid : bool = true

# ── Node references (set in _ready) ───────────────────────────────────────
var player        : Sprite2D
var target        : Sprite2D
var stars         : Node2D
var player_coord  : Label
var quadrant_lbl  : Label
var target_coord  : Label
var distance_lbl  : Label
var score_lbl     : Label
var message_lbl   : Label

# ── State ──────────────────────────────────────────────────────────────────
var stars_collected : int = 0
var total_stars     : int = 5
var message_timer   : float = 0.0


func _ready() -> void:
	# Grab node references so we can update them every frame
	player       = $Player
	target       = $Target
	stars        = $Stars
	player_coord = $UI/CoordDisplay/VBox/PlayerCoord
	quadrant_lbl = $UI/CoordDisplay/VBox/QuadrantLabel
	target_coord = $UI/CoordDisplay/VBox/TargetCoord
	distance_lbl = $UI/CoordDisplay/VBox/DistanceLabel
	score_lbl    = $UI/CoordDisplay/VBox/ScoreLabel
	message_lbl  = $UI/MessageLabel

	# Style the UI panels so they look clean
	_style_panels()

	# Connect each star's area so we know when the player touches it
	for star in stars.get_children():
		var area := Area2D.new()
		var col   := CollisionShape2D.new()
		var shape := CircleShape2D.new()
		shape.radius = 20.0
		col.shape    = shape
		area.add_child(col)
		star.add_child(area)
		# Store the star reference so we can hide it on collection
		area.set_meta("star", star)
		area.body_entered.connect(_on_star_body_entered.bind(area))

	# Wire up sandbox button
	$UI/SandboxBtn.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/sandbox.tscn"))

	# Update target label once
	_update_target_label()

	# Tell Godot we want to draw custom graphics (the grid)
	queue_redraw()


func _process(delta: float) -> void:
	# ── Update coordinate display every frame ──────────────────────────────
	var px : int = roundi(player.position.x)
	var py : int = roundi(player.position.y)

	player_coord.text = "Player:  x = %d ,  y = %d" % [px, py]
	quadrant_lbl.text = "Quadrant: %s" % _get_quadrant(px, py)

	# Distance to target (using the Pythagorean theorem / Vector2.distance_to)
	var dist : float = player.position.distance_to(target.position)
	distance_lbl.text = "Distance to target: %.0f px" % dist

	# ── Flash message timer ────────────────────────────────────────────────
	if message_timer > 0.0:
		message_timer -= delta
		if message_timer <= 0.0:
			message_lbl.text = ""


func _input(event: InputEvent) -> void:
	# ── Click to teleport ──────────────────────────────────────────────────
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			player.position = event.position
			queue_redraw()  # redraw grid (position label updates in _process)

	# ── Keyboard shortcuts ─────────────────────────────────────────────────
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_R:
				# Reset player to screen center
				player.position = Vector2(512, 300)
				_show_message("Reset to (512, 300) — the center of the screen!")

			KEY_T:
				# Move target to a new random position (stays on-screen)
				target.position = Vector2(
					randf_range(50, SCREEN_W - 50),
					randf_range(50, SCREEN_H - 50)
				)
				_update_target_label()
				_show_message("New target placed at (%d, %d)!" % [
					roundi(target.position.x),
					roundi(target.position.y)
				])

			KEY_G:
				# Toggle the coordinate grid
				show_grid = !show_grid
				queue_redraw()
				_show_message("Grid: %s" % ("ON" if show_grid else "OFF"))

			KEY_0:
				player.position = Vector2(0, 0)
				_show_message("(0, 0) — the TOP-LEFT corner of the screen!")

			KEY_1:
				player.position = Vector2(512, 300)
				_show_message("(512, 300) — center of a 1024×600 screen!")


# ── Drawing ────────────────────────────────────────────────────────────────
func _draw() -> void:
	if show_grid:
		_draw_grid()
	_draw_axes()
	_draw_origin_marker()


func _draw_grid() -> void:
	# Vertical lines (constant X)
	var x : int = 0
	while x <= SCREEN_W:
		draw_line(
			Vector2(x, 0),
			Vector2(x, SCREEN_H),
			GRID_COLOR, 1.0
		)
		# Label every other gridline
		if x > 0 and x % (GRID_SPACING * 2) == 0:
			draw_string(
				ThemeDB.fallback_font,
				Vector2(x + 2, SCREEN_H - 4),
				str(x),
				HORIZONTAL_ALIGNMENT_LEFT,
				-1, 11,
				LABEL_COLOR
			)
		x += GRID_SPACING

	# Horizontal lines (constant Y)
	var y : int = 0
	while y <= SCREEN_H:
		draw_line(
			Vector2(0, y),
			Vector2(SCREEN_W, y),
			GRID_COLOR, 1.0
		)
		if y > 0 and y % (GRID_SPACING * 2) == 0:
			draw_string(
				ThemeDB.fallback_font,
				Vector2(4, y - 3),
				str(y),
				HORIZONTAL_ALIGNMENT_LEFT,
				-1, 11,
				LABEL_COLOR
			)
		y += GRID_SPACING


func _draw_axes() -> void:
	# In Godot, (0,0) is top-left — these are the screen EDGES, not a center axis.
	# We draw them thicker and brighter to highlight the coordinate boundaries.
	draw_line(Vector2(0, 0), Vector2(SCREEN_W, 0), AXIS_COLOR, 2.5)   # Top edge (y = 0)
	draw_line(Vector2(0, 0), Vector2(0, SCREEN_H), AXIS_COLOR, 2.5)   # Left edge (x = 0)

	# Axis labels
	draw_string(ThemeDB.fallback_font, Vector2(6, 18),  "x = 0 (left edge)",  HORIZONTAL_ALIGNMENT_LEFT, -1, 13, AXIS_COLOR)
	draw_string(ThemeDB.fallback_font, Vector2(6, 34),  "y = 0 (top edge)",   HORIZONTAL_ALIGNMENT_LEFT, -1, 13, AXIS_COLOR)
	draw_string(ThemeDB.fallback_font, Vector2(SCREEN_W - 90, 16), "x = 1024", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, AXIS_COLOR)
	draw_string(ThemeDB.fallback_font, Vector2(6, SCREEN_H - 6),   "y = 600",  HORIZONTAL_ALIGNMENT_LEFT, -1, 13, AXIS_COLOR)


func _draw_origin_marker() -> void:
	# Highlight (0,0) with a small dot and label
	draw_circle(Vector2(0, 0), 5.0, ORIGIN_COLOR)
	draw_string(ThemeDB.fallback_font, Vector2(8, 12), "(0, 0)", HORIZONTAL_ALIGNMENT_LEFT, -1, 11, ORIGIN_COLOR)


# ── Helpers ────────────────────────────────────────────────────────────────

## Returns a description of where the player is on screen.
## This mirrors the quadrant concept from math — but in screen space.
func _get_quadrant(px: int, py: int) -> String:
	var cx : int = SCREEN_W / 2   # 512
	var cy : int = SCREEN_H / 2   # 300
	if   px < cx and py < cy: return "Top-Left     (x<512, y<300)"
	elif px > cx and py < cy: return "Top-Right    (x>512, y<300)"
	elif px < cx and py > cy: return "Bottom-Left  (x<512, y>300)"
	elif px > cx and py > cy: return "Bottom-Right (x>512, y>300)"
	else:                      return "Center axis"


func _update_target_label() -> void:
	target_coord.text = "🎯 Target:  x = %d ,  y = %d" % [
		roundi(target.position.x),
		roundi(target.position.y)
	]


func _show_message(msg: String) -> void:
	message_lbl.text  = msg
	message_timer     = 3.0   # seconds before it disappears


## Called when the player body enters a star's Area2D
func _on_star_body_entered(area: Area2D) -> void:
	var star : Node = area.get_meta("star")
	if star.visible:
		star.visible    = false
		stars_collected += 1
		score_lbl.text  = "⭐ Stars collected: %d / %d" % [stars_collected, total_stars]
		_show_message("⭐ Star collected at (%d, %d)!" % [
			roundi(star.position.x),
			roundi(star.position.y)
		])
		if stars_collected == total_stars:
			_show_message("🎉 All stars collected! Press R to reset and try again!")


## Style all UI Panel nodes with a semi-transparent dark theme
func _style_panels() -> void:
	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color            = Color(0.08, 0.05, 0.18, 0.88)
	panel_style.border_width_left   = 3
	panel_style.border_width_right  = 1
	panel_style.border_width_top    = 1
	panel_style.border_width_bottom = 1
	panel_style.border_color        = Color(0.42, 0.27, 0.74, 0.9)
	panel_style.corner_radius_top_left     = 6
	panel_style.corner_radius_top_right    = 6
	panel_style.corner_radius_bottom_left  = 6
	panel_style.corner_radius_bottom_right = 6
	panel_style.content_margin_left   = 4.0
	panel_style.content_margin_right  = 4.0
	panel_style.content_margin_top    = 4.0
	panel_style.content_margin_bottom = 4.0

	for panel_name in ["CoordDisplay", "Controls", "ChallengePanel"]:
		var panel := get_node_or_null("UI/" + panel_name)
		if panel:
			panel.add_theme_stylebox_override("panel", panel_style.duplicate())
