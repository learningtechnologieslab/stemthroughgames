# npc_dialogue.gd
# Attach this script to your NPC's Area2D node.
#
# This script shows a dialogue label when the player enters the NPC's
# collision zone, and hides it when they leave.
#
# Node tree required:
#   NPC (Area2D)          ← this script goes here
#   ├── Sprite2D
#   ├── CollisionShape2D
#   └── DialogueLabel (Label)

extends Area2D

# ─── NPC DATA ────────────────────────────────────────────────────────────────

# 🎨 CUSTOMIZE: Change the NPC name to match your character.
@export var npc_name: String = "The Old Watchman"

# 🎨 CUSTOMIZE: Write 1–4 lines of story dialogue here.
#   Each line should hint at your world's history — not explain game controls.
#   Think: what does this character know that the player doesn't yet?
@export var dialogue_lines: Array[String] = [
	"They said the machines stopped the night the lights went out…",
	"I haven't seen anyone come through that door in three years.",
	"Don't go near the east wing. Not after what happened.",
]

# Tracks which line to show next (so each interaction shows a new line)
var current_line_index: int = 0

# ─── NODE REFERENCES ─────────────────────────────────────────────────────────

# @onready means Godot fills this in automatically when the scene starts.
# Make sure your Label node is named "DialogueLabel" in the Scene panel.
@onready var dialogue_label: Label = $DialogueLabel

# ─── SETUP ───────────────────────────────────────────────────────────────────

func _ready() -> void:
	# Hide the dialogue when the game starts — it only appears on interaction.
	dialogue_label.visible = false

	# Set the first line of dialogue so it's ready to show.
	_update_dialogue_text()

# ─── SIGNAL HANDLERS ─────────────────────────────────────────────────────────

# This function runs when ANY physics body enters the Area2D zone.
# We check the name to make sure it's the player, not a falling box or enemy.
func _on_body_entered(body: Node2D) -> void:
	# 🎨 CUSTOMIZE: Change "Player" if your player node has a different name.
	if body.name == "Player":
		dialogue_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		dialogue_label.visible = false

		# Advance to the next dialogue line for the NEXT interaction.
		# When we reach the end of the list, loop back to the beginning.
		current_line_index = (current_line_index + 1) % dialogue_lines.size()
		_update_dialogue_text()

# ─── HELPER FUNCTIONS ────────────────────────────────────────────────────────

func _update_dialogue_text() -> void:
	# Guard: if there are no dialogue lines, do nothing.
	if dialogue_lines.is_empty():
		return

	# Build the display text: NPC name on top, dialogue below.
	var name_tag: String = "[" + npc_name + "]"
	var line: String = dialogue_lines[current_line_index]

	dialogue_label.text = name_tag + "\n" + line
