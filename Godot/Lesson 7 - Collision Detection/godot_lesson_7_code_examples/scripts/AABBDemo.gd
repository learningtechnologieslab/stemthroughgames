## AABBDemo.gd
## STEM Through Games — Day 7: Collision Detection
##
## This is a STANDALONE EDUCATIONAL DEMO — not part of the main game.
## Run it separately (attach to a Node in a new scene) to see AABB
## math visualized in the Output panel and on-screen.
##
## It demonstrates the exact algorithm Godot uses internally for
## broad-phase collision detection.
##
## TO USE:
##   1. Create a new scene with a Node2D root
##   2. Attach this script to it
##   3. Press F5 — watch the Output panel
##   4. Modify the rectangle values to experiment

extends Node2D


# ─────────────────────────────────────────────────────────────
#  RECTANGLE DATA STRUCTURE
# ─────────────────────────────────────────────────────────────

## A simple rectangle represented as position + size.
## In Godot this maps to a Rect2 object.
## We define our own here so students can see every field explicitly.
class SimpleRect:
	var x: float
	var y: float
	var width: float
	var height: float

	func _init(px: float, py: float, w: float, h: float) -> void:
		x = px
		y = py
		width = w
		height = h

	func right() -> float:
		return x + width

	func bottom() -> float:
		return y + height

	func label() -> String:
		return "Rect(x=%.0f, y=%.0f, w=%.0f, h=%.0f)" % [x, y, width, height]


# ─────────────────────────────────────────────────────────────
#  CORE AABB ALGORITHM
# ─────────────────────────────────────────────────────────────

## Returns true if rectangles A and B overlap.
##
## THE MATH:
##   Two rectangles overlap on the X axis if:
##     A's left edge  < B's right edge   (A.x < B.x + B.width)
##     B's left edge  < A's right edge   (B.x < A.x + A.width)
##
##   AND they overlap on the Y axis if:
##     A's top edge   < B's bottom edge  (A.y < B.y + B.height)
##     B's top edge   < A's bottom edge  (B.y < A.y + A.height)
##
##   BOTH conditions must be true for a collision.
func aabb_overlap(a: SimpleRect, b: SimpleRect) -> bool:
	var x_overlap: bool = (a.x < b.right()) and (b.x < a.right())
	var y_overlap: bool = (a.y < b.bottom()) and (b.y < a.bottom())
	return x_overlap and y_overlap


## Same function using Godot's built-in Rect2 — same result, less code.
## Students can compare both versions.
func godot_rect_overlap(a: SimpleRect, b: SimpleRect) -> bool:
	var rect_a := Rect2(a.x, a.y, a.width, a.height)
	var rect_b := Rect2(b.x, b.y, b.width, b.height)
	return rect_a.intersects(rect_b)


# ─────────────────────────────────────────────────────────────
#  DETAILED STEP-BY-STEP EXPLANATION
# ─────────────────────────────────────────────────────────────

func explain_overlap(a: SimpleRect, b: SimpleRect) -> void:
	print("─────────────────────────────────")
	print("A = ", a.label())
	print("    X range: [%.0f, %.0f]   Y range: [%.0f, %.0f]" % [a.x, a.right(), a.y, a.bottom()])
	print("B = ", b.label())
	print("    X range: [%.0f, %.0f]   Y range: [%.0f, %.0f]" % [b.x, b.right(), b.y, b.bottom()])
	print("")

	# X axis check
	var ax_check: bool = a.x < b.right()
	var bx_check: bool = b.x < a.right()
	var x_overlap: bool = ax_check and bx_check
	print("X overlap check:")
	print("  A.x (%.0f) < B.right (%.0f)  →  %s" % [a.x, b.right(), str(ax_check)])
	print("  B.x (%.0f) < A.right (%.0f)  →  %s" % [b.x, a.right(), str(bx_check)])
	print("  X overlap: ", x_overlap)
	print("")

	# Y axis check
	var ay_check: bool = a.y < b.bottom()
	var by_check: bool = b.y < a.bottom()
	var y_overlap: bool = ay_check and by_check
	print("Y overlap check:")
	print("  A.y (%.0f) < B.bottom (%.0f)  →  %s" % [a.y, b.bottom(), str(ay_check)])
	print("  B.y (%.0f) < A.bottom (%.0f)  →  %s" % [b.y, a.bottom(), str(by_check)])
	print("  Y overlap: ", y_overlap)
	print("")

	# Result
	var result: bool = x_overlap and y_overlap
	if result:
		print("✅  COLLISION DETECTED — both axes overlap!")
	else:
		if not x_overlap:
			print("❌  NO COLLISION — rectangles are separated on the X axis.")
		else:
			print("❌  NO COLLISION — rectangles are separated on the Y axis.")
	print("")


