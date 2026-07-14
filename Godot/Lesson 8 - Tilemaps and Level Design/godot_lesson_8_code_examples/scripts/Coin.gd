## Coin.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## An Area2D that detects when the Player walks into it.
## When collected:
##   1. Tells the World to increment the coin counter
##   2. Plays a simple scale animation
##   3. Hides itself (queue_free removes it from the scene)
##
## HOW IT WORKS — Signals:
##   Area2D emits "body_entered" when a physics body enters its collision shape.
##   We connect that signal to _on_body_entered() in _ready().
## ─────────────────────────────────────────────────────────────────────────

extends Area2D

# ── Node references ───────────────────────────────────────────────────────
@onready var sprite: ColorRect = $CoinSprite

# ── State ─────────────────────────────────────────────────────────────────
var _collected: bool = false   # prevent collecting twice

# ─────────────────────────────────────────────────────────────────────────
func _ready() -> void:
	# Connect the Area2D's built-in signal to our handler function
	body_entered.connect(_on_body_entered)

	# Gentle floating animation using a Tween
	_start_float_animation()

# ─────────────────────────────────────────────────────────────────────────
## Called when any physics body enters our collision area.
## We check it's actually the Player before collecting.
func _on_body_entered(body: Node2D) -> void:
	# Guard: only collect once, and only when the Player touches us
	if _collected:
		return
	if not body.is_in_group("player") and not body is CharacterBody2D:
		return

	_collected = true
	print("Coin collected at grid position:", _get_grid_pos())

	# Tell the World (parent scene) that a coin was collected
	# We walk up the scene tree to find the World node
	var world = get_tree().get_first_node_in_group("world")
	if world:
		world.coin_collected.emit()

	# Play a quick pop-and-disappear animation, then remove this node
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2.0, 2.0), 0.12)
	tween.tween_property(self, "scale", Vector2(0.0, 0.0), 0.1)
	tween.tween_callback(queue_free)  # removes this node after animation

# ─────────────────────────────────────────────────────────────────────────
## A looping up-down float animation so the coin is easy to spot
func _start_float_animation() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - 6.0, 0.6)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y + 6.0, 0.6)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

# ─────────────────────────────────────────────────────────────────────────
## Returns the tile-grid coordinate of this coin.
## MATH: col = int(pixel_x / tile_size)
func _get_grid_pos() -> Vector2i:
	const TILE_SIZE: int = 64
	return Vector2i(int(global_position.x / TILE_SIZE), int(global_position.y / TILE_SIZE))
