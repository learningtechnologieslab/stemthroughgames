# environmental_details.gd
# Attach this script to any Node2D in your scene — a good choice is your
# main Level node or a dedicated "WorldDetails" node.
#
# This script demonstrates three environmental storytelling techniques
# you can use in code:
#
#   1. MOOD TINTING    — color-tinting sprites and backgrounds for atmosphere
#   2. RANDOM DEBRIS   — placing environmental details with slight randomness
#                        so they look naturally scattered, not mechanical
#   3. DANGER PULSE    — a slow pulsing red tint on hazard areas
#
# These are all "Task 1" techniques from the lesson — things that make your
# world FEEL like it has a history, without a single word of dialogue.

extends Node2D

# ─── MOOD TINTING ────────────────────────────────────────────────────────────
#
# The .modulate property tints any node (Sprite2D, TileMapLayer, etc.)
# with a color. Use it to set the emotional tone of a room or area.
#
# How to read color values:
#   Color(R, G, B, A)
#   R/G/B = 0.0 (none) to 1.0 (full)
#   A     = 0.0 (invisible) to 1.0 (fully visible)

# 🎨 CUSTOMIZE: Uncomment the preset that matches your world's mood,
# or create your own with Color(r, g, b).

# Warm amber — a cozy or nostalgic place
const MOOD_WARM    := Color(1.0, 0.85, 0.6)

# Cold blue — an eerie, lonely, or frozen place
const MOOD_COLD    := Color(0.7, 0.85, 1.0)

# Sickly green — a poisoned, corrupted, or overgrown place
const MOOD_CORRUPT := Color(0.75, 1.0, 0.7)

# Deep red — a dangerous, violent, or cursed place
const MOOD_DANGER  := Color(1.0, 0.65, 0.65)

# Neutral grey — a desolate, abandoned, forgotten place
const MOOD_GREY    := Color(0.8, 0.8, 0.85)


func apply_mood_tint(target_node: Node2D, mood_color: Color) -> void:
	# Applies a color tint to any node. Works on Sprite2D, TileMapLayer,
	# and any other CanvasItem node.
	target_node.modulate = mood_color


# ─── RANDOM DEBRIS PLACEMENT ─────────────────────────────────────────────────
#
# Real abandoned places don't have objects placed in neat rows.
# This function takes a list of sprite nodes and scatters them with
# small random offsets and rotations — making them look naturally placed.
#
# How to use:
#   1. Place your debris Sprite2D nodes in the scene roughly where you want them
#   2. Call scatter_debris( get_children() ) to apply random variation

func scatter_debris(debris_nodes: Array, max_offset: float = 12.0) -> void:
	for node in debris_nodes:
		# Make sure we're only affecting Sprite2D nodes, not other node types
		if not node is Sprite2D:
			continue

		# Add a small random offset to X and Y position.
		# randi_range(-max, max) returns a random integer in that range.
		var offset_x := randi_range(-int(max_offset), int(max_offset))
		var offset_y := randi_range(-int(max_offset / 2), int(max_offset / 2))
		node.position += Vector2(offset_x, offset_y)

		# Add a small random rotation so objects don't all face the same way.
		# deg_to_rad() converts degrees to the radians Godot uses internally.
		var rotation_degrees := randf_range(-15.0, 15.0)
		node.rotation += deg_to_rad(rotation_degrees)

		# 🎨 CUSTOMIZE: Uncomment this to also randomly flip some sprites
		# horizontally, for even more natural variation.
		# node.flip_h = (randi() % 2 == 0)


# ─── DANGER PULSE ────────────────────────────────────────────────────────────
#
# A slow pulsing red tint tells the player this area is dangerous —
# without a single word. The pulse uses a sine wave for smooth in-and-out.
#
# How to use:
#   1. Assign your hazard area node (a Sprite2D or TileMapLayer) to
#      `hazard_node` below
#   2. Call enable_danger_pulse(your_node) from _ready()

var _pulsing_node: Node2D = null
var _pulse_time: float = 0.0

# 🎨 CUSTOMIZE: Adjust these to change the pulse feel.
@export var pulse_speed: float  = 1.5   # Higher = faster pulse
@export var pulse_min_alpha: float = 0.4  # How faint the tint gets at its weakest
@export var pulse_max_alpha: float = 0.85 # How strong the tint gets at its strongest


func enable_danger_pulse(target_node: Node2D) -> void:
	_pulsing_node = target_node


func _process(delta: float) -> void:
	if _pulsing_node == null:
		return

	# Advance the pulse timer
	_pulse_time += delta * pulse_speed

	# sin() oscillates between -1 and 1. We remap it to our alpha range.
	var t := (sin(_pulse_time) + 1.0) / 2.0  # now 0.0 to 1.0
	var alpha := lerp(pulse_min_alpha, pulse_max_alpha, t)

	# Apply a red tint with the pulsing alpha
	_pulsing_node.modulate = Color(1.0, 0.3, 0.3, alpha)


# ─── EXAMPLE: HOW TO USE ALL THREE IN YOUR LEVEL ─────────────────────────────
#
# Paste code like this into your Level scene's _ready() function,
# or into a dedicated setup script on the Level node.
#
# func _ready() -> void:
#
#     # 1. Apply a cold blue tint to the whole background
#     var background = $Background
#     apply_mood_tint(background, MOOD_COLD)
#
#     # 2. Scatter the debris sprites in the "RubbleGroup" node
#     var rubble_group = $RubbleGroup
#     scatter_debris(rubble_group.get_children())
#
#     # 3. Make the lava area pulse red
#     var lava_zone = $LavaZone
#     enable_danger_pulse(lava_zone)
