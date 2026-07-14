## ============================================================
## Bug 01: Null Reference Error
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT THIS SCENE DEMONSTRATES:
##   When code tries to access a node using a path that doesn't
##   exist, Godot returns null. Calling any method or property
##   on null causes a "Invalid get index" crash.
##
## THE BUG:
##   The node path below is WRONG. "Playar" is a typo —
##   the actual node in the scene tree is called "Player".
##
## WHAT YOU WILL SEE:
##   Press SPACE → game crashes with:
##   "Invalid get index 'position' (on base: 'Nil')"
##
## YOUR TASK:
##   1. Read the full error message in the Debugger panel.
##   2. Note the file name and LINE NUMBER it points to.
##   3. Find the typo in the get_node() call below.
##   4. Fix it so the player moves when SPACE is pressed.
##
## DEBUGGING STRATEGIES TO TRY:
##   • Read the error → it says "Nil", meaning get_node() returned null
##   • Add print(player) just after the get_node() line
##     → if it prints "Null" you know the path is wrong
##   • Check the Scene tree panel (left side) for the real node name
## ============================================================

extends Node2D

var player  # Will hold a reference to the Player node

func _ready():
	# ❌ BUG IS ON THIS LINE ↓
	# "Playar" does not match the node name "Player" in the scene tree.
	# get_node() will silently return null instead of crashing here.
	player = get_node("Playar")
	
	# 💡 DEBUGGING TIP: Add this line and run again — what does it print?
	# print("player node is: ", player)

func _process(delta):
	# The crash happens HERE because we try to use player.position
	# but player is null (the node was never found).
	if Input.is_action_just_pressed("ui_accept"):  # SPACE key
		player.position += Vector2(50, 0)  # ← CRASH: "Invalid get index 'position' on Nil"
		print("Player moved to: ", player.position)

## ============================================================
## HINT (read only if stuck for 3+ minutes):
##   Change "Playar" → "Player" on the get_node() line.
##   The node name must EXACTLY match what appears in the
##   Scene tree panel, including capitalisation.
## ============================================================
