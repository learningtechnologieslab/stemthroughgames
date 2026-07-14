# flickering_light.gd
# Attach this script to a PointLight2D node (or OmniLight2D in 3D).
#
# Creates a realistic flickering torch or broken light effect by randomly
# varying the light's brightness on a fast timer.
#
# This is the Extension Challenge from Day 14 — animating a single
# environmental detail to make your world feel more alive.
#
# Node tree:
#   FlickeringLight (PointLight2D)  ← this script goes here
#   └── FlickerTimer (Timer)        ← add this child node

extends PointLight2D

# ─── FLICKER SETTINGS ────────────────────────────────────────────────────────

# 🎨 CUSTOMIZE: These presets cover common use cases.
# Change the @export values in the Inspector, or swap to a preset below.

# How bright the light gets at its maximum
@export var max_energy: float = 1.2

# How dim the light gets at its minimum (0 = fully off)
@export var min_energy: float = 0.6

# How fast the flicker timer fires (seconds between each flicker step)
# Smaller = more chaotic. 0.04–0.12 is a good torch range.
@export var flicker_interval: float = 0.07

# How much the energy changes per flicker step (higher = more dramatic jumps)
@export var flicker_step: float = 0.15

# ─── PRESETS ─────────────────────────────────────────────────────────────────
# Uncomment one of these presets in _ready() to quickly set a mood.
# They override the @export values above.

# Steady torch — warm, reliable, slightly alive
const PRESET_TORCH := {
	"max_energy": 1.1, "min_energy": 0.75,
	"flicker_interval": 0.09, "flicker_step": 0.1
}

# Broken electrical light — erratic, unsettling
const PRESET_BROKEN_ELECTRIC := {
	"max_energy": 1.4, "min_energy": 0.0,
	"flicker_interval": 0.04, "flicker_step": 0.5
}

# Dying candle — slow, fading, almost gone
const PRESET_DYING_CANDLE := {
	"max_energy": 0.7, "min_energy": 0.15,
	"flicker_interval": 0.14, "flicker_step": 0.08
}

# Stable (no flicker) — use this to disable flicker for normal lights
const PRESET_STABLE := {
	"max_energy": 1.0, "min_energy": 1.0,
	"flicker_interval": 1.0, "flicker_step": 0.0
}

# ─── INTERNAL STATE ──────────────────────────────────────────────────────────

var _target_energy: float = 1.0
var _flicker_timer: Timer

# ─── SETUP ───────────────────────────────────────────────────────────────────

func _ready() -> void:
	# 🎨 CUSTOMIZE: Uncomment ONE preset line to use it, or leave all
	# commented out to use the @export values set in the Inspector.
	# _apply_preset(PRESET_TORCH)
	# _apply_preset(PRESET_BROKEN_ELECTRIC)
	# _apply_preset(PRESET_DYING_CANDLE)

	# Set initial light energy
	energy = max_energy
	_target_energy = max_energy

	# Create the flicker timer as a child node.
	# (You can also add a Timer node manually in the Scene panel
	#  and rename it "FlickerTimer" — this code will find it either way.)
	if has_node("FlickerTimer"):
		_flicker_timer = $FlickerTimer
	else:
		_flicker_timer = Timer.new()
		_flicker_timer.name = "FlickerTimer"
		add_child(_flicker_timer)

	_flicker_timer.wait_time = flicker_interval
	_flicker_timer.autostart = true
	_flicker_timer.timeout.connect(_on_flicker_tick)

# ─── FLICKER LOGIC ───────────────────────────────────────────────────────────

func _on_flicker_tick() -> void:
	# Pick a new random target brightness within our min/max range.
	_target_energy = randf_range(min_energy, max_energy)

	# Vary the next interval slightly for organic irregularity.
	# This prevents the flicker from having a mechanical rhythm.
	_flicker_timer.wait_time = flicker_interval + randf_range(-0.02, 0.02)


func _process(delta: float) -> void:
	# Smoothly move the current energy toward the target.
	# lerp() blends between two values — higher last number = snappier response.
	energy = lerp(energy, _target_energy, delta * 18.0)

# ─── HELPER ──────────────────────────────────────────────────────────────────

func _apply_preset(preset: Dictionary) -> void:
	max_energy      = preset["max_energy"]
	min_energy      = preset["min_energy"]
	flicker_interval = preset["flicker_interval"]
	flicker_step    = preset["flicker_step"]
