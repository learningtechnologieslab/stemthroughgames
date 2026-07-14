## ============================================================
## Fix 02: Movement Not Working — FIXED REFERENCE VERSION
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT WAS FIXED:
##   extends Node2D  →  extends CharacterBody2D
##   Node type in scene changed from Node2D to CharacterBody2D
##   CollisionShape2D child added with a RectangleShape2D
##
## WHY THIS WORKS NOW:
##   CharacterBody2D inherits from PhysicsBody2D which provides:
##   • velocity (Vector2 property)
##   • move_and_slide() method
##   • Automatic collision response with the physics world
##
##   Node2D has none of these — it is a pure 2D transform node
##   with no physics capabilities.
##
## PHYSICS CONNECTION:
##   move_and_slide() applies Newtonian physics:
##   • It moves the body by 'velocity * delta' each frame
##   • It checks for collisions along the way
##   • It slides the velocity along collision surfaces
##     (so you don't get stuck on walls)
##   • Gravity accumulates in velocity.y each frame
## ============================================================

## ✅ FIX: Changed from Node2D → CharacterBody2D
extends CharacterBody2D

const SPEED = 200.0
const GRAVITY = 600.0

func _ready():
	print("Fix 02 ready. Node type: ", get_class())
	print("velocity property exists: ", "velocity" in self)

func _physics_process(delta):
	## Apply gravity (makes movement feel physical)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	## Horizontal movement from input
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	
	## ✅ velocity and move_and_slide() both exist on CharacterBody2D
	if direction.x != 0:
		velocity.x = direction.x * SPEED
	else:
		## Smooth deceleration: lerp toward 0
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	
	## Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -400.0
	
	## ✅ This now works correctly
	move_and_slide()

## ============================================================
## PHYSICS + MATH CONNECTION:
##
##   velocity is a Vector2: velocity = Vector2(vx, vy)
##   Each frame: position += velocity * delta
##
##   With gravity: vy += g * delta  (acceleration)
##   This is the kinematic equation:  v = v₀ + at
##
##   move_and_slide() handles the position update and
##   collision resolution simultaneously.
## ============================================================
