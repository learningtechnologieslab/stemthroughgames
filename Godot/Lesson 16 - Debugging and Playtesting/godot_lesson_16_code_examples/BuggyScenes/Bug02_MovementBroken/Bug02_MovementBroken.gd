## ============================================================
## Bug 02: Movement Not Working (Wrong Node Type)
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT THIS SCENE DEMONSTRATES:
##   move_and_slide() is a method that ONLY exists on
##   CharacterBody2D nodes. If the Player node is a plain
##   Node2D, the method doesn't exist — Godot throws an error.
##
## THE BUG:
##   The Player node in the scene tree is type "Node2D".
##   This script calls move_and_slide() which requires
##   "CharacterBody2D". The method simply does not exist
##   on a Node2D.
##
## WHAT YOU WILL SEE:
##   Press any arrow key → error in Output panel:
##   "Invalid call. Nonexistent function 'move_and_slide'
##    in base 'Node2D'."
##   The square will not move at all.
##
## YOUR TASK:
##   1. Read the error message — what "base" does it mention?
##   2. Open the Scene panel, right-click the Player node.
##   3. Choose "Change Type" → CharacterBody2D.
##   4. Add a CollisionShape2D child with a RectangleShape2D.
##   5. Run again — movement should now work.
##
## DEBUGGING STRATEGIES TO TRY:
##   • print(typeof(self)) → shows the node's type at runtime
##   • Search Godot docs for "move_and_slide" — what node type
##     is listed under "Inherits"?
## ============================================================

## ❌ BUG: This script is attached to a Node2D, not CharacterBody2D.
##    extends Node2D does NOT have move_and_slide().
extends Node2D

const SPEED = 200.0

func _ready():
	print("Bug 02 ready. Try pressing arrow keys.")
	# 💡 DEBUGGING TIP: What does this print?
	print("My node type / class is: ", get_class())

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
		direction = direction.normalized()
	
	# ❌ BUG IS HERE ↓
	# move_and_slide() does not exist on Node2D.
	# This will throw: "Invalid call. Nonexistent function 'move_and_slide'"
	velocity = direction * SPEED  # 'velocity' also doesn't exist on Node2D
	move_and_slide()

## ============================================================
## HINT (read only if stuck for 3+ minutes):
##
##   In the Scene tree:
##   1. Right-click "Player" node → Change Type → CharacterBody2D
##   2. Add child node: CollisionShape2D
##   3. Set CollisionShape2D's Shape property to: New RectangleShape2D
##
##   Also change the first line of this script:
##   extends Node2D   →   extends CharacterBody2D
##
##   CharacterBody2D has both 'velocity' and 'move_and_slide()' built in.
## ============================================================
