# =============================================================================
# VillageScene.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   The main playable scene. A top-down village where the player walks
#   around and talks to NPCs to experience branching dialogue.
#
# SCENE STRUCTURE:
#   VillageScene (Node2D)        ← this script
#   ├── TileMap (or ColorRect background)
#   ├── Player (CharacterBody2D) ← Player.gd
#   ├── VillageElder (Area2D)    ← NPC.gd
#   ├── Merchant (Area2D)        ← NPC.gd  (second NPC for extension)
#   ├── DialogueBoxLayer (CanvasLayer)
#   │   └── DialogueBox (Control) ← DialogueBox.gd
#   └── UI (CanvasLayer)
#       ├── HUD (Control)
#       │   ├── TrustBar (ProgressBar)
#       │   ├── TrustLabel (Label)
#       │   └── StatusLabel (Label)
#       └── BackButton (Button)
# =============================================================================

extends Node2D


# ─────────────────────────────────────────────────────────────────────────────
# NODE REFERENCES
# ─────────────────────────────────────────────────────────────────────────────

@onready var trust_bar:    ProgressBar = $UI/HUD/TrustBar
@onready var trust_label:  Label       = $UI/HUD/TrustLabel
@onready var status_label: Label       = $UI/HUD/StatusLabel
@onready var back_button:  Button      = $UI/BackButton


# ─────────────────────────────────────────────────────────────────────────────
# BUILT-IN FUNCTIONS
# ─────────────────────────────────────────────────────────────────────────────

func _ready() -> void:
	# Connect to DialogueManager to track story state
	DialogueManager.variable_changed.connect(_on_variable_changed)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	# Back button
	if back_button:
		back_button.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))

	# Initialize HUD
	_update_hud()

	print("[VillageScene] Scene ready. Walk to an NPC and press E to talk!")
	print("[VillageScene] Watch the Trust variable change as you make choices.")


# ─────────────────────────────────────────────────────────────────────────────
# HUD / UI UPDATES
# ─────────────────────────────────────────────────────────────────────────────

func _update_hud() -> void:
	var trust = DialogueManager.get_variable("trust", 0)
	var helped = DialogueManager.get_variable("helped_village", null)

	# Update trust bar
	# MATH: Trust goes from -5 to +10. Bar shows 0 to 10 clamped.
	if trust_bar:
		trust_bar.max_value = 10
		trust_bar.value = clamp(trust, 0, 10)

	if trust_label:
		trust_label.text = "Trust: %d" % trust

	# Update status label
	if status_label:
		if helped == true:
			status_label.text = "Quest: Active — Find the goblin camp!"
		elif helped == false:
			status_label.text = "Quest: Refused. The village is on its own."
		else:
			status_label.text = "Talk to the Village Elder"


func _on_variable_changed(var_name: String, new_value) -> void:
	print("[VillageScene] Variable changed: %s = %s" % [var_name, str(new_value)])
	_update_hud()


func _on_dialogue_ended() -> void:
	_update_hud()
	_check_story_state()


## Check if any story milestones have been reached
func _check_story_state() -> void:
	var trust = DialogueManager.get_variable("trust", 0)

	# MATH: Conditional logic based on variable values
	if trust >= 5:
		DialogueManager.set_variable("reputation", "hero")
	elif trust <= -2:
		DialogueManager.set_variable("reputation", "coward")
	else:
		DialogueManager.set_variable("reputation", "neutral")
