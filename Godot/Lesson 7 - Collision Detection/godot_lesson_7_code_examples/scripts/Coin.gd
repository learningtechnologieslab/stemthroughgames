## Coin.gd
## STEM Through Games — Day 7: Collision Detection
##
## This script is attached to an Area2D node that acts as a collectible coin.
##
## NODE STRUCTURE (set up in Coin.tscn):
##   Area2D  ← this script lives here
##   ├── CollisionShape2D  (CircleShape2D, radius ~12px)
##   └── Sprite2D          (yellow circle drawn in code)
##
## HOW IT WORKS:
##   Area2D is a special node that detects when other physics bodies
##   enter its collision shape — but it does NOT physically block them.
##   Think of it as an invisible sensor zone.
##
##   When the player's CollisionShape2D overlaps this coin's CircleShape2D,
##   Godot fires the "body_entered" signal, which calls _on_body_entered().
##
## MATH CONNECTION — AABB:
##   Before checking the exact shapes, Godot first tests whether the
##   Axis-Aligned Bounding Boxes (AABBs) of the two objects overlap.
##   Only if the AABBs overlap does Godot do the more precise shape test.
##   This two-step process keeps the physics engine fast.

extends Area2D

# ─────────────────────────────────────────────────────────────
#  SIGNALS
# ─────────────────────────────────────────────────────────────

## Emitted when this coin is collected.
## The Main scene listens for this to update the HUD score label.
signal coin_collected


# ─────────────────────────────────────────────────────────────
#  EXPORT VARIABLES (editable in the Godot Inspector)
# ─────────────────────────────────────────────────────────────

## How many points this coin is worth
@export var point_value: int = 1

## Optional: play a sound when collected (connect an AudioStreamPlayer)
@export var collect_sound: AudioStream = null


# ─────────────────────────────────────────────────────────────
#  PRIVATE VARIABLES
# ─────────────────────────────────────────────────────────────

# Used for the floating animation
var _float_time: float = 0.0
var _start_y: float = 0.0


# ─────────────────────────────────────────────────────────────
#  READY
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	# Remember starting Y position for the float animation
	_start_y = position.y

	# Connect the body_entered signal to our handler function.
	# This is equivalent to clicking "Connect" in the Node panel.
	# In the lesson, students connect this in the editor — both ways work!
	#
	# body_entered fires when a PhysicsBody2D (like CharacterBody2D)
	# enters this Area2D's collision shape.
	body_entered.connect(_on_body_entered)


# ─────────────────────────────────────────────────────────────
#  PROCESS (runs every rendered frame)
# ─────────────────────────────────────────────────────────────

func _process(delta: float) -> void:
	# Simple floating animation using a sine wave
	_float_time += delta
	position.y = _start_y + sin(_float_time * 2.5) * 4.0


# ─────────────────────────────────────────────────────────────
#  SIGNAL HANDLER — body_entered
# ─────────────────────────────────────────────────────────────

## Called automatically when a physics body enters this Area2D.
##
## The 'body' parameter is the node that entered — usually the Player.
## We check it IS the player before doing anything, so enemies or
## other objects don't accidentally collect coins.
func _on_body_entered(body: Node2D) -> void:
	# ── LESSON FOCUS: This is the collision response! ────────
	#
	# At this point, Godot has already confirmed:
	#   1. The AABB of 'body' overlaps our AABB          (fast check)
	#   2. The precise shapes overlap each other          (exact check)
	#
	# Now we decide what to DO about the collision.

	# Only respond if the entering body is in the "player" group
	# (The Player node has been added to the "player" group)
	if not body.is_in_group("player"):
		return  # Not the player — ignore this collision

	# ── Collect the coin ─────────────────────────────────────
	print("Collected! Point value: ", point_value)

	# Tell the player to add to their score
	if body.has_method("add_score"):
		body.add_score(point_value)

	# Emit our custom signal so the HUD can update
	coin_collected.emit()

	# Play collection sound if one is assigned
	if collect_sound:
		# Play on a separate AudioStreamPlayer so sound survives queue_free()
		var audio = AudioStreamPlayer.new()
		audio.stream = collect_sound
		audio.autoplay = true
		get_tree().root.add_child(audio)
		audio.finished.connect(audio.queue_free)

	# Remove this coin from the scene
	# queue_free() tells Godot to delete this node at the end of the frame
	queue_free()


# ─────────────────────────────────────────────────────────────
#  DAY 7 STUDENT CHALLENGES
# ─────────────────────────────────────────────────────────────
#
#  CHALLENGE 1 (Starter):
#    Change point_value to 5 in the Inspector.
#    Does the score go up by 5 when you collect a coin?
#
#  CHALLENGE 2 (Intermediate):
#    Right now the coin disappears instantly.
#    Add a small animation before queue_free() by using a Tween:
#
#    var tween = create_tween()
#    tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
#    await tween.finished
#    queue_free()
#
#  CHALLENGE 3 (Advanced):
#    Add a second collision shape that is LARGER than the visible coin.
#    This is the "magnet zone" — when the player enters the outer ring,
#    the coin should move toward the player instead of waiting.
#    Hint: Use a second Area2D as a child node.
#
