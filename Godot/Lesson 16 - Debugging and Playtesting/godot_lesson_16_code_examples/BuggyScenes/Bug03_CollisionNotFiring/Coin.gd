## ============================================================
## Coin.gd — attached to the Area2D "Coin" node
## Part of Bug 03: Collision Not Firing
## ============================================================
##
## This script listens for body_entered.
## Because the layer/mask is misconfigured, this signal
## will NEVER fire — even when the player visually overlaps
## the coin. The function below will never be called.
##
## After fixing the layer/mask, this signal will work correctly.
## ============================================================

extends Area2D

func _ready():
	# Connect the body_entered signal to our handler function.
	# This connection is correct — the problem is the Layer/Mask,
	# not the signal connection.
	body_entered.connect(_on_body_entered)
	print("Coin ready. Waiting for body_entered signal...")
	print("Coin layer: ", collision_layer, "  Coin mask: ", collision_mask)

func _on_body_entered(body):
	## ❌ This function never runs because the layer/mask mismatch
	##    means the Area2D never detects the player body at all.
	print("Coin collected by: ", body.name)  # You'll see this once fixed
	
	# Tell the parent scene to update the score
	get_parent().update_score()
	
	# Remove the coin from the scene
	queue_free()

## ============================================================
## HINT (read only if stuck):
##
##   Select "Coin" in Scene tree → Inspector → Collision section.
##   In the MASK row, enable bit 1 (Layer 1).
##   This tells the Area2D: "I want to detect objects on Layer 1"
##   (which is where the Player lives).
##
##   Alternatively, select "Player" → set its Mask to include Layer 2.
##
##   MATH CONNECTION:
##   Layers/masks are stored as bitmasks (binary integers).
##   Layer 1 = bit 0 = binary 0001 = decimal 1
##   Layer 2 = bit 1 = binary 0010 = decimal 2
##   Both    = binary 0011 = decimal 3
##   This is Boolean OR logic: 1 | 2 = 3
## ============================================================
