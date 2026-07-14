extends Area2D

# =============================================================================
# STEM Through Games Program — Day 10: Loops, Timers & Spawning
# Script: CoinPickup.gd
# =============================================================================
# This script controls a single collectible coin.
#
# CONCEPTS DEMONSTRATED:
#   • Custom signals — emit a signal when the coin is collected
#   • Groups        — add_to_group() lets MainGame count remaining coins
#   • Area2D        — body_entered detects player overlap
#   • queue_free()  — safely remove a node from the scene tree
# =============================================================================

# Emit this signal when the player picks up the coin.
# MainGame listens for it to update the score.
signal collected

# How much this coin is worth (can be changed per wave in the future)
@export var value: int = 10

# Animation state
var _float_offset: float = 0.0
var _start_y: float = 0.0


# =============================================================================
# _ready()
# =============================================================================
func _ready() -> void:
	# Register in the "coins" group so MainGame can count remaining coins
	add_to_group("coins")

	# Store starting Y so we can animate a gentle float
	_start_y = position.y

	# Connect our own body_entered signal (player must be in "player" group)
	body_entered.connect(_on_body_entered)


# =============================================================================
# _process() — runs every frame; animates a gentle bobbing motion
# =============================================================================
func _process(delta: float) -> void:
	_float_offset += delta * 3.0                              # Speed of bobbing
	position.y = _start_y + sin(_float_offset) * 6.0         # ±6 pixel bob


# =============================================================================
# _on_body_entered() — called when a physics body overlaps this Area2D
# =============================================================================
func _on_body_entered(body: Node2D) -> void:
	# Only respond to the player character
	if body.is_in_group("player"):
		collected.emit()   # Tell MainGame we were collected
		queue_free()       # Remove this coin from the scene
