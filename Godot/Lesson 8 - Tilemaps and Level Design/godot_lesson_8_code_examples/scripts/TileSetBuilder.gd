## TileSetBuilder.gd
## STEM Through Games — Day 8: Tilemaps & Level Design
## ─────────────────────────────────────────────────────────────────────────
## A utility script that PROGRAMMATICALLY creates a TileSet with
## colored placeholder tiles and collision shapes.
##
## WHY THIS EXISTS:
##   Real game projects use image files for tiles. Since this starter
##   project has no image assets, this script generates solid-color tiles
##   in code so students can start painting their level immediately.
##
## HOW TO USE:
##   1. Attach this script to a Node in your scene (or run it as a tool).
##   2. It will create a TileSet and assign it to the TileMap node.
##   3. Each tile has a collision shape — so painted tiles are solid ground.
##
## TILE CATALOGUE (paint these in the TileMap editor):
##   Source 0, Atlas coords:
##     (0,0) = Ground / Platform  — dark green-gray
##     (1,0) = Wall               — medium slate blue
##     (2,0) = Ceiling            — similar to wall, slightly lighter
##     (3,0) = Decorative (no collision) — brownish background detail
##
## ─────────────────────────────────────────────────────────────────────────
@tool
extends Node

const TILE_SIZE: int = 64

# Called automatically when the scene loads in the editor (because @tool)
func _ready() -> void:
	if Engine.is_editor_hint():
		_build_tileset()

# ─────────────────────────────────────────────────────────────────────────
func _build_tileset() -> void:
	var tilemap: TileMap = get_parent()
	if not tilemap is TileMap:
		push_error("TileSetBuilder must be a child of a TileMap node!")
		return

	var tile_set := TileSet.new()
	tile_set.tile_size = Vector2i(TILE_SIZE, TILE_SIZE)

	# ── Add a physics layer to the TileSet ────────────────────────────────
	# This is what makes tiles solid — all tiles with collision assigned
	# will block CharacterBody2D movement via move_and_slide().
	tile_set.add_physics_layer()
	tile_set.set_physics_layer_collision_layer(0, 1)   # Layer 1 = "World"
	tile_set.set_physics_layer_collision_mask(0, 0)    # Tiles don't collide with each other

	# ── Create a TileSetAtlasSource with solid-color placeholder tiles ────
	var source := TileSetAtlasSource.new()
	source.texture_region_size = Vector2i(TILE_SIZE, TILE_SIZE)

	# We'll use a generated texture: a single 4×1 strip of colored tiles
	var img := Image.create(TILE_SIZE * 4, TILE_SIZE, false, Image.FORMAT_RGBA8)

	# Tile 0 — Ground/Platform: dark slate green
	_fill_tile_region(img, 0, Color(0.25, 0.38, 0.30))
	# Tile 1 — Wall: slate blue
	_fill_tile_region(img, 1, Color(0.22, 0.32, 0.48))
	# Tile 2 — Ceiling: lighter blue-gray
	_fill_tile_region(img, 2, Color(0.30, 0.40, 0.55))
	# Tile 3 — Decorative background (no collision): warm brown
	_fill_tile_region(img, 3, Color(0.38, 0.28, 0.20))

	# Add subtle pixel-art top-edge highlight on solid tiles
	for tile_col in range(3):
		for x in range(TILE_SIZE):
			img.set_pixel(tile_col * TILE_SIZE + x, 0, Color(1, 1, 1, 0.25))
			img.set_pixel(tile_col * TILE_SIZE + x, 1, Color(1, 1, 1, 0.12))

	var tex := ImageTexture.create_from_image(img)
	source.texture = tex

	# Register each tile in the atlas
	for col in range(4):
		source.create_tile(Vector2i(col, 0))

	# ── Assign collision shapes to solid tiles (0, 1, 2) ─────────────────
	for col in range(3):
		var tile_data: TileData = source.get_tile_data(Vector2i(col, 0), 0)
		if tile_data:
			# Full-tile rectangle collision shape
			var shape := RectangleShape2D.new()
			shape.size = Vector2(TILE_SIZE, TILE_SIZE)
			tile_data.add_collision_polygon(0)
			# Build a unit square polygon (normalised 0–1, engine scales by tile_size)
			var poly := PackedVector2Array([
				Vector2(-0.5, -0.5),
				Vector2(0.5, -0.5),
				Vector2(0.5, 0.5),
				Vector2(-0.5, 0.5),
			])
			tile_data.set_collision_polygon_points(0, 0, poly)

	# Tile 3 (decorative) intentionally has NO collision polygon.

	# ── Attach everything to the TileMap ─────────────────────────────────
	tile_set.add_source(source, 0)
	tilemap.tile_set = tile_set

	print("[TileSetBuilder] TileSet created! tile_size=%d, %d tiles ready." % [TILE_SIZE, 4])
	print("  Paint tile (0,0) = Ground  |  (1,0) = Wall  |  (2,0) = Ceiling  |  (3,0) = Deco")

# ─────────────────────────────────────────────────────────────────────────
## Fill a horizontal tile region in the strip image with a flat colour
func _fill_tile_region(img: Image, tile_col: int, color: Color) -> void:
	var x_start: int = tile_col * TILE_SIZE
	for y in range(TILE_SIZE):
		for x in range(TILE_SIZE):
			img.set_pixel(x_start + x, y, color)
