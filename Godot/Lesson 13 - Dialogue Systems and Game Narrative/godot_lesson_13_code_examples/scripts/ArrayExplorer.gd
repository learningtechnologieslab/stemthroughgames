# =============================================================================
# ArrayExplorer.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   An interactive tool that lets students SEE array indexing in real time.
#   Students can click array elements, modify the array, and watch the bounds
#   check logic update live.
#
# LEARNING GOALS:
#   - Understand 0-based indexing
#   - Visualize why bounds checking prevents crashes
#   - See how arrays connect to dialogue systems
#
# SCENE STRUCTURE:
#   ArrayExplorer (Control)
#   ├── Title (Label)
#   ├── ArrayVisual (HBoxContainer)   ← array cells drawn here dynamically
#   ├── IndexControl (HBoxContainer)
#   │   ├── PrevButton (Button)       "◀"
#   │   ├── IndexLabel (Label)        shows current index
#   │   └── NextButton (Button)       "▶"
#   ├── InfoPanel (Panel)
#   │   └── InfoLabel (RichTextLabel)
#   ├── CrashButton (Button)          "Crash! (set index out of bounds)"
#   ├── ResetButton (Button)          "Reset"
#   └── BackButton (Button)           "← Back"
# =============================================================================

extends Control

# ─────────────────────────────────────────────────────────────────────────────
# THE ARRAY WE'RE EXPLORING
# Students can modify this to experiment.
# ─────────────────────────────────────────────────────────────────────────────

## The dialogue array we're visualizing
## MATH: This array has 5 elements at indices 0, 1, 2, 3, 4
var my_array: Array = [
	"Welcome, traveler!",
	"We need your help.",
	"The goblins attack!",
	"Will you fight?",
	"The village is saved!"
]

## Current index (which element we're looking at)
## MATH: Starts at 0. Must stay in range 0 to my_array.size()-1
var current_index: int = 0

## Track whether we intentionally crashed (for teaching)
var _crashed: bool = false


# ─────────────────────────────────────────────────────────────────────────────
# NODE REFERENCES
# ─────────────────────────────────────────────────────────────────────────────

@onready var array_visual:   HBoxContainer  = $ArrayVisual
@onready var index_label:    Label          = $IndexControl/IndexLabel
@onready var info_label:     RichTextLabel  = $InfoPanel/InfoLabel
@onready var prev_button:    Button         = $IndexControl/PrevButton
@onready var next_button:    Button         = $IndexControl/NextButton
@onready var crash_button:   Button         = $CrashButton
@onready var reset_button:   Button         = $ResetButton


# ─────────────────────────────────────────────────────────────────────────────
# BUILT-IN FUNCTIONS
# ─────────────────────────────────────────────────────────────────────────────

func _ready() -> void:
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	crash_button.pressed.connect(_on_crash_pressed)
	reset_button.pressed.connect(_on_reset_pressed)

	_rebuild_array_visual()
	_update_display()


# ─────────────────────────────────────────────────────────────────────────────
# CONTROLS
# ─────────────────────────────────────────────────────────────────────────────

func _on_next_pressed() -> void:
	# MATH: Try to move to the next index
	var new_index = current_index + 1

	if new_index < my_array.size():
		# SAFE: within bounds
		current_index = new_index
		_crashed = false
	else:
		# WOULD CRASH: out of bounds!
		_show_bounds_warning(new_index)
		return

	_update_display()


func _on_prev_pressed() -> void:
	var new_index = current_index - 1

	if new_index >= 0:
		# SAFE: 0 is always the minimum valid index
		current_index = new_index
		_crashed = false
	else:
		_show_bounds_warning(new_index)
		return

	_update_display()


func _on_crash_pressed() -> void:
	# Intentionally set index out of bounds to show what would happen
	current_index = my_array.size()  # One past the end
	_crashed = true
	_update_display()


func _on_reset_pressed() -> void:
	current_index = 0
	_crashed = false
	_update_display()
	_rebuild_array_visual()


# ─────────────────────────────────────────────────────────────────────────────
# DISPLAY
# ─────────────────────────────────────────────────────────────────────────────

func _update_display() -> void:
	# Update the index label
	index_label.text = "current_index = %d" % current_index

	# Rebuild visual to highlight correct cell
	_rebuild_array_visual()

	# Update info text
	_update_info()

	# Update prev/next button states
	prev_button.disabled = (current_index <= 0)
	next_button.disabled = (current_index >= my_array.size() - 1)


