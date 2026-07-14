## Obstacle.gd
## STEM Through Games — Day 7: Collision Detection
##
## Obstacles are StaticBody2D nodes — they don't move, but
## they have a CollisionShape2D so the player can't pass through them.
##
## DAY 7 FOCUS:
##   On Day 7 we add CollisionShape2D to obstacles.
##   Without it, the player would fall straight through!
##
## NODE STRUCTURE (set up in Obstacle.tscn):
##   StaticBody2D  ← this script lives here
##   ├── CollisionShape2D  (RectangleShape2D)
##   └── Sprite2D          (platform/wall graphic)

extends StaticBody2D

# ─────────────────────────────────────────────────────────────
#  EXPORT VARIABLES
# ─────────────────────────────────────────────────────────────

## Set to true to make this obstacle harmful (kills the player on touch)
@export var is_hazard: bool = false

## Color used when drawing the obstacle in the absence of a sprite
@export var obstacle_color: Color = Color(0.3, 0.5, 0.8)


# ─────────────────────────────────────────────────────────────
#  READY
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	if is_hazard:
		# Hazard obstacles are drawn red as a visual cue
		# (In a real project you'd swap the sprite instead)
		modulate = Color(1.0, 0.3, 0.3)
		print("Hazard obstacle placed at: ", global_position)
	else:
		print("Obstacle placed at: ", global_position)


# ─────────────────────────────────────────────────────────────
#  HITBOX NOTE FOR STUDENTS
# ─────────────────────────────────────────────────────────────
#
#  This obstacle has a RectangleShape2D CollisionShape2D.
#  The shape DOES need to closely match the visual platform
#  so players don't feel like they're running on air.
#
#  Compare this to the Coin (Area2D) — coins use CircleShape2D
#  because the collection zone should feel natural and round.
#
#  QUESTION TO DISCUSS:
#    Should a spike hazard have a hitbox that is:
#      a) Exactly the same as the spike sprite?
#      b) Slightly smaller (forgiving — players can barely graze spikes)?
#      c) Slightly larger (punishing — spikes feel dangerous)?
#    There is no single right answer — it depends on your game's design!
#
