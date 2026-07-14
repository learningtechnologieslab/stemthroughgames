## ============================================================
## Fix 04: Score Not Updating — FIXED REFERENCE VERSION
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT WAS FIXED:
##   Added one line in _ready():
##   $ScoreTarget.score_changed.connect(_on_score_changed)
##
##   That's it. One line. The signal was firing correctly all
##   along — it just had no listener. Now it does.
##
## SIGNAL PATTERN — The Standard Way in Godot 4:
##   signal_name.connect(callable)
##
##   Where callable is any function reference:
##   • _on_score_changed        (a method on this node)
##   • someOtherNode._on_score  (a method on another node)
##   • func(x): print(x)       (an inline lambda)
## ============================================================

extends Node2D

var score = 0

func _ready():
	## ✅ FIX: Connect the signal. One line solves the whole problem.
	$ScoreTarget.score_changed.connect(_on_score_changed)
	
	## Verification — should print [{"callable":..., "flags":0}]
	print("score_changed connections: ", $ScoreTarget.score_changed.get_connections())
	print("Fix 04 ready — signal connected!")

func _on_score_changed(new_score):
	## ✅ This function now gets called every time score_changed fires
	print("_on_score_changed called! Updating label to: ", new_score)
	score = new_score
	$UI/ScoreLabel.text = "SCORE: " + str(score)

## ============================================================
## BROADER LESSON:
##
##   Signals decouple the "something happened" from the
##   "do something about it". ScoreTarget doesn't need to know
##   about the ScoreLabel — it just announces the event.
##   Anyone who cares can connect and respond.
##
##   This is the Observer pattern — used in virtually every
##   professional game engine and UI framework.
## ============================================================
