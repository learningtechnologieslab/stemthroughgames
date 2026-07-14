# =============================================================================
# GameManager.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# The Game Manager controls the overall game state machine.
# It listens to the Player's signals and decides what happens next.
#
# LESSON CONNECTION:
#   This is a more complete "game state" system. Instead of just checking
#   health and score inside the Player, we track a named GameState enum —
#   a common pattern used in real games.
#
# EXTENSION CHALLENGE: This file shows students what a full state machine
#   looks like. It uses an enum to name game states clearly.
# =============================================================================

extends Node

# =========================================================================
# GAME STATE ENUM
# =========================================================================
# An enum is a set of named constants. Instead of magic numbers like
#   state == 0  (what does 0 mean?!)
# we use readable names:
#   state == GameState.PLAYING  (clear!)
#
enum GameState {
	PLAYING,
	LOW_HEALTH,
	GAME_OVER,
	WIN
}

var current_state: GameState = GameState.PLAYING

# Node references
@onready var player: CharacterBody2D = $Player
@onready var hud: CanvasLayer = $HUD


func _ready() -> void:
	# Connect Player signals to GameManager handlers
	player.health_changed.connect(_on_health_changed)
	player.score_changed.connect(_on_score_changed)
	player.game_over.connect(_on_game_over)
	player.player_won.connect(_on_player_won)

	# Connect Player signals to HUD as well
	player.health_changed.connect(hud._on_player_health_changed)
	player.score_changed.connect(hud._on_player_score_changed)
	player.game_over.connect(hud._on_player_game_over)
	player.player_won.connect(hud._on_player_won)

	print("=== STEM Through Games: Day 9 ===")
	print("Controls: A/D Move | Space Jump | H Damage | E Collect | R Restart")
	print("Current state: ", GameState.keys()[current_state])


func _on_health_changed(new_health: int, max_hp: int) -> void:
	# =========================================================================
	# CONDITIONAL: Update the game state based on health value
	# Notice how we use the GameState enum to set named states
	# =========================================================================
	if new_health <= 0:
		_change_state(GameState.GAME_OVER)

	elif new_health < 30:
		# Only change to LOW_HEALTH if currently PLAYING (not WIN or GAME_OVER)
		if current_state == GameState.PLAYING:
			_change_state(GameState.LOW_HEALTH)

	else:
		# Healed back above 30 — return to PLAYING
		if current_state == GameState.LOW_HEALTH:
			_change_state(GameState.PLAYING)


func _on_score_changed(new_score: int) -> void:
	# The win condition is handled inside Player.gd, but the manager
	# can also respond here (e.g., to spawn new collectibles, etc.)
	print("[GameManager] Score updated: ", new_score)


func _on_game_over() -> void:
	_change_state(GameState.GAME_OVER)


func _on_player_won() -> void:
	_change_state(GameState.WIN)


func _change_state(new_state: GameState) -> void:
	# =========================================================================
	# CONDITIONAL: Only change state if it's actually different
	# Prevents triggering the same state logic twice in a row
	# =========================================================================
	if new_state == current_state:
		return

	var old_state_name: String = GameState.keys()[current_state]
	current_state = new_state
	var new_state_name: String = GameState.keys()[current_state]

	print("[GameManager] State: ", old_state_name, " → ", new_state_name)

	# =========================================================================
	# REACT to the new state
	# Each branch here handles what happens when we ENTER a new state
	# =========================================================================
	if current_state == GameState.GAME_OVER:
		print("Game over sequence starting...")

	elif current_state == GameState.WIN:
		print("Win sequence starting...")

	elif current_state == GameState.LOW_HEALTH:
		print("Player in danger!")

	elif current_state == GameState.PLAYING:
		print("Back to normal gameplay.")


func _input(event: InputEvent) -> void:
	# Global restart — works from any state
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
