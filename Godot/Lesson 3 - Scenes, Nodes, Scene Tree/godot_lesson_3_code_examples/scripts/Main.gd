extends Node

## Main.gd
## Controls the tabbed lesson interface.
## Each tab is a self-contained demo scene instanced as a child.

@onready var tab_bar       : HBoxContainer = $UI/TabBar
@onready var content_area  : Control       = $UI/ContentArea
@onready var info_label    : RichTextLabel = $UI/InfoPanel/InfoLabel

var tabs := []
var active_tab := 0

const TAB_SCENES := [
	"res://scenes/demos/Demo_WhatIsANode.tscn",
	"res://scenes/demos/Demo_BuildTheTree.tscn",
	"res://scenes/demos/Demo_ParentChild.tscn",
	"res://scenes/demos/Demo_MathPosition.tscn",
]

const TAB_NAMES := [
	"① What is a Node?",
	"② Build the Tree",
	"③ Parent & Child",
	"④ Position Math",
]

const TAB_COLORS := [
	Color(0.29, 0.25, 0.69),  # purple
	Color(0.06, 0.43, 0.34),  # teal
	Color(0.52, 0.24, 0.11),  # coral
	Color(0.52, 0.31, 0.04),  # amber
]

func _ready() -> void:
	_build_tab_bar()
	_switch_tab(0)

func _build_tab_bar() -> void:
	for i in TAB_NAMES.size():
		var btn := Button.new()
		btn.text = TAB_NAMES[i]
		btn.custom_minimum_size = Vector2(220, 48)
		btn.toggle_mode = true
		btn.add_theme_font_size_override("font_size", 15)
		var idx := i
		btn.pressed.connect(func(): _switch_tab(idx))
		tab_bar.add_child(btn)
		tabs.append(btn)

func _switch_tab(idx: int) -> void:
	active_tab = idx
	# Update button states
	for i in tabs.size():
		tabs[i].button_pressed = (i == idx)
	# Clear old demo
	for child in content_area.get_children():
		child.queue_free()
	# Load new demo
	var scene : PackedScene = load(TAB_SCENES[idx])
	if scene:
		var demo := scene.instantiate()
		content_area.add_child(demo)
		# Ask demo for its info text if it has one
		await get_tree().process_frame
		if demo.has_method("get_info_text"):
			info_label.text = demo.get_info_text()
		else:
			info_label.text = ""
