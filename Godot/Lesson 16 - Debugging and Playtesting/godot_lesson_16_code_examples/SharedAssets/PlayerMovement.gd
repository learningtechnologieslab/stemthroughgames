## ============================================================
## PlayerMovement.gd — Shared movement script
## STEM Through Games — Day 16: Debugging & Playtesting
##
## Attach to a CharacterBody2D node.
## Used by Bug03, Bug04, Fix03, Fix04 scenes.
## ============================================================

extends CharacterBody2D

const SPEED = 250.0

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * SPEED
	else:
		velocity = velocity.lerp(Vector2.ZERO, 0.25)
	
	move_and_slide()
