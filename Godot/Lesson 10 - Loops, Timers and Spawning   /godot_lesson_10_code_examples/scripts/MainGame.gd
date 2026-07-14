extends Node2D

# =============================================================================
# STEM Through Games Program — Day 10: Loops, Timers & Spawning
# Script: MainGame.gd
# =============================================================================
# LEARNING OBJECTIVES COVERED:
#   1. Use for loops to spawn multiple objects at once
#   2. Use while loops with a condition check
#   3. Configure and use a Timer node via code
#   4. Use randi_range() for random positions
#   5. Instantiate scenes and add_child() at runtime
# =============================================================================

# --- EXPORTED VARIABLES (assign these in the Godot Inspector) ---
@export var coin_scene: PackedScene    # Drag CoinPickup.tscn here
@export var enemy_scene: PackedScene   # Drag Enemy.tscn here

# --- GAME STATE ---
var score: int = 0
var wave: int = 0
var enemies_spawned: int = 0
var game_active: bool = false

# --- NODE REFERENCES (set in _ready) ---
@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_label: Label = $UI/ScoreLabel
@onready var wave_label: Label  = $UI/WaveLabel
@onready var info_label: Label  = $UI/InfoLabel


# =============================================================================
# _ready() — called once when the scene loads
# =============================================================================
func _ready() -> void:
	randomize()  # Seed the random number generator — always call this first!

	# Connect the Timer's timeout signal to our function
	# (You can also do this in the Godot editor via the Node panel)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

	# Show a welcome message and wait for the player to start
	info_label.text = "Press SPACE to start!"
	update_hud()


# =============================================================================
# _input() — listen for player input
# =============================================================================
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not game_active:
		start_game()


# =============================================================================
# start_game() — initialise and begin play
# =============================================================================
func start_game() -> void:
	game_active = true
	score = 0
	wave = 0
	info_label.text = ""
	update_hud()

	# Spawn the first wave of coins, then start the enemy timer
	next_wave()
	spawn_timer.start()


# =============================================================================
# next_wave() — LESSON FOCUS: for loop spawning coins
#
#   This function uses a for loop to place coins at random X positions.
#   Each call increments 'wave' and spawns one extra coin per wave.
# =============================================================================
func next_wave() -> void:
	wave += 1
	wave_label.text = "Wave: %d" % wave

	# ─── FOR LOOP ─────────────────────────────────────────────────────────────
	# Spawn (2 + wave) coins so each wave gets progressively more coins.
	# range(n) produces [0, 1, 2 … n-1] — the loop body runs n times.
	for i in range(2 + wave):
		spawn_coin()

	# ─── PROBABILITY DISCUSSION POINT ────────────────────────────────────────
	# randi_range(50, 750) returns a random integer between 50 and 750.
	# The range is 750 - 50 + 1 = 701 possible values.
	# Chance of landing in any 70-unit section ≈ 70 / 701 ≈ 10%


# =============================================================================
# spawn_coin() — create one coin at a random horizontal position
# =============================================================================
func spawn_coin() -> void:
	# Guard: if the scene reference is missing, warn and skip
	if coin_scene == null:
		push_warning("coin_scene is not assigned in the Inspector!")
		return

	var coin = coin_scene.instantiate()           # Create a new copy of CoinPickup
	coin.position = Vector2(
		randi_range(50, 750),                     # Random X between 50 and 750
		randi_range(80, 200)                      # Random Y near the top
	)
	coin.collected.connect(_on_coin_collected)    # Listen for the coin's signal
	add_child(coin)                               # Add it to the scene tree


# =============================================================================
# _on_spawn_timer_timeout() — LESSON FOCUS: Timer signal handler
#
#   The SpawnTimer node fires this signal every `wait_time` seconds.
#   We use it to spawn enemies at a regular, escalating interval.
# =============================================================================
func _on_spawn_timer_timeout() -> void:
	if not game_active:
		return

	spawn_enemy()

	# ─── ESCALATING DIFFICULTY ───────────────────────────────────────────────
	# Gradually reduce the spawn interval so enemies appear faster over time.
	# Clamp ensures it never goes below 0.6 seconds.
	spawn_timer.wait_time = max(0.6, spawn_timer.wait_time - 0.05)


# =============================================================================
# spawn_enemy() — create one enemy at a random position along the top edge
# =============================================================================
func spawn_enemy() -> void:
	if enemy_scene == null:
		push_warning("enemy_scene is not assigned in the Inspector!")
		return

	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(
		randi_range(50, 750),
		0                                         # Start at the top of the screen
	)
	enemy.reached_bottom.connect(_on_enemy_reached_bottom)
	add_child(enemy)
	enemies_spawned += 1


# =============================================================================
# while loop DEMO — LESSON FOCUS
#
#   This function demonstrates while loops.
#   Call it from another function or the Godot debugger console to test.
#   NOTE: This is intentionally separate so students can study it in isolation.
# =============================================================================
func demo_while_loop_spawn(count: int) -> void:
	# ─── WHILE LOOP ───────────────────────────────────────────────────────────
	# Keep spawning until we have placed `count` coins.
	# The condition (coins_placed < count) must eventually become false!
	var coins_placed: int = 0
	while coins_placed < count:
		spawn_coin()
		coins_placed += 1
		# If this line were missing, coins_placed never increases → infinite loop!


# =============================================================================
# Signal callbacks
# =============================================================================
func _on_coin_collected() -> void:
	score += 10
	update_hud()

	# Check if all coins are gone → start next wave
	var coins_left = get_tree().get_nodes_in_group("coins").size()
	if coins_left == 0:
		next_wave()


func _on_enemy_reached_bottom() -> void:
	# For now, just log — Day 11 will add health/game-over logic
	print("Enemy reached the bottom! (Day 11: add health system here)")


# =============================================================================
# update_hud() — refresh on-screen labels
# =============================================================================
func update_hud() -> void:
	score_label.text = "Score: %d" % score
	wave_label.text  = "Wave: %d"  % wave