# ─────────────────────────────────────────────────────────────
#  READY — RUN THE DEMO
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	print("═══════════════════════════════════")
	print("  AABB COLLISION DEMO — Day 7")
	print("═══════════════════════════════════")
	print("")

	# ── TEST CASE 1: Overlap ─────────────────────────────────
	print("TEST 1: Overlapping rectangles (from the lesson example)")
	var rect_a1 := SimpleRect.new(2, 3, 4, 3)   # X:[2,6]  Y:[3,6]
	var rect_b1 := SimpleRect.new(5, 4, 3, 2)   # X:[5,8]  Y:[4,6]
	explain_overlap(rect_a1, rect_b1)

	# ── TEST CASE 2: No overlap (X separated) ────────────────
	print("TEST 2: Separated on X axis")
	var rect_a2 := SimpleRect.new(0, 0, 3, 3)   # X:[0,3]  Y:[0,3]
	var rect_b2 := SimpleRect.new(5, 0, 3, 3)   # X:[5,8]  Y:[0,3]
	explain_overlap(rect_a2, rect_b2)

	# ── TEST CASE 3: No overlap (Y separated) ────────────────
	print("TEST 3: Separated on Y axis")
	var rect_a3 := SimpleRect.new(0, 0, 3, 2)   # X:[0,3]  Y:[0,2]
	var rect_b3 := SimpleRect.new(0, 4, 3, 2)   # X:[0,3]  Y:[4,6]
	explain_overlap(rect_a3, rect_b3)

	# ── TEST CASE 4: Touching at edge (not overlapping) ──────
	print("TEST 4: Touching exactly at edge (boundary case)")
	var rect_a4 := SimpleRect.new(0, 0, 4, 4)   # X:[0,4]  Y:[0,4]
	var rect_b4 := SimpleRect.new(4, 0, 4, 4)   # X:[4,8]  Y:[0,4]
	explain_overlap(rect_a4, rect_b4)

	# ── TEST CASE 5: One inside the other ────────────────────
	print("TEST 5: One rectangle entirely inside the other")
	var rect_a5 := SimpleRect.new(0, 0, 10, 10) # X:[0,10] Y:[0,10]
	var rect_b5 := SimpleRect.new(3, 3, 2, 2)   # X:[3,5]  Y:[3,5]
	explain_overlap(rect_a5, rect_b5)

	# ── GODOT BUILT-IN COMPARISON ────────────────────────────
	print("═══════════════════════════════════")
	print("Verification with Godot's Rect2.intersects():")
	print("Test 1: ", godot_rect_overlap(rect_a1, rect_b1))
	print("Test 2: ", godot_rect_overlap(rect_a2, rect_b2))
	print("Test 3: ", godot_rect_overlap(rect_a3, rect_b3))
	print("Test 4: ", godot_rect_overlap(rect_a4, rect_b4))
	print("Test 5: ", godot_rect_overlap(rect_a5, rect_b5))
	print("(Should match our manual results above!)")


# ─────────────────────────────────────────────────────────────
#  DRAW — Visualize the rectangles on screen
# ─────────────────────────────────────────────────────────────
#
# This draws the test rectangles directly in the Godot viewport
# so students can see them alongside the math in the Output panel.
#
# Scale factor: multiply all coordinate values by SCALE so they
# fill a reasonable portion of a 640x360 window.

const SCALE: float = 20.0
const OFFSET: Vector2 = Vector2(80, 50)

func _draw() -> void:
	var test_pairs = [
		[SimpleRect.new(2,3,4,3), SimpleRect.new(5,4,3,2)],   # Test 1
		[SimpleRect.new(0,0,3,3), SimpleRect.new(5,0,3,3)],   # Test 2
		[SimpleRect.new(0,0,3,2), SimpleRect.new(0,4,3,2)],   # Test 3
		[SimpleRect.new(0,0,4,4), SimpleRect.new(4,0,4,4)],   # Test 4
		[SimpleRect.new(0,0,10,10), SimpleRect.new(3,3,2,2)], # Test 5
	]

	var col_spacing: float = 120.0

	for i in range(test_pairs.size()):
		var a: SimpleRect = test_pairs[i][0]
		var b: SimpleRect = test_pairs[i][1]
		var overlapping: bool = aabb_overlap(a, b)

		var off: Vector2 = OFFSET + Vector2(col_spacing * i, 0)

		# Draw rectangle A in blue
		draw_rect(
			Rect2(off + Vector2(a.x, a.y) * SCALE, Vector2(a.width, a.height) * SCALE),
			Color(0.3, 0.6, 1.0, 0.5), true
		)
		draw_rect(
			Rect2(off + Vector2(a.x, a.y) * SCALE, Vector2(a.width, a.height) * SCALE),
			Color(0.3, 0.6, 1.0, 1.0), false
		)

		# Draw rectangle B in teal
		draw_rect(
			Rect2(off + Vector2(b.x, b.y) * SCALE, Vector2(b.width, b.height) * SCALE),
			Color(0.0, 0.7, 0.7, 0.5), true
		)
		draw_rect(
			Rect2(off + Vector2(b.x, b.y) * SCALE, Vector2(b.width, b.height) * SCALE),
			Color(0.0, 0.7, 0.7, 1.0), false
		)

		# Result label
		var label_color := Color(0.2, 0.8, 0.3) if overlapping else Color(0.9, 0.3, 0.3)
		var label_text  := "✅ HIT" if overlapping else "❌ MISS"
		draw_string(
			ThemeDB.fallback_font,
			off + Vector2(0, 230),
			"Test %d: %s" % [i + 1, label_text],
			HORIZONTAL_ALIGNMENT_LEFT,
			-1, 13, label_color
		)
