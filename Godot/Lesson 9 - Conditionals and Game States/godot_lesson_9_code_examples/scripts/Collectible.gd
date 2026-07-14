# =============================================================================
# Collectible.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# A coin or point item the player can walk over to gain score.
# Demonstrates: conditionals, signals, and Area2D collision.
#
# LESSON CONNECTION:
#   When the player overlaps this area, we call player.add_score(1),
#   which triggers the WIN CONDITION check in Player.gd.
# =============================================================================

extends Area2D

@export var point_value: int = 1   # How many points this collectible gives
@export var auto_respawn: bool = false
@export var respawn_time: float = 5.0

var is_collected: bool = false     # Prevents collecting the same item twice


func _ready() -> void:
	# Connect the body_entered signal to our handler function
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	# =========================================================================
	# CONDITIONAL: Only react if:
	#   1. Not already collected (prevents double-counting)
	#   2. The entering body is actually the Player
	# Uses AND (&&): BOTH conditions must be true
	# =========================================================================
	if !is_collected && body.is_in_group("player"):
		is_collected = true
		body.add_score(point_value)
		print("⭐ Collected! +", point_value, " point(s)")
		_play_collect_effect()

		if auto_respawn:
			_start_respawn_timer()
		else:
			queue_free()  # Remove this collectible from the scene


func _play_collect_effect() -> void:
	# Hide the visual immediately, then free after a tiny delay
	# (In a real project you'd play a particle/sound effect here)
	visible = false
	await get_tree().create_timer(0.1).timeout


func _start_respawn_timer() -> void:
	visible = false
	await get_tree().create_timer(respawn_time).timeout
	visible = true
	is_collected = false
	print("Collectible respawned!")
