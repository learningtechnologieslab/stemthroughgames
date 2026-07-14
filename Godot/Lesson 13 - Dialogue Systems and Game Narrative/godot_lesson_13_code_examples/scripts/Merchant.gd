# =============================================================================
# Merchant.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   A second NPC that demonstrates how dialogue can REACT to game variables
#   set by previous conversations. The Merchant knows if you helped the Elder!
#
# EXTENSION EXERCISE:
#   The Merchant's dialogue changes based on:
#   1. The "trust" variable (set when talking to the Village Elder)
#   2. The "helped_village" variable (true/false based on player's choice)
#   3. How many times the player has talked to NPCs
#
# STUDENT CHALLENGE:
#   Add a third NPC (a Guard, a Child, a Wizard?) with their own dialogue
#   that reacts to different game variables.
# =============================================================================

extends Area2D

@export var npc_name: String = "The Merchant"
@export var sprite_color: Color = Color(0.9, 0.7, 0.2)

@onready var sprite:            Sprite2D = $Sprite2D
@onready var interaction_label: Label    = $InteractionLabel

var _player_in_range: bool = false
var _has_met_player:  bool = false

# ─────────────────────────────────────────────────────────────────────────────
# DIALOGUE ARRAYS
# MATH: Each array is a separate list. We choose WHICH array to use
# based on game variable values — this is branching narrative!
# ─────────────────────────────────────────────────────────────────────────────

var greeting_lines: Array = [
	"Ah, a traveler! Come, come, I have wares for sale.",
	"But first — have you spoken to the Elder?"
]

## Dialogue if player HELPED the village (helped_village == true)
var hero_lines: Array = [
	"I heard you agreed to help the Elder. Brave soul!",
	"Word travels fast in a small village.",
	"My finest goods — free of charge — for the hero of Millbrook.",
	"Safe travels, and come back victorious!"
]

## Dialogue if player REFUSED to help (helped_village == false)
var coward_lines: Array = [
	"So you refused the Elder, did you?",
	"I won't judge — not everyone is a warrior.",
	"But... the goblins trouble us all. Even my trading routes.",
	"If you change your mind, the Elder will forgive you."
]

## Dialogue if player hasn't talked to the Elder yet
var uninformed_lines: Array = [
	"You haven't spoken to the Elder yet, have you?",
	"Look for the old one near the well in the village center.",
	"We have a... situation that needs addressing.",
	"Go talk to the Elder. Trust me."
]

## High trust version (trust >= 4)
var high_trust_lines: Array = [
	"The whole village is talking about you!",
	"A trust rating of %d out of 10 — impressive!",
	"You have a real gift for diplomacy.",
	"Come back anytime."
]


# ─────────────────────────────────────────────────────────────────────────────
# BUILT-IN FUNCTIONS
# ─────────────────────────────────────────────────────────────────────────────

func _ready() -> void:
	if sprite:
		sprite.modulate = sprite_color
	if interaction_label:
		interaction_label.hide()
		interaction_label.text = "Press E to talk"

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(_delta: float) -> void:
	if _player_in_range and Input.is_action_just_pressed("interact"):
		_start_conversation()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_in_range = true
		if interaction_label:
			interaction_label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		_player_in_range = false
		if interaction_label:
			interaction_label.hide()


# ─────────────────────────────────────────────────────────────────────────────
# DIALOGUE SELECTION LOGIC
# This is the key teaching moment: variables from one conversation
# change the dialogue in ANOTHER conversation!
# ─────────────────────────────────────────────────────────────────────────────

func _start_conversation() -> void:
	if DialogueManager.is_active:
		return

	DialogueManager.modify_variable("times_talked", 1)

	# Read the game variables set by previous conversations
	var helped   = DialogueManager.get_variable("helped_village", null)
	var trust    = DialogueManager.get_variable("trust", 0)

	# Choose which dialogue array to use
	# MATH: This is a chain of if/elif — the first true condition wins
	var lines_to_show: Array

	if trust >= 4 and helped == true:
		# High trust + helped = special appreciation dialogue
		# MATH: Replace %d placeholder with actual trust value
		var formatted = high_trust_lines.duplicate()
		formatted[1] = formatted[1] % trust   # Insert trust value into string
		lines_to_show = formatted

	elif helped == true:
		lines_to_show = hero_lines

	elif helped == false:
		lines_to_show = coward_lines

	elif not _has_met_player:
		# First visit, don't know if they talked to Elder yet
		_has_met_player = true
		lines_to_show = greeting_lines

	else:
		# Been here before, still hasn't talked to Elder
		lines_to_show = uninformed_lines

	# Start the conversation with the selected dialogue array
	print("[Merchant] Selected %d lines based on: helped=%s, trust=%d" % [lines_to_show.size(), str(helped), trust])
	DialogueManager.start_dialogue(npc_name, lines_to_show)
