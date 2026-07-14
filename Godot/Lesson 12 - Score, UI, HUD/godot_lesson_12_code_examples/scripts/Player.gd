## Player.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## This script controls the Player node (CharacterBody2D).
## It defines custom signals that broadcast score and health
## changes so the HUD can display them without the Player
## needing to know anything about the HUD directly.
##
## LESSON CONCEPTS COVERED:
##   - Custom signal definitions
##   - emit_signal() to broadcast data
##   - Variables for score and health
##   - Functions that modify state and notify listeners

extends CharacterBody2D

# ─── Signals ──────────────────────────────────────────────────────────────────
## Emitted whenever the player's score changes.
## The HUD listens to this and updates the ScoreLabel.
signal score_changed(new_score: int)

## Emitted whenever the player's health changes.
## The HUD listens to this and updates the HealthLabel.
signal health_changed(new_health: int)

## Emitted when the player's health reaches zero.
signal player_died()

# ─── Player Stats ─────────────────────────────────────────────────────────────
## Current score. Starts at 0.
var score: int = 0

## Current health. Starts at 100.
var health: int = 100

## Maximum health (used to clamp health above zero).
const MAX_HEALTH: int = 100

## How fast the player moves (pixels per second).
const SPEED: float = 200.0

## Jump velocity applied when the spacebar is pressed.
const JUMP_VELOCITY: float = -400.0

# ─── Built-in Functions ───────────────────────────────────────────────────────

func _ready() -> void:
	## Called once when the node enters the scene tree.
	## We emit both signals immediately so the HUD shows
	## the correct starting values (0 score, 100 HP).
	emit_signal("score_changed", score)
	emit_signal("health_changed", health)

func _physics_process(delta: float) -> void:
	## Called every physics frame. Handles movement.
	
	# Add gravity when the player is in the air.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Jump when Space is pressed and the player is on the floor.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Horizontal movement with arrow keys or A/D.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

# ─── Public Functions (called by other nodes / collisions) ────────────────────

## Call this to add points to the player's score.
## Example: player.add_score(10)   →   score becomes 10, HUD updates.
func add_score(points: int) -> void:
	score += points
	emit_signal("score_changed", score)
	print("Score is now: ", score)          # Debug: visible in Godot Output panel

## Call this to subtract health from the player.
## Example: player.take_damage(25)  →   health becomes 75, HUD updates.
func take_damage(amount: int) -> void:
	health -= amount
	# Clamp health so it never goes below 0.
	health = max(health, 0)
	emit_signal("health_changed", health)
	print("Health is now: ", health)        # Debug
	
	# Check for death.
	if health <= 0:
		emit_signal("player_died")
		_on_player_died()

## Call this to restore health (up to MAX_HEALTH).
func heal(amount: int) -> void:
	health = min(health + amount, MAX_HEALTH)
	emit_signal("health_changed", health)

# ─── Private Helpers ──────────────────────────────────────────────────────────

func _on_player_died() -> void:
	## Internal: handle death (placeholder – expanded in Day 13).
	print("Player died! Game over.")
	# TODO Day 13: transition to Game Over state here.
