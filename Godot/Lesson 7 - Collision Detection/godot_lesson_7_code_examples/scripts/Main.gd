## Main.gd
## STEM Through Games — Day 7: Collision Detection
##
## The Main scene is the root of the game.
## It holds the Player, Obstacles, Coins, and the HUD.
##
## RESPONSIBILITIES:
##   - Listen for coin_collected signals from every Coin
##   - Update the score Label in the HUD
##   - Handle win/lose conditions
##   - Restart the level

extends Node2D

# ─────────────────────────────────────────────────────────────
#  NODE REFERENCES
#  @onready fills these in automatically when the scene loads.
#  The "$" syntax finds a child node by its name in the scene tree.
# ─────────────────────────────────────────────────────────────

@onready var player: CharacterBody2D = $Player
@onready var hud_score_label: Label   = $HUD/ScoreLabel
@onready var coins_container: Node2D  = $Coins
@onready var win_label: Label         = $HUD/WinLabel


# ─────────────────────────────────────────────────────────────
#  VARIABLES
# ─────────────────────────────────────────────────────────────

var total_score: int  = 0
var coins_remaining: int = 0


# ─────────────────────────────────────────────────────────────
#  READY
# ─────────────────────────────────────────────────────────────

func _ready() -> void:
	win_label.hide()
	_connect_coins()
	_update_score_label()


# ─────────────────────────────────────────────────────────────
#  CONNECT ALL COINS
# ─────────────────────────────────────────────────────────────

## Loops through every child of the Coins container and connects
## each coin's coin_collected signal to our _on_coin_collected handler.
##
## This pattern is useful: instead of hardcoding each coin, we let
## Godot find them all at runtime.
func _connect_coins() -> void:
	coins_remaining = 0

	for coin in coins_container.get_children():
		if coin.has_signal("coin_collected"):
			coin.coin_collected.connect(_on_coin_collected)
			coins_remaining += 1

	print("Level loaded with ", coins_remaining, " coins.")


# ─────────────────────────────────────────────────────────────
#  SIGNAL HANDLERS
# ─────────────────────────────────────────────────────────────

## Called every time a Coin emits coin_collected.
func _on_coin_collected() -> void:
	# Read the player's actual score (the Coin already updated it)
	total_score = player.score
	coins_remaining -= 1

	_update_score_label()

	print("Coins remaining: ", coins_remaining)

	# Check win condition
	if coins_remaining <= 0:
		_on_level_complete()


# ─────────────────────────────────────────────────────────────
#  HUD HELPERS
# ─────────────────────────────────────────────────────────────

func _update_score_label() -> void:
	hud_score_label.text = "Score: " + str(total_score)


func _on_level_complete() -> void:
	print("All coins collected! Final score: ", total_score)
	win_label.text = "You win!  Score: " + str(total_score)
	win_label.show()


# ─────────────────────────────────────────────────────────────
#  INPUT — RESTART
# ─────────────────────────────────────────────────────────────

func _input(event: InputEvent) -> void:
	# Press R to restart the scene
	if event.is_action_pressed("ui_accept") and win_label.visible:
		get_tree().reload_current_scene()


# ─────────────────────────────────────────────────────────────
#  DAY 7 STUDENT CHALLENGES
# ─────────────────────────────────────────────────────────────
#
#  CHALLENGE 1 (Starter):
#    Add a "Coins Left: X" label to the HUD and update it
#    each time _on_coin_collected() fires.
#
#  CHALLENGE 2 (Intermediate):
#    Add a timer. Start it in _ready() and stop it in
#    _on_level_complete(). Display the elapsed time in the win message.
#    Hint: use Time.get_ticks_msec() or a Timer node.
#
#  CHALLENGE 3 (Advanced):
#    Make coins worth different amounts (1, 3, 5 points).
#    Change point_value on individual coins in the Inspector.
#    Display both "coins left" and "total score" in the HUD.
#
