## HitboxVisualizer.gd
## STEM Through Games — Day 7: Collision Detection
##
## Attach this script to any CharacterBody2D or StaticBody2D to
## draw its collision shape outline in the running game.
##
## This is a teaching tool — real games don't usually show hitboxes
## (though many have a debug mode that does exactly this!).
##
## HOW TO USE:
##   1. Add a new Node2D child to your Player or Obstacle
##   2. Rename it "HitboxVisualizer"
##   3. Attach this script
##   4. Run the game — you'll see the hitbox drawn over the sprite
##
## Press H during the game to toggle the hitbox display on/off.
## This lets students compare what they see vs what Godot "sees".

extends Node2D

# ─────────────────────────────────────────────────────────────
#  EXPORT VARIABLES
# ─────────────────────────────────────────────────────────────

@export var hitbox_color: Color    = Color(1.0, 0.2, 0.2, 0.7)   # Red, semi-transparent
@export var outline_color: Color   = Color(1.0, 0.2, 0.2, 1.0)   # Red, solid
@export var outline_width: float   = 2.0
@export var visible_by_default: bool = true


# ─────────────────────────────────────────────────────────────
#  PRIVATE
# ─────────────────────────────────────────────────────────────

var _collision_shape: CollisionShape2D = null
var _show_hitbox: bool = true


# ─────────────────────────────────────────────────────────────
#  READY
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	_show_hitbox = visible_by_default

	# Find the CollisionShape2D in the parent node
	var parent := get_parent()
	for child in parent.get_children():
		if child is CollisionShape2D:
			_collision_shape = child
			break

	if _collision_shape == null:
		push_warning("HitboxVisualizer: No CollisionShape2D found on parent node.")


# ─────────────────────────────────────────────────────────────
#  PROCESS
# ─────────────────────────────────────────────────────────────

func _process(_delta: float) -> void:
	# Redraw every frame so the hitbox follows the parent
	queue_redraw()


# ─────────────────────────────────────────────────────────────
#  INPUT
# ─────────────────────────────────────────────────────────────

func _input(event: InputEvent) -> void:
	# Press H to toggle hitbox visibility
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_H:
			_show_hitbox = !_show_hitbox
			print("Hitbox display: ", "ON" if _show_hitbox else "OFF")


# ─────────────────────────────────────────────────────────────
#  DRAW
# ─────────────────────────────────────────────────────────────

func _draw() -> void:
	if not _show_hitbox or _collision_shape == null:
		return

	var shape = _collision_shape.shape

	if shape is RectangleShape2D:
		_draw_rectangle(shape as RectangleShape2D)
	elif shape is CircleShape2D:
		_draw_circle_shape(shape as CircleShape2D)
	elif shape is CapsuleShape2D:
		_draw_capsule(shape as CapsuleShape2D)


func _draw_rectangle(shape: RectangleShape2D) -> void:
	# RectangleShape2D.size is the HALF-extents, so total size = size * 2
	var half := shape.size
	var rect  := Rect2(-half, half * 2)
	draw_rect(rect, hitbox_color, true)
	draw_rect(rect, outline_color, false, outline_width)

	# Draw the center crosshair
	draw_line(Vector2(-8, 0), Vector2(8, 0), outline_color, 1.0)
	draw_line(Vector2(0, -8), Vector2(0, 8), outline_color, 1.0)


func _draw_circle_shape(shape: CircleShape2D) -> void:
	draw_circle(Vector2.ZERO, shape.radius, hitbox_color)
	# Draw circle outline using arc
	draw_arc(Vector2.ZERO, shape.radius, 0, TAU, 32, outline_color, outline_width)

	# Draw the center dot
	draw_circle(Vector2.ZERO, 3.0, outline_color)


func _draw_capsule(shape: CapsuleShape2D) -> void:
	# Approximate capsule with a rectangle + two semicircles
	var r := shape.radius
	var h := shape.height / 2.0 - r
	draw_rect(Rect2(-r, -h, r * 2, h * 2), hitbox_color, true)
	draw_arc(Vector2(0, -h), r, PI, TAU, 16, outline_color, outline_width)
	draw_arc(Vector2(0,  h), r, 0,   PI, 16, outline_color, outline_width)
	draw_line(Vector2(-r, -h), Vector2(-r, h), outline_color, outline_width)
	draw_line(Vector2( r, -h), Vector2( r, h), outline_color, outline_width)


# ─────────────────────────────────────────────────────────────
#  CLASS DISCUSSION PROMPTS
# ─────────────────────────────────────────────────────────────
#
#  After attaching this script and running the game, ask students:
#
#  1. Is the red hitbox exactly the same size as the sprite?
#     If not — why might a designer make it different?
#
#  2. Make the CollisionShape2D smaller than the sprite.
#     Run the game. Does it feel more or less fair?
#
#  3. Make the CollisionShape2D larger than the sprite.
#     When would THIS design choice make sense?
#     (Hint: think about touch-screen games, or items that are
#      hard to grab with precise movement)
#
#  4. Real game example: in many classic bullet-hell games,
#     the player's hitbox is just a single pixel at the center.
#     The rest of the ship is "cosmetic."
#     Why do designers make this choice?
#
