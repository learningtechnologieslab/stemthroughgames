## Coin.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## A simple collectible that awards points when the player
## walks into it.  Attach to an Area2D node with a
## CollisionShape2D child.
##
## LESSON CONCEPTS COVERED:
##   - Area2D and body_entered signal
##   - Calling add_score() on the Player
##   - queue_free() to remove the coin from the scene

extends Area2D

## Points awarded when this coin is collected.
@export var point_value: int = 10

func _ready() -> void:
	## Connect the built-in body_entered signal to our handler.
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	## Called when any physics body overlaps this area.
	## We check it's the Player before awarding points.
	
	if body.is_in_group("player"):
		body.add_score(point_value)
		print("Coin collected! +", point_value, " points")
		queue_free()   # Remove coin from the scene.
