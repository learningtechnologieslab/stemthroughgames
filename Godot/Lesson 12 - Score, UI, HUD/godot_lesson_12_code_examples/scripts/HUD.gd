## HUD.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## This script drives the Heads-Up Display (CanvasLayer).
## It exposes functions that the Main scene connects to
## Player signals, so the labels always stay in sync with
## the player's current state.
##
## LESSON CONCEPTS COVERED:
##   - extends CanvasLayer
##   - Updating Label.text from code
##   - str() for integer-to-string conversion
##   - String concatenation with +
##   - _process(delta) for the countdown timer
##   - The formula:  remaining_time = MAX_TIME − elapsed_time
##   - Modulo operator for MM:SS formatting (CHALLENGE bonus)

extends CanvasLayer

# ─── Timer Constants & Variables ──────────────────────────────────────────────
## Starting time in seconds.  Change this to 90 or 120 to try the bonus challenge.
const MAX_TIME: float = 60.0

## Tracks how many seconds have passed since the game started.
var elapsed_time: float = 0.0

## Set to false to pause the timer (e.g. when the player dies).
var time_running: bool = true

# ─── Built-in Functions ───────────────────────────────────────────────────────

func _ready() -> void:
	## Called once when the HUD enters the scene tree.
	## Nothing to initialise here – the Main scene will
	## call update_score() and update_health() via signals.
	pass

func _process(delta: float) -> void:
	## Called every frame (~60×/sec). Used for the countdown timer.
	##
	## delta = time (in seconds) since the previous frame.
	## Summing delta each frame gives us total elapsed time –
	## the same idea as computing a running total in math class.
	
	if not time_running:
		return
	
	# Accumulate elapsed time.
	elapsed_time += delta
	
	# ── CORE MATH FORMULA ──────────────────────────────────────
	# remaining_time = MAX_TIME − elapsed_time
	# This is a linear function:  y = b − x
	#   b = 60  (the y-intercept / starting value)
	#   x = elapsed_time  (grows by delta each frame)
	#   y = remaining_time  (counts down toward zero)
	var remaining_time: float = MAX_TIME - elapsed_time
	
	# Clamp so we never show a negative number.
	if remaining_time <= 0.0:
		remaining_time = 0.0
		time_running = false
		_on_time_expired()
	
	# Display as a whole number (int truncates the decimal part).
	# str() converts the integer to a string for concatenation.
	$TimerLabel.text = "Time: " + str(int(remaining_time))
	
	# ── BONUS CHALLENGE: colour the timer red when < 10 seconds ──
	if remaining_time <= 10.0:
		$TimerLabel.add_theme_color_override("font_color", Color.RED)
	else:
		$TimerLabel.add_theme_color_override("font_color", Color.WHITE)

# ─── Public Update Functions (connected to Player signals) ────────────────────

## Called by Main._ready() via:
##   $Player.score_changed.connect($HUD.update_score)
##
## new_score is an integer (e.g. 42).
## str(new_score) converts it to the string "42".
## We then concatenate "Score: " + "42" = "Score: 42".
func update_score(new_score: int) -> void:
	$ScoreLabel.text = "Score: " + str(new_score)

## Called by Main._ready() via:
##   $Player.health_changed.connect($HUD.update_health)
func update_health(new_health: int) -> void:
	$HealthLabel.text = "HP: " + str(new_health)
	
	# Optional: colour health label red when low.
	if new_health <= 25:
		$HealthLabel.add_theme_color_override("font_color", Color.RED)
	elif new_health <= 50:
		$HealthLabel.add_theme_color_override("font_color", Color.YELLOW)
	else:
		$HealthLabel.add_theme_color_override("font_color", Color.WHITE)

## Call this from the Main scene when the player dies, to freeze the timer.
func stop_timer() -> void:
	time_running = false

# ─── Private Helpers ──────────────────────────────────────────────────────────

func _on_time_expired() -> void:
	## Called internally when remaining_time hits zero.
	$TimerLabel.text = "Time: 0"
	print("Time's up!")
	# TODO Day 13: trigger game-over state here.

# ─── BONUS CHALLENGE FUNCTION (MM:SS format) ─────────────────────────────────
## Uncomment _process_mmss() and swap out the _process() body to use it.
##
## MATH: integer division and modulo
##   total_seconds = 65
##   minutes = 65 / 60  = 1     (integer division, drops remainder)
##   seconds = 65 % 60  = 5     (modulo: the remainder after dividing by 60)
##   display → "1:05"
##
## func _process_mmss(remaining: int) -> String:
##     var minutes: int = remaining / 60
##     var seconds: int = remaining % 60
##     var seconds_str: String = str(seconds)
##     if seconds < 10:
##         seconds_str = "0" + seconds_str   # zero-pad: 5 → "05"
##     return str(minutes) + ":" + seconds_str
