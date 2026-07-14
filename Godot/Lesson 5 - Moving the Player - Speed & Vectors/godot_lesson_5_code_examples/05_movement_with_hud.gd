# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 05_movement_with_hud.gd
# LEVEL: Visual Learner — See the math ON SCREEN while you play!
# =============================================================================
#
# WHAT THIS SCRIPT DOES:
#   Shows a live HUD (Heads-Up Display) that displays:
#     • Current direction vector
#     • Current velocity vector
#     • Current speed (magnitude)
#     • Player's position on screen
#
# HOW TO SET UP THE SCENE:
#   CharacterBody2D  (attach this script)
#   ├── CollisionShape2D
#   ├── ColorRect  (or Sprite2D) — the visible character
#   └── CanvasLayer
#       └── VBoxContainer  (anchor: top-left)
#           ├── Label  (name it "LabelDirection")
#           ├── Label  (name it "LabelVelocity")
#           ├── Label  (name it "LabelSpeed")
#           └── Label  (name it "LabelPosition")
#
# SIMPLER ALTERNATIVE:
#   If the scene is too complex, just use this script without the HUD nodes —
#   it will print to the Output panel instead.
# =============================================================================

extends CharacterBody2D

var speed = 200

# References to the HUD labels (assign in the Inspector, or use $NodePath)
# If these are null, we fall back to printing in the Output panel.
@onready var label_direction = get_node_or_null("CanvasLayer/VBoxContainer/LabelDirection")
@onready var label_velocity  = get_node_or_null("CanvasLayer/VBoxContainer/LabelVelocity")
@onready var label_speed     = get_node_or_null("CanvasLayer/VBoxContainer/LabelSpeed")
@onready var label_position  = get_node_or_null("CanvasLayer/VBoxContainer/LabelPosition")


func _ready():
	if label_direction == null:
		print("Note: HUD labels not found. Printing to Output panel instead.")
		print("(See the scene setup instructions at the top of this file.)")


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
	
	# ── Update the HUD every frame ────────────────────────────────────────────
	_update_hud(direction)


func _update_hud(direction: Vector2):
	
	# Format numbers to 1 decimal place for readability
	var dir_text = "Direction:  (%s, %s)" % [snapped(direction.x, 0.01), snapped(direction.y, 0.01)]
	var vel_text = "Velocity:   (%s, %s)" % [snapped(velocity.x, 0.1),  snapped(velocity.y, 0.1)]
	var spd_text = "Speed:      %s px/sec" % snapped(velocity.length(), 0.1)
	var pos_text = "Position:   (%s, %s)" % [snapped(global_position.x, 1.0), snapped(global_position.y, 1.0)]
	
	if label_direction != null:
		# Update the on-screen labels
		label_direction.text = dir_text
		label_velocity.text  = vel_text
		label_speed.text     = spd_text
		label_position.text  = pos_text
		
		# Color the speed label red when diagonal (bug visible!)
		if direction.x != 0 and direction.y != 0:
			label_speed.modulate = Color(1.0, 0.3, 0.3)   # Red = diagonal (faster)
		else:
			label_speed.modulate = Color(0.3, 1.0, 0.3)   # Green = straight (correct)
	else:
		# Fallback: print a compact one-liner every 30 frames (not every frame)
		# to avoid flooding the Output panel
		if Engine.get_process_frames() % 30 == 0:
			print("%s  |  %s  |  %s" % [dir_text, vel_text, spd_text])


# =============================================================================
# 💡 EXTENSION IDEA — Draw the velocity vector as an arrow
# =============================================================================
# If you want to see the velocity as an arrow on screen, you can use
# draw_line() inside a _draw() function. Here's a starter:
#
# func _draw():
#     if velocity.length() > 0:
#         var arrow_end = velocity * 0.3   # Scale down for display
#         draw_line(Vector2.ZERO, arrow_end, Color.CYAN, 3.0)
#         # The arrow starts at the character's center (0,0 in local space)
#
# Then add this to _physics_process to refresh the drawing:
#     queue_redraw()
# =============================================================================
