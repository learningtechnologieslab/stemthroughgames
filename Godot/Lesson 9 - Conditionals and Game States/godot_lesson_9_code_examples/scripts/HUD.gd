# =============================================================================
# HUD.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# The HUD (Heads-Up Display) reacts to the Player's signals using conditionals.
# This script demonstrates how UI elements can change based on game state.
#
# LESSON CONNECTION:
#   - The player EMITS signals when health/score change
#   - The HUD LISTENS for those signals and updates its display
#   - Conditionals decide HOW the display changes (colors, messages, etc.)
# =============================================================================

extends CanvasLayer

# Node references — @onready fills these when the scene is ready
@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthRow/HealthBar
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthRow/HealthLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreRow/ScoreLabel
@onready var state_label: Label = $MarginContainer/VBoxContainer/StateLabel
@onready var hint_label: Label = $HintLabel
@onready var message_panel: Panel = $MessagePanel
@onready var message_label: Label = $MessagePanel/MessageLabel


func _ready() -> void:
	# Hide the big message panel at start
	message_panel.visible = false
	hint_label.text = "[H] Take Damage   [E] Collect Point   [R] Restart   [A/D] Move   [Space] Jump"
	_update_state_display("PLAYING")


# -----------------------------------------------------------------------------
# SIGNAL HANDLERS — Called automatically when the Player emits a signal
# -----------------------------------------------------------------------------

func _on_player_health_changed(new_health: int, max_hp: int) -> void:
	# Update the health bar value
	health_bar.max_value = max_hp
	health_bar.value = new_health
	health_label.text = str(new_health) + " / " + str(max_hp)

	# ==========================================================================
	# CONDITIONALS: Change health bar COLOR based on how much health remains
	# This is a great example of if/elif/else changing VISUAL behavior!
	# ==========================================================================
	if new_health <= 0:
		# Dead — gray
		health_bar.modulate = Color(0.5, 0.5, 0.5)
		_update_state_display("GAME OVER")

	elif new_health < 30:
		# Danger zone — red
		health_bar.modulate = Color(1.0, 0.2, 0.2)
		_update_state_display("LOW HEALTH ⚠️")

	elif new_health < 60:
		# Caution zone — orange/yellow
		health_bar.modulate = Color(1.0, 0.65, 0.0)
		_update_state_display("PLAYING")

	else:
		# Healthy — green
		health_bar.modulate = Color(0.2, 0.85, 0.3)
		_update_state_display("PLAYING")


func _on_player_score_changed(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

	# CONDITIONAL: Highlight score when close to winning
	if new_score >= 8:
		score_label.modulate = Color(1.0, 0.85, 0.0)  # Gold color — almost there!
	else:
		score_label.modulate = Color(1.0, 1.0, 1.0)   # Normal white


func _on_player_game_over() -> void:
	_show_message("GAME OVER", Color(0.8, 0.1, 0.1), "Press R to restart")
	_update_state_display("GAME OVER")


func _on_player_won() -> void:
	_show_message("YOU WIN! 🏆", Color(0.2, 0.75, 0.2), "Congratulations!")
	_update_state_display("WIN!")


# -----------------------------------------------------------------------------
# HELPERS
# -----------------------------------------------------------------------------

func _update_state_display(state_text: String) -> void:
	state_label.text = "State: " + state_text

	# CONDITIONAL: Color the state label differently for each game state
	# This maps game state strings to colors — a simple "state machine" pattern
	if state_text == "GAME OVER":
		state_label.modulate = Color(0.8, 0.1, 0.1)
	elif state_text == "WIN!":
		state_label.modulate = Color(0.2, 0.9, 0.2)
	elif state_text.begins_with("LOW"):
		state_label.modulate = Color(1.0, 0.5, 0.0)
	else:
		state_label.modulate = Color(1.0, 1.0, 1.0)


func _show_message(title: String, color: Color, subtitle: String) -> void:
	message_panel.visible = true
	message_label.text = title + "\n" + subtitle
	message_panel.modulate = color
