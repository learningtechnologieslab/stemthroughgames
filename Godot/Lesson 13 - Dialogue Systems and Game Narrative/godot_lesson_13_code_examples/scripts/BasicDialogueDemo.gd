# =============================================================================
# BasicDialogueDemo.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   This is the STARTER demo from the lesson plan.
#   It directly implements the code shown in class, then builds on it.
#
#   Start here! Read through this script top to bottom.
#
# WHAT YOU'LL SEE:
#   - The exact dialogue array from the lesson
#   - How dialogue_index traverses the array
#   - Console output showing index math in real time
#
# ─────────────────────────────────────────────────────
#  LESSON CODE (from Day 13 lesson plan)
# ─────────────────────────────────────────────────────
#
#   var dialogue = [
#       "Welcome to the village, traveler.",
#       "We have a problem with goblins...",
#       "Will you help us?"
#   ]
#   var dialogue_index = 0
#
#   func _on_next_pressed():
#       dialogue_index += 1
#       if dialogue_index < dialogue.size():
#           $DialogueLabel.text = dialogue[dialogue_index]
#       else:
#           hide()  # end of dialogue
#
# ─────────────────────────────────────────────────────
#
# SCENE STRUCTURE:
#   BasicDialogueDemo (Control)   ← this script
#   ├── Background (ColorRect)
#   ├── InfoPanel (Panel)
#   │   ├── InfoTitle (Label)     "Array State"
#   │   └── InfoText (RichTextLabel)
#   └── DialogueBox (Panel)
#       ├── SpeakerLabel (Label)
#       ├── DialogueLabel (RichTextLabel)
#       ├── NextButton (Button)
#       └── BackButton (Button)   → back to main menu
# =============================================================================

extends Control

# ─────────────────────────────────────────────────────────────────────────────
# THE LESSON'S DIALOGUE ARRAY
# MATH: An array stores an ordered list. Index 0 = first item.
# ─────────────────────────────────────────────────────────────────────────────

## The dialogue array from the lesson (3 elements, indices 0, 1, 2)
var dialogue: Array = [
	"Welcome to the village, traveler.",
	"We have a problem with goblins...",
	"Will you help us?"
]

## Current position in the array
## MATH: Starts at 0 (arrays are 0-indexed, not 1-indexed!)
var dialogue_index: int = 0


# ─────────────────────────────────────────────────────────────────────────────
# NODE REFERENCES
# ─────────────────────────────────────────────────────────────────────────────

@onready var speaker_label:  Label         = $DialogueBox/SpeakerLabel
@onready var dialogue_label: RichTextLabel = $DialogueBox/DialogueLabel
@onready var next_button:    Button        = $DialogueBox/NextButton
@onready var info_text:      RichTextLabel = $InfoPanel/InfoText
@onready var dialogue_box:   Panel         = $DialogueBox


# ─────────────────────────────────────────────────────────────────────────────
# BUILT-IN FUNCTIONS
# ─────────────────────────────────────────────────────────────────────────────

func _ready() -> void:
	# Show the first line (index 0) when the scene starts
	speaker_label.text = "Village Elder"
	dialogue_label.text = dialogue[0]   # MATH: dialogue[0] = first element

	# Connect the button
	next_button.pressed.connect(_on_next_pressed)

	# Update the info panel to show what's happening with the array
	_update_info_panel()

	# Print to console so students can see the array math
	_print_array_state()


# ─────────────────────────────────────────────────────────────────────────────
# THE LESSON'S CORE FUNCTION
# This is exactly the code shown in the lesson, with comments added.
# ─────────────────────────────────────────────────────────────────────────────

## Called when the player presses "Next"
## This is the exact function from the lesson plan!
func _on_next_pressed() -> void:
	# MATH: Increase the index by 1 (move to the next position)
	dialogue_index += 1

	# MATH: BOUNDS CHECK
	# dialogue.size() returns 3 (we have 3 elements)
	# Valid indices: 0, 1, 2  (that's size()-1 = 2 as the max)
	# If dialogue_index >= 3, we've gone past the end!
	if dialogue_index < dialogue.size():
		# Safe: index is within bounds, show the next line
		dialogue_label.text = dialogue[dialogue_index]
		print("Showing dialogue[%d] = \"%s\"" % [dialogue_index, dialogue[dialogue_index]])
	else:
		# Past the end: the dialogue is finished
		print("dialogue_index (%d) >= dialogue.size() (%d) — dialogue over!" % [dialogue_index, dialogue.size()])
		_end_dialogue()

	# Update the visual info panel
	_update_info_panel()
	_print_array_state()


# ─────────────────────────────────────────────────────────────────────────────
# END OF DIALOGUE
# ─────────────────────────────────────────────────────────────────────────────

func _end_dialogue() -> void:
	# The lesson code uses hide() — let's do that and show a completion message
	dialogue_box.hide()

	# Show a "Dialogue Complete" message so students see what happened
	if has_node("CompletionLabel"):
		$CompletionLabel.show()
		$CompletionLabel.text = "[center][color=lime]Dialogue complete!\nAll %d lines shown (indices 0 through %d)[/color][/center]" % [dialogue.size(), dialogue.size() - 1]


# ─────────────────────────────────────────────────────────────────────────────
# INFO PANEL - shows the array state visually (great for teaching!)
# ─────────────────────────────────────────────────────────────────────────────

func _update_info_panel() -> void:
	if not info_text:
		return

	var text = "[b]Array: dialogue[/b]\n"
	text += "Size: %d   |   Current index: %d\n\n" % [dialogue.size(), dialogue_index]

	# MATH: Loop from 0 to size()-1 and show each element
	for i in range(dialogue.size()):
		if i == dialogue_index and dialogue_index < dialogue.size():
			# Highlight the current index in green
			text += "[color=lime]► [%d] \"%s\"[/color]\n" % [i, dialogue[i]]
		elif i < dialogue_index:
			# Already-shown lines in gray
			text += "[color=gray]  [%d] \"%s\"[/color]\n" % [i, dialogue[i]]
		else:
			# Future lines in white
			text += "  [%d] \"%s\"\n" % [i, dialogue[i]]

	# Show the bounds check
	text += "\n[b]Bounds check:[/b]\n"
	text += "dialogue_index < dialogue.size()\n"
	text += "%d < %d → [color=%s]%s[/color]" % [
		dialogue_index,
		dialogue.size(),
		"lime" if dialogue_index < dialogue.size() else "red",
		"true (more lines!)" if dialogue_index < dialogue.size() else "false (end of dialogue)"
	]

	info_text.text = text


func _print_array_state() -> void:
	print("─── Array State ───────────────────────────")
	for i in range(dialogue.size()):
		var marker = "► " if i == dialogue_index else "  "
		print("%s dialogue[%d] = \"%s\"" % [marker, i, dialogue[i]])
	print("  dialogue.size() = %d" % dialogue.size())
	print("  Valid indices: 0 to %d" % (dialogue.size() - 1))
	print("───────────────────────────────────────────")
