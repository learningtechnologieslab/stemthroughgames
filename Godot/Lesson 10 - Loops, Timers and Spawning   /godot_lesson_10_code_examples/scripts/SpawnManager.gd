extends Node

# =============================================================================
# STEM Through Games Program — Day 10: Loops, Timers & Spawning
# Script: SpawnManager.gd
# =============================================================================
# A reusable spawn manager that students can attach to any scene.
# This is the STANDALONE version for experimenting with loops and timers
# outside of the full game — great for the lesson's direct instruction phase.
#
# LEARNING FOCUS — copy these snippets into your own scripts:
#
#   SNIPPET A — for loop spawn (spawn N objects at once)
#   SNIPPET B — while loop spawn (spawn until a condition is met)
#   SNIPPET C — Timer node (trigger a function every N seconds)
#   SNIPPET D — randi_range() probability demonstration
# =============================================================================

@export var object_scene: PackedScene   # Assign any scene in the Inspector
@export var spawn_interval: float = 3.0 # Seconds between spawns
@export var max_objects: int = 20       # Safety cap to prevent lag

var _timer: Timer
var _total_spawned: int = 0


# =============================================================================
# _ready() — set up the timer programmatically
# =============================================================================
func _ready() -> void:
	randomize()

	# ─── CREATE TIMER IN CODE ────────────────────────────────────────────────
	# You can also do this in the editor by adding a Timer node as a child,
	# setting Wait Time and Autostart in the Inspector, then connecting
	# the timeout() signal in the Node panel.
	_timer = Timer.new()
	_timer.wait_time = spawn_interval
	_timer.autostart = true
	_timer.one_shot  = false   # false = repeat forever; true = fire only once
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


# =============================================================================
# SNIPPET A — for loop: spawn a fixed number of objects at once
# =============================================================================
func spawn_batch_for_loop(count: int) -> void:
	# ─── FOR LOOP ─────────────────────────────────────────────────────────────
	# range(count) produces [0, 1, 2 … count-1]
	# The body runs exactly `count` times — no condition to check.
	for i in range(count):
		_spawn_one_object()

	print("Spawned %d objects using a for loop." % count)


# =============================================================================
# SNIPPET B — while loop: spawn until we hit a limit
# =============================================================================
func spawn_until_limit(limit: int) -> void:
	# ─── WHILE LOOP ───────────────────────────────────────────────────────────
	# The condition is checked BEFORE each iteration.
	# Always make sure the condition can eventually become false!
	var spawned_this_call: int = 0
	while spawned_this_call < limit and _total_spawned < max_objects:
		_spawn_one_object()
		spawned_this_call += 1   # This line must exist — or: infinite loop!

	print("While loop done. Spawned %d this call, %d total." % [spawned_this_call, _total_spawned])


# =============================================================================
# SNIPPET C — Timer callback: called automatically every `spawn_interval` seconds
# =============================================================================
func _on_timer_timeout() -> void:
	if _total_spawned >= max_objects:
		_timer.stop()
		print("Max objects reached (%d). Timer stopped." % max_objects)
		return

	_spawn_one_object()
	print("Timer fired! Total spawned: %d" % _total_spawned)

	# ESCALATING DIFFICULTY: reduce interval by 10% each time, min 0.5s
	_timer.wait_time = max(0.5, _timer.wait_time * 0.9)


# =============================================================================
# SNIPPET D — randi_range() probability demo
#
#   Run this from the Godot editor console:
#       get_node("/root/SpawnManager").demo_probability(100)
# =============================================================================
func demo_probability(trials: int) -> void:
	# ─── PROBABILITY QUESTION FROM THE LESSON ────────────────────────────────
	# randi_range(50, 750) has 701 possible values.
	# A 70-unit section (e.g. 50–119) covers 70/701 ≈ 10% of the range.

	var in_section: int = 0
	for _i in range(trials):
		var x: int = randi_range(50, 750)
		if x >= 50 and x <= 119:     # First 70-unit section
			in_section += 1

	var percent: float = (float(in_section) / float(trials)) * 100.0
	print("Probability demo (%d trials): %d landed in 50-119 (%.1f%%)" % [trials, in_section, percent])
	print("Expected: ~%.1f%%" % (70.0 / 701.0 * 100.0))


# =============================================================================
# _spawn_one_object() — internal helper: instantiate and position one object
# =============================================================================
func _spawn_one_object() -> void:
	if object_scene == null:
		push_warning("SpawnManager: object_scene is not assigned in the Inspector!")
		return

	var obj = object_scene.instantiate()

	# Place at a random X across the screen, starting at the top
	obj.position = Vector2(
		randi_range(50, 750),
		0
	)

	add_child(obj)
	_total_spawned += 1


# =============================================================================
# Public utilities — call these from other scripts or the console
# =============================================================================

## Stop the timer (pause spawning)
func pause_spawning() -> void:
	_timer.stop()

## Resume spawning
func resume_spawning() -> void:
	_timer.start()

## Reset everything and start fresh
func reset() -> void:
	# Remove all children that were spawned
	for child in get_children():
		if child != _timer:
			child.queue_free()
	_total_spawned = 0
	_timer.wait_time = spawn_interval
	_timer.start()
