# =============================================================================
# DialogueManager.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   This is an Autoload (singleton) script that manages all dialogue in the
#   game. Any scene can call DialogueManager to start a conversation.
#
# MATH CONNECTION:
#   Arrays store ordered lists. dialogue_lines[0] is always the FIRST item.
#   Valid indices: 0 to dialogue_lines.size() - 1
#   This pattern appears in music playlists, to-do lists, and more!
#
# HOW TO USE:
#   1. This script is loaded as an Autoload (see Project > Project Settings > Autoload)
#   2. Call DialogueManager.start_dialogue(npc_name, dialogue_array) from any scene
#   3. Connect to the signals to respond when dialogue ends or choices are made
# =============================================================================

extends Node

# -----------------------------------------------------------------------------
# SIGNALS
# Signals let other scripts know when something important happens.
# Think of them like notifications or events.
# -----------------------------------------------------------------------------

## Emitted when a new line of dialogue is ready to display
signal dialogue_line_changed(speaker: String, line: String)

## Emitted when the player must choose between options
signal choices_presented(choices: Array)

## Emitted when the entire dialogue sequence ends
signal dialogue_ended

## Emitted when the player's choice changes a variable
signal variable_changed(var_name: String, new_value)


# -----------------------------------------------------------------------------
# STATE VARIABLES
# These track what's happening right now in the conversation.
# -----------------------------------------------------------------------------

## Is a dialogue currently playing?
var is_active: bool = false

## Who is currently speaking?
var current_speaker: String = ""

## The full array of dialogue lines for the current conversation
## MATH: This is an Array - an ordered list indexed from 0
var dialogue_lines: Array = []

## Our position in the dialogue array
## MATH: This starts at 0 (the first index) and counts up
var dialogue_index: int = 0

## Game variables that track player choices and story state
## Dictionary maps variable names to their values
## Example: { "trust": 0, "helped_village": false, "goblin_choice": "none" }
var game_variables: Dictionary = {}


# -----------------------------------------------------------------------------
# BUILT-IN FUNCTIONS
# -----------------------------------------------------------------------------

func _ready() -> void:
	# Initialize default game variables when the game starts
	_reset_game_variables()
	print("[DialogueManager] Ready! Game variables initialized.")


# -----------------------------------------------------------------------------
# PUBLIC FUNCTIONS - called by other scripts
# -----------------------------------------------------------------------------

## Start a dialogue conversation
## Parameters:
##   speaker_name : String - who is talking (e.g. "Village Elder")
##   lines        : Array  - the dialogue lines to display
func start_dialogue(speaker_name: String, lines: Array) -> void:
	if lines.is_empty():
		push_warning("[DialogueManager] start_dialogue() called with empty array!")
		return

	# Store the conversation data
	current_speaker = speaker_name
	dialogue_lines = lines   # MATH: Store the array
	dialogue_index = 0       # MATH: Start at index 0 (the beginning)
	is_active = true

	print("[DialogueManager] Starting dialogue with %s (%d lines)" % [speaker_name, lines.size()])

	# Show the first line immediately
	# MATH: dialogue_lines[0] = the first element (index 0)
	dialogue_line_changed.emit(current_speaker, dialogue_lines[dialogue_index])


## Advance to the next line of dialogue
## Called when the player presses the "Next" button
func advance_dialogue() -> void:
	if not is_active:
		return

	# MATH: Increment the index (move to the next position in the array)
	dialogue_index += 1

	# MATH: BOUNDS CHECK - is our new index still within the valid range?
	# Valid indices are: 0, 1, 2, ..., size()-1
	# If dialogue_index >= size(), we've gone past the end!
	if dialogue_index < dialogue_lines.size():
		# Safe to access - emit the next line
		dialogue_line_changed.emit(current_speaker, dialogue_lines[dialogue_index])
	else:
		# We've reached the end of the dialogue
		_end_dialogue()


## Present a choice to the player
## choices: Array of Dictionaries, each with "text" and "result" keys
## Example:
##   [
##     {"text": "I will help!", "result": "accepted", "trust_change": 2},
##     {"text": "No thanks.",   "result": "refused",  "trust_change": -1}
##   ]
func present_choices(choices: Array) -> void:
	if choices.is_empty():
		push_warning("[DialogueManager] present_choices() called with empty array!")
		return

	choices_presented.emit(choices)


## The player made a choice - process its effects
## choice: Dictionary - the choice the player selected
func make_choice(choice: Dictionary) -> void:
	print("[DialogueManager] Player chose: %s" % choice.get("text", "???"))

	# Apply any variable changes from this choice
	if choice.has("trust_change"):
		modify_variable("trust", choice["trust_change"])

	if choice.has("sets_variable"):
		var var_data = choice["sets_variable"]
		set_variable(var_data["name"], var_data["value"])

	# Continue with the dialogue branch for this choice
	if choice.has("next_lines"):
		dialogue_lines = choice["next_lines"]
		dialogue_index = 0
		dialogue_line_changed.emit(current_speaker, dialogue_lines[dialogue_index])
	else:
		_end_dialogue()


## Set a game variable to a specific value
func set_variable(var_name: String, value) -> void:
	game_variables[var_name] = value
	variable_changed.emit(var_name, value)
	print("[DialogueManager] Set %s = %s" % [var_name, str(value)])


## Add or subtract from a numeric game variable
func modify_variable(var_name: String, amount: int) -> void:
	if not game_variables.has(var_name):
		game_variables[var_name] = 0
	game_variables[var_name] += amount
	variable_changed.emit(var_name, game_variables[var_name])
	print("[DialogueManager] Modified %s by %d → now %d" % [var_name, amount, game_variables[var_name]])


## Get the current value of a game variable
func get_variable(var_name: String, default_value = null):
	return game_variables.get(var_name, default_value)


# -----------------------------------------------------------------------------
# PRIVATE FUNCTIONS - internal helpers (prefixed with _)
# -----------------------------------------------------------------------------

func _end_dialogue() -> void:
	is_active = false
	dialogue_lines = []
	dialogue_index = 0
	print("[DialogueManager] Dialogue ended. Game variables: %s" % str(game_variables))
	dialogue_ended.emit()


func _reset_game_variables() -> void:
	game_variables = {
		"trust":           0,      # How much the village trusts the player (0-10)
		"helped_village":  false,  # Did the player agree to help?
		"goblin_choice":   "none", # What did the player decide about the goblins?
		"times_talked":    0,      # How many NPCs has the player spoken to?
		"reputation":      "neutral" # "hero", "neutral", or "coward"
	}
