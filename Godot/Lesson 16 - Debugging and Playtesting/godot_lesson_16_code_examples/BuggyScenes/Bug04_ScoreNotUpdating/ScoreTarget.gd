## ============================================================
## ScoreTarget.gd — attached to the Area2D "ScoreTarget" node
## Part of Bug 04: Score Not Updating
## ============================================================
##
## This node correctly emits "score_changed" every time
## the player enters it. The signal emission is NOT broken.
##
## The bug is in Bug04_ScoreNotUpdating.gd — the main scene
## script fails to connect to this signal, so no one hears it.
## ============================================================

extends Area2D

## Define a custom signal that passes the new score value
signal score_changed(new_score)

var hit_count = 0

func _ready():
	# This connection IS correct — the Area2D listens to itself
	body_entered.connect(_on_body_entered)
	
	# Also needs correct layer/mask — both are default (layer 1, mask 1)
	# so collision WILL fire here (unlike Bug 03)
	print("ScoreTarget ready. Waiting for player...")

func _on_body_entered(body):
	if body.name == "Player":
		hit_count += 1
		print("Player hit the target! Score is now: ", hit_count)
		
		## ✅ This signal IS emitted correctly every time.
		## But if nothing is connected to it in the parent scene,
		## nothing happens on screen.
		score_changed.emit(hit_count)
		
		# Flash the target to show collision IS working
		$TargetSprite.color = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.15).timeout
		$TargetSprite.color = Color(0.1, 0.8, 0.3, 1)

## ============================================================
## PHYSICS + MATH CONNECTION:
##
##   This is also a good example of EVENT-DRIVEN programming:
##   • An event occurs (body enters area)
##   • A signal fires (score_changed is emitted)
##   • A listener responds (if connected: update the label)
##
##   This mirrors how real game engines handle physics callbacks,
##   UI updates, and audio triggers — all signal-based.
## ============================================================
