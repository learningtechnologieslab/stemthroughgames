## Main.gd
## ============================================================
## STEM Through Games – Day 15: Animations, Sound & Game Feel
## ============================================================
##
## The main level script. Manages:
##   1. Coin score tracking
##   2. Background music startup
##   3. Connecting coin signals to the score counter
##   4. "Mute Test" toggle (for the silent-vs-sound activity)
##   5. HUD display (coin count)
##
## ============================================================

extends Node2D

# ── SCORE ─────────────────────────────────────────────────────
var coins_collected: int = 0
var total_coins: int     = 0

# ── MUTE TEST MODE ────────────────────────────────────────────
## Press M to toggle all game audio on/off for the comparison activity
var audio_muted: bool = false


# ════════════════════════════════════════════════════════════
# _ready()
# ════════════════════════════════════════════════════════════
func _ready() -> void:
	# Count how many coins exist in the scene
	var coins := get_tree().get_nodes_in_group("coins")
	total_coins = coins.size()

	# Connect each coin's "collected" signal to our handler
	for coin in coins:
		coin.collected.connect(_on_coin_collected)

	# Start background music
	# Uncomment when you have an audio file at this path:
	# MusicManager.play_track(preload("res://audio/bg_music.ogg"))

	# Update HUD
	_update_hud()

	print("Level loaded. Coins to collect: ", total_coins)


# ════════════════════════════════════════════════════════════
# _process() – Called every render frame
# ════════════════════════════════════════════════════════════
func _process(_delta: float) -> void:
	# ── M KEY: Toggle mute for the comparison activity ───────
	if Input.is_action_just_pressed("ui_accept"):
		pass  # Could be used for pause

	if Input.is_key_pressed(KEY_M) and Input.is_action_just_pressed("ui_cancel"):
		pass  # Placeholder - see _input below

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_M:
			_toggle_mute()
		if event.keycode == KEY_R:
			_restart_level()


# ════════════════════════════════════════════════════════════
# _on_coin_collected() – Fires when any coin is picked up
# ════════════════════════════════════════════════════════════
func _on_coin_collected() -> void:
	coins_collected += 1
	_update_hud()
	print("Coin collected! ", coins_collected, " / ", total_coins)

	if coins_collected >= total_coins:
		_on_level_complete()


# ════════════════════════════════════════════════════════════
# _update_hud() – Refreshes the on-screen coin counter
# ════════════════════════════════════════════════════════════
func _update_hud() -> void:
	# The HUD label must be at this path in your scene tree
	if has_node("HUD/CoinLabel"):
		$HUD/CoinLabel.text = "Coins: %d / %d" % [coins_collected, total_coins]


# ════════════════════════════════════════════════════════════
# _toggle_mute() – Press M to mute/unmute all game audio
## Used for the "Silent vs. Sound" classroom activity
# ════════════════════════════════════════════════════════════
func _toggle_mute() -> void:
	audio_muted = not audio_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), audio_muted)

	var label_text := "[MUTED – Silent Mode]" if audio_muted else ""
	if has_node("HUD/MuteLabel"):
		$HUD/MuteLabel.text = label_text

	print("Audio muted: ", audio_muted,
		  "  ← Press M again to restore sound")


# ════════════════════════════════════════════════════════════
# _on_level_complete() – All coins collected!
# ════════════════════════════════════════════════════════════
func _on_level_complete() -> void:
	print("🎉 Level complete! All ", total_coins, " coins collected.")
	# Optional: crossfade to a victory music track
	# MusicManager.play_track(preload("res://audio/victory.ogg"), true)


# ════════════════════════════════════════════════════════════
# _restart_level() – Press R to reload the scene (for testing)
# ════════════════════════════════════════════════════════════
func _restart_level() -> void:
	get_tree().reload_current_scene()
