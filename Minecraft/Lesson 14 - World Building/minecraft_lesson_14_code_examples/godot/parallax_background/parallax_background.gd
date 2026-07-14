# parallax_background.gd
# Attach this script to a ParallaxBackground node.
#
# A parallax background creates a sense of depth: far-away layers scroll
# slowly, close layers scroll fast. This makes your world feel physically
# real and atmospheric — the single most effective "Show Don't Tell" move
# for a 2D game's environment.
#
# Node tree:
#   ParallaxBackground         ← this script goes here
#   ├── FarLayer (ParallaxLayer)
#   │   └── FarSprite (Sprite2D or TileMap)
#   ├── MidLayer (ParallaxLayer)
#   │   └── MidSprite (Sprite2D or TileMap)
#   └── NearLayer (ParallaxLayer)
#       └── NearSprite (Sprite2D or TileMap)

extends ParallaxBackground

# ─── LAYER SETTINGS ──────────────────────────────────────────────────────────
#
# Each layer has a "motion scale" — how much it scrolls relative to the camera.
# Rule of thumb:
#   Far layer  (sky, distant mountains): 0.1 – 0.25
#   Mid layer  (background buildings):   0.35 – 0.55
#   Near layer (foreground details):     0.7 – 0.9
#   Game world (where player moves):     1.0  (set by Godot automatically)
#
# The bigger the gap between layers, the stronger the depth effect.

# 🎨 CUSTOMIZE: Adjust these scroll speeds for your world's depth feel.
@export var far_layer_scroll:  Vector2 = Vector2(0.15, 0.05)
@export var mid_layer_scroll:  Vector2 = Vector2(0.40, 0.15)
@export var near_layer_scroll: Vector2 = Vector2(0.75, 0.30)

# 🎨 CUSTOMIZE: Set to true to make the background tile/repeat horizontally.
@export var tile_far_layer:  bool = true
@export var tile_mid_layer:  bool = true
@export var tile_near_layer: bool = false

# ─── PRESETS ─────────────────────────────────────────────────────────────────
# World feel presets — different depth ratios create different atmospheres.

# Standard platformer — clear distinct depth layers
const PRESET_STANDARD := {
	"far":  Vector2(0.15, 0.05),
	"mid":  Vector2(0.40, 0.15),
	"near": Vector2(0.75, 0.30)
}

# Atmospheric / foggy — layers very close together, dreamy feel
const PRESET_FOGGY := {
	"far":  Vector2(0.25, 0.08),
	"mid":  Vector2(0.35, 0.10),
	"near": Vector2(0.50, 0.18)
}

# Dramatic depth — wide separation, epic scale feel
const PRESET_EPIC := {
	"far":  Vector2(0.08, 0.02),
	"mid":  Vector2(0.45, 0.20),
	"near": Vector2(0.85, 0.45)
}

# ─── SETUP ───────────────────────────────────────────────────────────────────

func _ready() -> void:
	# 🎨 CUSTOMIZE: Uncomment one preset to use it.
	# _apply_preset(PRESET_STANDARD)
	# _apply_preset(PRESET_FOGGY)
	# _apply_preset(PRESET_EPIC)

	# Apply scroll scales to the layer nodes.
	# These node names must match the actual names in your Scene panel.
	_setup_layer("FarLayer",  far_layer_scroll,  tile_far_layer)
	_setup_layer("MidLayer",  mid_layer_scroll,  tile_mid_layer)
	_setup_layer("NearLayer", near_layer_scroll, tile_near_layer)

# ─── HELPERS ─────────────────────────────────────────────────────────────────

func _setup_layer(layer_name: String, scroll_scale: Vector2, should_tile: bool) -> void:
	# Check if the layer exists before trying to configure it.
	# This way the script won't crash if you only have two layers.
	if not has_node(layer_name):
		return

	var layer: ParallaxLayer = get_node(layer_name)
	layer.motion_scale = scroll_scale

	if should_tile:
		# motion_mirroring makes the layer tile/repeat when the camera moves past it.
		# The value should match the width of your background sprite in pixels.
		# 🎨 CUSTOMIZE: Change 1024 to your actual background image width.
		layer.motion_mirroring = Vector2(1024, 0)
	else:
		layer.motion_mirroring = Vector2.ZERO


func _apply_preset(preset: Dictionary) -> void:
	far_layer_scroll  = preset["far"]
	mid_layer_scroll  = preset["mid"]
	near_layer_scroll = preset["near"]
