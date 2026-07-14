# =============================================================================
# Player.gd
# STEM Through Games - Day 9: Conditionals & Game States
# =============================================================================
#
# LESSON FOCUS: Boolean logic and branching
#
# This script demonstrates:
#   1. if / elif / else statements
#   2. Tracking game state variables (health, score)
#   3. Comparison operators: ==  !=  <  >  <=  >=
#   4. Boolean logic: AND (&&)  OR (||)  NOT (!)
#   5. Changing behavior based on conditions
#
# KEY VOCABULARY:
#   - Conditional:   A statement that only runs its code when a condition is TRUE
#   - Boolean:       A value that is either TRUE or FALSE — nothing in between
#   - Game State:    A snapshot of what is happening in the game right now
#   - Branch:        One of the possible paths code can take through a conditional
# =============================================================================

extends CharacterBody2D

# -----------------------------------------------------------------------------
# SECTION 1: GAME STATE VARIABLES
# -----------------------------------------------------------------------------
# Variables store the current "state" of the game.
# Conditionals will CHECK these values and REACT based on what they find.

var health: int = 100        # Player's hit points (0 = dead)
var max_health: int = 100    # Used to calculate health bar percentage
var score: int = 0           # Points collected so far
var win_score: int = 10      # How many points needed to win

# Game state flags — these are BOOLEAN variables (true or false only)
var is_dead: bool = false
var has_won: bool = false

# Movement constants
const SPEED: float = 200.0
const JUMP_VELOCITY: float = -400.0
const GRAVITY: float = 980.0

# Signal declarations — let other nodes know when something important happens
signal health_changed(new_health: int, max_hp: int)
signal score_changed(new_score: int)
signal game_over()
signal player_won()


# -----------------------------------------------------------------------------
# SECTION 2: READY & PROCESS
# -----------------------------------------------------------------------------

func _ready() -> void:
	# Emit starting values so the HUD can display them immediately
	emit_signal("health_changed", health, max_health)
	emit_signal("score_changed", score)
	print("Player ready! Health: ", health, " | Win score: ", win_score)


func _physics_process(delta: float) -> void:
	# =========================================================================
	# CONDITIONALS IN ACTION — Example 1: Gate all movement behind a state check
	# =========================================================================
	# "If the game is over OR the player has won, do NOT move."
	# This uses the OR (||) operator: either condition being true stops movement.
	if is_dead || has_won:
		return  # Stop here — skip everything below this line

	# Apply gravity when not on the floor
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle horizontal movement
	var direction: float = 0.0
	if Input.is_action_pressed("move_left"):
		direction = -1.0
	elif Input.is_action_pressed("move_right"):
		direction = 1.0

	velocity.x = direction * SPEED

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# =========================================================================
	# TEST KEYS — Press these during play to trigger the lesson's conditions
	# =========================================================================
	# Press H to take 25 damage (tests take_damage and health conditionals)
	if Input.is_action_just_pressed("take_damage"):
		take_damage(25)

	# Press E to collect a point (tests add_score and win condition)
	if Input.is_action_just_pressed("collect"):
		add_score(1)

	# Press R to restart the scene manually
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

	move_and_slide()


# -----------------------------------------------------------------------------
# SECTION 3: TAKE DAMAGE — The core if/elif/else from the lesson
# -----------------------------------------------------------------------------
#
# This is the EXACT function from the lesson plan.
# Read each branch carefully — only ONE branch runs per call.
#
func take_damage(amount: int) -> void:
	# Guard: ignore damage if already dead or won
	if is_dead || has_won:
		return

	health -= amount  # Subtract the damage amount from current health
	                  # MATH CONNECTION: health = health - amount

	print("Took ", amount, " damage! Health is now: ", health)

	# =========================================================================
	# THE if / elif / else CHAIN
	# Only the FIRST true branch runs. The others are skipped.
	# =========================================================================

	if health <= 0:
		# Branch 1: health has dropped to zero or below — GAME OVER
		# Operator used: <=  (less than OR equal to)
		health = 0          # Clamp to 0 so health bar doesn't go negative
		_trigger_game_over()

	elif health < 30:
		# Branch 2: health is LOW but not zero — warn the player
		# Only reached if Branch 1 was FALSE (health is NOT <= 0)
		# Operator used: <  (strictly less than)
		print("⚠️  WARNING: Low health! Only ", health, " HP remaining!")
		_flash_warning()

	else:
		# Branch 3: health is fine — just report the current value
		# Reached only if BOTH previous conditions were FALSE
		print("Health remaining: ", health)

	# Notify the HUD every time health changes (any branch)
	emit_signal("health_changed", health, max_health)


