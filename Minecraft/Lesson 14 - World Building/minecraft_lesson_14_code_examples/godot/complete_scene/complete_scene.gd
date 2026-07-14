# complete_scene.gd
# Attach this script to your main Level node.
#
# This is the "everything together" example — it shows how NPC dialogue,
# mood tinting, debris scattering, and a flickering light all connect in
# a single scene script.
#
# Use this as:
#   - A reference when building your own level
#   - A starter template (duplicate it and replace the node paths)
#   - A teacher demo showing the full Day 14 toolkit
#
# ─────────────────────────────────────────────────────────────────────────────
# EXPECTED NODE TREE
# ─────────────────────────────────────────────────────────────────────────────
#
#   Level (Node2D)                  ← this script goes here
#   ├── ParallaxBackground
#   │   ├── FarLayer (ParallaxLayer)
#   │   │   └── SkySprite (Sprite2D)
#   │   └── MidLayer (ParallaxLayer)
#   │       └── RuinsSprite (Sprite2D)
#   │
#   ├── Background (Sprite2D)       ← the main room background
#   │
#   ├── RubbleGroup (Node2D)        ← parent holding scattered debris sprites
#   │   ├── Rock1 (Sprite2D)
#   │   ├── Rock2 (Sprite2D)
#   │   └── Paper1 (Sprite2D)
#   │
#   ├── Torch (PointLight2D)        ← attach flickering_light.gd here separately
#   │
#   ├── NPC (Area2D)                ← attach npc_dialogue.gd here separately
#   │   ├── NPCSprite (Sprite2D)
#   │   ├── CollisionShape2D
#   │   └── DialogueLabel (Label)
#   │
#   └── Player (CharacterBody2D)    ← your existing player scene

extends Node2D

# ─── WORLD IDENTITY ──────────────────────────────────────────────────────────
# 🎨 CUSTOMIZE: Describe your world here. These values drive the setup below.

# What kind of world is this? Controls the mood tint applied to the background.
# Options: "abandoned_lab", "ancient_temple", "flooded_city", "danger_zone", "safe_haven"
@export var world_type: String = "abandoned_lab"

# ─── NODE REFERENCES ─────────────────────────────────────────────────────────

@onready var background:   Sprite2D  = $Background
@onready var rubble_group: Node2D    = $RubbleGroup
@onready var parallax:     ParallaxBackground = $ParallaxBackground

# ─── MOOD COLOR PRESETS ──────────────────────────────────────────────────────

const WORLD_MOODS: Dictionary = {
	"abandoned_lab":  Color(0.80, 0.90, 1.00),  # cold fluorescent blue-white
	"ancient_temple": Color(0.90, 0.80, 0.65),  # warm amber stone
	"flooded_city":   Color(0.65, 0.85, 1.00),  # deep water blue-green
	"danger_zone":    Color(1.00, 0.65, 0.65),  # warning red
	"safe_haven":     Color(1.00, 0.95, 0.80),  # warm golden safety
}

# ─── SETUP ───────────────────────────────────────────────────────────────────

func _ready() -> void:
	_apply_world_mood()
	_scatter_rubble()
	_configure_parallax()

	# The NPC and flickering light configure themselves via their own scripts
	# (npc_dialogue.gd and flickering_light.gd). Nothing needed here for those.
	print("Level ready: ", world_type)


func _apply_world_mood() -> void:
	# Look up the mood color for this world type.
	if not WORLD_MOODS.has(world_type):
		push_warning("complete_scene.gd: Unknown world_type '%s'. Using default." % world_type)
		return

	var mood_color: Color = WORLD_MOODS[world_type]

	# Apply tint to the main background.
	if background:
		background.modulate = mood_color

	# Apply a slightly lighter version of the same tint to parallax layers,
	# so the depth effect still reads clearly.
	var faded := Color(mood_color.r, mood_color.g, mood_color.b, 0.75)
	if parallax:
		parallax.modulate = faded


func _scatter_rubble() -> void:
	if not rubble_group:
		return

	for node in rubble_group.get_children():
		if not node is Sprite2D:
			continue

		# Small random position offset — makes debris look naturally placed
		node.position += Vector2(
			randi_range(-14, 14),
			randi_range(-7, 7)
		)

		# Small random rotation — nothing in a ruin is perfectly upright
		node.rotation += deg_to_rad(randf_range(-20.0, 20.0))

		# 30% chance of horizontal flip for visual variety
		if randi() % 10 < 3:
			node.flip_h = true


func _configure_parallax() -> void:
	if not parallax:
		return

	# Configure far layer
	if parallax.has_node("FarLayer"):
		var far: ParallaxLayer = parallax.get_node("FarLayer")
		far.motion_scale    = Vector2(0.15, 0.05)
		far.motion_mirroring = Vector2(1024, 0)

	# Configure mid layer
	if parallax.has_node("MidLayer"):
		var mid: ParallaxLayer = parallax.get_node("MidLayer")
		mid.motion_scale    = Vector2(0.40, 0.15)
		mid.motion_mirroring = Vector2(1024, 0)
