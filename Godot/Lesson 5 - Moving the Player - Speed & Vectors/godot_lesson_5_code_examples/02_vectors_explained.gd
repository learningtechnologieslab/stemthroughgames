# =============================================================================
# STEM Through Games — Day 5: Moving the Player
# FILE: 02_vectors_explained.gd
# LEVEL: Math Explorer (watch the Output panel!)
# =============================================================================
#
# WHAT THIS SCRIPT DOES:
#   This version prints vector math to the Godot Output panel so you can
#   SEE exactly what's happening with numbers, every frame.
#
# HOW TO USE:
#   1. Attach to a CharacterBody2D (same setup as 01_basic_movement.gd)
#   2. Open the Output panel at the bottom of the Godot editor
#   3. Press F5 and use arrow keys — watch the numbers change!
#
# LEARNING GOAL:
#   See the connection between:
#     • What key you press  →  direction vector  →  velocity vector
# =============================================================================

extends CharacterBody2D

var speed = 200

# This variable prevents the output panel from being flooded with
# identical messages every frame. It only prints when something changes.
var last_direction = Vector2.ZERO


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
	
	velocity = direction * speed
	move_and_slide()
	
	# ── Print math to the Output panel (only when direction changes) ──────────
	if direction != last_direction:
		last_direction = direction
		_print_vector_math(direction)


func _print_vector_math(direction: Vector2):
	# Draw a separator line for readability
	print("─────────────────────────────────────────")
	
	if direction == Vector2.ZERO:
		print("No keys pressed:")
		print("  direction = Vector2(0, 0)  →  STANDING STILL")
		return
	
	# Show the direction vector
	print("Direction vector:  ", direction)
	
	# Show the multiplication step by step
	print("Calculation:")
	print("  velocity.x  =  direction.x × speed  =  ", direction.x, " × ", speed, "  =  ", direction.x * speed)
	print("  velocity.y  =  direction.y × speed  =  ", direction.y, " × ", speed, "  =  ", direction.y * speed)
	
	# Show the final velocity
	print("Final velocity:    ", velocity)
	
	# Human-readable direction label
	var label = _direction_label(direction)
	print("Moving:  ", label)
	
	# Show magnitude (useful for diagonal discussion)
	var magnitude = velocity.length()
	print("Speed (magnitude): ", snapped(magnitude, 0.1), " px/sec")
	
	# Flag if diagonal (faster than expected!)
	if direction.x != 0 and direction.y != 0:
		print("⚠️  DIAGONAL! Speed is ", snapped(magnitude, 0.1), " instead of ", speed)
		print("   That's ", snapped(magnitude / speed * 100, 0.1), "% of your set speed!")
		print("   Why? Because √(", speed, "² + ", speed, "²) = √", speed*speed + speed*speed, " ≈ ", snapped(sqrt(speed*speed + speed*speed), 0.1))


func _direction_label(dir: Vector2) -> String:
	# Return a human-readable string for the direction
	if dir == Vector2(1, 0):   return "RIGHT →"
	if dir == Vector2(-1, 0):  return "← LEFT"
	if dir == Vector2(0, -1):  return "↑ UP  (negative Y = up on screen)"
	if dir == Vector2(0, 1):   return "DOWN ↓"
	if dir == Vector2(1, -1):  return "↗ UP-RIGHT (diagonal)"
	if dir == Vector2(-1, -1): return "↖ UP-LEFT  (diagonal)"
	if dir == Vector2(1, 1):   return "↘ DOWN-RIGHT (diagonal)"
	if dir == Vector2(-1, 1):  return "↙ DOWN-LEFT (diagonal)"
	return "Unknown direction"


# =============================================================================
# 📊 WHAT TO LOOK FOR IN THE OUTPUT PANEL:
# =============================================================================
#
# When you press RIGHT:
#   direction = (1, 0)
#   velocity.x = 1 × 200 = 200
#   velocity.y = 0 × 200 = 0
#   Final velocity = (200, 0)
#
# When you press UP:
#   direction = (0, -1)      ← note the NEGATIVE 1 !
#   velocity.x = 0 × 200 = 0
#   velocity.y = -1 × 200 = -200
#   Final velocity = (0, -200)
#
# When you press RIGHT + UP at the same time:
#   direction = (1, -1)
#   velocity = (200, -200)
#   Magnitude ≈ 282.8 px/sec  ← 41% faster than 200!
#   This is the DIAGONAL SPEED BUG. See 03_normalized_movement.gd for the fix.
# =============================================================================