# -----------------------------------------------------------------------------
# SECTION 4: ADD SCORE — Win condition (Challenge activity)
# -----------------------------------------------------------------------------
#
# CHALLENGE: Add a win condition — if score >= 10, the player wins!
#
func add_score(points: int) -> void:
	# Guard: don't add score if game is already over
	if is_dead || has_won:
		return

	score += points  # Add points to the current score
	                 # MATH CONNECTION: score = score + points

	print("Score: ", score, " / ", win_score)
	emit_signal("score_changed", score)

	# =========================================================================
	# WIN CONDITION CHECK
	# =========================================================================

	if score >= win_score:
		# Operator used: >=  (greater than OR equal to)
		# The player has collected enough points — THEY WIN!
		print("🏆  YOU WIN! Final score: ", score)
		_trigger_win()

	else:
		# Not there yet — tell the player how many more they need
		var points_needed: int = win_score - score
		print("Keep going! Need ", points_needed, " more point(s) to win.")


# -----------------------------------------------------------------------------
# SECTION 5: HEALING — Demonstrates additional operators
# -----------------------------------------------------------------------------
#
# EXTENSION CHALLENGE: Add a heal function!
# Notice how we use min() to prevent health from exceeding max_health.
#
func heal(amount: int) -> void:
	# Guard: can't heal if dead
	if is_dead:
		print("Can't heal — player is dead.")
		return

	health += amount

	# =========================================================================
	# BOOLEAN LOGIC EXAMPLES — AND (&&) and NOT (!)
	# =========================================================================

	# Use min() to clamp health, then check with AND logic
	health = min(health, max_health)  # Never exceed max_health

	# "If health is full AND we healed something" — uses AND (&&)
	if health == max_health && amount > 0:
		print("❤️  Fully healed! Health: ", health)

	# "If NOT at max health" — uses NOT (!)
	elif !( health == max_health ):
		print("Healed to: ", health, " / ", max_health)

	emit_signal("health_changed", health, max_health)


# -----------------------------------------------------------------------------
# SECTION 6: EXTENDED CHALLENGE FUNCTIONS
# -----------------------------------------------------------------------------
#
# CHALLENGE EXTENSION 1: Tiered win messages
# What happens if score >= 20? Add a "Perfect Score!" message!
#
func add_score_tiered(points: int) -> void:
	if is_dead || has_won:
		return

	score += points
	emit_signal("score_changed", score)

	# Three-tier scoring with elif chaining
	if score >= 20:
		print("⭐  PERFECT SCORE! You got ", score, " points!")
		_trigger_win()

	elif score >= win_score:
		# score is between 10 and 19
		print("🏆  YOU WIN! Score: ", score)
		_trigger_win()

	else:
		print("Score: ", score, " / ", win_score)


#
# CHALLENGE EXTENSION 2: Win only if ALIVE (uses AND &&)
# The player must have score >= 10 AND health > 0 to win.
#
func check_win_with_health() -> void:
	# BOOLEAN AND: BOTH conditions must be true
	if score >= win_score && health > 0:
		print("🏆  YOU WIN with ", health, " HP remaining!")
		_trigger_win()

	elif score >= win_score && health <= 0:
		# Score is enough but player is dead — no win
		print("So close! You reached the score, but ran out of health.")

	else:
		print("Keep collecting! Score: ", score)


#
# CHALLENGE EXTENSION 3: Close-call win message
#
func check_close_call_win() -> void:
	if score >= win_score:
		# Nested conditionals — check health INSIDE the win branch
		if health < 10:
			print("🏆  YOU WIN! ...but barely! Only ", health, " HP left — close call!")
		else:
			print("🏆  YOU WIN! Finished with ", health, " HP to spare.")
		_trigger_win()


# -----------------------------------------------------------------------------
# PRIVATE HELPER FUNCTIONS
# -----------------------------------------------------------------------------

func _trigger_game_over() -> void:
	is_dead = true
	print("💀  GAME OVER!")
	emit_signal("game_over")
	# Pause briefly then reload — gives the HUD time to react
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()


func _trigger_win() -> void:
	has_won = true
	set_physics_process(false)  # Stop all player movement
	emit_signal("player_won")
	print("Movement stopped. Game complete!")


func _flash_warning() -> void:
	# Visual feedback for low health — modulate flashes red briefly
	modulate = Color(1.0, 0.2, 0.2)  # Tint the player sprite red
	await get_tree().create_timer(0.15).timeout
	modulate = Color(1.0, 1.0, 1.0)  # Back to normal
	await get_tree().create_timer(0.1).timeout
	modulate = Color(1.0, 0.2, 0.2)
	await get_tree().create_timer(0.15).timeout
	modulate = Color(1.0, 1.0, 1.0)


# -----------------------------------------------------------------------------
# GETTERS — Safe way for other scripts to read state
# -----------------------------------------------------------------------------

func get_health() -> int:
	return health

func get_score() -> int:
	return score

func is_alive() -> bool:
	# NOT operator: returns true if is_dead is FALSE
	return !is_dead

func is_in_danger() -> bool:
	# AND operator: alive AND health is low
	return !is_dead && health < 30
