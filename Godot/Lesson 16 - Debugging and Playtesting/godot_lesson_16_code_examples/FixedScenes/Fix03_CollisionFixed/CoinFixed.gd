## CoinFixed.gd — Fixed version of Coin.gd
## collision_mask = 1 so the Area2D detects CharacterBody2D on layer 1

extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	print("CoinFixed ready. Mask: ", collision_mask, " (layer 1 = player layer)")

func _on_body_entered(body):
	print("Coin collected by: ", body.name, " — signal fired correctly!")
	get_parent().update_score()
	queue_free()
