## MathChallenge.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## OPTIONAL EXTENSION: Run this script (attach to any Node and press F5)
## to see the grid ↔ pixel coordinate math printed to the Output panel.
##
## This is a great way to check your answers to the Math Connection
## questions from the lesson!
##
## HOW TO USE:
##   1. Create a new scene with a single Node (not Node2D, just Node)
##   2. Attach this script to that Node
##   3. Press F5 (or the Play button) — answers appear in Output
## ─────────────────────────────────────────────────────────────────────────

extends Node

const TILE_SIZE: int = 64

func _ready() -> void:
	print("=" .repeat(60))
	print("  MATH CHALLENGE — Grid ↔ Pixel Coordinate Converter")
	print("  tile_size =", TILE_SIZE)
	print("=".repeat(60))

	# ── LESSON EXAMPLE ────────────────────────────────────────────────────
	print("\n📐 LESSON EXAMPLE:")
	_show_grid_to_pixel(3, 0)   # platform starts at col 3

	# ── EXTENSION QUESTIONS (Q1–Q4) ───────────────────────────────────────
	print("\n🚀 EXTENSION QUESTIONS:")

	print("\nQ1 — Coin at (col=7, row=3) with tile_size=64:")
	_show_grid_to_pixel(7, 3)

	print("\nQ2 — Player at pixel x=128, tile_size=64 → what column?")
	_show_pixel_to_col(128)

	print("\nQ3 — Level 20 tiles wide, tile_size=64 → total pixel width?")
	var level_width_px: int = 20 * TILE_SIZE
	print("  level_width = 20 × %d = %d pixels" % [TILE_SIZE, level_width_px])

	print("\nQ4 (CHALLENGE) — tile_size=32, screen=1280px → tiles per row?")
	var small_tile: int = 32
	var screen_w: int   = 1280
	var tiles_across: int = screen_w / small_tile
	print("  tiles_across = %d / %d = %d tiles" % [screen_w, small_tile, tiles_across])

	# ── INTERACTIVE SECTION: change these values to check your own level! ──
	print("\n" + "─".repeat(60))
	print("  YOUR LEVEL CHECKER — edit the coordinates below in the script!")
	print("─".repeat(60))
	_check_my_level()

	print("\n" + "=".repeat(60))
	print("  All calculations complete. Check your answers above!")
	print("=".repeat(60))

# ─────────────────────────────────────────────────────────────────────────
## Converts (col, row) → pixel position and prints it
func _show_grid_to_pixel(col: int, row: int) -> void:
	var pixel_x: int = col * TILE_SIZE
	var pixel_y: int = row * TILE_SIZE
	print("  Grid  (col=%2d, row=%2d)  →  Pixel  (x=%4d, y=%4d)" % [
		col, row, pixel_x, pixel_y
	])
	print("  Formula:  pixel_x = %d × %d = %d  |  pixel_y = %d × %d = %d" % [
		col, TILE_SIZE, pixel_x, row, TILE_SIZE, pixel_y
	])

# ─────────────────────────────────────────────────────────────────────────
## Converts a pixel x back to a column number and prints it
func _show_pixel_to_col(pixel_x: int) -> void:
	var col: int = int(pixel_x / TILE_SIZE)
	print("  Pixel  x=%d  ÷  tile_size=%d  =  col=%d" % [pixel_x, TILE_SIZE, col])

# ─────────────────────────────────────────────────────────────────────────
## ✏️  STUDENT: Edit the tile positions below to match YOUR level design!
##    Run the script to verify the pixel positions.
func _check_my_level() -> void:
	print("\n  --- Player Start ---")
	_show_grid_to_pixel(1, 6)   # ← change to your starting tile

	print("\n  --- Coin Location ---")
	_show_grid_to_pixel(5, 4)   # ← change to your coin tile

	print("\n  --- Goal Zone ---")
	_show_grid_to_pixel(14, 3)  # ← change to your goal tile

	print("\n  --- Hazard ---")
	_show_grid_to_pixel(7, 6)   # ← change to your hazard tile

	# ── Verify the goal pixel position can be used in the Inspector ───────
	var goal_col: int = 14
	var goal_row: int = 3
	print("\n  To place GoalZone in Inspector:")
	print("  Set Position to Vector2(%d, %d)" % [
		goal_col * TILE_SIZE,
		goal_row * TILE_SIZE
	])
