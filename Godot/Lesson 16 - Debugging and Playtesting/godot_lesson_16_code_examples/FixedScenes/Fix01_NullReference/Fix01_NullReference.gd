## ============================================================
## Fix 01: Null Reference Error — FIXED REFERENCE VERSION
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT WAS FIXED:
##   get_node("Playar")  →  get_node("Player")
##
##   The node name in the scene tree is "Player".
##   The original script had a typo: "Playar".
##   get_node() returned null, causing the crash when
##   the code tried to access player.position.
##
## BEST PRACTICES SHOWN HERE:
##   1. Use @onready to get node references safely at startup.
##   2. Add a null guard (if player == null) to catch future issues.
##   3. Use the $ shorthand which is cleaner than get_node("name").
## ============================================================

extends Node2D

## ✅ FIX 1: Use @onready so the node is fetched once when the
##    scene is fully loaded. This is safer than fetching in _ready().
@onready var player = $Player  # $ is shorthand for get_node()

func _ready():
	## ✅ FIX 2: Always validate the reference before using it.
	if player == null:
		push_error("Player node not found! Check the node name in the Scene tree.")
		return
	print("Fix 01 ready. Player found: ", player.name)
	print("Player position: ", player.position)

func _process(delta):
	## ✅ FIX 3: Null guard — safe even if something changes later
	if player == null:
		return
	
	if Input.is_action_just_pressed("ui_accept"):  # SPACE key
		player.position += Vector2(50, 0)
		print("Player moved to: ", player.position)

## ============================================================
## KEY LESSON:
##   get_node() and $ both perform a search by name.
##   If the name doesn't match exactly (case-sensitive,
##   spaces matter), they return null — silently.
##   The crash only happens later when you try to USE null.
##
##   Always validate node references. @onready + null check
##   is the professional pattern for this in Godot 4.
## ============================================================
