## HUD_Challenge_Complete.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## CHALLENGE COMPLETE VERSION
## This is the fully-implemented challenge solution.
## Students should try building this themselves first!
##
## Additions over the starter HUD.gd:
##   ✅ MM:SS time format using integer division and modulo
##   ✅ Timer pauses when player health hits zero
##   ✅ Score label pulses gold when points are added
##   ✅ Displays "GAME OVER" overlay when time or HP runs out

extends CanvasLayer

const MAX_TIME: float = 60.0
var elapsed_time: float = 0.0
var time_running: bool = true
var last_score: int = -1      # tracks previous score to detect changes

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not time_running:
		return
	
	elapsed_time += delta
	var remaining_time: float = MAX_TIME - elapsed_time
	
	if remaining_time <= 0.0:
		remaining_time = 0.0
		time_running = false
		_on_time_expired()
	
	# ── CHALLENGE COMPLETE: MM:SS format ────────────────────────
	# MATH: integer division (/) and modulo (%)
	#   total = 65 seconds
	#   minutes = 65 / 60 = 1     (how many full minutes)
	#   seconds = 65 % 60 = 5     (leftover seconds)
	#   → display "1:05"
	var total_secs: int = int(remaining_time)
	var minutes: int = total_secs / 60
	var seconds: int = total_secs % 60
	
	# Zero-pad seconds below 10:  5 → "05"
	var sec_str: String = str(seconds)
	if seconds < 10:
		sec_str = "0" + sec_str
	
	$TimerLabel.text = "Time: " + str(minutes) + ":" + sec_str
	
	# Colour the timer red when under 10 seconds.
	if remaining_time <= 10.0:
		$TimerLabel.add_theme_color_override("font_color", Color.RED)
	elif remaining_time <= 20.0:
		$TimerLabel.add_theme_color_override("font_color", Color.YELLOW)
	else:
		$TimerLabel.add_theme_color_override("font_color", Color.WHITE)

func update_score(new_score: int) -> void:
	$ScoreLabel.text = "Score: " + str(new_score)
	# Flash gold when score increases.
	if new_score > last_score:
		$ScoreLabel.add_theme_color_override("font_color", Color.GOLD)
		# Reset colour after a short delay.
		await get_tree().create_timer(0.3).timeout
		$ScoreLabel.add_theme_color_override("font_color", Color.WHITE)
	last_score = new_score

func update_health(new_health: int) -> void:
	$HealthLabel.text = "HP: " + str(new_health)
	if new_health <= 25:
		$HealthLabel.add_theme_color_override("font_color", Color.RED)
	elif new_health <= 50:
		$HealthLabel.add_theme_color_override("font_color", Color.YELLOW)
	else:
		$HealthLabel.add_theme_color_override("font_color", Color.WHITE)
	
	# Stop timer when player dies.
	if new_health <= 0:
		stop_timer()
		_show_game_over("OUT OF HP!")

func stop_timer() -> void:
	time_running = false

func _on_time_expired() -> void:
	$TimerLabel.text = "Time: 0:00"
	_show_game_over("TIME'S UP!")

func _show_game_over(reason: String) -> void:
	## Displays a simple Game Over overlay.
	## In Day 13 this will be replaced by a proper scene transition.
	if has_node("GameOverLabel"):
		return   # already showing
	var lbl := Label.new()
	lbl.name = "GameOverLabel"
	lbl.text = "GAME OVER\n" + reason + "\n\nFinal Score: " + str(last_score)
	lbl.add_theme_font_size_override("font_size", 32)
	lbl.add_theme_color_override("font_color", Color.RED)
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	lbl.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	add_child(lbl)
	print("GAME OVER – Reason: ", reason, "  Final score: ", last_score)