func _rebuild_array_visual() -> void:
	# Clear old cells
	for child in array_visual.get_children():
		child.queue_free()

	# MATH: Build one visual cell per element in the array
	# i goes from 0 to my_array.size()-1
	for i in range(my_array.size()):
		var cell = _make_cell(i)
		array_visual.add_child(cell)

	# Add a "crash zone" cell to show what's PAST the end
	var crash_cell = _make_crash_cell()
	array_visual.add_child(crash_cell)


func _make_cell(index: int) -> PanelContainer:
	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(160, 80)

	var vbox = VBoxContainer.new()
	panel.add_child(vbox)

	# Index label
	var idx_label = Label.new()
	idx_label.text = "[%d]" % index
	idx_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	idx_label.add_theme_font_size_override("font_size", 18)

	# Value label (truncated)
	var val_label = Label.new()
	val_label.text = _truncate(my_array[index], 16)
	val_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	val_label.add_theme_font_size_override("font_size", 11)
	val_label.autowrap_mode = TextServer.AUTOWRAP_WORD

	vbox.add_child(idx_label)
	vbox.add_child(val_label)

	# Color based on state
	if _crashed:
		# Crashed state - all cells dimmed
		idx_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
		val_label.add_theme_color_override("font_color", Color(0.5, 0.5, 0.5))
	elif index == current_index:
		# Active / highlighted cell
		idx_label.add_theme_color_override("font_color", Color(0.2, 1.0, 0.5))
		val_label.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0))
	elif index < current_index:
		# Already visited
		idx_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
		val_label.add_theme_color_override("font_color", Color(0.6, 0.6, 0.6))
	else:
		# Future
		idx_label.add_theme_color_override("font_color", Color(0.8, 0.8, 0.8))
		val_label.add_theme_color_override("font_color", Color(0.7, 0.7, 0.7))

	return panel


func _make_crash_cell() -> PanelContainer:
	# The "forbidden zone" — index my_array.size()
	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(120, 80)

	var vbox = VBoxContainer.new()
	panel.add_child(vbox)

	var idx_label = Label.new()
	idx_label.text = "[%d]" % my_array.size()
	idx_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	idx_label.add_theme_font_size_override("font_size", 18)

	var val_label = Label.new()
	val_label.text = "OUT OF\nBOUNDS!"
	val_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	val_label.add_theme_font_size_override("font_size", 11)

	if _crashed:
		idx_label.add_theme_color_override("font_color", Color(1.0, 0.2, 0.2))
		val_label.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
	else:
		idx_label.add_theme_color_override("font_color", Color(0.5, 0.2, 0.2))
		val_label.add_theme_color_override("font_color", Color(0.5, 0.3, 0.3))

	vbox.add_child(idx_label)
	vbox.add_child(val_label)

	return panel


func _update_info() -> void:
	var text = ""

	if _crashed:
		text += "[color=red][b]💥 CRASH! Index Out of Bounds![/b][/color]\n\n"
		text += "current_index = [color=red]%d[/color]\n" % current_index
		text += "my_array.size() = [color=white]%d[/color]\n\n" % my_array.size()
		text += "[color=red]%d >= %d[/color]\n" % [current_index, my_array.size()]
		text += "Trying to access my_array[%d] would crash!\n\n" % current_index
		text += "[color=yellow]This is why we check:\n[b]if index < array.size()[/b][/color]"
	else:
		text += "[b]my_array[/b]\n"
		text += "Size: [color=cyan]%d[/color]\n" % my_array.size()
		text += "Valid indices: [color=lime]0 to %d[/color]\n\n" % (my_array.size() - 1)
		text += "current_index = [color=lime]%d[/color]\n\n" % current_index

		if current_index < my_array.size():
			text += "my_array[%d] = \n[color=white]\"%s\"[/color]\n\n" % [current_index, my_array[current_index]]
			text += "[b]Bounds check:[/b]\n"
			text += "[color=lime]%d < %d → true ✓[/color]\n" % [current_index, my_array.size()]
			text += "Safe to access!"

	info_label.text = text


func _show_bounds_warning(attempted_index: int) -> void:
	info_label.text = "[color=orange][b]⚠ Bounds Warning![/b][/color]\n\nCan't go to index %d.\nValid range is [color=lime]0 to %d[/color]." % [attempted_index, my_array.size() - 1]


# ─────────────────────────────────────────────────────────────────────────────
# UTILITY
# ─────────────────────────────────────────────────────────────────────────────

func _truncate(s: String, max_len: int) -> String:
	if s.length() <= max_len:
		return s
	return s.substr(0, max_len - 3) + "..."
