## AnimationHelper.gd
## ============================================================
## STEM Through Games – Day 15: Animations, Sound & Game Feel
## ============================================================
##
## A utility script demonstrating the MATH behind animations.
## Attach to any node (or use as a reference).
##
## This script is NOT needed for the game to work —
## it is a TEACHING TOOL showing how FPS math works in code.
##
## ============================================================

extends Node

# ════════════════════════════════════════════════════════════
# loop_duration() – Calculate how long one animation loop takes
##
## FORMULA: time = frames / fps
##
## Examples:
##   loop_duration(8, 12)  → 0.667 seconds  (run cycle)
##   loop_duration(4, 6)   → 0.667 seconds  (idle cycle)
##   loop_duration(5, 15)  → 0.333 seconds  (jump animation)
# ════════════════════════════════════════════════════════════
static func loop_duration(frames: int, fps: float) -> float:
	if fps <= 0:
		push_error("FPS must be greater than 0!")
		return 0.0
	return float(frames) / fps


# ════════════════════════════════════════════════════════════
# fps_for_duration() – What FPS do I need for a target duration?
##
## FORMULA: fps = frames / desired_time
##
## Example: I want a 6-frame jump animation to take 0.3 seconds.
##   fps_for_duration(6, 0.3) → 20 FPS
# ════════════════════════════════════════════════════════════
static func fps_for_duration(frames: int, desired_seconds: float) -> float:
	if desired_seconds <= 0:
		push_error("Desired duration must be greater than 0!")
		return 0.0
	return float(frames) / desired_seconds


# ════════════════════════════════════════════════════════════
# distance_per_loop() – How far does the player travel per loop?
##
## FORMULA: distance = speed × time
##          time     = frames / fps
##          ∴ distance = speed × (frames / fps)
##
## Example:
##   Player speed = 200 px/sec
##   Run cycle = 8 frames at 12 FPS
##   distance_per_loop(200, 8, 12) → 133.3 pixels
# ════════════════════════════════════════════════════════════
static func distance_per_loop(speed_px_per_sec: float, frames: int, fps: float) -> float:
	return speed_px_per_sec * loop_duration(frames, fps)


# ════════════════════════════════════════════════════════════
# print_animation_report() – Prints a full timing breakdown
## Great for students to run and see the math in action!
## Call from _ready() in any script to see output in the console.
##
## Usage:
##   AnimationHelper.print_animation_report()
# ════════════════════════════════════════════════════════════
static func print_animation_report() -> void:
	print("═══════════════════════════════════════")
	print("  Animation Timing Report – Day 15")
	print("═══════════════════════════════════════")

	var animations := {
		"idle":  {"frames": 4,  "fps": 6.0},
		"run":   {"frames": 8,  "fps": 12.0},
		"jump":  {"frames": 5,  "fps": 15.0},
		"fall":  {"frames": 3,  "fps": 10.0},
		"hurt":  {"frames": 4,  "fps": 12.0},
	}

	var player_speed := 200.0

	for anim_name in animations:
		var data    = animations[anim_name]
		var frames  = data["frames"]
		var fps     = data["fps"]
		var dur     = loop_duration(frames, fps)
		var dist    = distance_per_loop(player_speed, frames, fps)

		print("  %s:" % anim_name.to_upper())
		print("    Frames: %d   |   FPS: %.1f" % [frames, fps])
		print("    Loop duration : %.3f seconds" % dur)
		print("    Distance/loop : %.1f pixels  (at %d px/sec)" % [dist, int(player_speed)])
		print("  ───────────────────────────────────────")

	print("")
	print("  DECIBEL VOLUME REFERENCE:")
	print("  ─────────────────────────────────────")
	var linears := [1.0, 0.75, 0.5, 0.25, 0.1, 0.0]
	for lin in linears:
		var db_val: float
		if lin <= 0.0:
			db_val = -80.0
		else:
			db_val = 20.0 * log(lin) / log(10.0)
		print("  Linear %.2f  →  %.1f dB" % [lin, db_val])
	print("═══════════════════════════════════════")
