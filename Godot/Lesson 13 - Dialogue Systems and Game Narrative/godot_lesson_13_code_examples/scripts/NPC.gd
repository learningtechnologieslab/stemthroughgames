# =============================================================================
# NPC.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   Base script for all NPCs (Non-Player Characters) in the game.
#   Each NPC holds their own dialogue arrays and knows when to trigger them.
#
# MATH CONNECTION:
#   Each NPC stores multiple dialogue arrays - think of them as "chapters"
#   the NPC can speak. We use array indices to move through lines:
#
#     first_meeting_lines[0]  → Line 1
#     first_meeting_lines[1]  → Line 2
#     first_meeting_lines[2]  → Line 3 (last valid index = size()-1 = 2)
#
# STUDENT CHALLENGE:
#   Try adding a new NPC by:
#   1. Duplicate this script
#   2. Change the npc_name and all dialogue arrays
#   3. Add your NPC scene to the game world
# =============================================================================

extends Area2D

# -----------------------------------------------------------------------------
# NPC IDENTITY - change these in the Inspector for each NPC
# -----------------------------------------------------------------------------
@export var npc_name: String = "Village Elder"
@export var interaction_prompt: String = "Press E to talk"
@export var sprite_color: Color = Color(0.6, 0.4, 1.0)

# -----------------------------------------------------------------------------
# NODE REFERENCES
# -----------------------------------------------------------------------------
@onready var sprite:         Sprite2D = $Sprite2D
@onready var interaction_label: Label = $InteractionLabel
@onready var exclamation:    Label    = $ExclamationMark

# -----------------------------------------------------------------------------
# DIALOGUE DATA
# MATH: Each of these is an Array of Strings.
# Access with dialogue_array[index] where index is 0 to size()-1
# -----------------------------------------------------------------------------

## Shown the very first time the player talks to this NPC
var first_meeting_lines: Array = [
	"Welcome to the village, traveler.",
	"I am the Elder of Millbrook. We have lived here peacefully for generations.",
	"But recently... something has changed in the forest.",
	"Strange sounds at night. Missing livestock. The goblins have grown bold.",
	"We are a simple people. We need someone with courage.",
	"Will you help us?"
]

## Shown after the player has already talked to this NPC
var revisit_lines: Array = [
	"Ah, you return. Have you made a decision?",
	"The goblins grow bolder every day.",
	"I hope you will choose to help us."
]

## Shown after the player helps the village
var after_help_lines: Array = [
	"You are truly a hero, traveler.",
	"The village will not forget your bravery.",
	"Our trust in you is complete."
]

## Shown if the player refused to help
var refused_lines: Array = [
	"I understand. Not everyone is cut out for adventure.",
	"Perhaps someone else will come along.",
	"Safe travels to you."
]

## The choices shown after the first meeting
var goblin_choices: Array = [
	{
		"text": "\"I will help you! Tell me where the goblins are.\"",
		"result": "accepted",
		"trust_change": 3,
		"sets_variable": {"name": "helped_village", "value": true},
		"next_lines": [
			"Bless you, brave traveler!",
			"The goblin camp is to the east, beyond the old mill.",
			"Be careful - their leader, Gruk, is cunning.",
			"Return to me when it is done, and you will be rewarded."
		]
	},
	{
		"text": "\"I'm sorry, I cannot get involved.\"",
		"result": "refused",
		"trust_change": -1,
		"sets_variable": {"name": "helped_village", "value": false},
		"next_lines": [
			"I see. That is... disappointing.",
			"We will have to find another way.",
			"Safe travels, traveler."
		]
	}
]

# -----------------------------------------------------------------------------
# PRIVATE STATE
# -----------------------------------------------------------------------------
var _player_in_range: bool = false
var _has_met_player: bool = false


# -----------------------------------------------------------------------------
# BUILT-IN FUNCTIONS
# -----------------------------------------------------------------------------

func _ready() -> void:
	# Style the NPC sprite
	if sprite:
		sprite.modulate = sprite_color

	# Start with interaction prompt hidden
	if interaction_label:
		interaction_label.hide()
		interaction_label.text = interaction_prompt

	if exclamation:
		exclamation.hide()

	# Connect area signals for player detection
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	# Connect to DialogueManager to know when dialogue ends
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	print("[NPC:%s] Ready." % npc_name)


func _process(_delta: float) -> void:
	# Check for player interaction input
	if _player_in_range and Input.is_action_just_pressed("interact"):
		_start_conversation()


# -----------------------------------------------------------------------------
# INTERACTION DETECTION
# -----------------------------------------------------------------------------

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_in_range = true
		if interaction_label:
			interaction_label.show()
		if exclamation:
			exclamation.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_in_range = false
		if interaction_label:
			interaction_label.hide()
		if exclamation:
			exclamation.hide()


# -----------------------------------------------------------------------------
# DIALOGUE LOGIC
# This is where we decide WHICH dialogue array to use based on game state.
# -----------------------------------------------------------------------------

func _start_conversation() -> void:
	# Don't start a new conversation if one is already active
	if DialogueManager.is_active:
		return

	# Track how many NPCs the player has talked to
	DialogueManager.modify_variable("times_talked", 1)

	# Decide which dialogue to show based on game variables
	var helped = DialogueManager.get_variable("helped_village", null)

	if helped == true:
		# Player already accepted the quest
		DialogueManager.start_dialogue(npc_name, after_help_lines)

	elif helped == false:
		# Player already refused
		DialogueManager.start_dialogue(npc_name, refused_lines)

	elif _has_met_player:
		# Player has talked before but not yet made a choice
		DialogueManager.start_dialogue(npc_name, revisit_lines)
		# Queue the choices to appear after these lines
		_queue_choices_after_dialogue()

	else:
		# First ever meeting!
		_has_met_player = true
		DialogueManager.start_dialogue(npc_name, first_meeting_lines)
		_queue_choices_after_dialogue()


func _queue_choices_after_dialogue() -> void:
	# Wait for the dialogue to end, then present choices
	# We disconnect first to avoid connecting multiple times
	if DialogueManager.dialogue_ended.is_connected(_present_goblin_choices):
		DialogueManager.dialogue_ended.disconnect(_present_goblin_choices)
	DialogueManager.dialogue_ended.connect(_present_goblin_choices, CONNECT_ONE_SHOT)


func _present_goblin_choices() -> void:
	# Start a new "dialogue" just for the choice prompt
	DialogueManager.start_dialogue(npc_name, ["What say you, traveler?"])
	# After that single line, present the actual choices
	DialogueManager.dialogue_ended.connect(
		func(): DialogueManager.present_choices(goblin_choices),
		CONNECT_ONE_SHOT
	)


func _on_dialogue_ended() -> void:
	# Called after any dialogue ends - update visuals if needed
	var helped = DialogueManager.get_variable("helped_village", null)
	if helped == true and exclamation:
		exclamation.hide()  # Quest accepted - no more exclamation mark
