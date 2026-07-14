## ============================================================
## Bug 04: Score Not Updating (Signal Not Connected)
## STEM Through Games — Day 16: Debugging & Playtesting
## ============================================================
##
## WHAT THIS SCENE DEMONSTRATES:
##   Godot uses Signals as a messaging system between nodes.
##   A signal must be CONNECTED to a function for anything to
##   happen when it fires. Defining a function that "should"
##   receive a signal is not enough — the wiring must exist.
##
## THE BUG:
##   The ScoreTarget emits a custom signal called "score_changed"
##   when the player enters it. This scene has a function
##   _on_score_changed() that updates the label — but the
##   signal is NEVER CONNECTED to that function.
##
##   The score variable increments. The signal fires.
##   But nothing is listening, so the label never updates.
##
## WHAT YOU WILL SEE:
##   Walk into the green target → Output panel prints
##   "Score is now: 1", "Score is now: 2", etc.
##   BUT the on-screen label always shows "SCORE: 0".
##
## YOUR TASK:
##   Option A — Fix it in code (add a connect() call in _ready):
##     $ScoreTarget.score_changed.connect(_on_score_changed)
##
##   Option B — Fix it in the Editor:
##     Select ScoreTarget → Node tab (next to Inspector)
##     → Find "score_changed" signal → Connect to this script's
##     _on_score_changed function.
##
## DEBUGGING STRATEGIES TO TRY:
##   • Add print("_on_score_changed called!") at the top of
##     _on_score_changed() — if it never prints, the signal
##     connection is the problem
##   • Check the Node tab for ScoreTarget — connected signals
##     show a green plug icon; disconnected ones are grey
## ============================================================

extends Node2D

var score = 0

func _ready():
	print("Bug 04 ready.")
	
	# ❌ BUG: The signal connection line is MISSING here.
	# The ScoreTarget emits "score_changed" but nothing is
	# connected to receive it.
	#
	# To fix, add this line:
	# $ScoreTarget.score_changed.connect(_on_score_changed)
	
	print("Is score_changed signal connected?")
	# 💡 DEBUGGING TIP: This prints all connections on the signal:
	# print($ScoreTarget.score_changed.get_connections())

func _on_score_changed(new_score):
	## This function DOES exist and IS correct.
	## It just never gets called because no signal is connected to it.
	print("_on_score_changed called! New score: ", new_score)
	score = new_score
	$UI/ScoreLabel.text = "SCORE: " + str(score)

## ============================================================
## HINT (read only if stuck):
##
##   In _ready(), add this single line:
##   $ScoreTarget.score_changed.connect(_on_score_changed)
##
##   This tells Godot: "When ScoreTarget emits 'score_changed',
##   call our _on_score_changed function and pass the value."
##
##   NARRATIVE CONNECTION:
##   A disconnected signal is like writing a plot twist that
##   never gets read — the event happens backstage, but the
##   player never sees it. Connecting the signal = putting
##   the twist on stage where it belongs.
## ============================================================
