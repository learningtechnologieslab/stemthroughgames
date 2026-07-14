## GoalZone.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## An Area2D that triggers "Level Complete!" when the Player enters it.
##
## KEY CONCEPT — Signals:
##   body_entered is emitted by Area2D automatically whenever a
##   CharacterBody2D, RigidBody2D, or StaticBody2D overlaps with our
##   CollisionShape2D. We connect it in _ready() and handle it below.
##
## STUDENT TASK:
##   After placing this node on the TileMap, try changing the color
##   of GoalSprite in the Inspector to match your level's visual theme!
## ─────────────────────────────────────────────────────────────────────────

extends Area2D

# ── Node references ───────────────────────────────────────────────────────
@onready var goal_sprite: ColorRect = $GoalSprite
@onready var goal_label:  Label     = $GoalLabel

# ── State ─────────────────────────────────────────────────────────────────
var _triggered: bool = false

# ─────────────────────────────────────────────────────────────────────────
func _ready() -> void:
	# Connect the signal: when any body enters this area, call our handler
	body_entered.connect(_on_body_entered)

	# Start a gentle pulse animation so the goal is always visible
	_start_pulse_animation()

	print("GoalZone ready at grid position:", _get_grid_pos())

# ─────────────────────────────────────────────────────────────────────────
## Fires when a physics body enters the goal area.
func _on_body_entered(body: Node2D) -> void:
	if _triggered:
		return   # only trigger once
	if not body is CharacterBody2D:
		return

	_triggered = true
	print("GOAL REACHED! Player was at:", body.global_position)

	# Change the goal colour to gold to show it's been activated
	goal_sprite.color = Color(1.0, 0.84, 0.0, 0.9)
	goal_label.text   = "YOU WIN! 🎉"

	# Notify the World
	var world = get_tree().get_first_node_in_group("world")
	if world:
		world.player_reached_goal.emit()

# ─────────────────────────────────────────────────────────────────────────
func _start_pulse_animation() -> void:
	# Slowly pulses between 70% and 100% opacity
	var tween = create_tween().set_loops()
	tween.tween_property(goal_sprite, "color:a", 0.4, 0.8)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(goal_sprite, "color:a", 0.8, 0.8)\
		.set_ease(Tween.EASE_IN_OUT)

# ─────────────────────────────────────────────────────────────────────────
func _get_grid_pos() -> Vector2i:
	const TILE_SIZE: int = 64
	return Vector2i(int(global_position.x / TILE_SIZE), int(global_position.y / TILE_SIZE))
