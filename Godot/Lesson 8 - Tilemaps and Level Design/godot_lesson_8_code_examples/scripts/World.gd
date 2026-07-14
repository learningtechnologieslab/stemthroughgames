## World.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## This script manages the overall game world:
##   • Tracks the coin count and updates the HUD
##   • Handles level-complete and respawn events
##   • Updates the live debug label showing grid ↔ pixel coordinates
##   • Moves the Camera2D to follow the Player
##
## MATH CONNECTION (read this!):
##   TileMap cells use integer coordinates: (col, row)
##   To convert to pixel position:
##       pixel_x = col * TILE_SIZE   →   pixel_x = col * 64
##       pixel_y = row * TILE_SIZE   →   pixel_y = row * 64
##   To convert BACK (pixel → grid):
##       col = int(pixel_x / TILE_SIZE)
##       row = int(pixel_y / TILE_SIZE)
## ─────────────────────────────────────────────────────────────────────────

extends Node2D

# ── Constants ─────────────────────────────────────────────────────────────
const TILE_SIZE: int = 64   # Each tile is 64×64 pixels

# ── Node references (filled in _ready) ───────────────────────────────────
@onready var tilemap:       TileMap  = $TileMap
@onready var player:        CharacterBody2D = $Player
@onready var camera:        Camera2D = $Camera2D
@onready var coins_label:   Label    = $HUD/CoinsLabel
@onready var message_label: Label    = $HUD/MessageLabel
@onready var debug_label:   Label    = $HUD/DebugLabel

# ── State ─────────────────────────────────────────────────────────────────
var coins_collected: int = 0
var player_start_position: Vector2   # saved so we can respawn

# ── Signals (other scripts call these via the World autoload) ─────────────
signal coin_collected
signal player_reached_goal
signal player_hit_hazard

# ─────────────────────────────────────────────────────────────────────────
func _ready() -> void:
	# Save the player's starting position for respawning
	player_start_position = player.global_position

	# Connect signals from child nodes
	coin_collected.connect(_on_coin_collected)
	player_reached_goal.connect(_on_player_reached_goal)
	player_hit_hazard.connect(_on_player_hit_hazard)

	_update_coins_label()
	print("World ready! tile_size =", TILE_SIZE)
	print("Player start pixel position:", player_start_position)
	print("Player start grid position: col=%d row=%d" % [
		int(player_start_position.x / TILE_SIZE),
		int(player_start_position.y / TILE_SIZE)
	])

# ─────────────────────────────────────────────────────────────────────────
func _process(delta: float) -> void:
	# ── Camera follows player smoothly ───────────────────────────────────
	camera.global_position = camera.global_position.lerp(
		player.global_position, delta * 5.0
	)

	# ── Debug label: live grid ↔ pixel math display ───────────────────────
	# MATH CONNECTION: this is the formula from the lesson in action!
	var px: float = player.global_position.x
	var py: float = player.global_position.y
	var col: int  = int(px / TILE_SIZE)
	var row: int  = int(py / TILE_SIZE)

	debug_label.text = (
		"Grid: (col=%d, row=%d)   Pixel: (x=%d, y=%d)   [tile_size=%d]" % [
			col, row, int(px), int(py), TILE_SIZE
		]
	)

# ─────────────────────────────────────────────────────────────────────────
## Called by Coin.gd when the player collects a coin
func _on_coin_collected() -> void:
	coins_collected += 1
	_update_coins_label()
	print("Coin collected! Total:", coins_collected)

# ─────────────────────────────────────────────────────────────────────────
## Called by GoalZone.gd when the player reaches the goal
func _on_player_reached_goal() -> void:
	print("Level complete! Coins collected:", coins_collected)
	_show_message("Level Complete!  🎉\nCoins: " + str(coins_collected), Color.GREEN)
	# Freeze player movement on win
	player.set_physics_process(false)

# ─────────────────────────────────────────────────────────────────────────
## Called by HazardZone.gd when the player touches a hazard
func _on_player_hit_hazard() -> void:
	print("Hit hazard! Respawning at start...")
	_show_message("Oops! Try again!", Color.RED, 1.5)
	_respawn_player()

# ─────────────────────────────────────────────────────────────────────────
## Teleport player back to the start position
func _respawn_player() -> void:
	player.global_position = player_start_position
	player.velocity = Vector2.ZERO
	player.set_physics_process(true)

# ─────────────────────────────────────────────────────────────────────────
func _update_coins_label() -> void:
	coins_label.text = "Coins: " + str(coins_collected)

# ─────────────────────────────────────────────────────────────────────────
## Display a temporary on-screen message
func _show_message(msg: String, color: Color = Color.WHITE, duration: float = 0.0) -> void:
	message_label.text = msg
	message_label.add_theme_color_override("font_color", color)
	message_label.visible = true
	if duration > 0.0:
		await get_tree().create_timer(duration).timeout
		message_label.visible = false

# ─────────────────────────────────────────────────────────────────────────
## STUDENT EXTENSION:
## This function converts a tile grid coordinate to a pixel position.
## Try calling it from the console to verify your math!
##   World.grid_to_pixel(3, 5) → Vector2(192, 320)
func grid_to_pixel(col: int, row: int) -> Vector2:
	# MATH: pixel_x = col * tile_size
	#       pixel_y = row * tile_size
	return Vector2(col * TILE_SIZE, row * TILE_SIZE)

## Converts a pixel position back to a tile grid coordinate
func pixel_to_grid(pixel_pos: Vector2) -> Vector2i:
	# MATH: col = int(pixel_x / tile_size)
	#       row = int(pixel_y / tile_size)
	return Vector2i(int(pixel_pos.x / TILE_SIZE), int(pixel_pos.y / TILE_SIZE))
