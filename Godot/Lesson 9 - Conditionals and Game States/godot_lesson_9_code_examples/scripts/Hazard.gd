# =============================================================================
# Hazard.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# A damage zone (spikes, lava, etc.) that hurts the player on contact.
# Demonstrates: repeated conditionals with timers, damage logic.
#
# LESSON CONNECTION:
#   Touching this hazard calls player.take_damage(), which triggers
#   the if/elif/else health check chain in Player.gd.
# =============================================================================

extends Area2D

@export var damage_per_hit: int = 25       # How much damage each hit does
@export var hit_cooldown: float = 1.0      # Seconds between repeated hits
@export var damage_type: String = "spike"  # For descriptive print messages

var can_damage: bool = true                # Cooldown flag — prevents spam damage
var players_inside: Array = []            # Track who's currently in the zone


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	# CONDITIONAL: Only damage Player nodes
	if body.is_in_group("player"):
		players_inside.append(body)
		_apply_damage(body)


func _on_body_exited(body: Node2D) -> void:
	# Remove from tracking when the player leaves
	if body in players_inside:
		players_inside.erase(body)


func _apply_damage(player: Node2D) -> void:
	# CONDITIONAL: Only deal damage if cooldown has expired
	if !can_damage:
		return

	can_damage = false
	print("💥 Hit by ", damage_type, "! Taking ", damage_per_hit, " damage.")
	player.take_damage(damage_per_hit)

	# Start the cooldown timer before allowing damage again
	await get_tree().create_timer(hit_cooldown).timeout
	can_damage = true

	# If player is still inside the hazard, damage them again
	# CONDITIONAL + BOOLEAN: player must still be in the list AND alive
	for p in players_inside:
		if p != null && p.is_alive():
			_apply_damage(p)
			break  # Only hit the first player found
