## ============================================================
## Fix 03: Collision Not Firing — FIXED REFERENCE VERSION
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT WAS FIXED:
##   Coin's collision_mask changed from 2 → 1
##
##   Before:  Coin mask = 2  (looking for objects on layer 2)
##            Player layer = 1
##            → Coin never sees the player
##
##   After:   Coin mask = 1  (looking for objects on layer 1)
##            Player layer = 1
##            → Coin detects the player ✓
##
## LAYER/MASK LOGIC:
##   Think of it as radio frequencies:
##   • Layer = "I broadcast on channel X"
##   • Mask  = "I listen to channel Y"
##   For two objects to interact, one must broadcast on a
##   channel the other is listening to.
## ============================================================

extends Node2D

var coins_collected = 0

func _ready():
	print("Fix 03 ready — collision layers corrected.")
	print("Player layer: ", $Player.collision_layer, "  mask: ", $Player.collision_mask)
	print("Coin   layer: ", $Coin.collision_layer,   "  mask: ", $Coin.collision_mask)
	print("Coin mask (1) now includes Player layer (1) → collision will fire!")

func update_score():
	coins_collected += 1
	$UI/ScoreLabel.text = "Coins collected: " + str(coins_collected)
	print("Score updated: ", coins_collected)
