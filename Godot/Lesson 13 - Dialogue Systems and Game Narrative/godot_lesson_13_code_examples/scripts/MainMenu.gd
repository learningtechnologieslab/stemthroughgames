# =============================================================================
# MainMenu.gd
# STEM Through Games - Day 13: Dialogue Systems & Game Narrative
# =============================================================================
# PURPOSE:
#   The starting screen of the Day 13 project. Lets students choose which
#   demo scene to explore.
#
# SCENES AVAILABLE:
#   1. Basic Demo     - The starter dialogue from the lesson (dialogue array)
#   2. Village Scene  - Full scene with NPC, player movement, branching
#   3. Array Explorer - Interactive tool to visualize array indexing
# =============================================================================

extends Control

# -----------------------------------------------------------------------------
# NODE REFERENCES
# -----------------------------------------------------------------------------
@onready var title_label:   Label  = $VBox/TitleLabel
@onready var version_label: Label  = $VBox/VersionLabel
@onready var btn_basic:     Button = $VBox/Buttons/BtnBasic
@onready var btn_village:   Button = $VBox/Buttons/BtnVillage
@onready var btn_explorer:  Button = $VBox/Buttons/BtnExplorer
@onready var btn_quit:      Button = $VBox/Buttons/BtnQuit


# -----------------------------------------------------------------------------
# BUILT-IN FUNCTIONS
# -----------------------------------------------------------------------------

func _ready() -> void:
	if title_label:
		title_label.text = "Day 13: Dialogue Systems\n& Game Narrative"
	if version_label:
		version_label.text = "STEM Through Games  |  Godot 4"

	# Connect buttons
	if btn_basic:
		btn_basic.pressed.connect(_on_basic_pressed)
	if btn_village:
		btn_village.pressed.connect(_on_village_pressed)
	if btn_explorer:
		btn_explorer.pressed.connect(_on_explorer_pressed)
	if btn_quit:
		btn_quit.pressed.connect(_on_quit_pressed)


# -----------------------------------------------------------------------------
# BUTTON HANDLERS
# -----------------------------------------------------------------------------

func _on_basic_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/BasicDialogueDemo.tscn")

func _on_village_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/VillageScene.tscn")

func _on_explorer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ArrayExplorer.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
