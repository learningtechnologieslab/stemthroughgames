## ============================================================
## Bug 03: Collision Not Firing (Layer/Mask Mismatch)
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT THIS SCENE DEMONSTRATES:
##   Godot's physics engine uses Layers and Masks to decide
##   which objects can "see" and interact with each other.
##
##   • A body's LAYER  = "what team am I on?"
##   • A body's MASK   = "which teams can I detect?"
##
##   For a collision to fire, Object A's mask must include
##   Object B's layer, OR vice versa.
##
## THE BUG:
##   Player is on Layer 1, Mask 1.
##   Coin (Area2D) is on Layer 2, Mask 2.
##
##   Neither one is looking at the other's layer!
##   Player's mask (1) doesn't include Coin's layer (2).
##   Coin's mask (2) doesn't include Player's layer (1).
##   → They are physically invisible to each other.
##
## WHAT YOU WILL SEE:
##   Player walks right through the yellow coin. No signal fires.
##   Output panel stays silent.
##
## YOUR TASK:
##   1. Select the "Coin" node in the Scene tree.
##   2. In the Inspector, expand "Collision".
##   3. Change Mask to include Layer 1 (the player's layer).
##      OR change Player's Mask to include Layer 2.
##   4. The body_entered signal should then fire correctly.
##
## DEBUGGING STRATEGIES TO TRY:
##   • Add print("_process running") inside _process() to confirm
##     the scene is actually running
##   • Add print("checking overlap") inside _physics_process
##   • Use Project → Physics → "Visible Collision Shapes" to
##     visually confirm shapes exist
## ============================================================

extends Node2D

var coins_collected = 0

func _ready():
	print("Bug 03 ready.")
	print("Player layer: ", $Player.collision_layer, "  mask: ", $Player.collision_mask)
	print("Coin   layer: ", $Coin.collision_layer,   "  mask: ", $Coin.collision_mask)
	print("Do these overlap? Player mask includes Coin layer?")

func update_score():
	coins_collected += 1
	$UI/ScoreLabel.text = "Coins collected: " + str(coins_collected)
	print("Score updated to: ", coins_collected)
