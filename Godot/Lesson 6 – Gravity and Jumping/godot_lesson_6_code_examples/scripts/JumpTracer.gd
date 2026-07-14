## JumpTracer.gd
## STEM Through Games – Day 6: Parabola Visualizer
## =============================================================================
## This script draws a trail of dots showing the player's path through the air.
## When you jump, the trail reveals the PARABOLA shape that comes directly
## from the equation:  y(t) = v₀t + ½gt²
##
## HOW TO USE:
##   1. Add a Node2D to your scene.
##   2. Attach this script to it.
##   3. Set the `player` export to point to your Player node.
##   4. Jump and watch the parabola appear!
##
## MATH DISCUSSION:
##   The trail is symmetric around the peak of the jump because the equation
##   is quadratic. The left half (rising) and right half (falling) are mirror
##   images — just like the graph of y = -x²
## =============================================================================

extends Node2D

## Drag your Player node here.
@export var player: CharacterBody2D

## How many trail dots to keep visible at once.
@export var max_trail_points: int = 80

## Color of the trail dots.
@export var trail_color: Color = Color(0.4, 0.9, 1.0, 0.75)  # Cyan

## Radius of each dot in pixels.
@export var dot_radius: float = 4.0

## Only record a point if the player moved this far since the last point.
@export var min_distance: float = 6.0

## Automatically clear the trail when the player lands.
@export var clear_on_land: bool = true

# Internal state
var _points: Array[Vector2] = []
var _last_pos: Vector2 = Vector2.ZERO
var _was_in_air: bool = false
var _peak_y: float = INF
var _peak_pos: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	if not player:
		return

	var in_air := not player.is_on_floor()

	# Clear trail when landing (if enabled)
	if _was_in_air and not in_air and clear_on_land:
		_points.clear()
		_peak_y = INF

	# Record a new point when airborne and moved far enough
	if in_air:
		var pos := player.global_position
		if pos.distance_to(_last_pos) >= min_distance:
			_points.append(pos)
			_last_pos = pos
			# Track peak (lowest Y value = highest on screen)
			if pos.y < _peak_y:
				_peak_y = pos.y
				_peak_pos = pos
			# Trim to max
			if _points.size() > max_trail_points:
				_points.pop_front()
			queue_redraw()

	_was_in_air = in_air

func _draw() -> void:
	if _points.is_empty():
		return

	# Draw each recorded position as a fading dot
	for i in _points.size():
		var alpha := float(i + 1) / float(_points.size())
		var color := Color(trail_color.r, trail_color.g, trail_color.b, trail_color.a * alpha)
		# Convert global position to local (Node2D uses local coords for drawing)
		var local_pos := to_local(_points[i])
		draw_circle(local_pos, dot_radius * alpha, color)

	# Draw a star marker at the peak of the arc
	if _peak_y < INF and _points.size() > 5:
		var local_peak := to_local(_peak_pos)
		draw_circle(local_peak, dot_radius * 2.0, Color(1.0, 0.9, 0.2, 0.9))  # Gold
		draw_circle(local_peak, dot_radius * 2.0 + 2.0, Color(1.0, 0.9, 0.2, 0.4))  # Glow
