## HUD_Student_Worksheet.gd
## STEM Through Games – Day 12: Score, UI & HUD
##
## ╔══════════════════════════════════════════════════════════╗
## ║  STUDENT WORKSHEET  –  Fill in the blanks!              ║
## ║  Replace every  ___  with the correct code.             ║
## ║  Hint: use HUD.gd as your reference.                    ║
## ╚══════════════════════════════════════════════════════════╝

extends ___             # Q1: Which node type does the HUD extend?

# ── Timer variables ──────────────────────────────────────────
const MAX_TIME: float = ___    # Q2: How many seconds on the clock?
var elapsed_time: float = 0.0
var time_running: bool = true

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not time_running:
		return
	
	# Q3: Add delta to elapsed_time each frame.
	elapsed_time ___ delta
	
	# Q4: Fill in the countdown formula.
	#     remaining_time = MAX_TIME − elapsed_time
	var remaining_time: float = ___ - ___
	
	if remaining_time <= 0.0:
		remaining_time = 0.0
		time_running = false
	
	# Q5: Update the TimerLabel text.
	# Hint: str() converts an integer to a string.
	# Expected output: "Time: 42"
	$TimerLabel.text = "Time: " + ___(int(remaining_time))


## Q6: This function receives the new score as an integer.
##     Update ScoreLabel.text to show "Score: <number>".
##     Hint: you need str() to concatenate an int with a string.
func update_score(___: int) -> void:
	$ScoreLabel.text = "Score: " + ___(___)


## Q7: This function receives the new health as an integer.
##     Update HealthLabel.text to show "HP: <number>".
func update_health(new_health: int) -> void:
	$HealthLabel.___ = "HP: " + str(___)


func stop_timer() -> void:
	time_running = ___    # Q8: What value stops the timer?


# ── CHALLENGE: MM:SS format ───────────────────────────────────
## Q9 (Challenge): Complete the MM:SS formatter.
##    MATH:
##      65 seconds ÷ 60 = 1 remainder 5
##      minutes = 65 ___ 60   (use integer division operator)
##      seconds = 65 ___ 60   (use modulo operator for remainder)

func format_mmss(total_seconds: int) -> String:
	var minutes: int = total_seconds ___ 60
	var seconds: int = total_seconds ___ 60
	var sec_str: String = str(seconds)
	if seconds < 10:
		sec_str = "0" + sec_str
	return str(minutes) + ":" + sec_str


# ── ANSWER KEY (Teacher only – remove before printing) ─────────
## Q1:  CanvasLayer
## Q2:  60.0
## Q3:  +=
## Q4:  MAX_TIME - elapsed_time
## Q5:  str
## Q6:  func update_score(new_score: int)  /  str(new_score)
## Q7:  .text  /  new_health
## Q8:  false
## Q9:  /  and  %
