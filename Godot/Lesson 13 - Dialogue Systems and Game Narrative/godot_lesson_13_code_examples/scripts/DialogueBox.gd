# =============================================================================
# DialogueBox.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   Controls the visual dialogue panel UI. Displays speaker name, text,
#   and handles the "Next" button and choice buttons.
#
# SCENE STRUCTURE this script expects:
#   DialogueBox (Control)          ← this script goes here
#   └── Panel
#       ├── SpeakerNameLabel       (Label)
#       ├── DialogueLabel          (RichTextLabel)
#       ├── NextButton             (Button)
#       └── ChoicesContainer       (VBoxContainer)
#           ├── ChoiceButton1      (Button)
#           └── ChoiceButton2      (Button)
#
# MATH CONNECTION:
#   We use arrays to store dialogue lines.
#   dialogue[0] is the first line (index starts at 0, not 1!)
#   dialogue[dialogue.size()-1] is the LAST valid element.
# =============================================================================

extends Control

# -----------------------------------------------------------------------------
# NODE REFERENCES
# @onready means these are fetched once when the scene is ready.
# The "$" shorthand means "find this child node by name".
# -----------------------------------------------------------------------------
@onready var panel:             Panel         = $Panel
@onready var speaker_label:     Label         = $Panel/SpeakerNameLabel
@onready var dialogue_label:    RichTextLabel = $Panel/DialogueLabel
@onready var next_button:       Button        = $Panel/NextButton
@onready var choices_container: VBoxContainer = $Panel/ChoicesContainer

# -----------------------------------------------------------------------------
# CONFIGURATION - exported variables appear in the Godot Inspector
# -----------------------------------------------------------------------------

## How fast text appears character by character (seconds per character)
@export var text_speed: float = 0.03

## Color for the speaker name
@export var speaker_color: Color = Color(0.4, 0.9, 1.0)   # Cyan

## Should text animate in letter-by-letter?
@export var use_typewriter_effect: bool = true


# -----------------------------------------------------------------------------
# PRIVATE STATE
# -----------------------------------------------------------------------------
var _is_typing: bool = false
var _full_text: String = ""
var _tween: Tween = null


# -----------------------------------------------------------------------------
# BUILT-IN FUNCTIONS
# -----------------------------------------------------------------------------

func _ready() -> void:
	# Start hidden - only show when dialogue begins
	hide()

	# Connect to the DialogueManager signals
	# These fire automatically when DialogueManager emits them
	DialogueManager.dialogue_line_changed.connect(_on_dialogue_line_changed)
	DialogueManager.choices_presented.connect(_on_choices_presented)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

	# Connect the Next button
	next_button.pressed.connect(_on_next_pressed)

	print("[DialogueBox] Ready and connected to DialogueManager.")


# -----------------------------------------------------------------------------
# SIGNAL HANDLERS - called when DialogueManager emits signals
# -----------------------------------------------------------------------------

## Called when a new line of dialogue is ready to display
func _on_dialogue_line_changed(speaker: String, line: String) -> void:
	# Make sure the dialogue box is visible
	show()

	# Update speaker name with color formatting
	speaker_label.text = speaker
	speaker_label.add_theme_color_override("font_color", speaker_color)

	# Hide choices while showing normal dialogue
	choices_container.hide()
	next_button.show()

	# Display the text (with optional typewriter animation)
	if use_typewriter_effect:
		_start_typewriter(line)
	else:
		dialogue_label.text = line


## Called when the player must choose between options
func _on_choices_presented(choices: Array) -> void:
	# Hide the Next button - player must choose instead
	next_button.hide()
	choices_container.show()

	# Clear any old choice buttons
	for child in choices_container.get_children():
		child.queue_free()

	# MATH: Loop through the choices array using an index
	# choices[0] is the first option, choices[1] is the second, etc.
	for i in range(choices.size()):
		var choice_data = choices[i]   # Get choice at index i

		# Create a new button for this choice
		var btn = Button.new()
		btn.text = choice_data.get("text", "Option %d" % (i + 1))
		btn.custom_minimum_size = Vector2(0, 40)

		# Style the button
		_style_choice_button(btn, i)

		# Connect the button - when pressed, call make_choice with this choice's data
		# We use a lambda (inline function) to capture the choice_data variable
		btn.pressed.connect(func(): DialogueManager.make_choice(choice_data))

		choices_container.add_child(btn)


## Called when dialogue has fully ended
func _on_dialogue_ended() -> void:
	hide()
	# Stop any typewriter animation
	if _tween:
		_tween.kill()
	print("[DialogueBox] Dialogue panel hidden.")


# -----------------------------------------------------------------------------
# BUTTON HANDLER
# -----------------------------------------------------------------------------

## Called when the player presses the "Next" button
func _on_next_pressed() -> void:
	# If text is still typing, skip to the end instead
	if _is_typing:
		_finish_typewriter()
		return

	# Otherwise, advance to the next dialogue line
	DialogueManager.advance_dialogue()


# -----------------------------------------------------------------------------
# TYPEWRITER EFFECT
# This animates text appearing letter by letter for dramatic effect.
# -----------------------------------------------------------------------------

func _start_typewriter(full_text: String) -> void:
	_full_text = full_text
	_is_typing = true
	dialogue_label.text = ""

	# Kill any existing animation
	if _tween:
		_tween.kill()

	# Use a timer to add characters one by one
	_tween = create_tween()
	var total_time = full_text.length() * text_speed

	# Animate the visible_characters property from 0 to full length
	dialogue_label.visible_ratio = 0.0
	_tween.tween_property(dialogue_label, "visible_ratio", 1.0, total_time)
	_tween.tween_callback(_on_typewriter_finished)

	dialogue_label.text = full_text


func _finish_typewriter() -> void:
	if _tween:
		_tween.kill()
	dialogue_label.visible_ratio = 1.0
	_is_typing = false


func _on_typewriter_finished() -> void:
	_is_typing = false


# -----------------------------------------------------------------------------
# VISUAL HELPERS
# -----------------------------------------------------------------------------

func _style_choice_button(btn: Button, index: int) -> void:
	# Give alternating choices slightly different visual treatment
	var colors = [
		Color(0.2, 0.6, 1.0),   # Blue  - Choice A
		Color(1.0, 0.5, 0.2),   # Orange - Choice B
		Color(0.4, 0.9, 0.4),   # Green  - Choice C
		Color(0.9, 0.4, 0.9),   # Purple - Choice D
	]
	if index < colors.size():
		btn.add_theme_color_override("font_color", colors[index])
