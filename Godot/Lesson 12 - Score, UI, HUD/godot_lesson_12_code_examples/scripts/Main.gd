## Main.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## This is the "conductor" script for the Main scene.
## Its primary job is to connect Player signals to HUD
## functions so data flows automatically.
##
## LESSON CONCEPTS COVERED:
##   - Signal connections in _ready()
##   - Node path references ($Player, $HUD)
##   - Using Input.is_action_just_pressed() for test controls

extends Node2D

# ─── Built-in Functions ───────────────────────────────────────────────────────

func _ready() -> void:
	## Connect Player signals → HUD update functions.
	##
	## After these lines run:
	##   - Every time Player emits score_changed(n), HUD.update_score(n) is called.
	##   - Every time Player emits health_changed(n), HUD.update_health(n) is called.
	##   - When the player dies, the HUD timer stops.
	
	$Player.score_changed.connect($HUD.update_score)
	$Player.health_changed.connect($HUD.update_health)
	$Player.player_died.connect($HUD.stop_timer)
	
	print("Day 12 – HUD ready!")
	print("Test controls:")
	print("  Arrow keys / A+D   = move player")
	print("  Space              = jump")
	print("  C                  = collect coin  (+10 score)")
	print("  H                  = take a hit    (-25 health)")
	print("  R                  = heal           (+25 health)")

func _process(_delta: float) -> void:
	## Test key bindings so students can see the HUD update
	## without needing a full collision system yet.
	
	# Press C to simulate collecting a coin (+10 points).
	if Input.is_action_just_pressed("ui_end"):         # mapped to End key
		$Player.add_score(10)
	
	# Keyboard fallback using scancode checks.
	if Input.is_key_pressed(KEY_C):
		# Throttled via a small timer to avoid spamming.
		pass   # see _input() below for cleaner one-shot handling

func _input(event: InputEvent) -> void:
	## One-shot key handlers (fire once per press, not every frame).
	
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_C:
				# Simulate collecting a coin.
				$Player.add_score(10)
				print("Coin collected! +10 points")
			
			KEY_H:
				# Simulate taking a hit from an enemy.
				$Player.take_damage(25)
				print("Ouch! -25 HP")
			
			KEY_R:
				# Simulate picking up a health pack.
				$Player.heal(25)
				print("Healed! +25 HP")
			
			KEY_F1:
				# Debug: print current state to Output panel.
				print("--- DEBUG STATE ---")
				print("Score:  ", $Player.score)
				print("Health: ", $Player.health)
				print("Time elapsed: ", $HUD.elapsed_time)
