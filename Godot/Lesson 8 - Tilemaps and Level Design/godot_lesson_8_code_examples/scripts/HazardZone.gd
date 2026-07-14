## HazardZone.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## An Area2D that respawns the player when they touch a hazard tile.
##
## LEVEL DESIGN CONNECTION:
##   Where you place hazards matters a lot!
##   • Hazard too close to the start = frustrating
##   • Hazard with no warning = unfair
##   • Hazard clearly visible + enough space to react = challenging but fair
##
## STUDENT EXTENSION:
##   Try adding multiple HazardZone nodes to your level.
##   You can duplicate this node in the Scene tree (Ctrl+D).
## ─────────────────────────────────────────────────────────────────────────

extends Area2D

@onready var hazard_sprite: ColorRect = $HazardSprite

# Cooldown prevents the signal firing multiple times in one frame
var _cooldown: bool = false

# ─────────────────────────────────────────────────────────────────────────
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	print("HazardZone ready at grid position:", _get_grid_pos())

# ─────────────────────────────────────────────────────────────────────────
func _on_body_entered(body: Node2D) -> void:
	if _cooldown:
		return
	if not body is CharacterBody2D:
		return

	_cooldown = true
	print("Player hit hazard at:", body.global_position)

	# Flash red
	hazard_sprite.color = Color(1.0, 1.0, 0.0, 1.0)
	await get_tree().create_timer(0.1).timeout
	hazard_sprite.color = Color(0.91, 0.3, 0.24, 0.8)

	# Notify World to respawn the player
	var world = get_tree().get_first_node_in_group("world")
	if world:
		world.player_hit_hazard.emit()

	# Reset cooldown after a short delay
	await get_tree().create_timer(1.0).timeout
	_cooldown = false

# ─────────────────────────────────────────────────────────────────────────
func _get_grid_pos() -> Vector2i:
	const TILE_SIZE: int = 64
	return Vector2i(int(global_position.x / TILE_SIZE), int(global_position.y / TILE_SIZE))
